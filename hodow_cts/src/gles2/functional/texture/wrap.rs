// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureWrapTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// The ETC1 cases (`*_pot_etc1`, `clamp_clamp_*_npot_etc1`) take their image from `glu::etc1` instead
// of the test-data archive.
//
// The `enableRelaxedRef` second pass sets `ReferenceParams::float16_tex_coord`. Upstream passes the flag
// per case; it is true exactly when a wrap mode is repeat or mirrored, which is what is derived here.

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::etc1::{ETC1_GL_FORMAT, ETC1_VK_FORMAT, Etc1Image};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d};
use crate::glu::texture_test_util_surface::{compare_images, make_reference_params, sample_texture_2d_to_surface};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::fill_with_component_gradients2;
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::texture::ChannelType;
use crate::tcu::vector::Vec2;
use crate::tcu::{TestOutcome, TestStatus, de_string_hash};

const VIEWPORT_WIDTH: i32 = 256;
const VIEWPORT_HEIGHT: i32 = 256;

struct TextureWrapCase {
    name: String,
    format: u32,
    data_type: u32,
    wrap_s: u32,
    wrap_t: u32,
    min_filter: u32,
    mag_filter: u32,
    width: i32,
    height: i32,
    /// The `filenames` constructor: one ETC1 image per level; `format`/`data_type`/`width`/`height` are unused then.
    etc1: Option<Vec<Etc1Image>>,
}

impl TestCase for TextureWrapCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // `TextureWrapCase::init`
        let is_compressed_tex = self.etc1.is_some();
        let texture = if let Some(levels) = &self.etc1 {
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
            // SAFETY: a current context, and `texture` outlives the call.
            unsafe { texture.upload_compressed()? };
            texture
        } else {
            let mut texture = Texture2D::new(
                render_ctx,
                self.format,
                self.data_type,
                self.width as u32,
                self.height as u32,
            )?;
            texture.ref_texture_mut().alloc_level(0);
            {
                let mut level0 = texture.ref_texture_mut().level_mut(0);
                // Repeat modes use the conical (pyramid) style so an edge sample does not
                // differ hugely when the coordinate moves inside the allowed range.
                if self.wrap_s == glw::GL_REPEAT || self.wrap_t == glw::GL_REPEAT {
                    crate::tcu::pixel::fill_with_component_gradients3(
                        &mut level0,
                        [-0.5, -0.5, -0.5, 1.5],
                        [1.0, 1.0, 1.0, 0.0],
                    );
                } else {
                    fill_with_component_gradients2(&mut level0, [-0.5, -0.5, -0.5, 1.5], [1.0, 1.0, 1.0, 0.0]);
                }
            }
            // SAFETY: a current context, and `texture` outlives the call.
            unsafe { texture.upload()? };
            texture
        };

        // `TextureWrapCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es100, Precision::MediumP);
        let viewport = RandomViewport::new(
            &render_target,
            VIEWPORT_WIDTH,
            VIEWPORT_HEIGHT,
            de_string_hash(&self.name),
        );
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let left_width = viewport.width / 2;
        let right_width = viewport.width - left_width;

        let tex_format_type = texture.ref_texture().format().type_;
        let threshold = if tex_format_type == ChannelType::UNORM_SHORT_4444
            || tex_format_type == ChannelType::UNSIGNED_SHORT_4444
        {
            PixelFormat::new(4, 4, 4, 4).get_color_threshold() + RGBA::new(1, 1, 1, 1)
        } else {
            pixel_format.get_color_threshold()
                + if is_compressed_tex {
                    RGBA::new(7, 7, 7, 7)
                } else {
                    RGBA::new(3, 3, 3, 3)
                }
        };

        // SAFETY: plain state setting on the current context.
        unsafe {
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, self.wrap_s as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, self.wrap_t as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, self.min_filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, self.mag_filter as i32);
        }
        glu::expect_no_error(gl, "Set texturing state")?;

        let ref_params = make_reference_params(
            TextureType::Texture2D,
            self.wrap_s,
            self.wrap_t,
            self.wrap_s,
            self.min_filter,
            self.mag_filter,
            LodMode::Exact,
        )?;
        let (min_params, mag_params) = (&ref_params, &ref_params);

        // Left: minification
        {
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x, viewport.y, left_width, viewport.height) };

            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(-1.5, -3.0), Vec2::new(1.5, 2.5));
            renderer.render_quad(0, &tex_coord, &min_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst =
                SurfaceAccess::new_region(&mut reference_frame, pixel_format, 0, 0, left_width, viewport.height);
            sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, min_params)?;
        }

        // Right: magnification
        {
            // SAFETY: plain state setting on the current context.
            unsafe { gl.viewport(viewport.x + left_width, viewport.y, right_width, viewport.height) };

            let tex_coord = compute_quad_tex_coord_2d(Vec2::new(-0.5, 0.75), Vec2::new(0.25, 1.25));
            renderer.render_quad(0, &tex_coord, &mag_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

            let mut dst = SurfaceAccess::new_region(
                &mut reference_frame,
                pixel_format,
                left_width,
                0,
                right_width,
                viewport.height,
            );
            sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, mag_params)?;
        }

        let mut is_ok = compare_images(&reference_frame, &rendered_frame, threshold).ok;

        let enable_relaxed_ref = [self.wrap_s, self.wrap_t]
            .iter()
            .any(|&mode| mode == glw::GL_REPEAT || mode == glw::GL_MIRRORED_REPEAT);
        if !is_ok && enable_relaxed_ref {
            let mut relaxed_params = ref_params;
            relaxed_params.float16_tex_coord = true;

            // Left: minification
            {
                let tex_coord = compute_quad_tex_coord_2d(Vec2::new(-1.5, -3.0), Vec2::new(1.5, 2.5));
                let mut dst =
                    SurfaceAccess::new_region(&mut reference_frame, pixel_format, 0, 0, left_width, viewport.height);
                sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &relaxed_params)?;
            }

            // Right: magnification
            {
                let tex_coord = compute_quad_tex_coord_2d(Vec2::new(-0.5, 0.75), Vec2::new(0.25, 1.25));
                let mut dst = SurfaceAccess::new_region(
                    &mut reference_frame,
                    pixel_format,
                    left_width,
                    0,
                    right_width,
                    viewport.height,
                );
                sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &relaxed_params)?;
            }

            is_ok |= compare_images(&reference_frame, &rendered_frame, threshold).ok;
        }

        if is_ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `TextureWrapTests::init`
pub fn create_tests() -> TestCaseGroup {
    const WRAP_MODES: [(&str, u32); 3] = [
        ("clamp", glw::GL_CLAMP_TO_EDGE),
        ("repeat", glw::GL_REPEAT),
        ("mirror", glw::GL_MIRRORED_REPEAT),
    ];
    const FILTERING_MODES: [(&str, u32); 2] = [("nearest", glw::GL_NEAREST), ("linear", glw::GL_LINEAR)];
    const SIZES: [(&str, i32, i32); 2] = [("pot", 64, 128), ("npot", 63, 112)];
    const FORMATS: [(&str, u32, u32); 4] = [
        ("rgba8888", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
        ("rgb888", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        ("rgba4444", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        ("l8", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
    ];

    let mut group = TestCaseGroup::new("wrap");

    for &(wrap_s_name, wrap_s) in &WRAP_MODES {
        for &(wrap_t_name, wrap_t) in &WRAP_MODES {
            for &(filter_name, filter) in &FILTERING_MODES {
                for &(size_name, width, height) in &SIZES {
                    for (format_ndx, &(format_name, format, data_type)) in FORMATS.iter().enumerate() {
                        let is_clamp_clamp = wrap_s == glw::GL_CLAMP_TO_EDGE && wrap_t == glw::GL_CLAMP_TO_EDGE;
                        let is_repeat_mirror = wrap_s == glw::GL_REPEAT && wrap_t == glw::GL_MIRRORED_REPEAT;

                        // Use other format variants with the clamp_clamp & repeat_mirror pairs only.
                        if !is_clamp_clamp && !is_repeat_mirror && format_ndx != 0 {
                            continue;
                        }
                        // Not supported as described in spec section 3.8.2.
                        if !is_clamp_clamp && (!(width as u32).is_power_of_two() || !(height as u32).is_power_of_two())
                        {
                            continue;
                        }

                        let name = format!("{wrap_s_name}_{wrap_t_name}_{filter_name}_{size_name}_{format_name}");
                        group.add_child(Box::new(TextureWrapCase {
                            name,
                            format,
                            data_type,
                            wrap_s,
                            wrap_t,
                            min_filter: filter,
                            mag_filter: filter,
                            width,
                            height,
                            etc1: None,
                        }) as Box<dyn TestCase>);
                    }
                }
            }
        }
    }

    let etc1_case = |name: String, wrap_s: u32, wrap_t: u32, filter: u32, image: Etc1Image| {
        Box::new(TextureWrapCase {
            name,
            format: 0,
            data_type: 0,
            wrap_s,
            wrap_t,
            min_filter: filter,
            mag_filter: filter,
            width: 0,
            height: 0,
            etc1: Some(vec![image]),
        }) as Box<dyn TestCase>
    };

    // Power-of-two ETC1 texture
    let pot_image = crate::glu::etc1::photo_mip_levels()[0];
    for &(wrap_s_name, wrap_s) in &WRAP_MODES {
        for &(wrap_t_name, wrap_t) in &WRAP_MODES {
            for &(filter_name, filter) in &FILTERING_MODES {
                group.add_child(etc1_case(
                    format!("{wrap_s_name}_{wrap_t_name}_{filter_name}_pot_etc1"),
                    wrap_s,
                    wrap_t,
                    filter,
                    pot_image,
                ));
            }
        }
    }

    // NPOT ETC1 texture
    let npot_image = crate::glu::etc1::photo_npot();
    for &(filter_name, filter) in &FILTERING_MODES {
        group.add_child(etc1_case(
            format!("clamp_clamp_{filter_name}_npot_etc1"),
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            filter,
            npot_image,
        ));
    }

    group
}

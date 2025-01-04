// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fTextureFormatTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `TextureCubeFormatCase`'s one-face-
// per-`iterate()` state machine is a plain loop over the six faces with the same
// per-face viewport seed and overall verdict.
//
// The four `etc1_*` cases (`Compressed2DFormatCase`/`CompressedCubeFormatCase`) are the shared
// `gles3::functional::texture::etc1_cases::Etc1FileCase`, fed from `glu::etc1` instead of the
// test-data archive.

use crate::gles3::functional::texture::etc1_cases::etc1_format_cases;
use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_cube::TextureCube;
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, TextureType, compute_quad_tex_coord_2d, get_sampler_type,
};
use crate::glu::texture_test_util_surface::{
    LodRange, compare_images, compute_quad_tex_coord_cube, map_gl_sampler, sample_texture_2d_to_surface,
    sample_texture_cube_to_surface,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::{CubeFace, fill_with_component_gradients2, get_texture_format_info};
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestOutcome, TestStatus, de_string_hash};

const FACES: [CubeFace; 6] = [
    CubeFace::NegativeX,
    CubeFace::PositiveX,
    CubeFace::NegativeY,
    CubeFace::PositiveY,
    CubeFace::NegativeZ,
    CubeFace::PositiveZ,
];

fn swizzle4(v: [f32; 4], s: [usize; 4]) -> [f32; 4] {
    [v[s[0]], v[s[1]], v[s[2]], v[s[3]]]
}

struct Texture2DFormatCase {
    name: String,
    format: u32,
    data_type: u32,
    width: i32,
    height: i32,
}

impl TestCase for Texture2DFormatCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture2DFormatCase::init`
        let mut texture = Texture2D::new(
            render_ctx,
            self.format,
            self.data_type,
            self.width as u32,
            self.height as u32,
        )?;
        let spec = get_texture_format_info(texture.ref_texture().format());
        texture.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = texture.ref_texture_mut().level_mut(0);
            fill_with_component_gradients2(&mut level0, spec.value_min, spec.value_max);
        }

        // `Texture2DFormatCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es100, Precision::MediumP);
        let viewport = RandomViewport::new(&render_target, self.width, self.height, de_string_hash(&self.name));
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        let mut render_params = ReferenceParams::new(
            TextureType::Texture2D,
            map_gl_sampler(
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_CLAMP_TO_EDGE,
                glw::GL_NEAREST,
                glw::GL_NEAREST,
                LodRange::Magnified,
            )?,
            LodMode::Exact,
        );
        render_params.base.sampler_type = get_sampler_type(texture.ref_texture().format());
        render_params.base.color_scale = Vec4::from_array(spec.look_up_scale);
        render_params.base.color_bias = Vec4::from_array(spec.look_up_bias);

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
            texture.upload()?;
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        }
        glu::expect_no_error(gl, "Set texturing state")?;

        renderer.render_quad(0, &tex_coord, &render_params.base)?;
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
        glu::expect_no_error(gl, "glReadPixels()")?;

        let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
        sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

        if compare_images(&reference_frame, &rendered_frame, threshold).ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

struct TextureCubeFormatCase {
    name: String,
    format: u32,
    data_type: u32,
    width: i32,
}

impl TestCase for TextureCubeFormatCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `TextureCubeFormatCase::init`
        let mut texture = TextureCube::new(render_ctx, self.format, self.data_type, self.width as u32)?;
        let spec = get_texture_format_info(texture.ref_texture().format());

        texture.ref_texture_mut().alloc_level(0);
        for (face_ndx, &face) in FACES.iter().enumerate() {
            let (g_min, g_max) = match face_ndx {
                0 => (
                    swizzle4(spec.value_min, [0, 1, 2, 3]),
                    swizzle4(spec.value_max, [0, 1, 2, 3]),
                ),
                1 => (
                    swizzle4(spec.value_min, [2, 1, 0, 3]),
                    swizzle4(spec.value_max, [2, 1, 0, 3]),
                ),
                2 => (
                    swizzle4(spec.value_min, [1, 2, 0, 3]),
                    swizzle4(spec.value_max, [1, 2, 0, 3]),
                ),
                3 => (
                    swizzle4(spec.value_max, [0, 1, 2, 3]),
                    swizzle4(spec.value_min, [0, 1, 2, 3]),
                ),
                4 => (
                    swizzle4(spec.value_max, [2, 1, 0, 3]),
                    swizzle4(spec.value_min, [2, 1, 0, 3]),
                ),
                _ => (
                    swizzle4(spec.value_max, [1, 2, 0, 3]),
                    swizzle4(spec.value_min, [1, 2, 0, 3]),
                ),
            };
            let mut level = texture.ref_texture_mut().face_level_mut(face, 0);
            fill_with_component_gradients2(&mut level, g_min, g_max);
        }

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe { texture.upload()? };

        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es100, Precision::MediumP);
        let mut is_ok = true;

        // `TextureCubeFormatCase::testFace`, once per face.
        for (face_ndx, &face) in FACES.iter().enumerate() {
            let viewport = RandomViewport::new(
                &render_target,
                self.width,
                self.width,
                de_string_hash(&self.name).wrapping_add(face_ndx as u32),
            );
            let mut rendered_frame = Surface::new(viewport.width, viewport.height);
            let mut reference_frame = Surface::new(viewport.width, viewport.height);
            let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);
            let tex_coord = compute_quad_tex_coord_cube(face);

            let mut render_params = ReferenceParams::new(
                TextureType::Cube,
                map_gl_sampler(
                    glw::GL_CLAMP_TO_EDGE,
                    glw::GL_CLAMP_TO_EDGE,
                    glw::GL_CLAMP_TO_EDGE,
                    glw::GL_NEAREST,
                    glw::GL_NEAREST,
                    LodRange::Magnified,
                )?,
                LodMode::Exact,
            );
            render_params.base.sampler_type = get_sampler_type(texture.ref_texture().format());
            render_params.sampler.seamless_cube_map = false;
            render_params.base.color_scale = Vec4::from_array(spec.look_up_scale);
            render_params.base.color_bias = Vec4::from_array(spec.look_up_bias);

            // SAFETY: plain state setting on the current context.
            unsafe {
                gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);
                gl.active_texture(glw::GL_TEXTURE0);
                gl.bind_texture(glw::GL_TEXTURE_CUBE_MAP, texture.gl_texture());
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_WRAP_S,
                    glw::GL_CLAMP_TO_EDGE as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_WRAP_T,
                    glw::GL_CLAMP_TO_EDGE as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_MIN_FILTER,
                    glw::GL_NEAREST as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_CUBE_MAP,
                    glw::GL_TEXTURE_MAG_FILTER,
                    glw::GL_NEAREST as i32,
                );
            }
            glu::expect_no_error(gl, "Set texturing state")?;

            renderer.render_quad(0, &tex_coord, &render_params.base)?;
            read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;
            glu::expect_no_error(gl, "glReadPixels()")?;

            let mut dst = SurfaceAccess::new(&mut reference_frame, render_target.pixel_format());
            sample_texture_cube_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

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

/// `TextureFormatTests::init`
pub fn create_tests() -> TestCaseGroup {
    const TEX_FORMATS: [(&str, u32, u32); 8] = [
        ("a8", glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("l8", glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        ("la88", glw::GL_LUMINANCE_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("rgb565", glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
        ("rgb888", glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        ("rgba4444", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4),
        ("rgba5551", glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_5_5_5_1),
        ("rgba8888", glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
    ];

    let mut group = TestCaseGroup::new("format");

    for &(name_base, format, data_type) in &TEX_FORMATS {
        group.add_child(Box::new(Texture2DFormatCase {
            name: format!("{name_base}_2d_pot"),
            format,
            data_type,
            width: 128,
            height: 128,
        }) as Box<dyn TestCase>);
        group.add_child(Box::new(Texture2DFormatCase {
            name: format!("{name_base}_2d_npot"),
            format,
            data_type,
            width: 63,
            height: 112,
        }) as Box<dyn TestCase>);
        group.add_child(Box::new(TextureCubeFormatCase {
            name: format!("{name_base}_cube_pot"),
            format,
            data_type,
            width: 64,
        }) as Box<dyn TestCase>);
        group.add_child(Box::new(TextureCubeFormatCase {
            name: format!("{name_base}_cube_npot"),
            format,
            data_type,
            width: 57,
        }) as Box<dyn TestCase>);
    }

    // ETC-1 compressed formats.
    for case in etc1_format_cases(GlslVersion::Es100, Precision::MediumP, false) {
        group.add_child(case);
    }

    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fTextureSwizzleTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `tcu::PixelFormat::convertColor` is a
// private helper here: this port's `tcu::PixelFormat` carries only the bit depths.

use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_test_util::{LodMode, TextureType, compute_quad_tex_coord_2d, get_sampler_type};
use crate::glu::texture_test_util_surface::{
    compare_images, fill_with_component_gradients_old, make_reference_params, sample_texture_2d_to_surface,
};
use crate::glu::{self, Context, GlslVersion, TestCase, TestCaseGroup, read_pixels};
use crate::glw;
use crate::tcu::pixel::get_texture_format_info;
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::SurfaceAccess;
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestOutcome, TestStatus, de_string_hash};

/// `swizzle(const tcu::RGBA &c, uint32_t swz)`
fn swizzle_channel(c: RGBA, swz: u32) -> i32 {
    match swz {
        glw::GL_RED => c.get_red(),
        glw::GL_GREEN => c.get_green(),
        glw::GL_BLUE => c.get_blue(),
        glw::GL_ALPHA => c.get_alpha(),
        glw::GL_ZERO => 0,
        glw::GL_ONE => (1 << 8) - 1,
        other => panic!("unknown swizzle source {other:#x}"),
    }
}

/// `swizzle(tcu::Surface &, swzR, swzG, swzB, swzA)`
fn swizzle_surface(surface: &mut Surface, swz_r: u32, swz_g: u32, swz_b: u32, swz_a: u32) {
    for y in 0..surface.get_height() {
        for x in 0..surface.get_width() {
            let p = surface.get_pixel(x, y);
            surface.set_pixel(
                x,
                y,
                RGBA::new(
                    swizzle_channel(p, swz_r),
                    swizzle_channel(p, swz_g),
                    swizzle_channel(p, swz_b),
                    swizzle_channel(p, swz_a),
                ),
            );
        }
    }
}

/// `tcu::PixelFormat::convertChannel`
fn convert_channel(val: i32, bits: i32) -> i32 {
    if bits == 0 {
        0
    } else if bits == 1 {
        if val & 0x80 != 0 { 0xff } else { 0 }
    } else if bits < 8 {
        // Emulate precision reduction by replicating the upper bits as the fractional component
        let int_comp = val >> (8 - bits);
        let fract_comp = (int_comp << (24 - bits)) | (int_comp << (24 - 2 * bits)) | (int_comp << (24 - 3 * bits));
        (int_comp << (8 - bits)) | (fract_comp >> (bits + 16))
    } else {
        // Bits greater than or equal to 8 will have full precision, so no reduction
        val
    }
}

/// `tcu::PixelFormat::convertColor`
fn convert_color(format: PixelFormat, col: RGBA) -> RGBA {
    RGBA::new(
        convert_channel(col.get_red(), format.red_bits),
        convert_channel(col.get_green(), format.green_bits),
        convert_channel(col.get_blue(), format.blue_bits),
        if format.alpha_bits != 0 {
            convert_channel(col.get_alpha(), format.alpha_bits)
        } else {
            0xff
        },
    )
}

struct Texture2DSwizzleCase {
    name: String,
    internal_format: u32,
    format: u32,
    data_type: u32,
    swizzle_r: u32,
    swizzle_g: u32,
    swizzle_b: u32,
    swizzle_a: u32,
}

impl TestCase for Texture2DSwizzleCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // `Texture2DSwizzleCase::init`
        let width = 128.min(render_target.width);
        let height = 128.min(render_target.height);
        let mut texture = if self.internal_format == self.format {
            Texture2D::new(render_ctx, self.format, self.data_type, width as u32, height as u32)?
        } else {
            Texture2D::new_sized(render_ctx, self.internal_format, width as u32, height as u32)?
        };
        let spec = get_texture_format_info(texture.ref_texture().format());

        // Fill level 0.
        texture.ref_texture_mut().alloc_level(0);
        {
            let mut level0 = texture.ref_texture_mut().level_mut(0);
            fill_with_component_gradients_old(&mut level0, spec.value_min, spec.value_max);
        }

        // `Texture2DSwizzleCase::iterate`
        let mut renderer = TextureRenderer::new(render_ctx, GlslVersion::Es300, Precision::HighP);
        let viewport = RandomViewport::new(
            &render_target,
            texture.ref_texture().width() as i32,
            texture.ref_texture().height() as i32,
            de_string_hash(&self.name),
        );
        let mut rendered_frame = Surface::new(viewport.width, viewport.height);
        let mut reference_frame = Surface::new(viewport.width, viewport.height);
        let threshold = render_target.pixel_format().get_color_threshold() + RGBA::new(1, 1, 1, 1);

        let mut render_params = make_reference_params(
            TextureType::Texture2D,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_NEAREST,
            glw::GL_NEAREST,
            LodMode::Exact,
        )?;
        render_params.base.sampler_type = get_sampler_type(texture.ref_texture().format());
        render_params.base.color_scale = Vec4::from_array(spec.look_up_scale);
        render_params.base.color_bias = Vec4::from_array(spec.look_up_bias);

        let tex_coord = compute_quad_tex_coord_2d(Vec2::new(0.0, 0.0), Vec2::new(1.0, 1.0));

        // SAFETY: a current context; `texture` outlives the upload.
        unsafe {
            // Setup base viewport.
            gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height);

            // Upload texture data to GL.
            texture.upload()?;

            // Bind to unit 0.
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());

            // Setup nearest neighbor filtering and clamp-to-edge.
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);

            // Setup texture swizzle.
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SWIZZLE_R, self.swizzle_r as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SWIZZLE_G, self.swizzle_g as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SWIZZLE_B, self.swizzle_b as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_SWIZZLE_A, self.swizzle_a as i32);
        }
        glu::expect_no_error(gl, "Set texturing state")?;

        // Draw.
        renderer.render_quad(0, &tex_coord, &render_params.base)?;
        read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered_frame.get_access())?;

        // Compute reference
        {
            let pixel_format = render_target.pixel_format();

            // Do initial rendering to RGBA8 in order to keep alpha
            let mut dst = SurfaceAccess::new(&mut reference_frame, PixelFormat::new(8, 8, 8, 8));
            sample_texture_2d_to_surface(&mut dst, texture.ref_texture(), tex_coord, &render_params)?;

            // Swizzle channels
            swizzle_surface(
                &mut reference_frame,
                self.swizzle_r,
                self.swizzle_g,
                self.swizzle_b,
                self.swizzle_a,
            );

            // Convert to destination format
            if pixel_format != PixelFormat::new(8, 8, 8, 8) {
                for y in 0..reference_frame.get_height() {
                    for x in 0..reference_frame.get_width() {
                        let p = reference_frame.get_pixel(x, y);
                        reference_frame.set_pixel(x, y, convert_color(pixel_format, p));
                    }
                }
            }
        }

        // Compare and log.
        if compare_images(&reference_frame, &rendered_frame, threshold).ok {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Image comparison failed"))
        }
    }
}

/// `TextureSwizzleTests::init`
pub fn create_tests() -> TestCaseGroup {
    // (name, internal format, format, data type)
    const FORMATS: [(&str, u32, u32, u32); 7] = [
        ("alpha", glw::GL_ALPHA, glw::GL_ALPHA, glw::GL_UNSIGNED_BYTE),
        ("luminance", glw::GL_LUMINANCE, glw::GL_LUMINANCE, glw::GL_UNSIGNED_BYTE),
        (
            "luminance_alpha",
            glw::GL_LUMINANCE_ALPHA,
            glw::GL_LUMINANCE_ALPHA,
            glw::GL_UNSIGNED_BYTE,
        ),
        ("red", glw::GL_R8, glw::GL_RED, glw::GL_UNSIGNED_BYTE),
        ("rg", glw::GL_RG8, glw::GL_RG, glw::GL_UNSIGNED_BYTE),
        ("rgb", glw::GL_RGB8, glw::GL_RGB, glw::GL_UNSIGNED_BYTE),
        ("rgba", glw::GL_RGBA8, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
    ];
    const CHANNELS: [&str; 4] = ["r", "g", "b", "a"];
    const SWIZZLES: [(&str, u32); 6] = [
        ("red", glw::GL_RED),
        ("green", glw::GL_GREEN),
        ("blue", glw::GL_BLUE),
        ("alpha", glw::GL_ALPHA),
        ("zero", glw::GL_ZERO),
        ("one", glw::GL_ONE),
    ];
    const SWIZZLE_CASES: [(&str, [u32; 4]); 9] = [
        ("all_red", [glw::GL_RED; 4]),
        ("all_green", [glw::GL_GREEN; 4]),
        ("all_blue", [glw::GL_BLUE; 4]),
        ("all_alpha", [glw::GL_ALPHA; 4]),
        ("all_zero", [glw::GL_ZERO; 4]),
        ("all_one", [glw::GL_ONE; 4]),
        ("bgra", [glw::GL_BLUE, glw::GL_GREEN, glw::GL_RED, glw::GL_ALPHA]),
        ("abgr", [glw::GL_ALPHA, glw::GL_BLUE, glw::GL_GREEN, glw::GL_RED]),
        (
            "one_one_red_green",
            [glw::GL_ONE, glw::GL_ONE, glw::GL_RED, glw::GL_GREEN],
        ),
    ];
    const DEFAULT_SWIZZLES: [u32; 4] = [glw::GL_RED, glw::GL_GREEN, glw::GL_BLUE, glw::GL_ALPHA];

    let mut group = TestCaseGroup::new("swizzle");

    // All swizzles applied to each channel.
    let mut single_channel_group = TestCaseGroup::new("single_channel");
    for (chan_ndx, &channel_name) in CHANNELS.iter().enumerate() {
        for &(swizzle_name, swz) in &SWIZZLES {
            if swz == DEFAULT_SWIZZLES[chan_ndx] {
                continue; // No need to test default case.
            }

            let mut swizzles = DEFAULT_SWIZZLES;
            swizzles[chan_ndx] = swz;

            single_channel_group.add_child(Box::new(Texture2DSwizzleCase {
                name: format!("{channel_name}_{swizzle_name}"),
                internal_format: glw::GL_RGBA8,
                format: glw::GL_RGBA,
                data_type: glw::GL_UNSIGNED_BYTE,
                swizzle_r: swizzles[0],
                swizzle_g: swizzles[1],
                swizzle_b: swizzles[2],
                swizzle_a: swizzles[3],
            }) as Box<dyn TestCase>);
        }
    }
    group.add_child(single_channel_group);

    // Swizzles for all formats.
    let mut multi_channel_group = TestCaseGroup::new("multi_channel");
    for &(format_name, internal_format, format, data_type) in &FORMATS {
        for &(case_name, swz) in &SWIZZLE_CASES {
            multi_channel_group.add_child(Box::new(Texture2DSwizzleCase {
                name: format!("{format_name}_{case_name}"),
                internal_format,
                format,
                data_type,
                swizzle_r: swz[0],
                swizzle_g: swz[1],
                swizzle_b: swz[2],
                swizzle_a: swz[3],
            }) as Box<dyn TestCase>);
        }
    }
    group.add_child(multi_channel_group);

    group
}

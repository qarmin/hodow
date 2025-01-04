// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fFboColorbufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// `.tex2d` (the three 16-bit normalised formats, `GL_EXT_texture_norm16`) is ported, on
// top of the ES 3.0 `FboTestCase` (the ES 3.1 one is the same class). `.texcubearray` (36
// cases) lives in `color_cube_array_tests.rs`. `FboTestCase::checkFormatSupport` is narrowed to the one extension
// those three formats name.

use crate::gles3::functional::fbo::fbo_test_case::{FboRender, FboTestCase, check_error, check_framebuffer_status};
use crate::gles3::functional::fbo::fbo_test_util::{
    Texture2DShader, get_format_threshold, get_fragment_output_type, read_pixels,
};
use crate::glu::texture_test_util_surface::fill_with_component_gradients_old;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format};
use crate::glu::{Context, TestCaseGroup};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel::{TextureLevel, get_texture_format_info};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::vector::Vec3;
use crate::tcu::{Surface, TestError};

const MIN_THRESHOLD: [u8; 4] = [12, 12, 12, 12];

/// `FboColorTex2DCase`
struct FboColorTex2DCase {
    tex_fmt: GLenum,
    tex_size: [i32; 2],
}

impl FboRender for FboColorTex2DCase {
    /// `preCheck` -> `checkFormatSupport(m_texFmt)`, for the formats this case is built with.
    fn pre_check(&self, context: &Context) -> Result<(), TestError> {
        if !context.context_info.is_extension_supported("GL_EXT_texture_norm16") {
            return Err(TestError::NotSupported("Format not supported".to_string()));
        }
        Ok(())
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let tex_fmt = map_gl_internal_format(self.tex_fmt)
            .ok_or_else(|| TestError::Fail(format!("unknown internal format {:#x}", self.tex_fmt)))?;
        let fmt_info = get_texture_format_info(tex_fmt);

        let out_scale: [f32; 4] = std::array::from_fn(|i| fmt_info.value_max[i] - fmt_info.value_min[i]);
        let tex_to_fbo_shader =
            Texture2DShader::new(1, get_fragment_output_type(tex_fmt), out_scale, fmt_info.value_min);
        let tex_to_fbo_uniforms = tex_to_fbo_shader.uniforms();
        let tex_to_fbo_shader_id = ctx.create_program(Box::new(tex_to_fbo_shader));

        // Setup shader
        tex_to_fbo_uniforms.set_uniforms(ctx, tex_to_fbo_shader_id);

        //  Generate fbo
        let mut fbo = [0u32];
        let mut tex = [0u32];
        {
            let transfer_fmt = get_transfer_format(tex_fmt)?;
            let format = self.tex_fmt;
            let size = self.tex_size;

            ctx.gen_framebuffers(&mut fbo);
            ctx.gen_textures(&mut tex);

            ctx.bind_texture(glw::GL_TEXTURE_2D, tex[0]);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
            ctx.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format,
                size[0],
                size[1],
                0,
                transfer_fmt.format,
                transfer_fmt.data_type,
                None,
            );

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);
            ctx.framebuffer_texture2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                tex[0],
                0,
            );
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
        }

        // Render texture to fbo
        {
            let format = glw::GL_RGBA;
            let data_type = glw::GL_UNSIGNED_BYTE;
            let tex_w = 128;
            let tex_h = 128;
            let viewport = self.tex_size;
            let mut data = TextureLevel::new(
                TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8),
                tex_w as u32,
                tex_h as u32,
                1,
            )?;

            fill_with_component_gradients_old(&mut data.get_access(), [0.0; 4], [1.0; 4]);

            let mut tmp_tex = [0u32];
            ctx.gen_textures(&mut tmp_tex);
            ctx.bind_texture(glw::GL_TEXTURE_2D, tmp_tex[0]);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_LINEAR as i32);
            ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_LINEAR as i32);
            ctx.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format,
                tex_w,
                tex_h,
                0,
                format,
                data_type,
                Some(data.data()),
            );

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo[0]);
            ctx.viewport(0, 0, viewport[0], viewport[1]);
            draw_quad(
                ctx,
                tex_to_fbo_shader_id,
                Vec3::new(-1.0, -1.0, 0.0),
                Vec3::new(1.0, 1.0, 0.0),
            );
        }

        let (width, height) = (ctx.get_width(), ctx.get_height());
        read_pixels(
            ctx,
            dst,
            0,
            0,
            width,
            height,
            tex_fmt,
            fmt_info.look_up_scale,
            fmt_info.look_up_bias,
        )?;
        check_error(ctx)
    }

    /// `FboColorbufferCase::compare`
    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        let Ok(format_threshold) = map_gl_internal_format(self.tex_fmt).map(get_format_threshold).ok_or(()) else {
            return false;
        };
        let threshold: [u8; 4] = std::array::from_fn(|i| format_threshold[i].max(MIN_THRESHOLD[i]));

        log::info!("Comparing images, threshold: {threshold:?}");

        bilinear_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            None,
            threshold,
        )
    }
}

/// `FboColorTests::init`
pub fn create_tests() -> TestCaseGroup {
    let unorm16_color_formats: [(&str, GLenum); 3] =
        [("r16", glw::GL_R16), ("rg16", glw::GL_RG16), ("rgba16", glw::GL_RGBA16)];

    let mut group = TestCaseGroup::new("color");

    group.add_child(super::color_cube_array_tests::create_tests());

    // .tex2d
    {
        let mut tex2d_group = TestCaseGroup::new("tex2d");

        for (name, format) in unorm16_color_formats {
            tex2d_group.add_child(FboTestCase::new(
                name,
                FboColorTex2DCase {
                    tex_fmt: format,
                    tex_size: [128, 128],
                },
            ));
        }

        group.add_child(tex2d_group);
    }

    group
}

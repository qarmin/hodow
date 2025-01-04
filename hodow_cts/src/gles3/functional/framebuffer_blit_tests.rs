// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFramebufferBlitTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.blit`: rect, conversion and depth_stencil. Each case is an `FboRender` run by
// `fbo::fbo_test_case::FboTestCase` against both `sglr::GLContext` and `sglr::ReferenceContext`.
//
// `default_framebuffer` blits through FBO 0, which is `glu::RenderContext::getDefaultFramebuffer()` here.
// `GradientShader`/`Texture2DShader` etc. come from `fbo::fbo_test_util`.

use super::fbo::fbo_test_case::{FboRender, FboTestCase, check_error, check_format_support, check_framebuffer_status};
use super::fbo::fbo_test_util::{
    ChannelClass, FlatColorShader, GradientShader, Texture2DShader, channel_class, get_format_name,
    get_format_threshold, get_format_threshold_gl, get_fragment_output_type, get_sampler_2d_type,
    get_to_srgb_conversion_threshold, read_pixels, set_flat_color, set_gradient,
};
use crate::glu::TestCaseGroup;
use crate::glu::shader_util::DataType;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::image_compare::pixel_threshold_compare;
use crate::tcu::pixel::{TextureFormatInfo, TextureLevel, fill_with_grid, get_texture_format_info};
use crate::tcu::rgba::{RGBA, compare_threshold};
use crate::tcu::vector::Vec3;
use crate::tcu::{ChannelOrder, Surface, TestError, TextureFormat};

type IVec4 = [i32; 4];

fn swizzle(v: IVec4, s: [usize; 4]) -> IVec4 {
    [v[s[0]], v[s[1]], v[s[2]], v[s[3]]]
}

fn gen_framebuffer(ctx: &mut dyn SglrContext) -> u32 {
    let mut names = [0u32];
    ctx.gen_framebuffers(&mut names);
    names[0]
}

fn gen_renderbuffer(ctx: &mut dyn SglrContext) -> u32 {
    let mut names = [0u32];
    ctx.gen_renderbuffers(&mut names);
    names[0]
}

fn gen_texture(ctx: &mut dyn SglrContext) -> u32 {
    let mut names = [0u32];
    ctx.gen_textures(&mut names);
    names[0]
}

fn map_format(format: GLenum) -> Result<TextureFormat, TestError> {
    map_gl_internal_format(format).ok_or_else(|| TestError::Fail(format!("unknown internal format {format:#x}")))
}

fn full_quad(ctx: &mut dyn SglrContext, program: u32, z0: f32, z1: f32) {
    draw_quad(ctx, program, Vec3::new(-1.0, -1.0, z0), Vec3::new(1.0, 1.0, z1));
}

/// Uploads a grid pattern as an `RGBA8` texture, bound to `GL_TEXTURE_2D` with clamp-to-edge and nearest filtering.
fn upload_grid_texture(
    ctx: &mut dyn SglrContext,
    width: i32,
    height: i32,
    cell_size: i32,
    color_a: [f32; 4],
    color_b: [f32; 4],
) -> Result<(), TestError> {
    let format = glw::GL_RGBA;
    let data_type = glw::GL_UNSIGNED_BYTE;
    let tex_format = map_gl_transfer_format(format, data_type)
        .ok_or_else(|| TestError::Fail("unknown transfer format GL_RGBA/GL_UNSIGNED_BYTE".to_string()))?;
    let mut data = TextureLevel::new(tex_format, width as u32, height as u32, 1)?;

    fill_with_grid(&mut data.get_access(), cell_size as u32, color_a, color_b);

    let grid_tex = gen_texture(ctx);
    ctx.bind_texture(glw::GL_TEXTURE_2D, grid_tex);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
    ctx.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        format,
        width,
        height,
        0,
        format,
        data_type,
        Some(data.data()),
    );
    Ok(())
}

fn color_threshold(context: &crate::glu::Context, extra: i32) -> RGBA {
    let t = context.render_target().pixel_format().get_color_threshold();
    RGBA::new(
        (t.get_red() + extra).min(255),
        (t.get_green() + extra).min(255),
        (t.get_blue() + extra).min(255),
        (t.get_alpha() + extra).min(255),
    )
}

/// `BlitRectCase` and, with `consistency` set, `BlitNearestFilterConsistencyCase`.
struct BlitRectCase {
    filter: GLenum,
    src_size: (i32, i32),
    src_rect: IVec4,
    dst_size: (i32, i32),
    dst_rect: IVec4,
    cell_size: i32,
    consistency: bool,
}

const GRID_CELL_COLOR_A: [f32; 4] = [0.2, 0.7, 0.1, 1.0];
const GRID_CELL_COLOR_B: [f32; 4] = [0.7, 0.1, 0.5, 0.8];

impl BlitRectCase {
    fn new(filter: GLenum, src_size: (i32, i32), src_rect: IVec4, dst_size: (i32, i32), dst_rect: IVec4) -> Self {
        Self {
            filter,
            src_size,
            src_rect,
            dst_size,
            dst_rect,
            cell_size: 8,
            consistency: false,
        }
    }

    /// `BlitNearestFilterConsistencyCase`
    fn nearest_consistency(src_size: (i32, i32), src_rect: IVec4, dst_size: (i32, i32), dst_rect: IVec4) -> Self {
        Self {
            filter: glw::GL_NEAREST,
            src_size,
            src_rect,
            dst_size,
            dst_rect,
            cell_size: 1,
            consistency: true,
        }
    }

    /// `BlitNearestFilterConsistencyCase::compare`
    fn compare_nearest_consistency(&self, context: &crate::glu::Context, result: &Surface) -> bool {
        // Image origin must be visible (for baseColor)
        debug_assert!(self.dst_rect[0].min(self.dst_rect[2]) >= 0);
        debug_assert!(self.dst_rect[1].min(self.dst_rect[3]) >= 0);

        let cell_color_a = RGBA::from_vec(crate::tcu::vector::Vec4::new(
            GRID_CELL_COLOR_A[0],
            GRID_CELL_COLOR_A[1],
            GRID_CELL_COLOR_A[2],
            GRID_CELL_COLOR_A[3],
        ));
        let cell_color_b = RGBA::from_vec(crate::tcu::vector::Vec4::new(
            GRID_CELL_COLOR_B[0],
            GRID_CELL_COLOR_B[1],
            GRID_CELL_COLOR_B[2],
            GRID_CELL_COLOR_B[3],
        ));
        let threshold = color_threshold(context, 7);
        let (w, h) = (result.get_width(), result.get_height());
        let r = self.dst_rect;
        let destination_area = [
            r[0].min(r[2]).clamp(0, w),
            r[1].min(r[3]).clamp(0, h),
            r[0].max(r[2]).clamp(0, w),
            r[1].max(r[3]).clamp(0, h),
        ];
        let base_color = result.get_pixel(destination_area[0], destination_area[1]);
        let sign_config = compare_threshold(base_color, cell_color_a, threshold);

        let area_w = destination_area[2] - destination_area[0];
        let area_h = destination_area[3] - destination_area[1];
        let mut error = false;
        let mut horisontal_sign = vec![false; area_w.max(0) as usize];
        let mut vertical_sign = vec![false; area_h.max(0) as usize];

        // Checking only area in our destination rect.
        // Verify that destination only contains valid colors.
        for dy in 0..area_h {
            for dx in 0..area_w {
                let color = result.get_pixel(destination_area[0] + dx, destination_area[1] + dy);
                let is_valid_color = compare_threshold(color, cell_color_a, threshold)
                    || compare_threshold(color, cell_color_b, threshold);

                if !is_valid_color {
                    error = true;
                }
            }
        }
        if error {
            // Image verification failed, destination rect contains unexpected values.
            return false;
        }

        // Detect result edges by reading the first row and first column of the blitted area.
        // Blitting a grid should result in a grid-like image. ("sign changes" should be consistent)
        for dx in 0..area_w {
            let color = result.get_pixel(destination_area[0] + dx, destination_area[1]);

            if compare_threshold(color, cell_color_a, threshold) {
                horisontal_sign[dx as usize] = true;
            } else if compare_threshold(color, cell_color_b, threshold) {
                horisontal_sign[dx as usize] = false;
            } else {
                debug_assert!(false);
            }
        }
        for dy in 0..area_h {
            let color = result.get_pixel(destination_area[0], destination_area[1] + dy);

            if compare_threshold(color, cell_color_a, threshold) {
                vertical_sign[dy as usize] = true;
            } else if compare_threshold(color, cell_color_b, threshold) {
                vertical_sign[dy as usize] = false;
            } else {
                debug_assert!(false);
            }
        }

        // Verify grid-like image
        for dy in 0..area_h {
            for dx in 0..area_w {
                let color = result.get_pixel(destination_area[0] + dx, destination_area[1] + dy);
                let result_sign = compare_threshold(cell_color_a, color, threshold);
                let correct_sign = (horisontal_sign[dx as usize] == vertical_sign[dy as usize]) == sign_config;

                if result_sign != correct_sign {
                    error = true;
                }
            }
        }

        !error
    }
}

impl FboRender for BlitRectCase {
    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_format = glw::GL_RGBA8;

        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));

        let mut fbos = [0u32; 2];

        // Setup shaders
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);
        tex_uniforms.set_uniforms(ctx, tex_shader_id);

        // Create framebuffers.
        for ndx in 0..2 {
            let size = if ndx == 1 { self.dst_size } else { self.src_size };

            let fbo = gen_framebuffer(ctx);
            let rbo = gen_renderbuffer(ctx);
            fbos[ndx] = fbo;

            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, color_format, size.0, size.1);

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo,
            );
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
        }
        let (src_fbo, dst_fbo) = (fbos[0], fbos[1]);

        // Fill destination with gradient.
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, dst_fbo);
        ctx.viewport(0, 0, self.dst_size.0, self.dst_size.1);
        full_quad(ctx, grad_shader_id, 0.0, 0.0);

        // Fill source with grid pattern.
        upload_grid_texture(
            ctx,
            self.src_size.0,
            self.src_size.1,
            self.cell_size,
            GRID_CELL_COLOR_A,
            GRID_CELL_COLOR_B,
        )?;
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, src_fbo);
        ctx.viewport(0, 0, self.src_size.0, self.src_size.1);
        full_quad(ctx, tex_shader_id, 0.0, 0.0);

        // Perform copy.
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, src_fbo);
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, dst_fbo);
        ctx.blit_framebuffer(
            self.src_rect[0],
            self.src_rect[1],
            self.src_rect[2],
            self.src_rect[3],
            self.dst_rect[0],
            self.dst_rect[1],
            self.dst_rect[2],
            self.dst_rect[3],
            glw::GL_COLOR_BUFFER_BIT,
            self.filter,
        );

        // Read back results.
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo);
        read_pixels(
            ctx,
            dst,
            0,
            0,
            self.dst_size.0,
            self.dst_size.1,
            map_format(color_format)?,
            [1.0; 4],
            [0.0; 4],
        )
    }

    fn compare_in(&self, context: &crate::glu::Context, reference: &Surface, result: &Surface) -> bool {
        if self.consistency {
            return self.compare_nearest_consistency(context, result);
        }

        // Use pixel-threshold compare for rect cases since 1px off will mean failure.
        let threshold = color_threshold(context, 7);
        reference.get_const_access().size() == result.get_const_access().size()
            && pixel_threshold_compare(reference, result, threshold).ok
    }
}

/// `getChannelMask`
fn get_channel_mask(order: ChannelOrder) -> [bool; 4] {
    match order {
        ChannelOrder::R => [true, false, false, false],
        ChannelOrder::RG => [true, true, false, false],
        ChannelOrder::RGB => [true, true, true, false],
        ChannelOrder::RGBA => [true, true, true, true],
        ChannelOrder::sRGB => [true, true, true, false],
        ChannelOrder::sRGBA => [true, true, true, true],
        _ => {
            debug_assert!(false);
            [false; 4]
        }
    }
}

/// `tcu::TextureFormatInfo` field-wise `select(dst, src, cond)`.
fn select_info(cond: [bool; 4], if_true: &TextureFormatInfo, if_false: &TextureFormatInfo) -> TextureFormatInfo {
    let pick = |t: [f32; 4], f: [f32; 4]| [0, 1, 2, 3].map(|i| if cond[i] { t[i] } else { f[i] });
    TextureFormatInfo {
        value_min: pick(if_true.value_min, if_false.value_min),
        value_max: pick(if_true.value_max, if_false.value_max),
        look_up_scale: pick(if_true.look_up_scale, if_false.look_up_scale),
        look_up_bias: pick(if_true.look_up_bias, if_false.look_up_bias),
    }
}

/// `BlitColorConversionCase`
struct BlitColorConversionCase {
    src_format: GLenum,
    dst_format: GLenum,
    size: (i32, i32),
}

impl FboRender for BlitColorConversionCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.src_format)?;
        check_format_support(context, self.dst_format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let src_format = map_format(self.src_format)?;
        let dst_format = map_format(self.dst_format)?;
        let src_output_type = get_fragment_output_type(src_format);
        let dst_output_type = get_fragment_output_type(dst_format);

        // Compute ranges \note Doesn't handle case where src or dest is not subset of the another!
        let src_fmt_range_info = get_texture_format_info(src_format);
        let dst_fmt_range_info = get_texture_format_info(dst_format);
        let src_mask = get_channel_mask(src_format.order);
        let dst_mask = get_channel_mask(dst_format.order);
        let copy_mask = [0, 1, 2, 3].map(|i| src_mask[i] && dst_mask[i]);
        let src_is_greater = [0, 1, 2, 3].map(|i| {
            src_fmt_range_info.value_max[i] - src_fmt_range_info.value_min[i]
                > dst_fmt_range_info.value_max[i] - dst_fmt_range_info.value_min[i]
        });
        let src_cond = [0, 1, 2, 3].map(|i| copy_mask[i] && src_is_greater[i]);
        let dst_cond = [0, 1, 2, 3].map(|i| !copy_mask[i] || src_is_greater[i]);
        let src_range_info = select_info(src_cond, &dst_fmt_range_info, &src_fmt_range_info);
        let dst_range_info = select_info(dst_cond, &dst_fmt_range_info, &src_fmt_range_info);

        // Shaders.
        let grad_shader_src_id = ctx.create_program(Box::new(GradientShader::new(src_output_type)));
        let grad_shader_dst_id = ctx.create_program(Box::new(GradientShader::new(dst_output_type)));

        let mut fbos = [0u32; 2];

        // Create framebuffers.
        for ndx in 0..2 {
            let format = if ndx == 1 { self.dst_format } else { self.src_format };

            let fbo = gen_framebuffer(ctx);
            let rbo = gen_renderbuffer(ctx);
            fbos[ndx] = fbo;

            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, format, self.size.0, self.size.1);

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                rbo,
            );
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
        }
        let (src_fbo, dst_fbo) = (fbos[0], fbos[1]);

        ctx.viewport(0, 0, self.size.0, self.size.1);

        // Render gradients.
        for ndx in 0..2 {
            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, if ndx == 1 { dst_fbo } else { src_fbo });

            if ndx == 1 {
                set_gradient(
                    ctx,
                    grad_shader_dst_id,
                    dst_range_info.value_max,
                    dst_range_info.value_min,
                );
                full_quad(ctx, grad_shader_dst_id, 0.0, 0.0);
            } else {
                set_gradient(
                    ctx,
                    grad_shader_src_id,
                    src_range_info.value_min,
                    dst_range_info.value_max,
                );
                full_quad(ctx, grad_shader_src_id, 0.0, 0.0);
            }
        }

        // Execute copy.
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, src_fbo);
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, dst_fbo);
        ctx.blit_framebuffer(
            0,
            0,
            self.size.0,
            self.size.1,
            0,
            0,
            self.size.0,
            self.size.1,
            glw::GL_COLOR_BUFFER_BIT,
            glw::GL_NEAREST,
        );
        check_error(ctx)?;

        // Read results.
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo);
        read_pixels(
            ctx,
            dst,
            0,
            0,
            self.size.0,
            self.size.1,
            dst_format,
            dst_range_info.look_up_scale,
            dst_range_info.look_up_bias,
        )
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        let (Ok(src_format), Ok(dst_format)) = (map_format(self.src_format), map_format(self.dst_format)) else {
            return false;
        };
        let src_is_srgb = src_format.order.is_srgb();
        let dst_is_srgb = dst_format.order.is_srgb();

        let threshold = if dst_is_srgb {
            get_to_srgb_conversion_threshold(src_format, dst_format)
        } else {
            let mut src_max_diff = get_format_threshold(src_format);
            if src_is_srgb {
                for c in src_max_diff.iter_mut() {
                    *c = c.saturating_mul(2);
                }
            }
            let dst_max_diff = get_format_threshold(dst_format);
            [0, 1, 2, 3].map(|i| src_max_diff[i].max(dst_max_diff[i]))
        };

        let threshold = RGBA::new(
            threshold[0] as i32,
            threshold[1] as i32,
            threshold[2] as i32,
            threshold[3] as i32,
        );
        reference.get_const_access().size() == result.get_const_access().size()
            && pixel_threshold_compare(reference, result, threshold).ok
    }
}

/// `BlitDepthStencilCase`
struct BlitDepthStencilCase {
    depth_format: GLenum,
    stencil_format: GLenum,
    src_buffers: u32,
    src_size: (i32, i32),
    src_rect: IVec4,
    dst_buffers: u32,
    dst_size: (i32, i32),
    dst_rect: IVec4,
    copy_buffers: u32,
}

impl FboRender for BlitDepthStencilCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        if self.depth_format != glw::GL_NONE {
            check_format_support(context, self.depth_format)?;
        }
        if self.stencil_format != glw::GL_NONE {
            check_format_support(context, self.stencil_format)?;
        }
        if !context
            .context_info
            .is_extension_supported("GL_EXT_separate_depth_stencil")
            && self.depth_format != glw::GL_NONE
            && self.stencil_format != glw::GL_NONE
        {
            return Err(TestError::NotSupported(
                "Separate depth and stencil buffers not supported".to_string(),
            ));
        }
        Ok(())
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_format = glw::GL_RGBA8;

        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));
        let flat_shader_id = ctx.create_program(Box::new(FlatColorShader::new(DataType::FloatVec4)));

        let mut fbos = [0u32; 2];

        // setup shaders
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);
        tex_uniforms.set_uniforms(ctx, tex_shader_id);

        // Create framebuffers.
        for ndx in 0..2 {
            let bufs = if ndx == 1 { self.dst_buffers } else { self.src_buffers };
            let size = if ndx == 1 { self.dst_size } else { self.src_size };
            let mut depth_rbo = 0;
            let mut stencil_rbo = 0;

            let fbo = gen_framebuffer(ctx);
            let color_rbo = gen_renderbuffer(ctx);
            fbos[ndx] = fbo;

            ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, color_rbo);
            ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, color_format, size.0, size.1);

            if self.depth_format != glw::GL_NONE {
                depth_rbo = gen_renderbuffer(ctx);
                ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, depth_rbo);
                ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.depth_format, size.0, size.1);
            }

            if self.stencil_format != glw::GL_NONE {
                stencil_rbo = gen_renderbuffer(ctx);
                ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, stencil_rbo);
                ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.stencil_format, size.0, size.1);
            }

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            ctx.framebuffer_renderbuffer(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_RENDERBUFFER,
                color_rbo,
            );

            if bufs & glw::GL_DEPTH_BUFFER_BIT != 0 {
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_DEPTH_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    depth_rbo,
                );
            }
            if bufs & glw::GL_STENCIL_BUFFER_BIT != 0 {
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_STENCIL_ATTACHMENT,
                    glw::GL_RENDERBUFFER,
                    if self.stencil_format == glw::GL_NONE {
                        depth_rbo
                    } else {
                        stencil_rbo
                    },
                );
            }

            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

            // Clear depth to 1 and stencil to 0.
            ctx.clear_buffer_fi(glw::GL_DEPTH_STENCIL, 0, 1.0, 0);
        }
        let (src_fbo, dst_fbo) = (fbos[0], fbos[1]);

        // Fill source with gradient, depth = [-1..1], stencil = 7
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, src_fbo);
        ctx.viewport(0, 0, self.src_size.0, self.src_size.1);
        ctx.enable(glw::GL_DEPTH_TEST);
        ctx.enable(glw::GL_STENCIL_TEST);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_REPLACE);
        ctx.stencil_func(glw::GL_ALWAYS, 7, 0xff);

        full_quad(ctx, grad_shader_id, -1.0, 1.0);

        // Fill destination with grid pattern, depth = 0 and stencil = 1
        {
            upload_grid_texture(
                ctx,
                self.src_size.0,
                self.src_size.1,
                8,
                [0.2, 0.7, 0.1, 1.0],
                [0.7, 0.1, 0.5, 0.8],
            )?;

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, dst_fbo);
            ctx.viewport(0, 0, self.dst_size.0, self.dst_size.1);
            ctx.stencil_func(glw::GL_ALWAYS, 1, 0xff);
            full_quad(ctx, tex_shader_id, 0.0, 0.0);
        }

        // Perform copy.
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, src_fbo);
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, dst_fbo);
        ctx.blit_framebuffer(
            self.src_rect[0],
            self.src_rect[1],
            self.src_rect[2],
            self.src_rect[3],
            self.dst_rect[0],
            self.dst_rect[1],
            self.dst_rect[2],
            self.dst_rect[3],
            self.copy_buffers,
            glw::GL_NEAREST,
        );

        // Render blue color where depth < 0, decrement on depth failure.
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, dst_fbo);
        ctx.viewport(0, 0, self.dst_size.0, self.dst_size.1);
        ctx.stencil_op(glw::GL_KEEP, glw::GL_DECR, glw::GL_KEEP);
        ctx.stencil_func(glw::GL_ALWAYS, 0, 0xff);

        set_flat_color(ctx, flat_shader_id, [0.0, 0.0, 1.0, 1.0]);
        full_quad(ctx, flat_shader_id, 0.0, 0.0);

        if self.dst_buffers & glw::GL_STENCIL_BUFFER_BIT != 0 {
            // Render green color where stencil == 6.
            ctx.disable(glw::GL_DEPTH_TEST);
            ctx.stencil_op(glw::GL_KEEP, glw::GL_KEEP, glw::GL_KEEP);
            ctx.stencil_func(glw::GL_EQUAL, 6, 0xff);

            set_flat_color(ctx, flat_shader_id, [0.0, 1.0, 0.0, 1.0]);
            full_quad(ctx, flat_shader_id, 0.0, 0.0);
        }

        read_pixels(
            ctx,
            dst,
            0,
            0,
            self.dst_size.0,
            self.dst_size.1,
            map_format(color_format)?,
            [1.0; 4],
            [0.0; 4],
        )
    }
}

/// `glu::isGLInternalColorFormatFilterable`
fn is_color_format_filterable(format: GLenum, tex_format: TextureFormat) -> bool {
    !matches!(channel_class(tex_format.type_), ChannelClass::Int | ChannelClass::Uint)
        && !matches!(format, glw::GL_R32F | glw::GL_RG32F | glw::GL_RGB32F | glw::GL_RGBA32F)
}

/// The comparison `BlitDefaultFramebufferCase` and `DefaultFramebufferBlitCase` share.
fn compare_default_framebuffer_blit(format: GLenum, reference: &Surface, result: &Surface) -> bool {
    let Ok(format_threshold) = get_format_threshold_gl(format) else {
        return false;
    };
    let threshold = [
        format_threshold[0].max(12),
        format_threshold[1].max(12),
        format_threshold[2].max(12),
        format_threshold[3].max(12),
    ];
    reference.get_const_access().size() == result.get_const_access().size()
        && bilinear_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            None,
            threshold,
        )
}

/// Creates the `texW x texH` texture-backed FBO both default-framebuffer cases use and returns `(fbo, tex)`.
fn create_texture_fbo(
    ctx: &mut dyn SglrContext,
    format: GLenum,
    filter: GLenum,
    tex_w: i32,
    tex_h: i32,
) -> Result<(u32, u32), TestError> {
    let color_format = map_format(format)?;
    let transfer_fmt = get_transfer_format(color_format)?;

    let fbo = gen_framebuffer(ctx);
    let tex = gen_texture(ctx);
    ctx.bind_texture(glw::GL_TEXTURE_2D, tex);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, filter as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, filter as i32);
    ctx.tex_image_2d(
        glw::GL_TEXTURE_2D,
        0,
        format,
        tex_w,
        tex_h,
        0,
        transfer_fmt.format,
        transfer_fmt.data_type,
        None,
    );

    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
    ctx.framebuffer_texture2d(
        glw::GL_FRAMEBUFFER,
        glw::GL_COLOR_ATTACHMENT0,
        glw::GL_TEXTURE_2D,
        tex,
        0,
    );
    check_error(ctx)?;
    check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
    Ok((fbo, tex))
}

/// `BlitDefaultFramebufferCase`
struct BlitDefaultFramebufferCase {
    format: GLenum,
    filter: GLenum,
}

impl FboRender for BlitDefaultFramebufferCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        if context.render_target().num_samples > 0 {
            return Err(TestError::NotSupported("Not supported in MSAA config".to_string()));
        }
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_format = map_format(self.format)?;
        let (width, height) = (ctx.get_width(), ctx.get_height());
        let tex_w = 128;
        let tex_h = 128;

        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));
        let tex_shader = Texture2DShader::with_samplers(
            &[get_sampler_2d_type(color_format)],
            DataType::FloatVec4,
            [1.0; 4],
            [0.0; 4],
        );
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));

        // Setup shaders
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);
        tex_uniforms.set_uniforms(ctx, tex_shader_id);

        // FBO
        let (fbo, _tex) = create_texture_fbo(ctx, self.format, self.filter, tex_w, tex_h)?;

        // Render gradient to screen.
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        full_quad(ctx, grad_shader_id, 0.0, 0.0);

        // Blit gradient from screen to fbo.
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo);
        ctx.blit_framebuffer(
            0,
            0,
            width,
            height,
            0,
            0,
            tex_w,
            tex_h,
            glw::GL_COLOR_BUFFER_BIT,
            self.filter,
        );

        // Fill left half of viewport with quad that uses texture.
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, 0);
        ctx.clear_buffer_fv(glw::GL_COLOR, 0, &[1.0, 0.0, 0.0, 1.0]);
        draw_quad(ctx, tex_shader_id, Vec3::new(-1.0, -1.0, 0.0), Vec3::new(0.0, 1.0, 0.0));

        // Blit fbo to right half.
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo);
        ctx.blit_framebuffer(
            0,
            0,
            tex_w,
            tex_h,
            width / 2,
            0,
            width,
            height,
            glw::GL_COLOR_BUFFER_BIT,
            self.filter,
        );
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, 0);

        dst.set_size(width, height);
        ctx.read_pixels(dst, 0, 0, width, height);
        Ok(())
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_default_framebuffer_blit(self.format, reference, result)
    }
}

/// `DefaultFramebufferBlitCase`
struct DefaultFramebufferBlitCase {
    format: GLenum,
    filter: GLenum,
    /// `BLIT_TO_DEFAULT_FROM_TARGET`, otherwise `BLIT_DEFAULT_TO_TARGET`.
    to_default: bool,
    /// `AREA_OUT_OF_BOUNDS`, otherwise `AREA_SCALE`.
    out_of_bounds: bool,
}

impl FboRender for DefaultFramebufferBlitCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        // `init`: the viewport is the whole render target and must be at least 128x128.
        let min_viewport_size = 128;
        let rt = context.render_target();
        if rt.width < min_viewport_size || rt.height < min_viewport_size {
            return Err(TestError::NotSupported(format!(
                "Viewport size {min_viewport_size}x{min_viewport_size} required"
            )));
        }
        if rt.num_samples > 0 {
            return Err(TestError::NotSupported("Not supported in MSAA config".to_string()));
        }
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let color_format = map_format(self.format)?;
        let (screen_w, screen_h) = (ctx.get_width(), ctx.get_height());

        // `init`: set proper areas
        let (src_rect, dst_rect, interesting_area): (IVec4, IVec4, IVec4) = if !self.out_of_bounds {
            ([10, 20, 65, 100], [25, 30, 125, 94], [0, 0, 128, 128])
        } else {
            let (ux, uy) = if self.to_default {
                (screen_w, screen_h)
            } else {
                (128, 128)
            };
            (
                [-10, -15, 100, 63],
                [ux - 75, uy - 99, ux + 8, uy + 16],
                [ux - 128, uy - 128, ux, uy],
            )
        };

        let target_class = if self.to_default {
            ChannelClass::Fixed
        } else {
            channel_class(color_format.type_)
        };
        let fbo_tex_w = 128;
        let fbo_tex_h = 128;
        let source_width = if self.to_default { fbo_tex_w } else { screen_w };
        let source_height = if self.to_default { fbo_tex_h } else { screen_h };
        let grid_render_width = 256.min(source_width);
        let grid_render_height = 256.min(source_height);

        // FBO
        let (fbo, _fbo_tex) = create_texture_fbo(ctx, self.format, self.filter, fbo_tex_w, fbo_tex_h)?;

        let target_fbo = if self.to_default { 0 } else { fbo };
        let source_fbo = if self.to_default { fbo } else { 0 };

        // Render grid to source framebuffer
        {
            let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
            let tex_uniforms = tex_shader.uniforms();
            let tex_shader_id = ctx.create_program(Box::new(tex_shader));

            upload_grid_texture(ctx, 128, 128, 9, [0.9, 0.5, 0.1, 0.9], [0.2, 0.8, 0.2, 0.7])?;

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, source_fbo);
            ctx.viewport(0, 0, grid_render_width, grid_render_height);
            ctx.clear_buffer_fv(glw::GL_COLOR, 0, &[1.0, 0.0, 0.0, 1.0]);

            tex_uniforms.set_uniforms(ctx, tex_shader_id);
            full_quad(ctx, tex_shader_id, 0.0, 0.0);
            ctx.use_program(0);
        }

        // Blit source framebuffer to destination
        ctx.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, source_fbo);
        ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, target_fbo);
        check_error(ctx)?;

        match target_class {
            ChannelClass::Fixed | ChannelClass::Float => ctx.clear_buffer_fv(glw::GL_COLOR, 0, &[1.0, 1.0, 0.0, 1.0]),
            ChannelClass::Int => ctx.clear_buffer_iv(glw::GL_COLOR, 0, &[0; 4]),
            ChannelClass::Uint => ctx.clear_buffer_uiv(glw::GL_COLOR, 0, &[0; 4]),
        }

        ctx.blit_framebuffer(
            src_rect[0],
            src_rect[1],
            src_rect[2],
            src_rect[3],
            dst_rect[0],
            dst_rect[1],
            dst_rect[2],
            dst_rect[3],
            glw::GL_COLOR_BUFFER_BIT,
            self.filter,
        );
        check_error(ctx)?;

        // Read target
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, target_fbo);
        let (ix, iy, iw, ih) = (
            interesting_area[0],
            interesting_area[1],
            interesting_area[2] - interesting_area[0],
            interesting_area[3] - interesting_area[1],
        );
        if self.to_default {
            dst.set_size(iw, ih);
            ctx.read_pixels(dst, ix, iy, iw, ih);
        } else {
            read_pixels(ctx, dst, ix, iy, iw, ih, color_format, [1.0; 4], [0.0; 4])?;
        }
        check_error(ctx)
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_default_framebuffer_blit(self.format, reference, result)
    }
}

/// `FramebufferBlitTests::init`
pub fn create_tests() -> TestCaseGroup {
    let color_formats: [GLenum; 35] = [
        // RGBA formats
        glw::GL_RGBA32I,
        glw::GL_RGBA32UI,
        glw::GL_RGBA16I,
        glw::GL_RGBA16UI,
        glw::GL_RGBA8,
        glw::GL_RGBA8I,
        glw::GL_RGBA8UI,
        glw::GL_SRGB8_ALPHA8,
        glw::GL_RGB10_A2,
        glw::GL_RGB10_A2UI,
        glw::GL_RGBA4,
        glw::GL_RGB5_A1,
        // RGB formats
        glw::GL_RGB8,
        glw::GL_RGB565,
        // RG formats
        glw::GL_RG32I,
        glw::GL_RG32UI,
        glw::GL_RG16I,
        glw::GL_RG16UI,
        glw::GL_RG8,
        glw::GL_RG8I,
        glw::GL_RG8UI,
        // R formats
        glw::GL_R32I,
        glw::GL_R32UI,
        glw::GL_R16I,
        glw::GL_R16UI,
        glw::GL_R8,
        glw::GL_R8I,
        glw::GL_R8UI,
        // GL_EXT_color_buffer_float
        glw::GL_RGBA32F,
        glw::GL_RGBA16F,
        glw::GL_R11F_G11F_B10F,
        glw::GL_RG32F,
        glw::GL_RG16F,
        glw::GL_R32F,
        glw::GL_R16F,
    ];

    let depth_stencil_formats: [GLenum; 6] = [
        glw::GL_NONE,
        glw::GL_DEPTH_COMPONENT32F,
        glw::GL_DEPTH_COMPONENT24,
        glw::GL_DEPTH_COMPONENT16,
        glw::GL_DEPTH32F_STENCIL8,
        glw::GL_DEPTH24_STENCIL8,
    ];

    let stencil_formats: [GLenum; 2] = [glw::GL_NONE, glw::GL_STENCIL_INDEX8];

    let mut group = TestCaseGroup::new("blit");

    // .rect
    {
        // (name, src rect, dst rect)
        let copy_rects: [(&str, IVec4, IVec4); 3] = [
            ("basic", [10, 20, 65, 100], [45, 5, 100, 85]),
            ("scale", [10, 20, 65, 100], [25, 30, 125, 94]),
            ("out_of_bounds", [-10, -15, 100, 63], [50, 30, 136, 144]),
        ];

        let filter_consistency_rects: [(&str, IVec4, IVec4); 4] = [
            ("mag", [20, 10, 74, 88], [10, 10, 91, 101]),
            ("min", [10, 20, 78, 100], [20, 20, 71, 80]),
            ("out_of_bounds_mag", [21, 10, 73, 82], [11, 43, 141, 151]),
            ("out_of_bounds_min", [11, 21, 77, 97], [80, 82, 135, 139]),
        ];

        // (name, src swizzle, dst swizzle)
        let swizzles: [(Option<&str>, [usize; 4], [usize; 4]); 7] = [
            (None, [0, 1, 2, 3], [0, 1, 2, 3]),
            (Some("reverse_src_x"), [2, 1, 0, 3], [0, 1, 2, 3]),
            (Some("reverse_src_y"), [0, 3, 2, 1], [0, 1, 2, 3]),
            (Some("reverse_dst_x"), [0, 1, 2, 3], [2, 1, 0, 3]),
            (Some("reverse_dst_y"), [0, 1, 2, 3], [0, 3, 2, 1]),
            (Some("reverse_src_dst_x"), [2, 1, 0, 3], [2, 1, 0, 3]),
            (Some("reverse_src_dst_y"), [0, 3, 2, 1], [0, 3, 2, 1]),
        ];

        let src_size = (127, 119);
        let dst_size = (132, 128);

        // Blit rectangle tests.
        let mut rect_group = TestCaseGroup::new("rect");

        for (rect_name, rect_src, rect_dst) in copy_rects {
            for (swz_name, src_swz, dst_swz) in swizzles {
                let name = match swz_name {
                    Some(swz) => format!("{rect_name}_{swz}"),
                    None => rect_name.to_string(),
                };
                let src_rect = swizzle(rect_src, src_swz);
                let dst_rect = swizzle(rect_dst, dst_swz);

                rect_group.add_child(FboTestCase::new(
                    format!("{name}_nearest"),
                    BlitRectCase::new(glw::GL_NEAREST, src_size, src_rect, dst_size, dst_rect),
                ));
                rect_group.add_child(FboTestCase::new(
                    format!("{name}_linear"),
                    BlitRectCase::new(glw::GL_LINEAR, src_size, src_rect, dst_size, dst_rect),
                ));
            }
        }

        // Nearest filter tests
        for (rect_name, rect_src, rect_dst) in filter_consistency_rects {
            for (swz_name, src_swz, dst_swz) in swizzles {
                let name = match swz_name {
                    Some(swz) => format!("nearest_consistency_{rect_name}_{swz}"),
                    None => format!("nearest_consistency_{rect_name}"),
                };
                let src_rect = swizzle(rect_src, src_swz);
                let dst_rect = swizzle(rect_dst, dst_swz);

                rect_group.add_child(FboTestCase::new(
                    name,
                    BlitRectCase::nearest_consistency(src_size, src_rect, dst_size, dst_rect),
                ));
            }
        }

        group.add_child(rect_group);
    }

    // .conversion
    {
        let mut conversion_group = TestCaseGroup::new("conversion");

        for src_format in color_formats {
            for dst_format in color_formats {
                let (Some(src_tex_fmt), Some(dst_tex_fmt)) =
                    (map_gl_internal_format(src_format), map_gl_internal_format(dst_format))
                else {
                    continue;
                };
                let src_type = channel_class(src_tex_fmt.type_);
                let dst_type = channel_class(dst_tex_fmt.type_);

                let float_or_unsigned_fixed = |c: ChannelClass| matches!(c, ChannelClass::Float | ChannelClass::Fixed);

                if float_or_unsigned_fixed(src_type) != float_or_unsigned_fixed(dst_type)
                    || (src_type == ChannelClass::Int) != (dst_type == ChannelClass::Int)
                    || (src_type == ChannelClass::Uint) != (dst_type == ChannelClass::Uint)
                {
                    continue; // Conversion not supported.
                }

                let name = format!("{}_to_{}", get_format_name(src_format), get_format_name(dst_format));
                conversion_group.add_child(FboTestCase::new(
                    name,
                    BlitColorConversionCase {
                        src_format,
                        dst_format,
                        size: (127, 113),
                    },
                ));
            }
        }

        group.add_child(conversion_group);
    }

    // .depth_stencil
    {
        let mut depth_stencil_group = TestCaseGroup::new("depth_stencil");

        for depth_format in depth_stencil_formats {
            for stencil_format in stencil_formats {
                let mut depth = false;
                let mut stencil = false;
                let mut fmt_name = String::new();

                if depth_format != glw::GL_NONE {
                    let Ok(info) = map_format(depth_format) else { continue };
                    fmt_name.push_str(get_format_name(depth_format));
                    if info.order == ChannelOrder::D || info.order == ChannelOrder::DS {
                        depth = true;
                    }
                    if info.order == ChannelOrder::DS {
                        stencil = true;
                    }
                }

                if stencil_format != glw::GL_NONE {
                    // Do not try separate stencil along with a combined depth/stencil
                    if stencil {
                        continue;
                    }

                    if depth_format != glw::GL_NONE {
                        fmt_name.push('_');
                    }
                    fmt_name.push_str(get_format_name(stencil_format));
                    stencil = true;
                }

                if !stencil && !depth {
                    continue;
                }

                let buffers = (if depth { glw::GL_DEPTH_BUFFER_BIT } else { 0 })
                    | (if stencil { glw::GL_STENCIL_BUFFER_BIT } else { 0 });

                let case = |src_size: (i32, i32), src_rect: IVec4, dst_size: (i32, i32), dst_rect: IVec4, copy: u32| {
                    BlitDepthStencilCase {
                        depth_format,
                        stencil_format,
                        src_buffers: buffers,
                        src_size,
                        src_rect,
                        dst_buffers: buffers,
                        dst_size,
                        dst_rect,
                        copy_buffers: copy,
                    }
                };

                depth_stencil_group.add_child(FboTestCase::new(
                    format!("{fmt_name}_basic"),
                    case((128, 128), [0, 0, 128, 128], (128, 128), [0, 0, 128, 128], buffers),
                ));
                depth_stencil_group.add_child(FboTestCase::new(
                    format!("{fmt_name}_scale"),
                    case((127, 119), [10, 30, 100, 70], (111, 130), [20, 5, 80, 130], buffers),
                ));

                if depth && stencil {
                    depth_stencil_group.add_child(FboTestCase::new(
                        format!("{fmt_name}_depth_only"),
                        case(
                            (128, 128),
                            [0, 0, 128, 128],
                            (128, 128),
                            [0, 0, 128, 128],
                            glw::GL_DEPTH_BUFFER_BIT,
                        ),
                    ));
                    depth_stencil_group.add_child(FboTestCase::new(
                        format!("{fmt_name}_stencil_only"),
                        case(
                            (128, 128),
                            [0, 0, 128, 128],
                            (128, 128),
                            [0, 0, 128, 128],
                            glw::GL_STENCIL_BUFFER_BIT,
                        ),
                    ));
                }
            }
        }

        group.add_child(depth_stencil_group);
    }

    // .default_framebuffer
    {
        // (name, out of bounds)
        let areas: [(&str, bool); 2] = [("scale", false), ("out_of_bounds", true)];

        let mut default_fb_group = TestCaseGroup::new("default_framebuffer");

        for format in color_formats {
            let Some(tex_fmt) = map_gl_internal_format(format) else {
                continue;
            };
            let fmt_class = channel_class(tex_fmt.type_);
            let filterable = is_color_format_filterable(format, tex_fmt);
            let filter = if filterable { glw::GL_LINEAR } else { glw::GL_NEAREST };

            if fmt_class != ChannelClass::Float && fmt_class != ChannelClass::Fixed {
                continue; // Conversion not supported.
            }

            default_fb_group.add_child(FboTestCase::new(
                get_format_name(format),
                BlitDefaultFramebufferCase { format, filter },
            ));

            for (area_name, out_of_bounds) in areas {
                let add_linear = filterable;
                // No need to check out-of-bounds with different filtering
                let add_nearest = !add_linear || !out_of_bounds;

                for (filter_name, filter, enabled) in [
                    ("nearest", glw::GL_NEAREST, add_nearest),
                    ("linear", glw::GL_LINEAR, add_linear),
                ] {
                    if !enabled {
                        continue;
                    }
                    default_fb_group.add_child(FboTestCase::new_screen_sized(
                        format!(
                            "{}_{filter_name}_{area_name}_blit_from_default",
                            get_format_name(format)
                        ),
                        DefaultFramebufferBlitCase {
                            format,
                            filter,
                            to_default: false,
                            out_of_bounds,
                        },
                    ));
                    default_fb_group.add_child(FboTestCase::new_screen_sized(
                        format!("{}_{filter_name}_{area_name}_blit_to_default", get_format_name(format)),
                        DefaultFramebufferBlitCase {
                            format,
                            filter,
                            to_default: true,
                            out_of_bounds,
                        },
                    ));
                }
            }
        }

        group.add_child(default_fb_group);
    }

    group
}

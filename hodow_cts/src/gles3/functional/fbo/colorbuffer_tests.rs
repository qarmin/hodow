// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fFboColorbufferTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `dEQP-GLES3.functional.fbo.color`: clear, tex2d, texcube, tex2darray, tex3d, blend and repeated_clear.sample.tex2d and repeated_clear.blit.{tex2d,rbo}.
// `FboRepeatedClearBlitTex2DCase`/`FboRepeatedClearBlitRboCase` share `FboRepeatedClearBlitCase`.
// `FboColorTexCubeCase`/`FboColorTex2DArrayCase`/`FboColorTex3DCase` share one `FboColorLayeredCase` body (they
// differ only in how the layer is allocated, attached and sampled).
//
// Not ported (the groups are simply not registered, so these case counts are missing, they are not
// reported as NotSupported):
// Narrowing inside the registered groups, which end as NotSupported for the affected formats:
//  - none beyond the groups above: integer colour formats run with `isampler2D`/`usampler2D` shaders and read back
//    through `sglr::Context::read_pixels_rgba_f32`.
// `glTexStorage2D` is replaced by `glTexImage2D` with a null pointer (`sglr::Context` has no storage
// entry point); both create the one level these cases use.

use super::fbo_test_case::{FboRender, FboTestCase, check_error, check_format_support, check_framebuffer_status};
use super::fbo_test_util::{
    ChannelClass, GradientShader, Texture2DShader, TextureNdShader, channel_class, clear_color_buffer, get_format_name,
    get_format_threshold_gl, get_fragment_output_type, get_sampler_2d_array_type, get_sampler_2d_type,
    get_sampler_3d_type, get_sampler_cube_type, read_pixels, set_3d_uniforms, set_array_uniforms, set_cube_uniforms,
    set_gradient,
};
use super::render_tests::tex_image_2d_storage;
use crate::glu::TestCaseGroup;
use crate::glu::shader_util::DataType;
use crate::glu::texture_test_util_surface::fill_with_component_gradients_old;
use crate::glu::texture_util::{get_transfer_format, map_gl_internal_format, map_gl_transfer_format};
use crate::glw::{self, GLenum};
use crate::sglr::context::Context as SglrContext;
use crate::sglr::context_util::draw_quad;
use crate::tcu::bilinear_image_compare::bilinear_compare;
use crate::tcu::pixel::{CubeFace, TextureLevel, fill_with_grid, get_texture_format_info};
use crate::tcu::vector::Vec3;
use crate::tcu::{Random, Surface, TestError, TextureFormat, de_string_hash};

const MIN_THRESHOLD: u8 = 12;

/// `glu::isGLInternalColorFormatFilterable`
fn is_color_format_filterable(format: GLenum, tex_format: TextureFormat) -> bool {
    !matches!(channel_class(tex_format.type_), ChannelClass::Int | ChannelClass::Uint)
        && !matches!(format, glw::GL_R32F | glw::GL_RG32F | glw::GL_RGB32F | glw::GL_RGBA32F)
}

fn map_format(format: GLenum) -> Result<TextureFormat, TestError> {
    map_gl_internal_format(format).ok_or_else(|| TestError::Fail(format!("unknown internal format {format:#x}")))
}

/// `FboColorbufferCase::compare`
fn compare_with_format_threshold(format: GLenum, reference: &Surface, result: &Surface) -> bool {
    let Ok(format_threshold) = get_format_threshold_gl(format) else {
        return false;
    };
    let threshold = [
        format_threshold[0].max(MIN_THRESHOLD),
        format_threshold[1].max(MIN_THRESHOLD),
        format_threshold[2].max(MIN_THRESHOLD),
        format_threshold[3].max(MIN_THRESHOLD),
    ];
    reference.get_const_access().size() == result.get_const_access().size()
        && bilinear_compare(
            &reference.get_const_access(),
            &result.get_const_access(),
            None,
            threshold,
        )
}

/// `randomVector<4>(rnd, minVal, maxVal)`
fn random_vector(rnd: &mut Random, min_val: [f32; 4], max_val: [f32; 4]) -> [f32; 4] {
    let mut res = [0.0f32; 4];
    for ndx in 0..4 {
        res[ndx] = rnd.get_float_range(min_val[ndx], max_val[ndx]);
    }
    res
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

fn read_default_framebuffer(ctx: &mut dyn SglrContext, dst: &mut Surface) {
    let (w, h) = (ctx.get_width(), ctx.get_height());
    dst.set_size(w, h);
    ctx.read_pixels(dst, 0, 0, w, h);
}

fn clamp_to_edge(ctx: &mut dyn SglrContext) {
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
}

fn filter(ctx: &mut dyn SglrContext, mode: GLenum) {
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, mode as i32);
    ctx.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, mode as i32);
}

fn full_quad(ctx: &mut dyn SglrContext, program: u32) {
    draw_quad(ctx, program, Vec3::new(-1.0, -1.0, 0.0), Vec3::new(1.0, 1.0, 0.0));
}

/// `FboColorClearCase`
struct FboColorClearCase {
    format: GLenum,
    width: i32,
    height: i32,
}

impl FboRender for FboColorClearCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let fbo_format = map_format(self.format)?;
        let fmt_class = channel_class(fbo_format.type_);
        let fmt_info = get_texture_format_info(fbo_format);
        let mut rnd = Random::new(17);
        let num_clears = 16;

        let fbo = gen_framebuffer(ctx);
        let rbo = gen_renderbuffer(ctx);

        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.format, self.width, self.height);
        check_error(ctx)?;

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo,
        );
        check_error(ctx)?;
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.viewport(0, 0, self.width, self.height);

        // Initialize to transparent black.
        match fmt_class {
            ChannelClass::Float | ChannelClass::Fixed => ctx.clear_buffer_fv(glw::GL_COLOR, 0, &[0.0; 4]),
            ChannelClass::Uint => ctx.clear_buffer_uiv(glw::GL_COLOR, 0, &[0; 4]),
            ChannelClass::Int => ctx.clear_buffer_iv(glw::GL_COLOR, 0, &[0; 4]),
        }

        // Do random scissored clears.
        ctx.enable(glw::GL_SCISSOR_TEST);
        for _ in 0..num_clears {
            let x = rnd.get_int(0, self.width - 1);
            let y = rnd.get_int(0, self.height - 1);
            let w = rnd.get_int(1, self.width - x);
            let h = rnd.get_int(1, self.height - y);
            let color = random_vector(&mut rnd, fmt_info.value_min, fmt_info.value_max);

            ctx.scissor(x, y, w, h);

            match fmt_class {
                ChannelClass::Float | ChannelClass::Fixed => ctx.clear_buffer_fv(glw::GL_COLOR, 0, &color),
                ChannelClass::Uint => ctx.clear_buffer_uiv(
                    glw::GL_COLOR,
                    0,
                    &[color[0] as u32, color[1] as u32, color[2] as u32, color[3] as u32],
                ),
                ChannelClass::Int => ctx.clear_buffer_iv(
                    glw::GL_COLOR,
                    0,
                    &[color[0] as i32, color[1] as i32, color[2] as i32, color[3] as i32],
                ),
            }
        }

        // Read results from renderbuffer.
        read_pixels(
            ctx,
            dst,
            0,
            0,
            self.width,
            self.height,
            fbo_format,
            fmt_info.look_up_scale,
            fmt_info.look_up_bias,
        )?;
        check_error(ctx)
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_with_format_threshold(self.format, reference, result)
    }
}

/// `FboColorMultiTex2DCase`
struct FboColorMultiTex2DCase {
    tex0_fmt: GLenum,
    tex1_fmt: GLenum,
    tex0_size: (i32, i32),
    tex1_size: (i32, i32),
}

impl FboRender for FboColorMultiTex2DCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.tex0_fmt)?;
        check_format_support(context, self.tex1_fmt)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let tex_fmt0 = map_format(self.tex0_fmt)?;
        let tex_fmt1 = map_format(self.tex1_fmt)?;
        let fmt_info0 = get_texture_format_info(tex_fmt0);
        let fmt_info1 = get_texture_format_info(tex_fmt1);

        let range = |info: &crate::tcu::pixel::TextureFormatInfo| {
            let mut scale = [0.0f32; 4];
            for i in 0..4 {
                scale[i] = info.value_max[i] - info.value_min[i];
            }
            scale
        };

        let tex_to_fbo0_shader = Texture2DShader::new(
            1,
            get_fragment_output_type(tex_fmt0),
            range(&fmt_info0),
            fmt_info0.value_min,
        );
        let tex_to_fbo1_shader = Texture2DShader::new(
            1,
            get_fragment_output_type(tex_fmt1),
            range(&fmt_info1),
            fmt_info1.value_min,
        );
        let mut multi_tex_shader = Texture2DShader::with_samplers(
            &[get_sampler_2d_type(tex_fmt0), get_sampler_2d_type(tex_fmt1)],
            DataType::FloatVec4,
            [1.0; 4],
            [0.0; 4],
        );

        // Setup shaders
        let half = |v: [f32; 4]| [v[0] * 0.5, v[1] * 0.5, v[2] * 0.5, v[3] * 0.5];
        multi_tex_shader.set_tex_scale_bias(0, half(fmt_info0.look_up_scale), half(fmt_info0.look_up_bias));
        multi_tex_shader.set_tex_scale_bias(1, half(fmt_info1.look_up_scale), half(fmt_info1.look_up_bias));
        let tex_to_fbo0_uniforms = tex_to_fbo0_shader.uniforms();
        let tex_to_fbo1_uniforms = tex_to_fbo1_shader.uniforms();
        let multi_tex_uniforms = multi_tex_shader.uniforms();

        let tex_to_fbo0_shader_id = ctx.create_program(Box::new(tex_to_fbo0_shader));
        let tex_to_fbo1_shader_id = ctx.create_program(Box::new(tex_to_fbo1_shader));
        let multi_tex_shader_id = ctx.create_program(Box::new(multi_tex_shader));

        tex_to_fbo0_uniforms.set_uniforms(ctx, tex_to_fbo0_shader_id);
        tex_to_fbo1_uniforms.set_uniforms(ctx, tex_to_fbo1_shader_id);
        multi_tex_uniforms.set_uniforms(ctx, multi_tex_shader_id);

        // Framebuffers.
        let mut fbos = [0u32; 2];
        let mut texs = [0u32; 2];

        for ndx in 0..2 {
            let tex_format = if ndx == 1 { tex_fmt1 } else { tex_fmt0 };
            let transfer_fmt = get_transfer_format(tex_format)?;
            let format = if ndx == 1 { self.tex1_fmt } else { self.tex0_fmt };
            let is_filterable = is_color_format_filterable(format, tex_format);
            let size = if ndx == 1 { self.tex1_size } else { self.tex0_size };

            fbos[ndx] = gen_framebuffer(ctx);
            texs[ndx] = gen_texture(ctx);

            ctx.bind_texture(glw::GL_TEXTURE_2D, texs[ndx]);
            clamp_to_edge(ctx);
            filter(ctx, if is_filterable { glw::GL_LINEAR } else { glw::GL_NEAREST });
            ctx.tex_image_2d(
                glw::GL_TEXTURE_2D,
                0,
                format,
                size.0,
                size.1,
                0,
                transfer_fmt.format,
                transfer_fmt.data_type,
                None,
            );

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[ndx]);
            ctx.framebuffer_texture2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                texs[ndx],
                0,
            );
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
        }

        // Render textures to both framebuffers.
        for ndx in 0..2 {
            let format = glw::GL_RGBA;
            let data_type = glw::GL_UNSIGNED_BYTE;
            let tex_w = 128;
            let tex_h = 128;
            let fbo = fbos[ndx];
            let viewport = if ndx == 1 { self.tex1_size } else { self.tex0_size };
            let data_format = map_gl_transfer_format(format, data_type)
                .ok_or_else(|| TestError::Fail("unknown transfer format GL_RGBA/GL_UNSIGNED_BYTE".to_string()))?;
            let mut data = TextureLevel::new(data_format, tex_w as u32, tex_h as u32, 1)?;

            if ndx == 0 {
                fill_with_component_gradients_old(&mut data.get_access(), [0.0; 4], [1.0; 4]);
            } else {
                fill_with_grid(&mut data.get_access(), 8, [0.2, 0.7, 0.1, 1.0], [0.7, 0.1, 0.5, 0.8]);
            }

            let tmp_tex = gen_texture(ctx);
            ctx.bind_texture(glw::GL_TEXTURE_2D, tmp_tex);
            clamp_to_edge(ctx);
            filter(ctx, glw::GL_LINEAR);
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

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            ctx.viewport(0, 0, viewport.0, viewport.1);
            full_quad(
                ctx,
                if ndx == 1 {
                    tex_to_fbo1_shader_id
                } else {
                    tex_to_fbo0_shader_id
                },
            );
        }

        // Render to framebuffer.
        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
        let (w, h) = (ctx.get_width(), ctx.get_height());
        ctx.viewport(0, 0, w, h);
        ctx.active_texture(glw::GL_TEXTURE0);
        ctx.bind_texture(glw::GL_TEXTURE_2D, texs[0]);
        ctx.active_texture(glw::GL_TEXTURE1);
        ctx.bind_texture(glw::GL_TEXTURE_2D, texs[1]);
        full_quad(ctx, multi_tex_shader_id);

        read_default_framebuffer(ctx, dst);
        Ok(())
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_with_format_threshold(self.tex0_fmt, reference, result)
    }
}

/// `generateRandomColor`
fn generate_random_color(rnd: &mut Random) -> [f32; 4] {
    [rnd.get_float(), rnd.get_float(), rnd.get_float(), 1.0]
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum LayeredKind {
    Cube,
    Array,
    ThreeD,
}

/// `FboColorTexCubeCase` (`size.2` ignored), `FboColorTex2DArrayCase` and `FboColorTex3DCase`.
struct FboColorLayeredCase {
    kind: LayeredKind,
    format: GLenum,
    size: (i32, i32, i32),
}

impl FboRender for FboColorLayeredCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        const CUBE_GL_FACES: [GLenum; 6] = [
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y,
            glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z,
        ];
        const CUBE_TEX_FACES: [CubeFace; 6] = [
            CubeFace::PositiveX,
            CubeFace::PositiveY,
            CubeFace::PositiveZ,
            CubeFace::NegativeX,
            CubeFace::NegativeY,
            CubeFace::NegativeZ,
        ];

        let (target, seed) = match self.kind {
            LayeredKind::Cube => (glw::GL_TEXTURE_CUBE_MAP, 0x9eef603d_u32),
            LayeredKind::Array => (glw::GL_TEXTURE_2D_ARRAY, 0xed607a89_u32),
            LayeredKind::ThreeD => (glw::GL_TEXTURE_3D, 0x74d947b2_u32),
        };
        let mut rnd = Random::new(de_string_hash(get_format_name(self.format)) ^ seed);
        let tex_fmt = map_format(self.format)?;
        let fmt_info = get_texture_format_info(tex_fmt);
        let (size_x, size_y, size_z) = self.size;

        let mut range = [0.0f32; 4];
        for i in 0..4 {
            range[i] = fmt_info.value_max[i] - fmt_info.value_min[i];
        }
        let tex_to_fbo_shader = Texture2DShader::new(1, get_fragment_output_type(tex_fmt), range, fmt_info.value_min);
        let tex_to_fbo_uniforms = tex_to_fbo_shader.uniforms();
        let layered_shader = match self.kind {
            LayeredKind::Cube => TextureNdShader::cube(get_sampler_cube_type(tex_fmt), DataType::FloatVec4),
            LayeredKind::Array => TextureNdShader::array(get_sampler_2d_array_type(tex_fmt), DataType::FloatVec4),
            LayeredKind::ThreeD => TextureNdShader::three_d(get_sampler_3d_type(tex_fmt), DataType::FloatVec4),
        };

        let tex_to_fbo_shader_id = ctx.create_program(Box::new(tex_to_fbo_shader));
        let layered_shader_id = ctx.create_program(Box::new(layered_shader));

        // Setup shaders
        tex_to_fbo_uniforms.set_uniforms(ctx, tex_to_fbo_shader_id);

        // Framebuffers.
        let mut fbos: Vec<u32> = Vec::new();
        let tex = gen_texture(ctx);

        {
            let transfer_fmt = get_transfer_format(tex_fmt)?;
            let is_filterable = self.kind != LayeredKind::ThreeD && is_color_format_filterable(self.format, tex_fmt);
            let mode_enum = if is_filterable { glw::GL_LINEAR } else { glw::GL_NEAREST };
            let mode = mode_enum as i32;

            ctx.bind_texture(target, tex);
            ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
            ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);
            if self.kind != LayeredKind::Cube {
                ctx.tex_parameteri(target, glw::GL_TEXTURE_WRAP_R, glw::GL_CLAMP_TO_EDGE as i32);
            }
            ctx.tex_parameteri(target, glw::GL_TEXTURE_MIN_FILTER, mode);
            ctx.tex_parameteri(target, glw::GL_TEXTURE_MAG_FILTER, mode);

            if self.kind == LayeredKind::Cube {
                // Generate an image and FBO for each cube face
                for face in CUBE_GL_FACES {
                    ctx.tex_image_2d(
                        face,
                        0,
                        self.format,
                        size_x,
                        size_y,
                        0,
                        transfer_fmt.format,
                        transfer_fmt.data_type,
                        None,
                    );
                }
                check_error(ctx)?;

                for face in CUBE_GL_FACES {
                    let layer_fbo = gen_framebuffer(ctx);
                    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, layer_fbo);
                    ctx.framebuffer_texture2d(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, face, tex, 0);
                    check_error(ctx)?;
                    check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

                    fbos.push(layer_fbo);
                }
            } else {
                ctx.tex_image_3d(
                    target,
                    0,
                    self.format,
                    size_x,
                    size_y,
                    size_z,
                    0,
                    transfer_fmt.format,
                    transfer_fmt.data_type,
                    None,
                );

                // Generate an FBO for each layer
                for ndx in 0..size_z {
                    let layer_fbo = gen_framebuffer(ctx);
                    ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, layer_fbo);
                    ctx.framebuffer_texture_layer(glw::GL_FRAMEBUFFER, glw::GL_COLOR_ATTACHMENT0, tex, 0, ndx);
                    check_error(ctx)?;
                    check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

                    fbos.push(layer_fbo);
                }
            }
        }

        // Render test images to random cube faces / texture layers
        let mut order: Vec<usize> = (0..fbos.len()).collect();
        rnd.shuffle(&mut order);

        let num_rendered = if self.kind == LayeredKind::Cube { 4 } else { order.len() };
        for ndx in 0..num_rendered {
            let layer = order[ndx];
            let format = glw::GL_RGBA;
            let data_type = glw::GL_UNSIGNED_BYTE;
            let (tex_w, tex_h) = (128, 128);
            let fbo = fbos[layer];
            let data_format = map_gl_transfer_format(format, data_type)
                .ok_or_else(|| TestError::Fail("unknown transfer format GL_RGBA/GL_UNSIGNED_BYTE".to_string()))?;
            let mut data = TextureLevel::new(data_format, tex_w as u32, tex_h as u32, 1)?;

            let color = generate_random_color(&mut rnd);
            fill_with_grid(&mut data.get_access(), 8, color, [0.0; 4]);

            let tmp_tex = gen_texture(ctx);
            ctx.bind_texture(glw::GL_TEXTURE_2D, tmp_tex);
            clamp_to_edge(ctx);
            filter(ctx, glw::GL_LINEAR);
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

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
            ctx.viewport(0, 0, size_x, size_y);
            full_quad(ctx, tex_to_fbo_shader_id);
            check_error(ctx)?;

            // Render to framebuffer
            {
                let p0 = Vec3::new((ndx % 2) as f32 - 1.0, (ndx / 2) as f32 - 1.0, 0.0);
                let p1 = Vec3::new(p0.x() + 1.0, p0.y() + 1.0, 0.0);

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, 0);
                let (w, h) = (ctx.get_width(), ctx.get_height());
                ctx.viewport(0, 0, w, h);

                ctx.active_texture(glw::GL_TEXTURE0);
                ctx.bind_texture(target, tex);

                match self.kind {
                    LayeredKind::Cube => set_cube_uniforms(
                        ctx,
                        layered_shader_id,
                        CUBE_TEX_FACES[layer],
                        fmt_info.look_up_scale,
                        fmt_info.look_up_bias,
                    ),
                    LayeredKind::Array => set_array_uniforms(
                        ctx,
                        layered_shader_id,
                        layer as i32,
                        fmt_info.look_up_scale,
                        fmt_info.look_up_bias,
                    ),
                    LayeredKind::ThreeD => set_3d_uniforms(
                        ctx,
                        layered_shader_id,
                        layer as f32 / (size_z - 1) as f32,
                        fmt_info.look_up_scale,
                        fmt_info.look_up_bias,
                    ),
                }

                draw_quad(ctx, layered_shader_id, p0, p1);
                check_error(ctx)?;
            }
        }

        read_default_framebuffer(ctx, dst);
        Ok(())
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_with_format_threshold(self.format, reference, result)
    }
}

/// `FboBlendCase`
struct FboBlendCase {
    format: GLenum,
    size: (i32, i32),
    func_rgb: GLenum,
    func_alpha: GLenum,
    src_rgb: GLenum,
    dst_rgb: GLenum,
    src_alpha: GLenum,
    dst_alpha: GLenum,
}

impl FboRender for FboBlendCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        // Assumes floating-point or fixed-point format.
        let fbo_fmt = map_format(self.format)?;
        let tex_shader = Texture2DShader::new(1, DataType::FloatVec4, [1.0; 4], [0.0; 4]);
        let tex_uniforms = tex_shader.uniforms();
        let tex_shader_id = ctx.create_program(Box::new(tex_shader));
        let grad_shader_id = ctx.create_program(Box::new(GradientShader::new(DataType::FloatVec4)));

        // Setup shaders
        tex_uniforms.set_uniforms(ctx, tex_shader_id);
        set_gradient(ctx, grad_shader_id, [0.0; 4], [1.0; 4]);

        let fbo = gen_framebuffer(ctx);
        let rbo = gen_renderbuffer(ctx);

        ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo);
        ctx.renderbuffer_storage(glw::GL_RENDERBUFFER, self.format, self.size.0, self.size.1);
        check_error(ctx)?;

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo);
        ctx.framebuffer_renderbuffer(
            glw::GL_FRAMEBUFFER,
            glw::GL_COLOR_ATTACHMENT0,
            glw::GL_RENDERBUFFER,
            rbo,
        );
        check_error(ctx)?;
        check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;

        ctx.viewport(0, 0, self.size.0, self.size.1);

        // Fill framebuffer with grid pattern.
        {
            let format = glw::GL_RGBA;
            let data_type = glw::GL_UNSIGNED_BYTE;
            let tex_w = 128;
            let tex_h = 128;
            let data_format = map_gl_transfer_format(format, data_type)
                .ok_or_else(|| TestError::Fail("unknown transfer format GL_RGBA/GL_UNSIGNED_BYTE".to_string()))?;
            let mut data = TextureLevel::new(data_format, tex_w as u32, tex_h as u32, 1)?;

            fill_with_grid(&mut data.get_access(), 8, [0.2, 0.7, 0.1, 1.0], [0.7, 0.1, 0.5, 0.8]);

            let grid_tex = gen_texture(ctx);
            ctx.bind_texture(glw::GL_TEXTURE_2D, grid_tex);
            clamp_to_edge(ctx);
            filter(ctx, glw::GL_LINEAR);
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

            full_quad(ctx, tex_shader_id);
        }

        // Setup blend.
        ctx.enable(glw::GL_BLEND);
        ctx.blend_equation_separate(self.func_rgb, self.func_alpha);
        ctx.blend_func_separate(self.src_rgb, self.dst_rgb, self.src_alpha, self.dst_alpha);

        // Render gradient with blend.
        full_quad(ctx, grad_shader_id);

        read_pixels(ctx, dst, 0, 0, self.size.0, self.size.1, fbo_fmt, [1.0; 4], [0.0; 4])
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_with_format_threshold(self.format, reference, result)
    }
}

/// `FboRepeatedClearSampleTex2DCase`
struct FboRepeatedClearSampleTex2DCase {
    format: GLenum,
}

impl FboRender for FboRepeatedClearSampleTex2DCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let fbo_format = map_format(self.format)?;
        let fmt_info = get_texture_format_info(fbo_format);
        let num_rows_cols = 4;
        let cell_size = 16;
        let fbo_sizes = [cell_size, cell_size * num_rows_cols];

        let fbo_blit_shader = Texture2DShader::with_samplers(
            &[get_sampler_2d_type(fbo_format)],
            get_fragment_output_type(fbo_format),
            [1.0; 4],
            [0.0; 4],
        );
        let fbo_blit_uniforms = fbo_blit_shader.uniforms();
        let fbo_blit_shader_id = ctx.create_program(Box::new(fbo_blit_shader));

        let mut rnd = Random::new(18169662);
        let mut fbos = [0u32; 2];
        let mut textures = [0u32; 2];

        for fbo_ndx in 0..2 {
            fbos[fbo_ndx] = gen_framebuffer(ctx);
            textures[fbo_ndx] = gen_texture(ctx);
        }

        for fbo_ndx in 0..2 {
            ctx.bind_texture(glw::GL_TEXTURE_2D, textures[fbo_ndx]);
            tex_image_2d_storage(
                ctx,
                glw::GL_TEXTURE_2D,
                0,
                self.format,
                fbo_sizes[fbo_ndx],
                fbo_sizes[fbo_ndx],
            )?;
            clamp_to_edge(ctx);
            filter(ctx, glw::GL_NEAREST);
            check_error(ctx)?;

            ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[fbo_ndx]);
            ctx.framebuffer_texture2d(
                glw::GL_FRAMEBUFFER,
                glw::GL_COLOR_ATTACHMENT0,
                glw::GL_TEXTURE_2D,
                textures[fbo_ndx],
                0,
            );
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
        }

        // larger fbo bound -- clear to transparent black
        clear_color_buffer(ctx, fbo_format, [0.0; 4]);

        fbo_blit_uniforms.set_uniforms(ctx, fbo_blit_shader_id);
        ctx.bind_texture(glw::GL_TEXTURE_2D, textures[0]);

        for cell_y in 0..num_rows_cols {
            for cell_x in 0..num_rows_cols {
                let color = random_vector(&mut rnd, fmt_info.value_min, fmt_info.value_max);

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[0]);
                clear_color_buffer(ctx, fbo_format, color);

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[1]);
                ctx.viewport(cell_x * cell_size, cell_y * cell_size, cell_size, cell_size);
                full_quad(ctx, fbo_blit_shader_id);
            }
        }

        read_pixels(
            ctx,
            dst,
            0,
            0,
            fbo_sizes[1],
            fbo_sizes[1],
            fbo_format,
            fmt_info.look_up_scale,
            fmt_info.look_up_bias,
        )?;
        check_error(ctx)
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_with_format_threshold(self.format, reference, result)
    }
}

/// `FboRepeatedClearBlitTex2DCase` (`rbo == false`) and `FboRepeatedClearBlitRboCase` (`rbo == true`).
struct FboRepeatedClearBlitCase {
    format: GLenum,
    rbo: bool,
}

impl FboRender for FboRepeatedClearBlitCase {
    fn pre_check(&self, context: &crate::glu::Context) -> Result<(), TestError> {
        check_format_support(context, self.format)
    }

    fn render(&self, ctx: &mut dyn SglrContext, dst: &mut Surface) -> Result<(), TestError> {
        let fbo_format = map_format(self.format)?;
        let fmt_info = get_texture_format_info(fbo_format);
        let num_rows_cols = 4;
        let cell_size = 16;
        let fbo_sizes = [cell_size, cell_size * num_rows_cols];

        let mut rnd = Random::new(18169662);
        let mut fbos = [0u32; 2];
        let mut attachments = [0u32; 2];

        for fbo_ndx in 0..2 {
            fbos[fbo_ndx] = gen_framebuffer(ctx);
            attachments[fbo_ndx] = if self.rbo {
                gen_renderbuffer(ctx)
            } else {
                gen_texture(ctx)
            };
        }

        for fbo_ndx in 0..2 {
            if self.rbo {
                ctx.bind_renderbuffer(glw::GL_RENDERBUFFER, attachments[fbo_ndx]);
                ctx.renderbuffer_storage(
                    glw::GL_RENDERBUFFER,
                    self.format,
                    fbo_sizes[fbo_ndx],
                    fbo_sizes[fbo_ndx],
                );
                check_error(ctx)?;

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[fbo_ndx]);
                ctx.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    attachments[fbo_ndx],
                );
            } else {
                ctx.bind_texture(glw::GL_TEXTURE_2D, attachments[fbo_ndx]);
                tex_image_2d_storage(
                    ctx,
                    glw::GL_TEXTURE_2D,
                    0,
                    self.format,
                    fbo_sizes[fbo_ndx],
                    fbo_sizes[fbo_ndx],
                )?;
                clamp_to_edge(ctx);
                filter(ctx, glw::GL_NEAREST);
                check_error(ctx)?;

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[fbo_ndx]);
                ctx.framebuffer_texture2d(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_TEXTURE_2D,
                    attachments[fbo_ndx],
                    0,
                );
            }
            check_error(ctx)?;
            check_framebuffer_status(ctx, glw::GL_FRAMEBUFFER)?;
        }

        // larger fbo bound -- clear to transparent black
        clear_color_buffer(ctx, fbo_format, [0.0; 4]);

        for cell_y in 0..num_rows_cols {
            for cell_x in 0..num_rows_cols {
                let color = random_vector(&mut rnd, fmt_info.value_min, fmt_info.value_max);

                ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[0]);
                clear_color_buffer(ctx, fbo_format, color);

                ctx.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbos[1]);
                ctx.blit_framebuffer(
                    0,
                    0,
                    cell_size,
                    cell_size,
                    cell_x * cell_size,
                    cell_y * cell_size,
                    (cell_x + 1) * cell_size,
                    (cell_y + 1) * cell_size,
                    glw::GL_COLOR_BUFFER_BIT,
                    glw::GL_NEAREST,
                );
            }
        }

        ctx.bind_framebuffer(glw::GL_FRAMEBUFFER, fbos[1]);
        read_pixels(
            ctx,
            dst,
            0,
            0,
            fbo_sizes[1],
            fbo_sizes[1],
            fbo_format,
            fmt_info.look_up_scale,
            fmt_info.look_up_bias,
        )?;
        check_error(ctx)
    }

    fn compare(&self, reference: &Surface, result: &Surface) -> bool {
        compare_with_format_threshold(self.format, reference, result)
    }
}

/// `FboColorTests::init`
pub fn create_tests() -> TestCaseGroup {
    let color_formats: [GLenum; 36] = [
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
        // GL_EXT_color_buffer_half_float
        glw::GL_RGB16F,
    ];

    let mut group = TestCaseGroup::new("color");

    // .clear
    {
        let mut clear_group = TestCaseGroup::new("clear");
        for format in color_formats {
            clear_group.add_child(FboTestCase::new(
                get_format_name(format),
                FboColorClearCase {
                    format,
                    width: 129,
                    height: 117,
                },
            ));
        }
        group.add_child(clear_group);
    }

    // .tex2d
    {
        let mut tex2d_group = TestCaseGroup::new("tex2d");
        for format in color_formats {
            tex2d_group.add_child(FboTestCase::new(
                get_format_name(format),
                FboColorMultiTex2DCase {
                    tex0_fmt: format,
                    tex1_fmt: format,
                    tex0_size: (129, 117),
                    tex1_size: (99, 128),
                },
            ));
        }
        group.add_child(tex2d_group);
    }

    // .texcube / .tex2darray / .tex3d
    for (name, kind, size) in [
        ("texcube", LayeredKind::Cube, (128, 128, 1)),
        ("tex2darray", LayeredKind::Array, (128, 128, 5)),
        ("tex3d", LayeredKind::ThreeD, (128, 128, 5)),
    ] {
        let mut layered_group = TestCaseGroup::new(name);
        for format in color_formats {
            layered_group.add_child(FboTestCase::new(
                get_format_name(format),
                FboColorLayeredCase { kind, format, size },
            ));
        }
        group.add_child(layered_group);
    }

    // .blend
    {
        let mut blend_group = TestCaseGroup::new("blend");
        for format in color_formats {
            let Some(tex_fmt) = map_gl_internal_format(format) else {
                continue;
            };
            let fmt_class = channel_class(tex_fmt.type_);
            let fmt_name = get_format_name(format);

            if tex_fmt.type_ == crate::tcu::ChannelType::FLOAT
                || matches!(fmt_class, ChannelClass::Int | ChannelClass::Uint)
            {
                continue; // Blending is not supported.
            }

            blend_group.add_child(FboTestCase::new(
                format!("{fmt_name}_src_over"),
                FboBlendCase {
                    format,
                    size: (127, 111),
                    func_rgb: glw::GL_FUNC_ADD,
                    func_alpha: glw::GL_FUNC_ADD,
                    src_rgb: glw::GL_SRC_ALPHA,
                    dst_rgb: glw::GL_ONE_MINUS_SRC_ALPHA,
                    src_alpha: glw::GL_ZERO,
                    dst_alpha: glw::GL_ONE,
                },
            ));
        }
        group.add_child(blend_group);
    }

    // .repeated_clear
    {
        let mut repeated_clear_group = TestCaseGroup::new("repeated_clear");

        // .sample.tex2d
        {
            let mut sample_group = TestCaseGroup::new("sample");
            let mut tex2d_group = TestCaseGroup::new("tex2d");
            for format in color_formats {
                tex2d_group.add_child(FboTestCase::new(
                    get_format_name(format),
                    FboRepeatedClearSampleTex2DCase { format },
                ));
            }
            sample_group.add_child(tex2d_group);
            repeated_clear_group.add_child(sample_group);
        }

        // .blit
        {
            let mut blit_group = TestCaseGroup::new("blit");
            for (name, rbo) in [("tex2d", false), ("rbo", true)] {
                let mut kind_group = TestCaseGroup::new(name);
                for format in color_formats {
                    kind_group.add_child(FboTestCase::new(
                        get_format_name(format),
                        FboRepeatedClearBlitCase { format, rbo },
                    ));
                }
                blit_group.add_child(kind_group);
            }
            repeated_clear_group.add_child(blit_group);
        }

        group.add_child(repeated_clear_group);
    }

    group
}

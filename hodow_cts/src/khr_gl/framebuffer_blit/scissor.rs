// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcFramebufferBlitTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `runMultiColorPatternTest`'s four-fold repeated clear and verify calls are loops over the quadrants, in upstream's order.

use super::{
    BLACK, BLUE, Base, BufferConfig, Coord, DEFAULT_COLOR_CHANNEL_BITS, DST_COLOR, DST_DEPTH, DST_STCIL, FOUR, GREEN,
    ONE, Q0, Q1, Q2, Q3, Q4, RED, Rectangle, Slot, THREE, TWO, WHITE, ZERO, bind_renderbuffer, bind_texture, enum_name,
};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

fn get_epsilon(result_pre_bits: GLuint, source_pre_bits: GLuint) -> f32 {
    let tolerance = result_pre_bits.min(source_pre_bits).min(23);
    1.0f32 / (1u32 << tolerance) as f32
}

fn gen_texture(base: &mut Base, slot: Slot) -> Result<(), TestError> {
    let gl = base.gl;
    let mut object: GLuint = 0;
    gl_call!(gl, "genTextures", gl.gen_textures(1, &mut object));
    base.set_slot(slot, object);
    Ok(())
}

fn gen_renderbuffer(base: &mut Base, slot: Slot) -> Result<(), TestError> {
    let gl = base.gl;
    let mut object: GLuint = 0;
    gl_call!(gl, "genRenderbuffers", gl.gen_renderbuffers(1, &mut object));
    base.set_slot(slot, object);
    Ok(())
}

fn center_of(rect: Rectangle) -> Coord {
    (rect.x + rect.w / 2, rect.y + rect.h / 2)
}

fn fail_on_false(result: bool, what: &str) -> Result<(), TestError> {
    if !result {
        log::info!("{what}: {}:{}", file!(), line!());
        return Err(TestError::Fail("result".to_string()));
    }
    Ok(())
}

/// `FramebufferBlitScissorTestCase`
pub(super) struct Scissor;

impl Scissor {
    /// `FramebufferBlitScissorTestCase::init`
    fn init(context: &Context) -> Base<'_> {
        let mut base = Base::new(context);
        let render_target = context.render_target();
        let (buf_width, buf_height) = (render_target.width, render_target.height);

        base.setup.scissor_rect = Rectangle::new(0, 0, buf_width / 2, buf_height / 2);

        base.setup.ul_color = BLACK;
        base.setup.ur_color = BLACK;
        base.setup.ll_color = GREEN;
        base.setup.lr_color = BLACK;
        base.setup.ul_depth = Q0;
        base.setup.ur_depth = Q0;
        base.setup.ll_depth = Q1;
        base.setup.lr_depth = Q0;
        base.setup.ul_stcil = ZERO;
        base.setup.ur_stcil = ZERO;
        base.setup.ll_stcil = ONE;
        base.setup.lr_stcil = ZERO;
        base
    }

    /// `runMultiColorPatternTest`
    fn run_multi_color_pattern_test(base: &mut Base, max_color_attachments: GLint) -> Result<bool, TestError> {
        let gl = base.gl;
        let mut result = true;
        let bits = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
        let buf_width = base.full_rect.w;

        for i in 0..base.buffer_cfg.len() {
            let mut effective_bits = bits;

            for j in 0..max_color_attachments {
                let buf_config: BufferConfig = base.buffer_cfg[i];
                let attachment: GLenum = glw::GL_COLOR_ATTACHMENT0 + j as u32;

                let (mut ul_color, mut ur_color, mut ll_color, mut lr_color) = (RED, GREEN, BLUE, WHITE);
                let (mut ul_depth, mut ur_depth, mut ll_depth, mut lr_depth) = (Q1, Q2, Q3, Q4);
                let (mut ul_stcil, mut ur_stcil, mut ll_stcil, mut lr_stcil) = (ONE, TWO, THREE, FOUR);

                let mut src_ul_rect = base.setup.ul_rect;
                let mut src_ur_rect = base.setup.ur_rect;
                let mut src_ll_rect = base.setup.ll_rect;
                let mut src_lr_rect = base.setup.lr_rect;

                let mut dst_rect = base.setup.blt_dst_rect;

                let mut src_ul_center = center_of(src_ul_rect);
                let mut src_ur_center = center_of(src_ur_rect);
                let mut src_ll_center = center_of(src_ll_rect);
                let mut src_lr_center = center_of(src_lr_rect);
                let mut dst_center = center_of(dst_rect);

                let mut end_ul_coord = base.setup.ul_coord;
                let mut end_ur_coord = base.setup.ur_coord;
                let mut end_ll_coord = base.setup.ll_coord;
                let mut end_lr_coord = base.setup.lr_coord;

                let mut blt_src_rect = base.setup.blt_src_rect;
                let mut blt_dst_rect = base.setup.blt_dst_rect;

                let scissored =
                    base.setup.scissor_rect.w != base.full_rect.w && base.setup.scissor_rect.h != base.full_rect.h;

                if scissored && buf_config.same_read_and_draw_buffer {
                    continue;
                }

                base.depth_internal_format = 0;
                base.depth_type = 0;
                base.depth_format = 0;
                base.stcil_internal_format = 0;
                base.stcil_type = 0;
                base.stcil_format = 0;

                if buf_config.src_type == 0 || buf_config.dst_type == 0 {
                    let mut sample_buffers: GLint = 0;

                    gl_call!(
                        gl,
                        "bindFramebuffer",
                        gl.bind_framebuffer(glw::GL_FRAMEBUFFER, base.default_fbo)
                    );
                    gl_call!(
                        gl,
                        "getIntegerv",
                        gl.get_integerv(glw::GL_SAMPLE_BUFFERS, &mut sample_buffers)
                    );

                    if sample_buffers != 0 {
                        log::info!("SKIP --------------------------------------------------------------------");
                        continue;
                    }

                    let (found, no_default_depth, no_default_stcil) = base.get_default_framebuffer_blit_format()?;
                    if !found {
                        if effective_bits & glw::GL_COLOR_BUFFER_BIT == 0 {
                            log::info!("SKIP --------------------------------------------------------------------");
                            continue;
                        }
                        effective_bits &= !glw::GL_DEPTH_BUFFER_BIT;
                        effective_bits &= !glw::GL_STENCIL_BUFFER_BIT;
                    }

                    if no_default_depth {
                        effective_bits &= !glw::GL_DEPTH_BUFFER_BIT;
                    }

                    if no_default_stcil {
                        effective_bits &= !glw::GL_STENCIL_BUFFER_BIT;
                    }
                }

                if buf_config.same_read_and_draw_buffer {
                    log::info!("........................................................................");

                    src_ll_rect.x /= 2;
                    src_ll_rect.w /= 2;
                    src_lr_rect.x = src_ll_rect.w;
                    src_lr_rect.w = buf_width / 2 - src_ll_rect.w;
                    src_ul_rect.x /= 2;
                    src_ul_rect.w /= 2;
                    src_ur_rect.x = src_ul_rect.w;
                    src_ur_rect.w = buf_width / 2 - src_ul_rect.w;

                    dst_rect.x = buf_width / 2 + dst_rect.x / 2;
                    dst_rect.w = buf_width / 2;

                    src_ul_center = center_of(src_ul_rect);
                    src_ur_center = center_of(src_ur_rect);
                    src_ll_center = center_of(src_ll_rect);
                    src_lr_center = center_of(src_lr_rect);

                    dst_center = center_of(dst_rect);

                    end_ul_coord = (dst_rect.x, end_ul_coord.1);
                    end_ur_coord = (dst_rect.x + dst_rect.w - 1, end_ur_coord.1);
                    end_ll_coord = (dst_rect.x, end_ll_coord.1);
                    end_lr_coord = (dst_rect.x + dst_rect.w - 1, end_lr_coord.1);

                    blt_src_rect.x = src_ll_rect.x;
                    blt_src_rect.w = src_ll_rect.w + src_lr_rect.w;
                    blt_dst_rect.x = dst_rect.x;
                    blt_dst_rect.w = dst_rect.w;

                    log::info!("........................................................................");
                }

                let mut dst_ul_rect = Rectangle::new(
                    blt_dst_rect.x,
                    blt_dst_rect.y + blt_dst_rect.h / 2,
                    blt_dst_rect.w / 2,
                    blt_dst_rect.h - blt_dst_rect.h / 2,
                );
                let mut dst_ur_rect = Rectangle::new(
                    blt_dst_rect.x + blt_dst_rect.w / 2,
                    blt_dst_rect.y + blt_dst_rect.h / 2,
                    blt_dst_rect.w - blt_dst_rect.w / 2,
                    blt_dst_rect.h - blt_dst_rect.h / 2,
                );
                let mut dst_ll_rect =
                    Rectangle::new(blt_dst_rect.x, blt_dst_rect.y, blt_dst_rect.w / 2, blt_dst_rect.h / 2);
                let mut dst_lr_rect = Rectangle::new(
                    blt_dst_rect.x + blt_dst_rect.w / 2,
                    blt_dst_rect.y,
                    blt_dst_rect.w - blt_dst_rect.w / 2,
                    blt_dst_rect.h / 2,
                );

                if scissored {
                    (ul_color, ur_color, ll_color, lr_color) = (GREEN, GREEN, GREEN, GREEN);
                    (ul_depth, ur_depth, ll_depth, lr_depth) = (Q1, Q1, Q1, Q1);
                    (ul_stcil, ur_stcil, ll_stcil, lr_stcil) = (ONE, ONE, ONE, ONE);
                }

                gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(2, base.fbos.as_mut_ptr()));

                log::info!("BEGIN ------------------------------------------------------------------");
                log::info!(
                    "BLITTING in {} from {} to {} {}",
                    enum_name(attachment),
                    if buf_config.src_type == 0 {
                        "DEFAULT".to_string()
                    } else {
                        enum_name(buf_config.src_type)
                    },
                    if buf_config.dst_type == 0 {
                        "DEFAULT".to_string()
                    } else {
                        enum_name(buf_config.dst_type)
                    },
                    if buf_config.dst_type != 0 {
                        if buf_config.same_read_and_draw_buffer {
                            "(same buffer)"
                        } else {
                            "(different buffers)"
                        }
                    } else {
                        ""
                    }
                );

                for slot in [
                    buf_config.src_cbuf,
                    buf_config.src_dbuf,
                    buf_config.src_sbuf,
                    buf_config.dst_cbuf,
                    buf_config.dst_dbuf,
                    buf_config.dst_sbuf,
                ] {
                    base.set_slot(slot, 0);
                }

                let src_color_quadrants = [
                    (ul_color, src_ul_rect, src_ul_center),
                    (ur_color, src_ur_rect, src_ur_center),
                    (ll_color, src_ll_rect, src_ll_center),
                    (lr_color, src_lr_rect, src_lr_center),
                ];
                let src_depth_quadrants = [
                    (ul_depth, src_ul_rect, src_ul_center),
                    (ur_depth, src_ur_rect, src_ur_center),
                    (ll_depth, src_ll_rect, src_ll_center),
                    (lr_depth, src_lr_rect, src_lr_center),
                ];
                let src_stencil_quadrants = [
                    (ul_stcil, src_ul_rect, src_ul_center),
                    (ur_stcil, src_ur_rect, src_ur_center),
                    (ll_stcil, src_ll_rect, src_ll_center),
                    (lr_stcil, src_lr_rect, src_lr_center),
                ];

                if effective_bits & glw::GL_COLOR_BUFFER_BIT != 0 {
                    if buf_config.src_type == glw::GL_TEXTURE_2D {
                        gen_texture(base, buf_config.src_cbuf)?;
                        let src_cbuf = [base.slot(buf_config.src_cbuf)];
                        result &= base.init_gl_objs(glw::GL_TEXTURE_2D, 0, bind_texture, &src_cbuf, glw::GL_RGBA8)?;

                        for (color, rect, center) in src_color_quadrants {
                            result &= base.clear_color_buffer(
                                base.fbos[0],
                                glw::GL_COLOR_ATTACHMENT0,
                                glw::GL_TEXTURE_2D,
                                src_cbuf[0],
                                color,
                                rect,
                                center,
                                DEFAULT_COLOR_CHANNEL_BITS,
                                false,
                            )?;
                        }
                    } else if buf_config.src_type == glw::GL_RENDERBUFFER {
                        gen_renderbuffer(base, buf_config.src_cbuf)?;
                        let src_cbuf = [base.slot(buf_config.src_cbuf)];
                        result &=
                            base.init_gl_objs(glw::GL_RENDERBUFFER, 0, bind_renderbuffer, &src_cbuf, glw::GL_RGBA8)?;

                        for (color, rect, center) in src_color_quadrants {
                            result &= base.clear_color_buffer(
                                base.fbos[0],
                                glw::GL_COLOR_ATTACHMENT0,
                                glw::GL_RENDERBUFFER,
                                src_cbuf[0],
                                color,
                                rect,
                                center,
                                DEFAULT_COLOR_CHANNEL_BITS,
                                false,
                            )?;
                        }
                    } else {
                        for (color, rect, center) in src_color_quadrants {
                            result &= base.clear_color_buffer(
                                base.default_fbo,
                                0,
                                0,
                                0,
                                color,
                                rect,
                                center,
                                DEFAULT_COLOR_CHANNEL_BITS,
                                false,
                            )?;
                        }
                    }

                    if buf_config.dst_type == glw::GL_TEXTURE_2D {
                        base.set_slot(buf_config.dst_cbuf, base.slot(buf_config.src_cbuf));
                        if !buf_config.same_read_and_draw_buffer {
                            gen_texture(base, buf_config.dst_cbuf)?;
                            let dst_cbuf = [base.slot(buf_config.dst_cbuf)];
                            result &=
                                base.init_gl_objs(glw::GL_TEXTURE_2D, 0, bind_texture, &dst_cbuf, glw::GL_RGBA8)?;
                        }
                        result &= base.clear_color_buffer(
                            base.fbos[1],
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_TEXTURE_2D,
                            base.slot(buf_config.dst_cbuf),
                            DST_COLOR,
                            dst_rect,
                            dst_center,
                            DEFAULT_COLOR_CHANNEL_BITS,
                            false,
                        )?;
                    } else if buf_config.dst_type == glw::GL_RENDERBUFFER {
                        base.set_slot(buf_config.dst_cbuf, base.slot(buf_config.src_cbuf));
                        if !buf_config.same_read_and_draw_buffer {
                            gen_renderbuffer(base, buf_config.dst_cbuf)?;
                            let dst_cbuf = [base.slot(buf_config.dst_cbuf)];
                            result &= base.init_gl_objs(
                                glw::GL_RENDERBUFFER,
                                0,
                                bind_renderbuffer,
                                &dst_cbuf,
                                glw::GL_RGBA8,
                            )?;
                        }
                        result &= base.clear_color_buffer(
                            base.fbos[1],
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_RENDERBUFFER,
                            base.slot(buf_config.dst_cbuf),
                            DST_COLOR,
                            dst_rect,
                            dst_center,
                            DEFAULT_COLOR_CHANNEL_BITS,
                            false,
                        )?;
                    } else {
                        result &= base.clear_color_buffer(
                            base.default_fbo,
                            0,
                            0,
                            0,
                            DST_COLOR,
                            dst_rect,
                            dst_center,
                            DEFAULT_COLOR_CHANNEL_BITS,
                            false,
                        )?;
                    }
                }

                if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                    if buf_config.src_type == glw::GL_TEXTURE_2D {
                        gen_texture(base, buf_config.src_dbuf)?;

                        if buf_config.dst_type != 0 {
                            if effective_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
                                base.stcil_internal_format = glw::GL_DEPTH24_STENCIL8;
                                base.depth_internal_format = glw::GL_DEPTH24_STENCIL8;
                                base.stcil_type = glw::GL_UNSIGNED_INT_24_8;
                                base.depth_type = glw::GL_UNSIGNED_INT_24_8;
                                base.stcil_format = glw::GL_DEPTH_STENCIL;
                                base.depth_format = glw::GL_DEPTH_STENCIL;
                            } else {
                                base.depth_internal_format = glw::GL_DEPTH_COMPONENT16;
                                base.depth_type = glw::GL_UNSIGNED_SHORT;
                                base.depth_format = glw::GL_DEPTH_COMPONENT;
                            }
                        }
                        let src_dbuf = [base.slot(buf_config.src_dbuf)];
                        result &= base.init_gl_objs(
                            glw::GL_TEXTURE_2D,
                            0,
                            bind_texture,
                            &src_dbuf,
                            base.depth_internal_format,
                        )?;

                        for (depth, rect, center) in src_depth_quadrants {
                            result &= base.clear_depth_buffer(
                                base.fbos[0],
                                glw::GL_DEPTH_ATTACHMENT,
                                glw::GL_TEXTURE_2D,
                                src_dbuf[0],
                                base.depth_internal_format,
                                depth,
                                rect,
                                center,
                            )?;
                        }
                    } else if buf_config.src_type == glw::GL_RENDERBUFFER {
                        gen_renderbuffer(base, buf_config.src_dbuf)?;

                        if buf_config.dst_type != 0 {
                            if effective_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
                                base.stcil_internal_format = glw::GL_DEPTH24_STENCIL8;
                                base.depth_internal_format = glw::GL_DEPTH24_STENCIL8;
                                base.stcil_type = glw::GL_UNSIGNED_INT_24_8;
                                base.depth_type = glw::GL_UNSIGNED_INT_24_8;
                                base.stcil_format = glw::GL_DEPTH_STENCIL;
                                base.depth_format = glw::GL_DEPTH_STENCIL;
                            } else {
                                base.depth_internal_format = glw::GL_DEPTH_COMPONENT16;
                                base.depth_type = glw::GL_UNSIGNED_SHORT;
                                base.depth_format = glw::GL_DEPTH_COMPONENT;
                            }
                        }
                        let src_dbuf = [base.slot(buf_config.src_dbuf)];
                        result &= base.init_gl_objs(
                            glw::GL_RENDERBUFFER,
                            0,
                            bind_renderbuffer,
                            &src_dbuf,
                            base.depth_internal_format,
                        )?;
                        for (depth, rect, center) in src_depth_quadrants {
                            result &= base.clear_depth_buffer(
                                base.fbos[0],
                                glw::GL_DEPTH_ATTACHMENT,
                                glw::GL_RENDERBUFFER,
                                src_dbuf[0],
                                base.depth_internal_format,
                                depth,
                                rect,
                                center,
                            )?;
                        }
                    } else {
                        for (depth, rect, center) in src_depth_quadrants {
                            result &= base.clear_depth_buffer(
                                base.default_fbo,
                                0,
                                0,
                                0,
                                base.depth_internal_format,
                                depth,
                                rect,
                                center,
                            )?;
                        }
                    }

                    if buf_config.dst_type == glw::GL_TEXTURE_2D {
                        base.set_slot(buf_config.dst_dbuf, base.slot(buf_config.src_dbuf));
                        if !buf_config.same_read_and_draw_buffer {
                            gen_texture(base, buf_config.dst_dbuf)?;
                            let dst_dbuf = [base.slot(buf_config.dst_dbuf)];
                            result &= base.init_gl_objs(
                                glw::GL_TEXTURE_2D,
                                0,
                                bind_texture,
                                &dst_dbuf,
                                base.depth_internal_format,
                            )?;
                        }
                        result &= base.clear_depth_buffer(
                            base.fbos[1],
                            glw::GL_DEPTH_ATTACHMENT,
                            glw::GL_TEXTURE_2D,
                            base.slot(buf_config.dst_dbuf),
                            base.depth_internal_format,
                            DST_DEPTH,
                            dst_rect,
                            dst_center,
                        )?;
                    } else if buf_config.dst_type == glw::GL_RENDERBUFFER {
                        base.set_slot(buf_config.dst_dbuf, base.slot(buf_config.src_dbuf));
                        if !buf_config.same_read_and_draw_buffer {
                            gen_renderbuffer(base, buf_config.dst_dbuf)?;
                            let dst_dbuf = [base.slot(buf_config.dst_dbuf)];
                            result &= base.init_gl_objs(
                                glw::GL_RENDERBUFFER,
                                0,
                                bind_renderbuffer,
                                &dst_dbuf,
                                base.depth_internal_format,
                            )?;
                        }
                        result &= base.clear_depth_buffer(
                            base.fbos[1],
                            glw::GL_DEPTH_ATTACHMENT,
                            glw::GL_RENDERBUFFER,
                            base.slot(buf_config.dst_dbuf),
                            base.depth_internal_format,
                            DST_DEPTH,
                            dst_rect,
                            dst_center,
                        )?;
                    } else {
                        result &= base.clear_depth_buffer(
                            base.default_fbo,
                            0,
                            0,
                            0,
                            base.depth_internal_format,
                            DST_DEPTH,
                            dst_rect,
                            dst_center,
                        )?;
                    }
                }

                if effective_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
                    if buf_config.src_type == glw::GL_TEXTURE_2D {
                        if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                            base.set_slot(buf_config.src_sbuf, base.slot(buf_config.src_dbuf));
                        } else {
                            gen_texture(base, buf_config.src_sbuf)?;

                            if buf_config.dst_type != 0 {
                                base.stcil_internal_format = glw::GL_DEPTH24_STENCIL8;
                                base.stcil_type = glw::GL_UNSIGNED_INT_24_8;
                                base.stcil_format = glw::GL_DEPTH_STENCIL;
                            }

                            let src_sbuf = [base.slot(buf_config.src_sbuf)];
                            result &= base.init_gl_objs(
                                glw::GL_TEXTURE_2D,
                                0,
                                bind_texture,
                                &src_sbuf,
                                base.stcil_internal_format,
                            )?;
                        }
                        let src_sbuf = base.slot(buf_config.src_sbuf);
                        for (stcil, rect, center) in src_stencil_quadrants {
                            result &= base.clear_stencil_buffer(
                                base.fbos[0],
                                glw::GL_STENCIL_ATTACHMENT,
                                glw::GL_TEXTURE_2D,
                                src_sbuf,
                                stcil,
                                rect,
                                center,
                            )?;
                        }
                    } else if buf_config.src_type == glw::GL_RENDERBUFFER {
                        if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                            base.set_slot(buf_config.src_sbuf, base.slot(buf_config.src_dbuf));
                        } else {
                            gen_renderbuffer(base, buf_config.src_sbuf)?;

                            if buf_config.dst_type != 0 {
                                if buf_config.dst_type == glw::GL_TEXTURE_2D {
                                    base.stcil_internal_format = glw::GL_DEPTH24_STENCIL8;
                                    base.stcil_type = glw::GL_UNSIGNED_INT_24_8;
                                    base.stcil_format = glw::GL_DEPTH_STENCIL;
                                } else {
                                    base.stcil_internal_format = glw::GL_STENCIL_INDEX8;
                                    base.stcil_type = 0;
                                    base.stcil_format = 0;
                                }
                            }

                            let src_sbuf = [base.slot(buf_config.src_sbuf)];
                            result &= base.init_gl_objs(
                                glw::GL_RENDERBUFFER,
                                0,
                                bind_renderbuffer,
                                &src_sbuf,
                                base.stcil_internal_format,
                            )?;
                        }
                        let src_sbuf = base.slot(buf_config.src_sbuf);
                        for (stcil, rect, center) in src_stencil_quadrants {
                            result &= base.clear_stencil_buffer(
                                base.fbos[0],
                                glw::GL_STENCIL_ATTACHMENT,
                                glw::GL_RENDERBUFFER,
                                src_sbuf,
                                stcil,
                                rect,
                                center,
                            )?;
                        }
                    } else {
                        for (stcil, rect, center) in src_stencil_quadrants {
                            result &= base.clear_stencil_buffer(base.default_fbo, 0, 0, 0, stcil, rect, center)?;
                        }
                    }

                    if buf_config.dst_type == glw::GL_TEXTURE_2D {
                        if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                            base.set_slot(buf_config.dst_sbuf, base.slot(buf_config.dst_dbuf));
                        } else {
                            base.set_slot(buf_config.dst_sbuf, base.slot(buf_config.src_sbuf));
                            if !buf_config.same_read_and_draw_buffer {
                                gen_texture(base, buf_config.dst_sbuf)?;
                                let dst_sbuf = [base.slot(buf_config.dst_sbuf)];
                                result &= base.init_gl_objs(
                                    glw::GL_TEXTURE_2D,
                                    0,
                                    bind_texture,
                                    &dst_sbuf,
                                    base.stcil_internal_format,
                                )?;
                            }
                        }
                        result &= base.clear_stencil_buffer(
                            base.fbos[1],
                            glw::GL_STENCIL_ATTACHMENT,
                            glw::GL_TEXTURE_2D,
                            base.slot(buf_config.dst_sbuf),
                            DST_STCIL,
                            dst_rect,
                            dst_center,
                        )?;
                    } else if buf_config.dst_type == glw::GL_RENDERBUFFER {
                        if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                            base.set_slot(buf_config.dst_sbuf, base.slot(buf_config.dst_dbuf));
                        } else {
                            base.set_slot(buf_config.dst_sbuf, base.slot(buf_config.src_sbuf));
                            if !buf_config.same_read_and_draw_buffer {
                                gen_renderbuffer(base, buf_config.dst_sbuf)?;
                                let dst_sbuf = [base.slot(buf_config.dst_sbuf)];
                                result &= base.init_gl_objs(
                                    glw::GL_RENDERBUFFER,
                                    0,
                                    bind_renderbuffer,
                                    &dst_sbuf,
                                    base.stcil_internal_format,
                                )?;
                            }
                        }
                        result &= base.clear_stencil_buffer(
                            base.fbos[1],
                            glw::GL_STENCIL_ATTACHMENT,
                            glw::GL_RENDERBUFFER,
                            base.slot(buf_config.dst_sbuf),
                            DST_STCIL,
                            dst_rect,
                            dst_center,
                        )?;
                    } else {
                        result &=
                            base.clear_stencil_buffer(base.default_fbo, 0, 0, 0, DST_STCIL, dst_rect, dst_center)?;
                    }
                }

                base.print_global_buffer_info();

                let src_fbo = if buf_config.src_type == 0 {
                    base.default_fbo
                } else {
                    base.slot(buf_config.src_fbo)
                };
                let dst_fbo = if buf_config.dst_type == 0 {
                    base.default_fbo
                } else {
                    base.slot(buf_config.dst_fbo)
                };
                gl_call!(
                    gl,
                    "bindFramebuffer",
                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, src_fbo)
                );
                gl_call!(
                    gl,
                    "bindFramebuffer",
                    gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, dst_fbo)
                );

                if effective_bits & glw::GL_COLOR_BUFFER_BIT != 0 {
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_READ_FRAMEBUFFER,
                        attachment,
                        buf_config.src_type,
                        base.slot(buf_config.src_cbuf),
                    )?;
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_DRAW_FRAMEBUFFER,
                        attachment,
                        buf_config.dst_type,
                        base.slot(buf_config.dst_cbuf),
                    )?;
                }
                if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_DEPTH_ATTACHMENT,
                        buf_config.src_type,
                        base.slot(buf_config.src_dbuf),
                    )?;
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_DRAW_FRAMEBUFFER,
                        glw::GL_DEPTH_ATTACHMENT,
                        buf_config.dst_type,
                        base.slot(buf_config.dst_dbuf),
                    )?;
                }
                if effective_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_READ_FRAMEBUFFER,
                        glw::GL_STENCIL_ATTACHMENT,
                        buf_config.src_type,
                        base.slot(buf_config.src_sbuf),
                    )?;
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_DRAW_FRAMEBUFFER,
                        glw::GL_STENCIL_ATTACHMENT,
                        buf_config.dst_type,
                        base.slot(buf_config.dst_sbuf),
                    )?;
                }

                if buf_config.src_type != 0 {
                    gl_call!(gl, "readBuffer", gl.read_buffer(attachment));
                }

                if buf_config.dst_type != 0 {
                    gl_call!(gl, "drawBuffers", gl.draw_buffers(1, &attachment));
                }

                if scissored {
                    let scissor = base.setup.scissor_rect;
                    log::info!("SCISSOR[{},{},{},{}]", scissor.x, scissor.y, scissor.w, scissor.h);
                    gl_call!(gl, "scissor", gl.scissor(scissor.x, scissor.y, scissor.w, scissor.h));
                    gl_call!(gl, "enable", gl.enable(glw::GL_SCISSOR_TEST));
                }

                // SAFETY: plain queries on the framebuffers bound above.
                let status = unsafe { gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) };
                crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
                result &= status == glw::GL_FRAMEBUFFER_COMPLETE;
                if !result {
                    log::info!(
                        "glCheckFramebufferStatus: {}:{}expected {} but got {}",
                        file!(),
                        line!(),
                        enum_name(glw::GL_FRAMEBUFFER_COMPLETE),
                        enum_name(status)
                    );
                }
                // SAFETY: plain queries on the framebuffers bound above.
                let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
                crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
                result &= status == glw::GL_FRAMEBUFFER_COMPLETE;
                if !result {
                    log::info!(
                        "glCheckFramebufferStatus: {}:{}expected {} but got {}",
                        file!(),
                        line!(),
                        enum_name(glw::GL_FRAMEBUFFER_COMPLETE),
                        enum_name(status)
                    );
                }

                {
                    let mut src_x0 = blt_src_rect.x;
                    let mut src_y0 = blt_src_rect.y;
                    let mut src_x1 = blt_src_rect.x + blt_src_rect.w;
                    let mut src_y1 = blt_src_rect.y + blt_src_rect.h;

                    let mut dst_x0 = blt_dst_rect.x;
                    let mut dst_y0 = blt_dst_rect.y;
                    let mut dst_x1 = blt_dst_rect.x + blt_dst_rect.w;
                    let mut dst_y1 = blt_dst_rect.y + blt_dst_rect.h;

                    let flip_width =
                        |ul: &mut Rectangle, ur: &mut Rectangle, ll: &mut Rectangle, lr: &mut Rectangle| {
                            std::mem::swap(&mut ul.w, &mut ur.w);
                            ur.x = ul.x + ul.w;
                            std::mem::swap(&mut ll.w, &mut lr.w);
                            lr.x = ll.x + ll.w;
                        };
                    let flip_height =
                        |ul: &mut Rectangle, ur: &mut Rectangle, ll: &mut Rectangle, lr: &mut Rectangle| {
                            std::mem::swap(&mut ul.h, &mut ll.h);
                            ul.y = ll.y + ll.h;
                            std::mem::swap(&mut ur.h, &mut lr.h);
                            ur.y = lr.y + lr.h;
                        };

                    if base.setup.negative_src_width {
                        std::mem::swap(&mut src_x0, &mut src_x1);
                        flip_width(&mut dst_ul_rect, &mut dst_ur_rect, &mut dst_ll_rect, &mut dst_lr_rect);
                    }
                    if base.setup.negative_src_height {
                        std::mem::swap(&mut src_y0, &mut src_y1);
                        flip_height(&mut dst_ul_rect, &mut dst_ur_rect, &mut dst_ll_rect, &mut dst_lr_rect);
                    }
                    if base.setup.negative_dst_width {
                        std::mem::swap(&mut dst_x0, &mut dst_x1);
                        flip_width(&mut dst_ul_rect, &mut dst_ur_rect, &mut dst_ll_rect, &mut dst_lr_rect);
                    }
                    if base.setup.negative_dst_height {
                        std::mem::swap(&mut dst_y0, &mut dst_y1);
                        flip_height(&mut dst_ul_rect, &mut dst_ur_rect, &mut dst_ll_rect, &mut dst_lr_rect);
                    }

                    log::info!(
                        "BLIT blt_src_rect=[{src_x0},{src_y0},{src_x1},{src_y1}] blt_dst_rect=[{dst_x0},{dst_y0},{dst_x1},{dst_y1}]"
                    );

                    gl_call!(
                        gl,
                        "blitFramebuffer",
                        gl.blit_framebuffer(
                            src_x0,
                            src_y0,
                            src_x1,
                            src_y1,
                            dst_x0,
                            dst_y0,
                            dst_x1,
                            dst_y1,
                            effective_bits,
                            glw::GL_NEAREST
                        )
                    );
                }

                gl_call!(
                    gl,
                    "bindFramebuffer",
                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo)
                );

                if buf_config.dst_type != 0 {
                    gl_call!(gl, "readBuffer", gl.read_buffer(attachment));
                }

                if scissored {
                    gl_call!(gl, "disable", gl.disable(glw::GL_SCISSOR_TEST));
                }

                if effective_bits & glw::GL_COLOR_BUFFER_BIT != 0 {
                    for (coord, expected) in [
                        (end_ul_coord, base.setup.ul_color),
                        (end_ur_coord, base.setup.ur_color),
                        (end_ll_coord, base.setup.ll_color),
                        (end_lr_coord, base.setup.lr_color),
                    ] {
                        let actual = base.get_color(coord, false)?;
                        result &= base.check_color(actual, expected, DEFAULT_COLOR_CHANNEL_BITS);
                        fail_on_false(result, "checkColor")?;
                    }
                }
                if effective_bits & glw::GL_DEPTH_BUFFER_BIT != 0 {
                    let depth_pre_bits = base.depth_precision_bits(base.depth_internal_format);

                    for (coord, expected) in [
                        (end_ul_coord, base.setup.ul_depth),
                        (end_ur_coord, base.setup.ur_depth),
                        (end_ll_coord, base.setup.ll_depth),
                        (end_lr_coord, base.setup.lr_depth),
                    ] {
                        let (actual, result_pre_bits) = base.get_depth(coord)?;
                        let epsilon = get_epsilon(result_pre_bits, depth_pre_bits);
                        result &= base.check_depth(actual, expected, epsilon);
                        fail_on_false(result, "checkDepth")?;
                    }
                }
                if effective_bits & glw::GL_STENCIL_BUFFER_BIT != 0 {
                    for (coord, expected) in [
                        (end_ul_coord, base.setup.ul_stcil),
                        (end_ur_coord, base.setup.ur_stcil),
                        (end_ll_coord, base.setup.ll_stcil),
                        (end_lr_coord, base.setup.lr_stcil),
                    ] {
                        let actual = base.get_stencil(coord)?;
                        result &= base.check_stencil(actual, expected);
                        fail_on_false(result, "checkStencil")?;
                    }
                }

                let same_type = buf_config.dst_type == buf_config.src_type;
                if base.slot(buf_config.dst_cbuf) == base.slot(buf_config.src_cbuf) && same_type {
                    base.set_slot(buf_config.dst_cbuf, 0);
                }
                if base.slot(buf_config.dst_dbuf) == base.slot(buf_config.src_dbuf) && same_type {
                    base.set_slot(buf_config.dst_dbuf, 0);
                }
                if base.slot(buf_config.dst_sbuf) == base.slot(buf_config.src_sbuf) && same_type {
                    base.set_slot(buf_config.dst_sbuf, 0);
                }
                if base.slot(buf_config.src_sbuf) == base.slot(buf_config.src_dbuf) && same_type {
                    base.set_slot(buf_config.src_sbuf, 0);
                }

                gl_call!(gl, "deleteTextures", gl.delete_textures(2, base.color_tbos.as_ptr()));
                gl_call!(gl, "deleteTextures", gl.delete_textures(2, base.depth_tbos.as_ptr()));
                gl_call!(gl, "deleteTextures", gl.delete_textures(2, base.stcil_tbos.as_ptr()));
                gl_call!(
                    gl,
                    "deleteRenderbuffers",
                    gl.delete_renderbuffers(2, base.color_rbos.as_ptr())
                );
                gl_call!(
                    gl,
                    "deleteRenderbuffers",
                    gl.delete_renderbuffers(2, base.depth_rbos.as_ptr())
                );
                gl_call!(
                    gl,
                    "deleteRenderbuffers",
                    gl.delete_renderbuffers(2, base.stcil_rbos.as_ptr())
                );
                gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(2, base.fbos.as_ptr()));

                base.color_tbos = [0, 0];
                base.depth_tbos = [0, 0];
                base.stcil_tbos = [0, 0];
                base.color_rbos = [0, 0];
                base.depth_rbos = [0, 0];
                base.stcil_rbos = [0, 0];
                base.fbos = [0, 0];

                log::info!("END --------------------------------------------------------------------");
            }
        }
        Ok(result)
    }
}

impl TestCase for Scissor {
    fn name(&self) -> &str {
        "scissor_blit"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut base = Self::init(context);
        let gl = base.gl;

        let mut max_color_attachments: GLint = 0;
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_MAX_COLOR_ATTACHMENTS, &mut max_color_attachments)
        );

        if max_color_attachments < base.min_color_attachments {
            log::info!("glGetIntegerv: {}:{}expected true but got false", file!(), line!());
            return Err(TestError::Fail("result".to_string()));
        }

        if !Self::run_multi_color_pattern_test(&mut base, max_color_attachments)? {
            log::info!("Multi color blit test failed: {}:{}", file!(), line!());
            return Err(TestError::Fail("result".to_string()));
        }

        Ok(TestStatus::pass("Pass"))
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcFramebufferBlitTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `FramebufferBlitMultiToSingleSampledTestCase::iterate` dispatches on `dynamic_cast` upstream; here each of the two derived cases is its own type calling the same helper.

use super::{
    ALPHA_CHANNEL, BLUE, BLUE_CHANNEL, Base, Coord, DST_COLOR, DST_DEPTH, DST_STCIL, FOUR, GREEN, GREEN_CHANNEL,
    MultisampleColorConfig, ONE, Q1, Q2, Q3, Q4, RED, RED_CHANNEL, THREE, TWO, WHITE, bind_renderbuffer, bind_texture,
    enum_name,
};
use crate::glu::{Context, TestCase};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

const SAMPLES: GLuint = 4;

/// `FramebufferBlitMultiToSingleSampledTestCase::init` (desktop half)
fn multisample_color_cfg() -> Vec<MultisampleColorConfig> {
    let all = RED_CHANNEL | GREEN_CHANNEL | BLUE_CHANNEL | ALPHA_CHANNEL;
    let rgb = RED_CHANNEL | GREEN_CHANNEL | BLUE_CHANNEL;
    let rg = RED_CHANNEL | GREEN_CHANNEL;
    let entry = |internal_format, format, type_, color_channel_bits, is_float| MultisampleColorConfig {
        internal_format,
        format,
        type_,
        color_channel_bits,
        is_float,
    };
    vec![
        entry(glw::GL_R8, glw::GL_RED, glw::GL_UNSIGNED_BYTE, RED_CHANNEL, false),
        entry(glw::GL_RG8, glw::GL_RG, glw::GL_UNSIGNED_BYTE, rg, false),
        entry(glw::GL_RGBA8, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, all, false),
        entry(glw::GL_SRGB8_ALPHA8, glw::GL_RGBA, glw::GL_UNSIGNED_BYTE, all, false),
        entry(glw::GL_RGBA4, glw::GL_RGBA, glw::GL_UNSIGNED_SHORT_4_4_4_4, all, false),
        entry(
            glw::GL_RGB5_A1,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_SHORT_5_5_5_1,
            all,
            false,
        ),
        entry(
            glw::GL_R11F_G11F_B10F,
            glw::GL_RGB,
            glw::GL_UNSIGNED_INT_10F_11F_11F_REV,
            rgb,
            true,
        ),
        entry(glw::GL_RG16F, glw::GL_RG, glw::GL_HALF_FLOAT, rg, true),
        entry(glw::GL_R16F, glw::GL_RED, glw::GL_HALF_FLOAT, RED_CHANNEL, true),
        entry(glw::GL_RGB8, glw::GL_RGB, glw::GL_UNSIGNED_BYTE, rgb, false),
        entry(
            glw::GL_RGB10_A2,
            glw::GL_RGBA,
            glw::GL_UNSIGNED_INT_10_10_10_2,
            all,
            false,
        ),
    ]
}

/// The four quadrant centers `iterate` computes from the setup rectangles.
fn quadrant_centers(base: &Base) -> [Coord; 4] {
    let center = |rect: super::Rectangle| (rect.x + rect.w / 2, rect.y + rect.h / 2);
    [
        center(base.setup.ul_rect),
        center(base.setup.ur_rect),
        center(base.setup.ll_rect),
        center(base.setup.lr_rect),
    ]
}

fn verdict(result: bool) -> TestOutcome {
    Ok(if result {
        TestStatus::pass("Pass")
    } else {
        TestStatus::fail("Fail")
    })
}

/// `FramebufferBlitMultiToSingleSampledColorConfigTestCase`
pub(super) struct ColorConfigTest;

impl ColorConfigTest {
    /// `testColorBlitConfig`
    fn test_color_blit_config(
        base: &mut Base,
        centers: [Coord; 4],
        max_color_attachments: GLint,
    ) -> Result<bool, TestError> {
        let gl = base.gl;
        let mut result = true;
        let [ul_center, ur_center, ll_center, lr_center] = centers;
        let (ul_color, ur_color, ll_color, lr_color) = (RED, GREEN, BLUE, WHITE);
        let bits = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
        let filter = glw::GL_NEAREST;
        let multisample_color_cfg = multisample_color_cfg();

        for i in 0..base.buffer_cfg.len() {
            for j in 0..max_color_attachments {
                for color_config in &multisample_color_cfg {
                    let attachment: GLenum = glw::GL_COLOR_ATTACHMENT0 + j as u32;
                    let buf_config = base.buffer_cfg[i];

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

                        if (buf_config.src_type == 0 && sample_buffers == 0)
                            || (buf_config.dst_type == 0 && sample_buffers != 0)
                        {
                            continue;
                        }
                    }

                    if buf_config.same_read_and_draw_buffer {
                        continue;
                    }

                    log::info!(
                        "BEGIN ------------------------------------------------------------------BLITTING in {} from {} to {}[{}] buffers",
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
                        enum_name(color_config.internal_format)
                    );

                    gl_call!(gl, "enable", gl.enable(glw::GL_MULTISAMPLE));

                    gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(2, base.fbos.as_mut_ptr()));
                    gl_call!(gl, "genTextures", gl.gen_textures(2, base.color_tbos.as_mut_ptr()));

                    if base.ms_tbos_supported {
                        let tbo = [base.color_tbos[0]];
                        result &= base.init_gl_objs(
                            glw::GL_TEXTURE_2D_MULTISAMPLE,
                            SAMPLES,
                            bind_texture,
                            &tbo,
                            color_config.internal_format,
                        )?;
                    }

                    let tbo = [base.color_tbos[1]];
                    result &=
                        base.init_gl_objs(glw::GL_TEXTURE_2D, 0, bind_texture, &tbo, color_config.internal_format)?;

                    gl_call!(
                        gl,
                        "genRenderbuffers",
                        gl.gen_renderbuffers(2, base.color_rbos.as_mut_ptr())
                    );

                    let rbo = [base.color_rbos[0]];
                    result &= base.init_gl_objs(
                        glw::GL_RENDERBUFFER,
                        SAMPLES,
                        bind_renderbuffer,
                        &rbo,
                        color_config.internal_format,
                    )?;
                    let rbo = [base.color_rbos[1]];
                    result &= base.init_gl_objs(
                        glw::GL_RENDERBUFFER,
                        0,
                        bind_renderbuffer,
                        &rbo,
                        color_config.internal_format,
                    )?;

                    let quadrants = [
                        (ul_color, base.setup.ul_rect, ul_center),
                        (ur_color, base.setup.ur_rect, ur_center),
                        (ll_color, base.setup.ll_rect, ll_center),
                        (lr_color, base.setup.lr_rect, lr_center),
                    ];

                    if base.ms_tbos_supported && buf_config.src_type == glw::GL_TEXTURE_2D {
                        for (color, rect, center) in quadrants {
                            result &= base.clear_color_buffer(
                                base.fbos[0],
                                glw::GL_COLOR_ATTACHMENT0,
                                glw::GL_TEXTURE_2D_MULTISAMPLE,
                                base.color_tbos[0],
                                color,
                                rect,
                                center,
                                color_config.color_channel_bits,
                                color_config.is_float,
                            )?;
                        }
                    } else if buf_config.src_type == glw::GL_RENDERBUFFER {
                        for (color, rect, center) in quadrants {
                            result &= base.clear_color_buffer(
                                base.fbos[0],
                                glw::GL_COLOR_ATTACHMENT0,
                                glw::GL_RENDERBUFFER,
                                base.color_rbos[0],
                                color,
                                rect,
                                center,
                                color_config.color_channel_bits,
                                color_config.is_float,
                            )?;
                        }
                    } else {
                        for (color, rect, center) in quadrants {
                            result &= base.clear_color_buffer(
                                base.default_fbo,
                                glw::GL_NONE,
                                0,
                                0,
                                color,
                                rect,
                                center,
                                color_config.color_channel_bits,
                                color_config.is_float,
                            )?;
                        }
                    }

                    if buf_config.dst_type == glw::GL_TEXTURE_2D {
                        result &= base.clear_color_buffer(
                            base.fbos[1],
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_TEXTURE_2D,
                            base.color_tbos[1],
                            DST_COLOR,
                            base.full_rect,
                            base.default_coord,
                            color_config.color_channel_bits,
                            color_config.is_float,
                        )?;
                    } else if buf_config.dst_type == glw::GL_RENDERBUFFER {
                        result &= base.clear_color_buffer(
                            base.fbos[1],
                            glw::GL_COLOR_ATTACHMENT0,
                            glw::GL_RENDERBUFFER,
                            base.color_rbos[1],
                            DST_COLOR,
                            base.full_rect,
                            base.default_coord,
                            color_config.color_channel_bits,
                            color_config.is_float,
                        )?;
                    } else {
                        result &= base.clear_color_buffer(
                            base.default_fbo,
                            glw::GL_NONE,
                            0,
                            0,
                            DST_COLOR,
                            base.full_rect,
                            base.default_coord,
                            color_config.color_channel_bits,
                            color_config.is_float,
                        )?;
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

                    let src_cbuf = base.slot(buf_config.src_cbuf);
                    let dst_cbuf = base.slot(buf_config.dst_cbuf);
                    if base.ms_tbos_supported && buf_config.src_type == glw::GL_TEXTURE_2D {
                        result &= base.attach_buffer_to_framebuffer(
                            glw::GL_READ_FRAMEBUFFER,
                            attachment,
                            glw::GL_TEXTURE_2D_MULTISAMPLE,
                            src_cbuf,
                        )?;
                    } else {
                        result &= base.attach_buffer_to_framebuffer(
                            glw::GL_READ_FRAMEBUFFER,
                            attachment,
                            buf_config.src_type,
                            src_cbuf,
                        )?;
                    }
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_DRAW_FRAMEBUFFER,
                        attachment,
                        buf_config.dst_type,
                        dst_cbuf,
                    )?;

                    if buf_config.src_type != 0 {
                        gl_call!(gl, "readBuffer", gl.read_buffer(attachment));
                    }

                    if buf_config.dst_type != 0 {
                        gl_call!(gl, "drawBuffers", gl.draw_buffers(1, &attachment));
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
                        continue;
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
                        continue;
                    }

                    let (src, dst) = (base.setup.blt_src_rect, base.setup.blt_dst_rect);
                    log::info!(
                        "BLIT -------------------------------------------------------------------BLIT SRC_RECT=[{},{},{},{}] DST_RECT=[{},{},{},{}]",
                        src.x,
                        src.y,
                        src.w,
                        src.h,
                        dst.x,
                        dst.y,
                        dst.w,
                        dst.h
                    );

                    gl_call!(
                        gl,
                        "blitFramebuffer",
                        gl.blit_framebuffer(
                            src.x,
                            src.y,
                            src.x + src.w,
                            src.y + src.h,
                            dst.x,
                            dst.y,
                            dst.x + dst.w,
                            dst.y + dst.h,
                            bits,
                            filter
                        )
                    );

                    gl_call!(
                        gl,
                        "bindFramebuffer",
                        gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo)
                    );

                    if buf_config.dst_type != 0 {
                        gl_call!(gl, "readBuffer", gl.read_buffer(attachment));
                    }

                    log::info!("BITS [{:x}]", color_config.color_channel_bits);

                    for (coord, expected) in [
                        (base.setup.ul_coord, ul_color),
                        (base.setup.ur_coord, ur_color),
                        (base.setup.ll_coord, ll_color),
                        (base.setup.lr_coord, lr_color),
                    ] {
                        let actual = base.get_color(coord, color_config.is_float)?;
                        result &= base.check_color(actual, expected, color_config.color_channel_bits);
                        if !result {
                            log::info!("checkColor: {}:{}", file!(), line!());
                            return Err(TestError::Fail("result".to_string()));
                        }
                    }

                    gl_call!(gl, "deleteTextures", gl.delete_textures(2, base.color_tbos.as_ptr()));
                    base.color_tbos = [0, 0];
                    gl_call!(
                        gl,
                        "deleteRenderbuffers",
                        gl.delete_renderbuffers(2, base.color_rbos.as_ptr())
                    );
                    base.color_rbos = [0, 0];
                    gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(2, base.fbos.as_ptr()));
                    base.fbos = [0, 0];

                    gl_call!(gl, "disable", gl.disable(glw::GL_MULTISAMPLE));

                    log::info!("END --------------------------------------------------------------------");
                }
            }
        }
        Ok(result)
    }
}

impl TestCase for ColorConfigTest {
    fn name(&self) -> &str {
        "multisampled_to_singlesampled_blit_color_config_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut base = Base::new(context);
        let gl = base.gl;
        let centers = quadrant_centers(&base);

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

        let result = Self::test_color_blit_config(&mut base, centers, max_color_attachments)?;
        if !result {
            log::info!("color blit test failed: {}:{}", file!(), line!());
            return Err(TestError::Fail("result".to_string()));
        }

        verdict(true)
    }
}

/// `FramebufferBlitMultiToSingleSampledDepthConfigTestCase`
pub(super) struct DepthConfigTest;

impl DepthConfigTest {
    /// `testDepthBlitConfig`
    fn test_depth_blit_config(base: &mut Base, centers: [Coord; 4]) -> Result<bool, TestError> {
        let gl = base.gl;
        let mut result = true;
        let [ul_center, ur_center, ll_center, lr_center] = centers;
        let (ul_depth, ur_depth, ll_depth, lr_depth) = (Q1, Q2, Q3, Q4);
        let (ul_stcil, ur_stcil, ll_stcil, lr_stcil) = (ONE, TWO, THREE, FOUR);
        let bits = glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT;
        let filter = glw::GL_NEAREST;

        let get_blit_epsilon = |src_pre_bits: GLuint, result_pre_bits: GLuint, dst_pre_bits: GLuint| {
            let tolerance = src_pre_bits.min(result_pre_bits.min(dst_pre_bits)).min(23);
            1.0f32 / (1u32 << tolerance) as f32
        };

        for i in 0..base.buffer_cfg.len() {
            for j in 0..base.depth_cfg.len() {
                let buf_config = base.buffer_cfg[i];
                let depth_config = base.depth_cfg[j];

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

                    if (buf_config.src_type == 0 && sample_buffers == 0)
                        || (buf_config.dst_type == 0 && sample_buffers != 0)
                    {
                        continue;
                    }

                    let (found, no_default_depth, _no_default_stcil) = base.get_default_framebuffer_blit_format()?;
                    if !found {
                        continue;
                    }

                    if no_default_depth || depth_config.internal_format != base.depth_internal_format {
                        continue;
                    }
                }

                if buf_config.same_read_and_draw_buffer {
                    continue;
                }

                log::info!(
                    "BEGIN ------------------------------------------------------------------[{}] buffers",
                    enum_name(depth_config.internal_format)
                );

                gl_call!(gl, "enable", gl.enable(glw::GL_MULTISAMPLE));

                gl_call!(gl, "genFramebuffers", gl.gen_framebuffers(2, base.fbos.as_mut_ptr()));
                gl_call!(gl, "genTextures", gl.gen_textures(2, base.depth_tbos.as_mut_ptr()));

                if base.ms_tbos_supported {
                    let tbo = [base.depth_tbos[0]];
                    result &= base.init_gl_objs(
                        glw::GL_TEXTURE_2D_MULTISAMPLE,
                        SAMPLES,
                        bind_texture,
                        &tbo,
                        depth_config.internal_format,
                    )?;
                }

                let tbo = [base.depth_tbos[1]];
                result &= base.init_gl_objs(glw::GL_TEXTURE_2D, 0, bind_texture, &tbo, depth_config.internal_format)?;

                gl_call!(
                    gl,
                    "genRenderbuffers",
                    gl.gen_renderbuffers(2, base.depth_rbos.as_mut_ptr())
                );

                let rbo = [base.depth_rbos[0]];
                result &= base.init_gl_objs(
                    glw::GL_RENDERBUFFER,
                    SAMPLES,
                    bind_renderbuffer,
                    &rbo,
                    depth_config.internal_format,
                )?;
                let rbo = [base.depth_rbos[1]];
                result &= base.init_gl_objs(
                    glw::GL_RENDERBUFFER,
                    0,
                    bind_renderbuffer,
                    &rbo,
                    depth_config.internal_format,
                )?;

                let depth_quadrants = [
                    (ul_depth, base.setup.ul_rect, ul_center),
                    (ur_depth, base.setup.ur_rect, ur_center),
                    (ll_depth, base.setup.ll_rect, ll_center),
                    (lr_depth, base.setup.lr_rect, lr_center),
                ];
                let stencil_quadrants = [
                    (ul_stcil, base.setup.ul_rect, ul_center),
                    (ur_stcil, base.setup.ur_rect, ur_center),
                    (ll_stcil, base.setup.ll_rect, ll_center),
                    (lr_stcil, base.setup.lr_rect, lr_center),
                ];

                if base.ms_tbos_supported && buf_config.src_type == glw::GL_TEXTURE_2D {
                    for (depth, rect, center) in depth_quadrants {
                        result &= base.clear_depth_buffer(
                            base.fbos[0],
                            depth_config.attachment,
                            glw::GL_TEXTURE_2D_MULTISAMPLE,
                            base.depth_tbos[0],
                            depth_config.internal_format,
                            depth,
                            rect,
                            center,
                        )?;
                    }
                } else if buf_config.src_type == glw::GL_RENDERBUFFER {
                    for (depth, rect, center) in depth_quadrants {
                        result &= base.clear_depth_buffer(
                            base.fbos[0],
                            depth_config.attachment,
                            glw::GL_RENDERBUFFER,
                            base.depth_rbos[0],
                            depth_config.internal_format,
                            depth,
                            rect,
                            center,
                        )?;
                    }
                } else {
                    for (depth, rect, center) in depth_quadrants {
                        result &= base.clear_depth_buffer(
                            base.default_fbo,
                            0,
                            0,
                            0,
                            depth_config.internal_format,
                            depth,
                            rect,
                            center,
                        )?;
                    }
                }

                if buf_config.dst_type == glw::GL_TEXTURE_2D {
                    result &= base.clear_depth_buffer(
                        base.fbos[1],
                        depth_config.attachment,
                        glw::GL_TEXTURE_2D,
                        base.depth_tbos[1],
                        depth_config.internal_format,
                        DST_DEPTH,
                        base.full_rect,
                        base.default_coord,
                    )?;
                } else if buf_config.dst_type == glw::GL_RENDERBUFFER {
                    result &= base.clear_depth_buffer(
                        base.fbos[1],
                        depth_config.attachment,
                        glw::GL_RENDERBUFFER,
                        base.depth_rbos[1],
                        depth_config.internal_format,
                        DST_DEPTH,
                        base.full_rect,
                        base.default_coord,
                    )?;
                } else {
                    result &= base.clear_depth_buffer(
                        base.default_fbo,
                        0,
                        0,
                        0,
                        depth_config.internal_format,
                        DST_DEPTH,
                        base.full_rect,
                        base.default_coord,
                    )?;
                }

                if depth_config.attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT {
                    if base.ms_tbos_supported && buf_config.src_type == glw::GL_TEXTURE_2D {
                        for (stcil, rect, center) in stencil_quadrants {
                            result &= base.clear_stencil_buffer(
                                base.fbos[0],
                                depth_config.attachment,
                                glw::GL_TEXTURE_2D_MULTISAMPLE,
                                base.depth_tbos[0],
                                stcil,
                                rect,
                                center,
                            )?;
                        }
                    } else if buf_config.src_type == glw::GL_RENDERBUFFER {
                        for (stcil, rect, center) in stencil_quadrants {
                            result &= base.clear_stencil_buffer(
                                base.fbos[0],
                                depth_config.attachment,
                                glw::GL_RENDERBUFFER,
                                base.depth_rbos[0],
                                stcil,
                                rect,
                                center,
                            )?;
                        }
                    } else {
                        for (stcil, rect, center) in stencil_quadrants {
                            result &= base.clear_stencil_buffer(base.default_fbo, 0, 0, 0, stcil, rect, center)?;
                        }
                    }

                    if buf_config.dst_type == glw::GL_TEXTURE_2D {
                        result &= base.clear_stencil_buffer(
                            base.fbos[1],
                            depth_config.attachment,
                            glw::GL_TEXTURE_2D,
                            base.depth_tbos[1],
                            DST_STCIL,
                            base.full_rect,
                            base.default_coord,
                        )?;
                    } else if buf_config.dst_type == glw::GL_RENDERBUFFER {
                        result &= base.clear_stencil_buffer(
                            base.fbos[1],
                            depth_config.attachment,
                            glw::GL_RENDERBUFFER,
                            base.depth_rbos[1],
                            DST_STCIL,
                            base.full_rect,
                            base.default_coord,
                        )?;
                    } else {
                        result &= base.clear_stencil_buffer(
                            base.default_fbo,
                            0,
                            0,
                            0,
                            DST_STCIL,
                            base.full_rect,
                            base.default_coord,
                        )?;
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

                let src_dbuf = base.slot(buf_config.src_dbuf);
                let dst_dbuf = base.slot(buf_config.dst_dbuf);
                if base.ms_tbos_supported && buf_config.src_type == glw::GL_TEXTURE_2D {
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_READ_FRAMEBUFFER,
                        depth_config.attachment,
                        glw::GL_TEXTURE_2D_MULTISAMPLE,
                        src_dbuf,
                    )?;
                } else {
                    result &= base.attach_buffer_to_framebuffer(
                        glw::GL_READ_FRAMEBUFFER,
                        depth_config.attachment,
                        buf_config.src_type,
                        src_dbuf,
                    )?;
                }
                result &= base.attach_buffer_to_framebuffer(
                    glw::GL_DRAW_FRAMEBUFFER,
                    depth_config.attachment,
                    buf_config.dst_type,
                    dst_dbuf,
                )?;

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
                    continue;
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
                    continue;
                }

                log::info!(
                    "BLITTING in {} from {} to {}",
                    enum_name(depth_config.attachment),
                    if buf_config.src_type == 0 {
                        "DEFAULT".to_string()
                    } else {
                        enum_name(buf_config.src_type)
                    },
                    if buf_config.dst_type == 0 {
                        "DEFAULT".to_string()
                    } else {
                        enum_name(buf_config.dst_type)
                    }
                );

                let (src, dst) = (base.setup.blt_src_rect, base.setup.blt_dst_rect);
                log::info!(
                    "BLIT -------------------------------------------------------------------BLIT SRC_RECT=[{},{},{},{}] DST_RECT=[{},{},{},{}]",
                    src.x,
                    src.y,
                    src.x + src.w,
                    src.y + src.h,
                    dst.x,
                    dst.y,
                    dst.x + dst.w,
                    dst.y + dst.h
                );

                gl_call!(
                    gl,
                    "blitFramebuffer",
                    gl.blit_framebuffer(
                        src.x,
                        src.y,
                        src.x + src.w,
                        src.y + src.h,
                        dst.x,
                        dst.y,
                        dst.x + dst.w,
                        dst.y + dst.h,
                        bits,
                        filter
                    )
                );

                gl_call!(
                    gl,
                    "bindFramebuffer",
                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, dst_fbo)
                );

                {
                    let src_pre_bits = if buf_config.src_type != 0 {
                        base.depth_precision_bits(depth_config.internal_format) as GLint
                    } else {
                        base.get_depth_or_stencil_bits(glw::GL_READ_FRAMEBUFFER, false)?
                    };
                    let dst_pre_bits = if buf_config.dst_type != 0 {
                        base.depth_precision_bits(depth_config.internal_format) as GLint
                    } else {
                        base.get_depth_or_stencil_bits(glw::GL_READ_FRAMEBUFFER, false)?
                    };

                    for (coord, expected) in [
                        (base.setup.ul_coord, ul_depth),
                        (base.setup.ur_coord, ur_depth),
                        (base.setup.ll_coord, ll_depth),
                        (base.setup.lr_coord, lr_depth),
                    ] {
                        let (actual, result_pre_bits) = base.get_depth(coord)?;
                        let epsilon = get_blit_epsilon(src_pre_bits as GLuint, result_pre_bits, dst_pre_bits as GLuint);
                        result &= base.check_depth(actual, expected, epsilon);
                        if !result {
                            log::info!("checkDepth: {}:{}", file!(), line!());
                            return Err(TestError::Fail("result".to_string()));
                        }
                    }
                }

                if depth_config.attachment == glw::GL_DEPTH_STENCIL_ATTACHMENT {
                    for (coord, expected) in [
                        (base.setup.ul_coord, ul_stcil),
                        (base.setup.ur_coord, ur_stcil),
                        (base.setup.ll_coord, ll_stcil),
                        (base.setup.lr_coord, lr_stcil),
                    ] {
                        let actual = base.get_stencil(coord)?;
                        result &= base.check_stencil(actual, expected);
                        if !result {
                            log::info!("checkStencil: {}:{}", file!(), line!());
                            return Err(TestError::Fail("result".to_string()));
                        }
                    }
                }

                gl_call!(gl, "deleteTextures", gl.delete_textures(2, base.depth_tbos.as_ptr()));
                base.color_tbos = [0, 0];
                gl_call!(
                    gl,
                    "deleteRenderbuffers",
                    gl.delete_renderbuffers(2, base.depth_rbos.as_ptr())
                );
                base.depth_rbos = [0, 0];
                base.color_rbos = [0, 0];
                gl_call!(gl, "deleteFramebuffers", gl.delete_framebuffers(2, base.fbos.as_ptr()));
                base.fbos = [0, 0];

                gl_call!(gl, "disable", gl.disable(glw::GL_MULTISAMPLE));

                log::info!("END --------------------------------------------------------------------");
            }
        }

        Ok(result)
    }
}

impl TestCase for DepthConfigTest {
    fn name(&self) -> &str {
        "multisampled_to_singlesampled_blit_depth_config_test"
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut base = Base::new(context);
        let centers = quadrant_centers(&base);

        let result = Self::test_depth_blit_config(&mut base, centers)?;
        if !result {
            log::info!("depth blit test failed: {}:{}", file!(), line!());
            return Err(TestError::Fail("result".to_string()));
        }

        verdict(true)
    }
}

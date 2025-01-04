// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcFramebufferBlitTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Desktop GL only: every `m_isContextES` branch (the shader based depth and stencil read-back, the extension gates) is dropped. `BufferConfig`'s pointers into the member arrays are `Slot` indices. The default framebuffer is object 0, which is what `getDefaultFramebuffer` returns on the EGL surfaces used here.

use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLint, GLuint};
use crate::tcu::TestError;

/// One GL call followed by upstream's `GLU_EXPECT_NO_ERROR` on it.
macro_rules! gl_call {
    ($gl:expr, $name:expr, $call:expr) => {{
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call };
        crate::glu::expect_no_error($gl, $name)?;
    }};
}

mod multisampled;
mod scissor;

pub(super) type Stencil = GLuint;
pub(super) type Depth = f32;
pub(super) type Color = [f32; 4];
pub(super) type Coord = (GLint, GLint);

pub(super) const RED: Color = [1.0, 0.0, 0.0, 1.0];
pub(super) const GREEN: Color = [0.0, 1.0, 0.0, 1.0];
pub(super) const BLUE: Color = [0.0, 0.0, 1.0, 1.0];
pub(super) const WHITE: Color = [1.0, 1.0, 1.0, 1.0];
pub(super) const BLACK: Color = [0.0, 0.0, 0.0, 1.0];
pub(super) const Q0: Depth = 0.0;
pub(super) const Q1: Depth = 0.25;
pub(super) const Q2: Depth = 0.5;
pub(super) const Q3: Depth = 0.75;
pub(super) const Q4: Depth = 1.0;
pub(super) const ZERO: Stencil = 0;
pub(super) const ONE: Stencil = 1;
pub(super) const TWO: Stencil = 2;
pub(super) const THREE: Stencil = 3;
pub(super) const FOUR: Stencil = 4;

pub(super) const RED_CHANNEL: GLuint = 1 << 13;
pub(super) const GREEN_CHANNEL: GLuint = 1 << 14;
pub(super) const BLUE_CHANNEL: GLuint = 1 << 15;
pub(super) const ALPHA_CHANNEL: GLuint = 1 << 16;
pub(super) const MAX_BUF_OBJECTS: GLuint = 256;
pub(super) const DEFAULT_COLOR_CHANNEL_BITS: GLuint = RED_CHANNEL | GREEN_CHANNEL | BLUE_CHANNEL | ALPHA_CHANNEL;

pub(super) const DST_COLOR: Color = [0.0, 0.0, 0.0, 1.0];
pub(super) const DST_DEPTH: Depth = 0.0;
pub(super) const DST_STCIL: Stencil = 0;

pub(super) fn enum_name(e: GLenum) -> String {
    format!("0x{e:04x}")
}

/// `blt::Rectangle`
#[derive(Clone, Copy, Default)]
pub(super) struct Rectangle {
    pub x: GLint,
    pub y: GLint,
    pub w: GLint,
    pub h: GLint,
}

impl Rectangle {
    pub(super) fn new(x: GLint, y: GLint, w: GLint, h: GLint) -> Self {
        Self { x, y, w, h }
    }
}

/// `blt::MultiColorTestSetup`
#[derive(Clone, Copy, Default)]
#[allow(dead_code)]
pub(super) struct MultiColorTestSetup {
    pub ul_rect: Rectangle,
    pub ur_rect: Rectangle,
    pub ll_rect: Rectangle,
    pub lr_rect: Rectangle,
    pub blt_src_rect: Rectangle,
    pub blt_dst_rect: Rectangle,
    pub scissor_rect: Rectangle,
    pub ul_coord: Coord,
    pub ur_coord: Coord,
    pub ll_coord: Coord,
    pub lr_coord: Coord,
    pub ul_color: Color,
    pub ur_color: Color,
    pub ll_color: Color,
    pub lr_color: Color,
    pub ul_depth: Depth,
    pub ur_depth: Depth,
    pub ll_depth: Depth,
    pub lr_depth: Depth,
    pub ul_stcil: Stencil,
    pub ur_stcil: Stencil,
    pub ll_stcil: Stencil,
    pub lr_stcil: Stencil,
    pub negative_src_width: bool,
    pub negative_src_height: bool,
    pub negative_dst_width: bool,
    pub negative_dst_height: bool,
}

/// Which member of `FramebufferBlitBaseTestCase` an upstream `BufferConfig` pointer points at.
#[derive(Clone, Copy)]
pub(super) enum Slot {
    Fbo(usize),
    ColorTbo(usize),
    DepthTbo(usize),
    StcilTbo(usize),
    ColorRbo(usize),
    DepthRbo(usize),
    StcilRbo(usize),
    Dflt,
}

/// `blt::BufferConfig`
#[derive(Clone, Copy)]
#[allow(dead_code)]
pub(super) struct BufferConfig {
    pub src_fbo: Slot,
    pub dst_fbo: Slot,
    pub src_type: GLenum,
    pub dst_type: GLenum,
    pub src_cbuf: Slot,
    pub src_dbuf: Slot,
    pub src_sbuf: Slot,
    pub dst_cbuf: Slot,
    pub dst_dbuf: Slot,
    pub dst_sbuf: Slot,
    pub same_read_and_draw_buffer: bool,
}

/// `blt::MultisampleColorConfig`
#[derive(Clone, Copy)]
#[allow(dead_code)]
pub(super) struct MultisampleColorConfig {
    pub internal_format: GLenum,
    pub format: GLenum,
    pub type_: GLenum,
    pub color_channel_bits: GLuint,
    pub is_float: bool,
}

/// `blt::DepthConfig`
#[derive(Clone, Copy)]
#[allow(dead_code)]
pub(super) struct DepthConfig {
    pub internal_format: GLenum,
    pub format: GLenum,
    pub type_: GLenum,
    pub attachment: GLenum,
    pub precision_bits: GLuint,
}

/// `FramebufferBlitBaseTestCase`, built by `init` and dropped with the test.
#[allow(dead_code)]
pub(super) struct Base<'a> {
    pub gl: &'a glw::Functions,
    pub fbos: [GLuint; 2],
    pub color_tbos: [GLuint; 2],
    pub depth_tbos: [GLuint; 2],
    pub stcil_tbos: [GLuint; 2],
    pub color_rbos: [GLuint; 2],
    pub depth_rbos: [GLuint; 2],
    pub stcil_rbos: [GLuint; 2],
    pub dflt: GLuint,
    pub full_rect: Rectangle,
    pub default_coord: Coord,
    pub setup: MultiColorTestSetup,
    pub default_fbo: GLuint,
    pub ms_tbos_supported: bool,
    pub min_color_attachments: GLint,
    pub buffer_cfg: Vec<BufferConfig>,
    pub depth_cfg: Vec<DepthConfig>,
    pub depth_internal_format: GLuint,
    pub depth_type: GLuint,
    pub depth_format: GLuint,
    pub stcil_internal_format: GLuint,
    pub stcil_type: GLuint,
    pub stcil_format: GLuint,
}

impl<'a> Base<'a> {
    /// `FramebufferBlitBaseTestCase::init` (desktop half)
    pub(super) fn new(context: &'a Context) -> Self {
        let render_target = context.render_target();
        let (buf_width, buf_height) = (render_target.width, render_target.height);

        let full_rect = Rectangle::new(0, 0, buf_width, buf_height);

        let setup = MultiColorTestSetup {
            ul_rect: Rectangle::new(0, buf_height / 2, buf_width / 2, buf_height - buf_height / 2),
            ur_rect: Rectangle::new(
                buf_width / 2,
                buf_height / 2,
                buf_width - buf_width / 2,
                buf_height - buf_height / 2,
            ),
            ll_rect: Rectangle::new(0, 0, buf_width / 2, buf_height / 2),
            lr_rect: Rectangle::new(buf_width / 2, 0, buf_width - buf_width / 2, buf_height / 2),
            blt_src_rect: full_rect,
            blt_dst_rect: full_rect,
            scissor_rect: full_rect,
            ul_coord: (0, buf_height - 1),
            ur_coord: (buf_width - 1, buf_height - 1),
            ll_coord: (0, 0),
            lr_coord: (buf_width - 1, 0),
            ul_color: RED,
            ur_color: GREEN,
            ll_color: BLUE,
            lr_color: WHITE,
            ul_depth: Q1,
            ur_depth: Q2,
            ll_depth: Q3,
            lr_depth: Q4,
            ul_stcil: ONE,
            ur_stcil: TWO,
            ll_stcil: THREE,
            lr_stcil: FOUR,
            negative_src_width: false,
            negative_src_height: false,
            negative_dst_width: false,
            negative_dst_height: false,
        };

        let config = |src_fbo, dst_fbo, src_type, dst_type, src: [Slot; 3], dst: [Slot; 3], same| BufferConfig {
            src_fbo,
            dst_fbo,
            src_type,
            dst_type,
            src_cbuf: src[0],
            src_dbuf: src[1],
            src_sbuf: src[2],
            dst_cbuf: dst[0],
            dst_dbuf: dst[1],
            dst_sbuf: dst[2],
            same_read_and_draw_buffer: same,
        };
        let tbo0 = [Slot::ColorTbo(0), Slot::DepthTbo(0), Slot::StcilTbo(0)];
        let tbo1 = [Slot::ColorTbo(1), Slot::DepthTbo(1), Slot::StcilTbo(1)];
        let rbo0 = [Slot::ColorRbo(0), Slot::DepthRbo(0), Slot::StcilRbo(0)];
        let rbo1 = [Slot::ColorRbo(1), Slot::DepthRbo(1), Slot::StcilRbo(1)];
        let dflt = [Slot::Dflt; 3];
        let (f0, f1, d) = (Slot::Fbo(0), Slot::Fbo(1), Slot::Dflt);
        let (tex, rbo) = (glw::GL_TEXTURE_2D, glw::GL_RENDERBUFFER);

        let buffer_cfg = vec![
            config(f0, f1, tex, tex, tbo0, tbo1, false),
            config(f0, f1, rbo, tex, rbo0, tbo1, false),
            config(f0, f1, tex, rbo, tbo0, rbo1, false),
            config(f0, f1, rbo, rbo, rbo0, rbo1, false),
            config(d, f1, 0, tex, dflt, tbo1, false),
            config(d, f1, 0, rbo, dflt, rbo1, false),
            config(f0, d, tex, 0, tbo0, dflt, false),
            config(f0, d, rbo, 0, rbo0, dflt, false),
            config(f0, f1, tex, tex, tbo0, tbo1, true),
            config(f0, f1, rbo, rbo, rbo0, rbo1, true),
            config(d, d, 0, 0, dflt, dflt, true),
        ];

        let depth_cfg = vec![
            DepthConfig {
                internal_format: glw::GL_DEPTH_COMPONENT24,
                format: glw::GL_DEPTH_COMPONENT,
                type_: glw::GL_UNSIGNED_INT,
                attachment: glw::GL_DEPTH_ATTACHMENT,
                precision_bits: 24,
            },
            DepthConfig {
                internal_format: glw::GL_DEPTH_COMPONENT16,
                format: glw::GL_DEPTH_COMPONENT,
                type_: glw::GL_UNSIGNED_SHORT,
                attachment: glw::GL_DEPTH_ATTACHMENT,
                precision_bits: 16,
            },
            DepthConfig {
                internal_format: glw::GL_DEPTH_COMPONENT32F,
                format: glw::GL_DEPTH_COMPONENT,
                type_: glw::GL_FLOAT,
                attachment: glw::GL_DEPTH_ATTACHMENT,
                precision_bits: 32,
            },
            DepthConfig {
                internal_format: glw::GL_DEPTH24_STENCIL8,
                format: glw::GL_DEPTH_STENCIL,
                type_: glw::GL_UNSIGNED_INT_24_8,
                attachment: glw::GL_DEPTH_STENCIL_ATTACHMENT,
                precision_bits: 24,
            },
            DepthConfig {
                internal_format: glw::GL_DEPTH32F_STENCIL8,
                format: glw::GL_DEPTH_STENCIL,
                type_: glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV,
                attachment: glw::GL_DEPTH_STENCIL_ATTACHMENT,
                precision_bits: 32,
            },
            DepthConfig {
                internal_format: glw::GL_DEPTH_COMPONENT32,
                format: glw::GL_DEPTH_COMPONENT,
                type_: glw::GL_UNSIGNED_INT,
                attachment: glw::GL_DEPTH_ATTACHMENT,
                precision_bits: 32,
            },
        ];

        Self {
            gl: context.gl(),
            fbos: [0; 2],
            color_tbos: [0; 2],
            depth_tbos: [0; 2],
            stcil_tbos: [0; 2],
            color_rbos: [0; 2],
            depth_rbos: [0; 2],
            stcil_rbos: [0; 2],
            dflt: 0,
            full_rect,
            default_coord: (buf_width / 2, buf_height / 2),
            setup,
            default_fbo: 0,
            ms_tbos_supported: true,
            min_color_attachments: 8,
            buffer_cfg,
            depth_cfg,
            depth_internal_format: 0,
            depth_type: 0,
            depth_format: 0,
            stcil_internal_format: 0,
            stcil_type: 0,
            stcil_format: 0,
        }
    }

    pub(super) fn slot(&self, slot: Slot) -> GLuint {
        match slot {
            Slot::Fbo(i) => self.fbos[i],
            Slot::ColorTbo(i) => self.color_tbos[i],
            Slot::DepthTbo(i) => self.depth_tbos[i],
            Slot::StcilTbo(i) => self.stcil_tbos[i],
            Slot::ColorRbo(i) => self.color_rbos[i],
            Slot::DepthRbo(i) => self.depth_rbos[i],
            Slot::StcilRbo(i) => self.stcil_rbos[i],
            Slot::Dflt => self.dflt,
        }
    }

    pub(super) fn set_slot(&mut self, slot: Slot, value: GLuint) {
        match slot {
            Slot::Fbo(i) => self.fbos[i] = value,
            Slot::ColorTbo(i) => self.color_tbos[i] = value,
            Slot::DepthTbo(i) => self.depth_tbos[i] = value,
            Slot::StcilTbo(i) => self.stcil_tbos[i] = value,
            Slot::ColorRbo(i) => self.color_rbos[i] = value,
            Slot::DepthRbo(i) => self.depth_rbos[i] = value,
            Slot::StcilRbo(i) => self.stcil_rbos[i] = value,
            Slot::Dflt => self.dflt = value,
        }
    }

    /// `getBits` for `GL_DEPTH_BITS` / `GL_STENCIL_BITS` on a desktop context
    pub(super) fn get_depth_or_stencil_bits(&self, target: GLenum, stencil: bool) -> Result<GLint, TestError> {
        let gl = self.gl;
        let mut fbo: GLint = 0;
        let binding = if target == glw::GL_READ_FRAMEBUFFER {
            glw::GL_READ_FRAMEBUFFER_BINDING
        } else {
            glw::GL_FRAMEBUFFER_BINDING
        };
        gl_call!(gl, "getIntegerv", gl.get_integerv(binding, &mut fbo));

        let mut attachment = if stencil { glw::GL_STENCIL } else { glw::GL_DEPTH };
        if fbo != 0 {
            attachment = if stencil {
                glw::GL_STENCIL_ATTACHMENT
            } else {
                glw::GL_DEPTH_ATTACHMENT
            };
        } else {
            let mut object_type: GLint = 0;
            gl_call!(
                gl,
                "getFramebufferAttachmentParameteriv",
                gl.get_framebuffer_attachment_parameteriv(
                    target,
                    attachment,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
                    &mut object_type
                )
            );
            if object_type == glw::GL_NONE as GLint {
                return Ok(0);
            }
        }

        let size = if stencil {
            glw::GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE
        } else {
            glw::GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE
        };
        let mut value: GLint = 0;
        gl_call!(
            gl,
            "getFramebufferAttachmentParameteriv",
            gl.get_framebuffer_attachment_parameteriv(target, attachment, size, &mut value)
        );
        Ok(value)
    }

    /// `GetDefaultFramebufferBlitFormat`, returning (found, noDepth, noStencil)
    pub(super) fn get_default_framebuffer_blit_format(&mut self) -> Result<(bool, bool, bool), TestError> {
        let gl = self.gl;
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_FRAMEBUFFER, self.default_fbo)
        );

        let depth_bits = self.get_depth_or_stencil_bits(glw::GL_DRAW_FRAMEBUFFER, false)?;
        let stencil_bits = self.get_depth_or_stencil_bits(glw::GL_DRAW_FRAMEBUFFER, true)?;

        self.depth_internal_format = 0;
        self.depth_type = 0;
        self.depth_format = 0;
        self.stcil_internal_format = 0;
        self.stcil_type = 0;
        self.stcil_format = 0;

        let no_depth = depth_bits == 0;
        let no_stencil = stencil_bits == 0;

        if self.default_fbo != 0 {
            self.stcil_internal_format = glw::GL_DEPTH24_STENCIL8;
            self.depth_internal_format = glw::GL_DEPTH24_STENCIL8;
            self.stcil_type = glw::GL_UNSIGNED_INT_24_8;
            self.depth_type = glw::GL_UNSIGNED_INT_24_8;
            self.stcil_format = glw::GL_DEPTH_STENCIL;
            self.depth_format = glw::GL_DEPTH_STENCIL;
            return Ok((true, no_depth, no_stencil));
        }

        let found = match (depth_bits, stencil_bits) {
            (16, 0) => {
                self.depth_internal_format = glw::GL_DEPTH_COMPONENT16;
                self.depth_type = glw::GL_UNSIGNED_SHORT;
                self.depth_format = glw::GL_DEPTH_COMPONENT;
                true
            }
            (24, 0) => {
                self.depth_internal_format = glw::GL_DEPTH_COMPONENT24;
                self.depth_type = glw::GL_UNSIGNED_INT;
                self.depth_format = glw::GL_DEPTH_COMPONENT;
                true
            }
            (24, 8) => {
                self.stcil_internal_format = glw::GL_DEPTH24_STENCIL8;
                self.depth_internal_format = glw::GL_DEPTH24_STENCIL8;
                self.stcil_type = glw::GL_UNSIGNED_INT_24_8;
                self.depth_type = glw::GL_UNSIGNED_INT_24_8;
                self.stcil_format = glw::GL_DEPTH_STENCIL;
                self.depth_format = glw::GL_DEPTH_STENCIL;
                true
            }
            (32, 0) => {
                let component_type = self.get_drawbuffer_32_depth_component_type()?;
                if component_type == glw::GL_FLOAT as GLint {
                    self.depth_internal_format = glw::GL_DEPTH_COMPONENT32F;
                    self.depth_type = glw::GL_FLOAT;
                } else {
                    self.depth_internal_format = glw::GL_DEPTH_COMPONENT32;
                    self.depth_type = glw::GL_UNSIGNED_INT;
                }
                self.depth_format = glw::GL_DEPTH_COMPONENT;
                true
            }
            (32, 8) => {
                self.stcil_internal_format = glw::GL_DEPTH32F_STENCIL8;
                self.depth_internal_format = glw::GL_DEPTH32F_STENCIL8;
                self.stcil_type = glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV;
                self.depth_type = glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV;
                self.stcil_format = glw::GL_DEPTH_STENCIL;
                self.depth_format = glw::GL_DEPTH_STENCIL;
                true
            }
            _ => false,
        };
        Ok((found, no_depth, no_stencil))
    }

    /// `GetDrawbuffer32DepthComponentType` (the value; upstream's bool is not read by any caller)
    pub(super) fn get_drawbuffer_32_depth_component_type(&self) -> Result<GLint, TestError> {
        let gl = self.gl;
        let target = glw::GL_DRAW_FRAMEBUFFER;
        let mut depth_attachment = glw::GL_DEPTH;
        let mut fbo: GLint = 0;
        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_FRAMEBUFFER_BINDING, &mut fbo)
        );

        if fbo != 0 {
            depth_attachment = glw::GL_DEPTH_ATTACHMENT;
        }

        let mut value: GLint = 0;
        if fbo == 0 {
            gl_call!(
                gl,
                "getFramebufferAttachmentParameteriv",
                gl.get_framebuffer_attachment_parameteriv(
                    target,
                    glw::GL_DEPTH,
                    glw::GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE,
                    &mut value
                )
            );
            if value == glw::GL_NONE as GLint {
                return Ok(glw::GL_FLOAT as GLint);
            }
        }
        gl_call!(
            gl,
            "getFramebufferAttachmentParameteriv",
            gl.get_framebuffer_attachment_parameteriv(
                target,
                depth_attachment,
                glw::GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE,
                &mut value
            )
        );
        Ok(value)
    }

    pub(super) fn check_param(&self, expr: bool, message: &str) -> bool {
        if !expr {
            log::info!(":{}:{}{message}", file!(), line!());
            return false;
        }
        true
    }

    /// `init_gl_objs`: initialise textures or renderbuffers, `bind` being `glBindTexture` or `glBindRenderbuffer`
    pub(super) fn init_gl_objs(
        &self,
        target: GLenum,
        samples: GLuint,
        bind: fn(&glw::Functions, GLenum, GLuint),
        buf: &[GLuint],
        format: GLenum,
    ) -> Result<bool, TestError> {
        let gl = self.gl;
        if !self.check_param(buf.len() < MAX_BUF_OBJECTS as usize, "invalid count") {
            return Ok(false);
        }

        for &object in buf {
            bind(gl, target, object);
            crate::glu::expect_no_error(gl, "bindTexture")?;
            if target == glw::GL_TEXTURE_2D {
                gl_call!(
                    gl,
                    "texStorage2D",
                    gl.tex_storage_2d(target, 1, format, self.full_rect.w, self.full_rect.h)
                );
            } else if target == glw::GL_TEXTURE_2D_MULTISAMPLE {
                gl_call!(
                    gl,
                    "texStorage2DMultisample",
                    gl.tex_storage_2d_multisample(
                        target,
                        samples as GLint,
                        format,
                        self.full_rect.w,
                        self.full_rect.h,
                        glw::TRUE
                    )
                );
            } else if target == glw::GL_RENDERBUFFER {
                if samples == 0 {
                    gl_call!(
                        gl,
                        "renderbufferStorage",
                        gl.renderbuffer_storage(target, format, self.full_rect.w, self.full_rect.h)
                    );
                } else {
                    gl_call!(
                        gl,
                        "renderbufferStorageMultisample",
                        gl.renderbuffer_storage_multisample(
                            target,
                            samples as GLint,
                            format,
                            self.full_rect.w,
                            self.full_rect.h
                        )
                    );
                }
            }
        }
        Ok(true)
    }

    /// `clearColorBuffer`
    #[allow(clippy::too_many_arguments)]
    pub(super) fn clear_color_buffer(
        &self,
        fbo: GLuint,
        attachment: GLenum,
        type_: GLenum,
        buf: GLuint,
        color: Color,
        rect: Rectangle,
        check_coord: Coord,
        check_channels: GLuint,
        float_internal_format: bool,
    ) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;
        let mut sample_buffers: GLint = 0;

        if !self.check_param(
            type_ == 0
                || type_ == glw::GL_TEXTURE_2D
                || type_ == glw::GL_TEXTURE_2D_MULTISAMPLE
                || type_ == glw::GL_RENDERBUFFER,
            "invalid type",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo)
        );

        if fbo != 0 && fbo != self.default_fbo {
            result &= self.attach_buffer_to_framebuffer(glw::GL_DRAW_FRAMEBUFFER, attachment, type_, buf)?;
            result &= self.attach_buffer_to_framebuffer(glw::GL_READ_FRAMEBUFFER, attachment, type_, buf)?;
            gl_call!(gl, "readBuffer", gl.read_buffer(attachment));
            gl_call!(gl, "drawBuffers", gl.draw_buffers(1, &attachment));
        }

        gl_call!(gl, "scissor", gl.scissor(rect.x, rect.y, rect.w, rect.h));
        gl_call!(gl, "enable", gl.enable(glw::GL_SCISSOR_TEST));

        // SAFETY: a plain query on the framebuffer bound above.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("checkFramebufferStatus unexpected status");
        }

        gl_call!(gl, "clearColor", gl.clear_color(color[0], color[1], color[2], color[3]));
        log::info!(
            "clearing color to [{},{},{},{}]",
            color[0],
            color[1],
            color[2],
            color[3]
        );
        gl_call!(gl, "clear", gl.clear(glw::GL_COLOR_BUFFER_BIT));
        gl_call!(gl, "disable", gl.disable(glw::GL_SCISSOR_TEST));

        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_SAMPLE_BUFFERS, &mut sample_buffers)
        );

        if sample_buffers == 0 {
            log::info!(
                "verifying initial buf{buf} color [{},{},{},{}]",
                color[0],
                color[1],
                color[2],
                color[3]
            );
            let actual = self.get_color(check_coord, float_internal_format)?;
            let matches = self.check_color(actual, color, check_channels);
            result &= matches;
            if !result {
                log::info!("checkColor: {}:{}expected true but got false", file!(), line!());
            }
        } else {
            log::info!("no verification of multisampled buf{buf}");
        }

        if fbo != 0 && fbo != self.default_fbo {
            result &= self.attach_buffer_to_framebuffer(glw::GL_DRAW_FRAMEBUFFER, attachment, type_, 0)?;
            result &= self.attach_buffer_to_framebuffer(glw::GL_READ_FRAMEBUFFER, attachment, type_, 0)?;
        }

        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.default_fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.default_fbo)
        );

        Ok(result)
    }

    /// `attachBufferToFramebuffer`
    pub(super) fn attach_buffer_to_framebuffer(
        &self,
        target: GLenum,
        attachment: GLenum,
        type_: GLenum,
        buf: GLuint,
    ) -> Result<bool, TestError> {
        let gl = self.gl;
        if type_ == glw::GL_TEXTURE_2D || type_ == glw::GL_TEXTURE_2D_MULTISAMPLE {
            gl_call!(
                gl,
                "framebufferTexture2D",
                gl.framebuffer_texture_2d(target, attachment, type_, buf, 0)
            );
            if buf != 0 {
                log::info!(
                    "attaching texbuf{buf} to {} of {}",
                    enum_name(attachment),
                    enum_name(target)
                );
            } else {
                log::info!("detaching {} of {}", enum_name(attachment), enum_name(target));
            }
        } else if type_ == glw::GL_RENDERBUFFER {
            gl_call!(
                gl,
                "framebufferRenderbuffer",
                gl.framebuffer_renderbuffer(target, attachment, type_, buf)
            );
            if buf != 0 {
                log::info!(
                    "attaching renbuf{buf} to {} of {}",
                    enum_name(attachment),
                    enum_name(target)
                );
            } else {
                log::info!("detaching {} of {}", enum_name(attachment), enum_name(target));
            }
        }
        Ok(true)
    }

    /// `getColor`
    pub(super) fn get_color(&self, coord: Coord, float_internal_format: bool) -> Result<Color, TestError> {
        let gl = self.gl;
        let (x, y) = coord;

        // SAFETY: a plain query on the read framebuffer.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) };
        crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!("checkFramebufferStatus unexpected status");
        }

        let color = if float_internal_format {
            let mut pixel = [0.6f32; 4];
            gl_call!(
                gl,
                "readPixels",
                gl.read_pixels(x, y, 1, 1, glw::GL_RGBA, glw::GL_FLOAT, pixel.as_mut_ptr().cast())
            );
            pixel
        } else {
            let mut pixel = [100u8; 4];
            gl_call!(
                gl,
                "readPixels",
                gl.read_pixels(
                    x,
                    y,
                    1,
                    1,
                    glw::GL_RGBA,
                    glw::GL_UNSIGNED_BYTE,
                    pixel.as_mut_ptr().cast()
                )
            );
            [
                f32::from(pixel[0]) / 255.0,
                f32::from(pixel[1]) / 255.0,
                f32::from(pixel[2]) / 255.0,
                f32::from(pixel[3]) / 255.0,
            ]
        };

        log::info!(
            "getColor: XY=[{x},{y}] RGBA=[{},{},{},{}]",
            color[0],
            color[1],
            color[2],
            color[3]
        );
        Ok(color)
    }

    /// `checkColor`
    pub(super) fn check_color(&self, actual: Color, expect: Color, channels: GLuint) -> bool {
        let mut expected_bytes = [0u8; 4];
        let mut actual_bytes = [0u8; 4];
        for (i, channel) in [RED_CHANNEL, GREEN_CHANNEL, BLUE_CHANNEL, ALPHA_CHANNEL]
            .into_iter()
            .enumerate()
        {
            if channels & channel != 0 {
                expected_bytes[i] = self.float_to_byte(expect[i]);
                actual_bytes[i] = self.float_to_byte(actual[i]);
            }
        }

        if actual_bytes != expected_bytes {
            log::info!("ERROR: expected  RGBA={expected_bytes:?} but got RGBA{actual_bytes:?}");
            return false;
        }
        true
    }

    /// `floatToByte`
    pub(super) fn float_to_byte(&self, f: f32) -> u8 {
        if !(0.0..=1.0).contains(&f) {
            log::info!(":{}:{}float not in range [0.0f, 1.0f]", file!(), line!());
            return 0;
        }
        (if f == 1.0 { 255.0 } else { f64::from(f) * 255.0 }).floor() as u8
    }

    /// `clearDepthBuffer`
    #[allow(clippy::too_many_arguments)]
    pub(super) fn clear_depth_buffer(
        &self,
        fbo: GLuint,
        attachment: GLenum,
        type_: GLenum,
        buf: GLuint,
        internal_format: GLuint,
        depth: Depth,
        rect: Rectangle,
        check_coord: Coord,
    ) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;
        let mut sample_buffers: GLint = 0;

        let get_epsilon = |result_pre_bits: GLuint, source_pre_bits: GLuint| {
            let tolerance = result_pre_bits.min(source_pre_bits).min(23);
            1.0f32 / (1u32 << tolerance) as f32
        };

        if !self.check_param(
            type_ == 0
                || type_ == glw::GL_TEXTURE_2D
                || type_ == glw::GL_TEXTURE_2D_MULTISAMPLE
                || type_ == glw::GL_RENDERBUFFER,
            "invalid type",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo)
        );

        if fbo != 0 && fbo != self.default_fbo {
            result &= self.attach_buffer_to_framebuffer(glw::GL_DRAW_FRAMEBUFFER, attachment, type_, buf)?;
            result &= self.attach_buffer_to_framebuffer(glw::GL_READ_FRAMEBUFFER, attachment, type_, buf)?;
        }

        gl_call!(gl, "scissor", gl.scissor(rect.x, rect.y, rect.w, rect.h));
        gl_call!(gl, "enable", gl.enable(glw::GL_SCISSOR_TEST));

        // SAFETY: a plain query on the framebuffer bound above.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
        self.check_ret_status(status)?;

        gl_call!(gl, "clearDepth", gl.clear_depth(f64::from(depth)));
        log::info!("clearing depth to [{depth}]");
        gl_call!(gl, "clear", gl.clear(glw::GL_DEPTH_BUFFER_BIT));
        gl_call!(gl, "disable", gl.disable(glw::GL_SCISSOR_TEST));

        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_SAMPLE_BUFFERS, &mut sample_buffers)
        );

        if sample_buffers == 0 {
            log::info!("verifying initial buf{buf} depth [{depth}]");
            let (actual, precision_bits) = self.get_depth(check_coord)?;

            let epsilon = get_epsilon(precision_bits, self.depth_precision_bits(internal_format));
            result = self.check_depth(actual, depth, epsilon);
            if !result {
                log::info!("checkDepth: {}:{}expected true but got false", file!(), line!());
            }
        } else {
            log::info!("no verification of multisampled buf{buf}");
        }

        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.default_fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.default_fbo)
        );

        Ok(result)
    }

    /// `CHECK_RET(status, GL_FRAMEBUFFER_COMPLETE, glCheckFramebufferStatus)`
    pub(super) fn check_ret_status(&self, status: GLenum) -> Result<(), TestError> {
        if status != glw::GL_FRAMEBUFFER_COMPLETE {
            log::info!(
                "glCheckFramebufferStatus: expected {} but got {}",
                enum_name(glw::GL_FRAMEBUFFER_COMPLETE),
                enum_name(status)
            );
            return Err(TestError::Fail("glCheckFramebufferStatus".to_string()));
        }
        Ok(())
    }

    /// `getDepth` (desktop half): the depth and its precision in bits
    pub(super) fn get_depth(&self, coord: Coord) -> Result<(Depth, GLuint), TestError> {
        let gl = self.gl;
        let (x, y) = coord;

        // SAFETY: a plain query on the read framebuffer.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) };
        crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
        self.check_ret_status(status)?;

        let mut depth = 0.2f32;
        gl_call!(
            gl,
            "readPixels",
            gl.read_pixels(
                x,
                y,
                1,
                1,
                glw::GL_DEPTH_COMPONENT,
                glw::GL_FLOAT,
                (&mut depth as *mut f32).cast()
            )
        );

        log::info!("getDepth: XY[{x},{y}] DEPTH_COMPONENT[{depth}]");
        Ok((depth, 24))
    }

    /// `GetDepthPrecisionBits`
    pub(super) fn depth_precision_bits(&self, depth_internal_format: GLenum) -> GLuint {
        self.depth_cfg
            .iter()
            .find(|config| config.internal_format == depth_internal_format)
            .map_or(0, |config| config.precision_bits)
    }

    /// `checkDepth`
    pub(super) fn check_depth(&self, actual: Depth, expected: Depth, eps: f32) -> bool {
        if (actual - expected).abs() > eps {
            log::info!("ERROR: expected DEPTH[{expected}] but got DEPTH[{actual}], epsilon[{eps}]");
            return false;
        }
        true
    }

    /// `getStencil` (desktop half)
    pub(super) fn get_stencil(&self, coord: Coord) -> Result<Stencil, TestError> {
        let gl = self.gl;
        let (x, y) = coord;

        // SAFETY: a plain query on the read framebuffer.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_READ_FRAMEBUFFER) };
        crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
        self.check_ret_status(status)?;

        let mut stencil: GLuint = 50;
        gl_call!(
            gl,
            "readPixels",
            gl.read_pixels(
                x,
                y,
                1,
                1,
                glw::GL_STENCIL_INDEX,
                glw::GL_UNSIGNED_INT,
                (&mut stencil as *mut GLuint).cast()
            )
        );

        log::info!("getStencil: XY[{x},{y}] STENCIL_INDEX[{stencil}]");
        Ok(stencil)
    }

    /// `checkStencil`
    pub(super) fn check_stencil(&self, actual: Stencil, expected: Stencil) -> bool {
        if actual != expected {
            log::info!("ERROR: expected STENCIL[{expected}] but got STENCIL[{actual}]");
            return false;
        }
        true
    }

    /// `clearStencilBuffer`
    #[allow(clippy::too_many_arguments)]
    pub(super) fn clear_stencil_buffer(
        &self,
        fbo: GLuint,
        attachment: GLenum,
        type_: GLenum,
        buf: GLuint,
        stcil: Stencil,
        rect: Rectangle,
        check_coord: Coord,
    ) -> Result<bool, TestError> {
        let gl = self.gl;
        let mut result = true;
        let mut sample_buffers: GLint = 0;

        if !self.check_param(
            type_ == 0
                || type_ == glw::GL_TEXTURE_2D
                || type_ == glw::GL_TEXTURE_2D_MULTISAMPLE
                || type_ == glw::GL_RENDERBUFFER,
            "invalid type",
        ) {
            return Ok(false);
        }

        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, fbo)
        );
        if fbo != 0 && fbo != self.default_fbo {
            result &= self.attach_buffer_to_framebuffer(glw::GL_DRAW_FRAMEBUFFER, attachment, type_, buf)?;
            result &= self.attach_buffer_to_framebuffer(glw::GL_READ_FRAMEBUFFER, attachment, type_, buf)?;
        }

        gl_call!(gl, "scissor", gl.scissor(rect.x, rect.y, rect.w, rect.h));
        gl_call!(gl, "enable", gl.enable(glw::GL_SCISSOR_TEST));

        // SAFETY: a plain query on the framebuffer bound above.
        let status = unsafe { gl.check_framebuffer_status(glw::GL_DRAW_FRAMEBUFFER) };
        crate::glu::expect_no_error(gl, "checkFramebufferStatus")?;
        self.check_ret_status(status)?;

        gl_call!(gl, "clearStencil", gl.clear_stencil(stcil as GLint));
        log::info!("clearing stencil to [{stcil}]");
        gl_call!(gl, "clear", gl.clear(glw::GL_STENCIL_BUFFER_BIT));
        gl_call!(gl, "disable", gl.disable(glw::GL_SCISSOR_TEST));

        gl_call!(
            gl,
            "getIntegerv",
            gl.get_integerv(glw::GL_SAMPLE_BUFFERS, &mut sample_buffers)
        );
        if sample_buffers == 0 {
            log::info!("verifying initial buf{buf} stencil [{stcil}]");
            let actual = self.get_stencil(check_coord)?;
            result = self.check_stencil(actual, stcil);
            if !result {
                log::info!("checkStencil: {}:{}expected true but got false", file!(), line!());
            }
        } else {
            log::info!("no verification of multisampled buf{buf}");
        }

        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, self.default_fbo)
        );
        gl_call!(
            gl,
            "bindFramebuffer",
            gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, self.default_fbo)
        );

        Ok(result)
    }

    /// `printGlobalBufferInfo`
    pub(super) fn print_global_buffer_info(&self) {
        let print_info = |h0: GLuint, h1: GLuint, name: &str| log::info!("CONFIG: {name}[0]={h0}, {name}[1]={h1}");

        print_info(self.fbos[0], self.fbos[1], "fbos");
        print_info(self.color_tbos[0], self.color_tbos[1], "color_tbos");
        print_info(self.depth_tbos[0], self.depth_tbos[1], "depth_tbos");
        print_info(self.stcil_tbos[0], self.stcil_tbos[1], "stcil_tbos");
        print_info(self.color_rbos[0], self.color_rbos[1], "color_rbos");
        print_info(self.depth_rbos[0], self.depth_rbos[1], "depth_rbos");
        print_info(self.stcil_rbos[0], self.stcil_rbos[1], "stcil_rbos");

        log::info!(
            "CONFIG: depth_internalFormat={}\nCONFIG: stcil_internalFormat={}",
            enum_name(self.depth_internal_format),
            enum_name(self.stcil_internal_format)
        );
    }
}

pub(super) fn bind_texture(gl: &glw::Functions, target: GLenum, texture: GLuint) {
    // SAFETY: a plain state change with a current context.
    unsafe { gl.bind_texture(target, texture) }
}

pub(super) fn bind_renderbuffer(gl: &glw::Functions, target: GLenum, renderbuffer: GLuint) {
    // SAFETY: a plain state change with a current context.
    unsafe { gl.bind_renderbuffer(target, renderbuffer) }
}

/// `FramebufferBlitTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("framebuffer_blit");
    group.add_child(Box::new(multisampled::ColorConfigTest) as Box<dyn TestCase>);
    group.add_child(Box::new(multisampled::DepthConfigTest) as Box<dyn TestCase>);
    group.add_child(Box::new(scissor::Scissor) as Box<dyn TestCase>);
    group
}

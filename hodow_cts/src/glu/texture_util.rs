// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTextureUtil.hpp / .cpp  (glu::TransferFormat, getTransferFormat)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::glw::{self, GLenum};
use crate::tcu::{ChannelOrder, ChannelType, TestError, TextureFormat};

/// `glu::TransferFormat` - the `(format, type)` pair a pixel transfer call takes.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub struct TransferFormat {
    pub format: GLenum,
    pub data_type: GLenum,
}

/// `glu::getTransferFormat` - maps a `tcu::TextureFormat` onto the GL enums that
/// describe the same layout in memory.
pub fn get_transfer_format(tex_format: TextureFormat) -> Result<TransferFormat, TestError> {
    use ChannelType::*;

    let is_int = matches!(
        tex_format.type_,
        SIGNED_INT8 | SIGNED_INT16 | SIGNED_INT32 | UNSIGNED_INT8 | UNSIGNED_INT16 | UNSIGNED_INT32 | UNSIGNED_INT_1010102_REV
    );

    let format = match tex_format.order {
        ChannelOrder::A => glw::GL_ALPHA,
        ChannelOrder::L => glw::GL_LUMINANCE,
        ChannelOrder::LA => glw::GL_LUMINANCE_ALPHA,
        ChannelOrder::R => {
            if is_int {
                glw::GL_RED_INTEGER
            } else {
                glw::GL_RED
            }
        }
        ChannelOrder::RG => {
            if is_int {
                glw::GL_RG_INTEGER
            } else {
                glw::GL_RG
            }
        }
        ChannelOrder::RGB => {
            if is_int {
                glw::GL_RGB_INTEGER
            } else {
                glw::GL_RGB
            }
        }
        ChannelOrder::RGBA => {
            if is_int {
                glw::GL_RGBA_INTEGER
            } else {
                glw::GL_RGBA
            }
        }
        ChannelOrder::sR => glw::GL_RED,
        ChannelOrder::sRG => glw::GL_RG,
        ChannelOrder::sRGB => glw::GL_RGB,
        ChannelOrder::sRGBA => glw::GL_RGBA,
        ChannelOrder::D => glw::GL_DEPTH_COMPONENT,
        ChannelOrder::DS => glw::GL_DEPTH_STENCIL,
        ChannelOrder::S => glw::GL_STENCIL_INDEX,
        ChannelOrder::BGRA => glw::GL_BGRA,
        other => return Err(TestError::NotPorted(format!("GL transfer format of channel order {other:?}"))),
    };

    let data_type = match tex_format.type_ {
        SNORM_INT8 => glw::GL_BYTE,
        SNORM_INT16 => glw::GL_SHORT,
        UNORM_INT8 => glw::GL_UNSIGNED_BYTE,
        UNORM_INT16 => glw::GL_UNSIGNED_SHORT,
        UNORM_SHORT_565 => glw::GL_UNSIGNED_SHORT_5_6_5,
        UNORM_SHORT_4444 => glw::GL_UNSIGNED_SHORT_4_4_4_4,
        UNORM_SHORT_5551 => glw::GL_UNSIGNED_SHORT_5_5_5_1,
        SIGNED_INT8 => glw::GL_BYTE,
        SIGNED_INT16 => glw::GL_SHORT,
        SIGNED_INT32 => glw::GL_INT,
        UNSIGNED_INT8 => glw::GL_UNSIGNED_BYTE,
        UNSIGNED_INT16 => glw::GL_UNSIGNED_SHORT,
        UNSIGNED_INT32 => glw::GL_UNSIGNED_INT,
        FLOAT => glw::GL_FLOAT,
        UNORM_INT_101010 => glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        UNORM_INT_1010102_REV => glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        UNSIGNED_INT_1010102_REV => glw::GL_UNSIGNED_INT_2_10_10_10_REV,
        UNSIGNED_INT_11F_11F_10F_REV => glw::GL_UNSIGNED_INT_10F_11F_11F_REV,
        UNSIGNED_INT_999_E5_REV => glw::GL_UNSIGNED_INT_5_9_9_9_REV,
        HALF_FLOAT => glw::GL_HALF_FLOAT,
        FLOAT_UNSIGNED_INT_24_8_REV => glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV,
        UNSIGNED_INT_24_8 => {
            if tex_format.order == ChannelOrder::D {
                glw::GL_UNSIGNED_INT
            } else {
                glw::GL_UNSIGNED_INT_24_8
            }
        }
        other => return Err(TestError::InternalError(format!("Can't map texture format {other:?} to GL transfer format"))),
    };

    Ok(TransferFormat { format, data_type })
}

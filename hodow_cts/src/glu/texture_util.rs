// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/gluTextureUtil.hpp / .cpp  (glu::TransferFormat, getTransferFormat,
//   mapGLInternalFormat, mapGLCompressedTexFormat, isCompressedFormat)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `mapGLCompressedTexFormat`/`isCompressedFormat` answer with `vk::Format` rather than
// re-introducing upstream's own `tcu::CompressedTexFormat` enum - `tcu::compressed_texture`
// (this crate's port of `tcuCompressedTexture.cpp`) already made that same call for its
// decoder, documented in that file's own top comment ("keeping a second enum in step
// with the registry for no gain"), and keying this function the same way lets a GL
// caller hand the result straight to `tcu::compressed_texture::decompress`/
// `get_uncompressed_format` with no translation step in between.

use vulkanalia::vk;

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
        SIGNED_INT8
            | SIGNED_INT16
            | SIGNED_INT32
            | UNSIGNED_INT8
            | UNSIGNED_INT16
            | UNSIGNED_INT32
            | UNSIGNED_INT_1010102_REV
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
        other => {
            return Err(TestError::NotPorted(format!(
                "GL transfer format of channel order {other:?}"
            )));
        }
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
        other => {
            return Err(TestError::InternalError(format!(
                "Can't map texture format {other:?} to GL transfer format"
            )));
        }
    };

    Ok(TransferFormat { format, data_type })
}

/// `glu::mapGLChannelType`
///
/// The normalized bit is ignored where it does not apply. `None` is upstream's
/// `DE_ASSERT(false)` for a data type with no mapping.
fn map_gl_channel_type(data_type: GLenum, normalized: bool) -> Option<ChannelType> {
    use ChannelType::*;

    let normalized_or = |yes: ChannelType, no: ChannelType| if normalized { yes } else { no };

    Some(match data_type {
        glw::GL_UNSIGNED_BYTE => normalized_or(UNORM_INT8, UNSIGNED_INT8),
        glw::GL_BYTE => normalized_or(SNORM_INT8, SIGNED_INT8),
        glw::GL_UNSIGNED_SHORT => normalized_or(UNORM_INT16, UNSIGNED_INT16),
        glw::GL_SHORT => normalized_or(SNORM_INT16, SIGNED_INT16),
        glw::GL_UNSIGNED_INT => normalized_or(UNORM_INT32, UNSIGNED_INT32),
        glw::GL_INT => normalized_or(SNORM_INT32, SIGNED_INT32),
        glw::GL_FLOAT => FLOAT,
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => UNORM_SHORT_4444,
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => UNORM_SHORT_5551,
        glw::GL_UNSIGNED_SHORT_5_6_5 => UNORM_SHORT_565,
        glw::GL_HALF_FLOAT => HALF_FLOAT,
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => normalized_or(UNORM_INT_1010102_REV, UNSIGNED_INT_1010102_REV),
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => UNSIGNED_INT_11F_11F_10F_REV,
        glw::GL_UNSIGNED_INT_24_8 => UNSIGNED_INT_24_8,
        glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => FLOAT_UNSIGNED_INT_24_8_REV,
        glw::GL_UNSIGNED_INT_5_9_9_9_REV => UNSIGNED_INT_999_E5_REV,
        // GL_OES_texture_half_float
        glw::GL_HALF_FLOAT_OES => HALF_FLOAT,
        _ => return None,
    })
}

/// `glu::mapGLTransferFormat` - a GL pixel transfer (format, type) pair as a
/// `tcu::TextureFormat`.
///
/// Upstream throws `tcu::InternalError` where this answers `None`.
pub fn map_gl_transfer_format(format: GLenum, data_type: GLenum) -> Option<TextureFormat> {
    let (order, normalized) = match format {
        glw::GL_ALPHA => (ChannelOrder::A, true),
        glw::GL_LUMINANCE => (ChannelOrder::L, true),
        glw::GL_LUMINANCE_ALPHA => (ChannelOrder::LA, true),
        glw::GL_RGB => (ChannelOrder::RGB, true),
        glw::GL_RGBA => (ChannelOrder::RGBA, true),
        glw::GL_BGRA => (ChannelOrder::BGRA, true),
        glw::GL_RG => (ChannelOrder::RG, true),
        glw::GL_RED => (ChannelOrder::R, true),
        glw::GL_RGBA_INTEGER => (ChannelOrder::RGBA, false),
        glw::GL_RGB_INTEGER => (ChannelOrder::RGB, false),
        glw::GL_RG_INTEGER => (ChannelOrder::RG, false),
        glw::GL_RED_INTEGER => (ChannelOrder::R, false),
        glw::GL_SRGB => (ChannelOrder::sRGB, false),
        glw::GL_SRGB_ALPHA => (ChannelOrder::sRGBA, false),
        glw::GL_DEPTH_COMPONENT => (ChannelOrder::D, true),
        glw::GL_DEPTH_STENCIL => (ChannelOrder::DS, true),
        _ => return None,
    };

    map_gl_channel_type(data_type, normalized).map(|type_| TextureFormat::new(order, type_))
}

/// `glu::mapGLInternalFormat` - the inverse of `getTransferFormat` for a *sized* GL
/// internal format.
///
/// Upstream throws `tcu::InternalError` for a format it does not know; `None` here is
/// the same answer, and the one caller turns it into the "format does not exist" the
/// completeness tests are checking for.
pub fn map_gl_internal_format(internal_format: GLenum) -> Option<TextureFormat> {
    match internal_format {
        glw::GL_RGB5_A1 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_SHORT_5551)),
        glw::GL_RGBA4 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_SHORT_4444)),
        glw::GL_RGB565 => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_SHORT_565)),
        glw::GL_DEPTH_COMPONENT16 => Some(TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16)),
        glw::GL_STENCIL_INDEX8 => Some(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8)),
        glw::GL_RGBA32F => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT)),
        glw::GL_RGBA32I => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32)),
        glw::GL_RGBA32UI => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32)),
        glw::GL_RGBA16 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT16)),
        glw::GL_RGBA16_SNORM => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT16)),
        glw::GL_RGBA16F => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::HALF_FLOAT)),
        glw::GL_RGBA16I => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT16)),
        glw::GL_RGBA16UI => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT16)),
        glw::GL_RGBA8 => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)),
        glw::GL_RGBA8I => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT8)),
        glw::GL_RGBA8UI => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8)),
        glw::GL_SRGB8_ALPHA8 => Some(TextureFormat::new(ChannelOrder::sRGBA, ChannelType::UNORM_INT8)),
        glw::GL_RGB10_A2 => Some(TextureFormat::new(
            ChannelOrder::RGBA,
            ChannelType::UNORM_INT_1010102_REV,
        )),
        glw::GL_RGB10_A2UI => Some(TextureFormat::new(
            ChannelOrder::RGBA,
            ChannelType::UNSIGNED_INT_1010102_REV,
        )),
        glw::GL_RGBA8_SNORM => Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::SNORM_INT8)),
        glw::GL_RGB8 => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_INT8)),
        glw::GL_R11F_G11F_B10F => Some(TextureFormat::new(
            ChannelOrder::RGB,
            ChannelType::UNSIGNED_INT_11F_11F_10F_REV,
        )),
        glw::GL_RGB32F => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::FLOAT)),
        glw::GL_RGB32I => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT32)),
        glw::GL_RGB32UI => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT32)),
        glw::GL_RGB16 => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_INT16)),
        glw::GL_RGB16_SNORM => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SNORM_INT16)),
        glw::GL_RGB16F => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::HALF_FLOAT)),
        glw::GL_RGB16I => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT16)),
        glw::GL_RGB16UI => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT16)),
        glw::GL_RGB8_SNORM => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SNORM_INT8)),
        glw::GL_RGB8I => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::SIGNED_INT8)),
        glw::GL_RGB8UI => Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNSIGNED_INT8)),
        glw::GL_SRGB8 => Some(TextureFormat::new(ChannelOrder::sRGB, ChannelType::UNORM_INT8)),
        glw::GL_RGB9_E5 => Some(TextureFormat::new(
            ChannelOrder::RGB,
            ChannelType::UNSIGNED_INT_999_E5_REV,
        )),
        glw::GL_RGB10 => Some(TextureFormat::new(
            ChannelOrder::RGB,
            ChannelType::UNORM_INT_1010102_REV,
        )),
        glw::GL_RG32F => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::FLOAT)),
        glw::GL_RG32I => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT32)),
        glw::GL_RG32UI => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT32)),
        glw::GL_RG16 => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_INT16)),
        glw::GL_RG16_SNORM => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SNORM_INT16)),
        glw::GL_RG16F => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::HALF_FLOAT)),
        glw::GL_RG16I => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT16)),
        glw::GL_RG16UI => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT16)),
        glw::GL_RG8 => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNORM_INT8)),
        glw::GL_RG8I => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SIGNED_INT8)),
        glw::GL_RG8UI => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::UNSIGNED_INT8)),
        glw::GL_RG8_SNORM => Some(TextureFormat::new(ChannelOrder::RG, ChannelType::SNORM_INT8)),
        glw::GL_SRG8_EXT => Some(TextureFormat::new(ChannelOrder::sRG, ChannelType::UNORM_INT8)),
        glw::GL_R32F => Some(TextureFormat::new(ChannelOrder::R, ChannelType::FLOAT)),
        glw::GL_R32I => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT32)),
        glw::GL_R32UI => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT32)),
        glw::GL_R16 => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_INT16)),
        glw::GL_R16_SNORM => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SNORM_INT16)),
        glw::GL_R16F => Some(TextureFormat::new(ChannelOrder::R, ChannelType::HALF_FLOAT)),
        glw::GL_R16I => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT16)),
        glw::GL_R16UI => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT16)),
        glw::GL_R8 => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNORM_INT8)),
        glw::GL_R8I => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SIGNED_INT8)),
        glw::GL_R8UI => Some(TextureFormat::new(ChannelOrder::R, ChannelType::UNSIGNED_INT8)),
        glw::GL_R8_SNORM => Some(TextureFormat::new(ChannelOrder::R, ChannelType::SNORM_INT8)),
        glw::GL_SR8_EXT => Some(TextureFormat::new(ChannelOrder::sR, ChannelType::UNORM_INT8)),
        glw::GL_BGRA => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_INT8)),
        glw::GL_BGRA8_EXT => Some(TextureFormat::new(ChannelOrder::BGRA, ChannelType::UNORM_INT8)),
        glw::GL_DEPTH_COMPONENT32F => Some(TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT)),
        glw::GL_DEPTH_COMPONENT24 => Some(TextureFormat::new(ChannelOrder::D, ChannelType::UNSIGNED_INT_24_8)),
        glw::GL_DEPTH_COMPONENT32 => Some(TextureFormat::new(ChannelOrder::D, ChannelType::UNSIGNED_INT32)),
        glw::GL_DEPTH32F_STENCIL8 => Some(TextureFormat::new(
            ChannelOrder::DS,
            ChannelType::FLOAT_UNSIGNED_INT_24_8_REV,
        )),
        glw::GL_DEPTH24_STENCIL8 => Some(TextureFormat::new(ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8)),
        _ => None,
    }
}

/// `glu::mapGLCompressedTexFormat` - a *compressed* GL internal format as the
/// `vk::Format` `tcu::compressed_texture` already decodes (see this file's own top
/// comment for why `vk::Format` rather than upstream's own `tcu::CompressedTexFormat`).
///
/// Every GLES3/3.1-core compressed format is covered: the four EAC single/dual-channel
/// variants, the four ETC2 RGB/RGBA/punch-through-alpha variants, and the full
/// `GL_KHR_texture_compression_astc_ldr` 2D block-size set (14 sizes x UNORM/sRGB).
/// **Not covered**: `GL_ETC1_RGB8_OES` (legacy GLES2 `OES_compressed_ETC1_RGB8_texture`,
/// absent from GLES3 core) and ASTC's HDR (`SFLOAT`) and 3D-block (`_EXT`) variants -
/// upstream's own `es3fTextureFormatTests.cpp` only reaches ETC1 through
/// `tcu::ResourceBuilder`-loaded `.pkm`/`.png` files (the same unported archive-loading
/// gap `tessellation.user_defined_io` already documents elsewhere in this crate), so
/// nothing here could exercise a mapping for it yet; ASTC HDR/3D need their own
/// `GL_KHR_texture_compression_astc_hdr`/`GL_OES_texture_compression_astc` extension
/// support this port does not have either. Desktop-only BC1-7 need no GL mapping at all
/// - no GLES target samples them (see `tcu::compressed_texture`'s own top comment).
///
/// Upstream throws `tcu::InternalError` for an unmapped format; `None` here is the same
/// answer.
pub fn map_gl_compressed_tex_format(internal_format: GLenum) -> Option<vk::Format> {
    Some(match internal_format {
        glw::GL_COMPRESSED_R11_EAC => vk::Format::EAC_R11_UNORM_BLOCK,
        glw::GL_COMPRESSED_SIGNED_R11_EAC => vk::Format::EAC_R11_SNORM_BLOCK,
        glw::GL_COMPRESSED_RG11_EAC => vk::Format::EAC_R11G11_UNORM_BLOCK,
        glw::GL_COMPRESSED_SIGNED_RG11_EAC => vk::Format::EAC_R11G11_SNORM_BLOCK,
        glw::GL_COMPRESSED_RGB8_ETC2 => vk::Format::ETC2_R8G8B8_UNORM_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ETC2 => vk::Format::ETC2_R8G8B8_SRGB_BLOCK,
        glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 => vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK,
        glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 => vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC => vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC => vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK,

        glw::GL_COMPRESSED_RGBA_ASTC_4x4 => vk::Format::ASTC_4X4_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_5x4 => vk::Format::ASTC_5X4_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_5x5 => vk::Format::ASTC_5X5_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_6x5 => vk::Format::ASTC_6X5_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_6x6 => vk::Format::ASTC_6X6_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_8x5 => vk::Format::ASTC_8X5_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_8x6 => vk::Format::ASTC_8X6_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_8x8 => vk::Format::ASTC_8X8_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_10x5 => vk::Format::ASTC_10X5_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_10x6 => vk::Format::ASTC_10X6_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_10x8 => vk::Format::ASTC_10X8_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_10x10 => vk::Format::ASTC_10X10_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_12x10 => vk::Format::ASTC_12X10_UNORM_BLOCK,
        glw::GL_COMPRESSED_RGBA_ASTC_12x12 => vk::Format::ASTC_12X12_UNORM_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4 => vk::Format::ASTC_4X4_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4 => vk::Format::ASTC_5X4_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5 => vk::Format::ASTC_5X5_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5 => vk::Format::ASTC_6X5_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6 => vk::Format::ASTC_6X6_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5 => vk::Format::ASTC_8X5_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6 => vk::Format::ASTC_8X6_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8 => vk::Format::ASTC_8X8_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5 => vk::Format::ASTC_10X5_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6 => vk::Format::ASTC_10X6_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8 => vk::Format::ASTC_10X8_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10 => vk::Format::ASTC_10X10_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10 => vk::Format::ASTC_12X10_SRGB_BLOCK,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12 => vk::Format::ASTC_12X12_SRGB_BLOCK,

        _ => return None,
    })
}

/// `glu::isCompressedFormat` - whether `internal_format` is one
/// `map_gl_compressed_tex_format` answers for. Deliberately `map_gl_compressed_tex_format(...)
/// .is_some()` rather than a second, independently-maintained enum list: upstream keeps
/// the two in sync by hand (confirmed by reading `gluTextureUtil.cpp` directly - its own
/// `isCompressedFormat` is a separate `switch` over the identical case list), which is
/// exactly the kind of duplication this port avoids where the two can be derived from
/// one list instead.
pub fn is_compressed_format(internal_format: GLenum) -> bool {
    map_gl_compressed_tex_format(internal_format).is_some()
}

/// `glu::getGLFormat(tcu::CompressedTexFormat)` - the reverse of
/// `map_gl_compressed_tex_format`, needed by `glu::Texture2D::new_compressed` (and its
/// `TextureCube`/`Texture2DArray` siblings) to name the `internalformat` argument a real
/// `glCompressedTexImage2D`/`3D` call takes, given only the `vk::Format` a test already
/// has (e.g. from `tcu::compressed_texture`'s own format list). Upstream keeps this as a
/// second, independently-written `switch` over the same case list rather than deriving
/// it from `getGLInternalFormat` (confirmed by reading `gluTextureUtil.cpp` directly) -
/// this one is a literal match arm by arm instead, since `map_gl_compressed_tex_format`
/// is a `match` expression and not a static table there is nothing to invert
/// mechanically. `every_compressed_format_round_trips` below is what keeps the two in
/// step, the same role `is_decompressible`/`get_uncompressed_format` play for each other.
///
/// ETC1 (`GL_ETC1_RGB8_OES`) is dropped for the same reason
/// `map_gl_compressed_tex_format`'s own doc comment gives: nothing ported reaches it.
pub fn get_gl_format_for_compressed(format: vk::Format) -> Option<GLenum> {
    Some(match format {
        vk::Format::EAC_R11_UNORM_BLOCK => glw::GL_COMPRESSED_R11_EAC,
        vk::Format::EAC_R11_SNORM_BLOCK => glw::GL_COMPRESSED_SIGNED_R11_EAC,
        vk::Format::EAC_R11G11_UNORM_BLOCK => glw::GL_COMPRESSED_RG11_EAC,
        vk::Format::EAC_R11G11_SNORM_BLOCK => glw::GL_COMPRESSED_SIGNED_RG11_EAC,
        vk::Format::ETC2_R8G8B8_UNORM_BLOCK => glw::GL_COMPRESSED_RGB8_ETC2,
        vk::Format::ETC2_R8G8B8_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ETC2,
        vk::Format::ETC2_R8G8B8A1_UNORM_BLOCK => glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        vk::Format::ETC2_R8G8B8A8_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,

        vk::Format::ASTC_4X4_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_4x4,
        vk::Format::ASTC_5X4_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_5x4,
        vk::Format::ASTC_5X5_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_5x5,
        vk::Format::ASTC_6X5_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_6x5,
        vk::Format::ASTC_6X6_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_6x6,
        vk::Format::ASTC_8X5_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_8x5,
        vk::Format::ASTC_8X6_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_8x6,
        vk::Format::ASTC_8X8_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_8x8,
        vk::Format::ASTC_10X5_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_10x5,
        vk::Format::ASTC_10X6_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_10x6,
        vk::Format::ASTC_10X8_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_10x8,
        vk::Format::ASTC_10X10_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_10x10,
        vk::Format::ASTC_12X10_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_12x10,
        vk::Format::ASTC_12X12_UNORM_BLOCK => glw::GL_COMPRESSED_RGBA_ASTC_12x12,
        vk::Format::ASTC_4X4_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4,
        vk::Format::ASTC_5X4_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4,
        vk::Format::ASTC_5X5_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5,
        vk::Format::ASTC_6X5_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5,
        vk::Format::ASTC_6X6_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6,
        vk::Format::ASTC_8X5_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5,
        vk::Format::ASTC_8X6_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6,
        vk::Format::ASTC_8X8_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8,
        vk::Format::ASTC_10X5_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5,
        vk::Format::ASTC_10X6_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6,
        vk::Format::ASTC_10X8_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8,
        vk::Format::ASTC_10X10_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10,
        vk::Format::ASTC_12X10_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10,
        vk::Format::ASTC_12X12_SRGB_BLOCK => glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12,

        _ => return None,
    })
}

/// `glu::RENDERABLE_COLOR` and friends - what `getRenderableBitsES3` answers with.
const RENDERABLE_COLOR: u32 = 1 << 0;

/// `getRenderableBitsES3`, restricted to the colour half - no ported case asks about
/// depth or stencil renderability through here.
fn renderable_bits_es3(context_info: &crate::glu::ContextInfo, internal_format: GLenum) -> u32 {
    match internal_format {
        // Color-renderable formats.
        glw::GL_RGBA32I
        | glw::GL_RGBA32UI
        | glw::GL_RGBA16I
        | glw::GL_RGBA16UI
        | glw::GL_RGBA8
        | glw::GL_RGBA8I
        | glw::GL_RGBA8UI
        | glw::GL_SRGB8_ALPHA8
        | glw::GL_RGB10_A2
        | glw::GL_RGB10_A2UI
        | glw::GL_RGBA4
        | glw::GL_RGB5_A1
        | glw::GL_RGB8
        | glw::GL_RGB565
        | glw::GL_RG32I
        | glw::GL_RG32UI
        | glw::GL_RG16I
        | glw::GL_RG16UI
        | glw::GL_RG8
        | glw::GL_RG8I
        | glw::GL_RG8UI
        | glw::GL_R32I
        | glw::GL_R32UI
        | glw::GL_R16I
        | glw::GL_R16UI
        | glw::GL_R8
        | glw::GL_R8I
        | glw::GL_R8UI => RENDERABLE_COLOR,

        // GL_EXT_color_buffer_float
        glw::GL_RGBA32F | glw::GL_R11F_G11F_B10F | glw::GL_RG32F | glw::GL_R32F
            if context_info.is_extension_supported("GL_EXT_color_buffer_float") =>
        {
            RENDERABLE_COLOR
        }

        // GL_EXT_color_buffer_float / GL_EXT_color_buffer_half_float
        glw::GL_RGBA16F | glw::GL_RG16F | glw::GL_R16F
            if context_info.is_extension_supported("GL_EXT_color_buffer_float")
                || context_info.is_extension_supported("GL_EXT_color_buffer_half_float") =>
        {
            RENDERABLE_COLOR
        }

        // The depth, depth+stencil and stencil formats upstream also answers for are
        // left out: nothing ported asks this function about them.
        _ => 0,
    }
}

/// `glu::isSizedFormatColorRenderable`
///
/// Upstream throws `InternalError` for anything but an ES 3.0 context; the one group
/// that calls this is an ES 3.0 group, so the version check has nothing to add here.
pub fn is_sized_format_color_renderable(context_info: &crate::glu::ContextInfo, sized_format: GLenum) -> bool {
    renderable_bits_es3(context_info, sized_format) & RENDERABLE_COLOR != 0
}

/// `glu::getInternalFormat` - the sized internal format a `tcu::TextureFormat` is uploaded as.
pub fn get_internal_format(tex_format: TextureFormat) -> Result<GLenum, TestError> {
    Ok(match (tex_format.order, tex_format.type_) {
        (ChannelOrder::RGBA, ChannelType::UNORM_SHORT_5551) => glw::GL_RGB5_A1,
        (ChannelOrder::RGBA, ChannelType::UNORM_SHORT_4444) => glw::GL_RGBA4,
        (ChannelOrder::RGB, ChannelType::UNORM_SHORT_565) => glw::GL_RGB565,
        (ChannelOrder::D, ChannelType::UNORM_INT16) => glw::GL_DEPTH_COMPONENT16,
        (ChannelOrder::S, ChannelType::UNSIGNED_INT8) => glw::GL_STENCIL_INDEX8,
        (ChannelOrder::RGBA, ChannelType::FLOAT) => glw::GL_RGBA32F,
        (ChannelOrder::RGBA, ChannelType::SIGNED_INT32) => glw::GL_RGBA32I,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32) => glw::GL_RGBA32UI,
        (ChannelOrder::RGBA, ChannelType::UNORM_INT16) => glw::GL_RGBA16,
        (ChannelOrder::RGBA, ChannelType::SNORM_INT16) => glw::GL_RGBA16_SNORM,
        (ChannelOrder::RGBA, ChannelType::HALF_FLOAT) => glw::GL_RGBA16F,
        (ChannelOrder::RGBA, ChannelType::SIGNED_INT16) => glw::GL_RGBA16I,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT16) => glw::GL_RGBA16UI,
        (ChannelOrder::RGBA, ChannelType::UNORM_INT8) => glw::GL_RGBA8,
        (ChannelOrder::RGBA, ChannelType::SIGNED_INT8) => glw::GL_RGBA8I,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8) => glw::GL_RGBA8UI,
        (ChannelOrder::sRGBA, ChannelType::UNORM_INT8) => glw::GL_SRGB8_ALPHA8,
        (ChannelOrder::RGBA, ChannelType::UNORM_INT_1010102_REV) => glw::GL_RGB10_A2,
        (ChannelOrder::RGBA, ChannelType::UNSIGNED_INT_1010102_REV) => glw::GL_RGB10_A2UI,
        (ChannelOrder::RGBA, ChannelType::SNORM_INT8) => glw::GL_RGBA8_SNORM,
        (ChannelOrder::RGB, ChannelType::UNORM_INT8) => glw::GL_RGB8,
        (ChannelOrder::RGB, ChannelType::UNSIGNED_INT_11F_11F_10F_REV) => glw::GL_R11F_G11F_B10F,
        (ChannelOrder::RGB, ChannelType::FLOAT) => glw::GL_RGB32F,
        (ChannelOrder::RGB, ChannelType::SIGNED_INT32) => glw::GL_RGB32I,
        (ChannelOrder::RGB, ChannelType::UNSIGNED_INT32) => glw::GL_RGB32UI,
        (ChannelOrder::RGB, ChannelType::UNORM_INT16) => glw::GL_RGB16,
        (ChannelOrder::RGB, ChannelType::SNORM_INT16) => glw::GL_RGB16_SNORM,
        (ChannelOrder::RGB, ChannelType::HALF_FLOAT) => glw::GL_RGB16F,
        (ChannelOrder::RGB, ChannelType::SIGNED_INT16) => glw::GL_RGB16I,
        (ChannelOrder::RGB, ChannelType::UNSIGNED_INT16) => glw::GL_RGB16UI,
        (ChannelOrder::RGB, ChannelType::SNORM_INT8) => glw::GL_RGB8_SNORM,
        (ChannelOrder::RGB, ChannelType::SIGNED_INT8) => glw::GL_RGB8I,
        (ChannelOrder::RGB, ChannelType::UNSIGNED_INT8) => glw::GL_RGB8UI,
        (ChannelOrder::sRGB, ChannelType::UNORM_INT8) => glw::GL_SRGB8,
        (ChannelOrder::RGB, ChannelType::UNSIGNED_INT_999_E5_REV) => glw::GL_RGB9_E5,
        (ChannelOrder::RGB, ChannelType::UNORM_INT_1010102_REV) => glw::GL_RGB10,
        (ChannelOrder::RG, ChannelType::FLOAT) => glw::GL_RG32F,
        (ChannelOrder::RG, ChannelType::SIGNED_INT32) => glw::GL_RG32I,
        (ChannelOrder::RG, ChannelType::UNSIGNED_INT32) => glw::GL_RG32UI,
        (ChannelOrder::RG, ChannelType::UNORM_INT16) => glw::GL_RG16,
        (ChannelOrder::RG, ChannelType::SNORM_INT16) => glw::GL_RG16_SNORM,
        (ChannelOrder::RG, ChannelType::HALF_FLOAT) => glw::GL_RG16F,
        (ChannelOrder::RG, ChannelType::SIGNED_INT16) => glw::GL_RG16I,
        (ChannelOrder::RG, ChannelType::UNSIGNED_INT16) => glw::GL_RG16UI,
        (ChannelOrder::RG, ChannelType::UNORM_INT8) => glw::GL_RG8,
        (ChannelOrder::RG, ChannelType::SIGNED_INT8) => glw::GL_RG8I,
        (ChannelOrder::RG, ChannelType::UNSIGNED_INT8) => glw::GL_RG8UI,
        (ChannelOrder::RG, ChannelType::SNORM_INT8) => glw::GL_RG8_SNORM,
        (ChannelOrder::sRG, ChannelType::UNORM_INT8) => glw::GL_SRG8_EXT,
        (ChannelOrder::R, ChannelType::FLOAT) => glw::GL_R32F,
        (ChannelOrder::R, ChannelType::SIGNED_INT32) => glw::GL_R32I,
        (ChannelOrder::R, ChannelType::UNSIGNED_INT32) => glw::GL_R32UI,
        (ChannelOrder::R, ChannelType::UNORM_INT16) => glw::GL_R16,
        (ChannelOrder::R, ChannelType::SNORM_INT16) => glw::GL_R16_SNORM,
        (ChannelOrder::R, ChannelType::HALF_FLOAT) => glw::GL_R16F,
        (ChannelOrder::R, ChannelType::SIGNED_INT16) => glw::GL_R16I,
        (ChannelOrder::R, ChannelType::UNSIGNED_INT16) => glw::GL_R16UI,
        (ChannelOrder::R, ChannelType::UNORM_INT8) => glw::GL_R8,
        (ChannelOrder::R, ChannelType::SIGNED_INT8) => glw::GL_R8I,
        (ChannelOrder::R, ChannelType::UNSIGNED_INT8) => glw::GL_R8UI,
        (ChannelOrder::R, ChannelType::SNORM_INT8) => glw::GL_R8_SNORM,
        (ChannelOrder::sR, ChannelType::UNORM_INT8) => glw::GL_SR8_EXT,
        (ChannelOrder::D, ChannelType::FLOAT) => glw::GL_DEPTH_COMPONENT32F,
        (ChannelOrder::D, ChannelType::UNSIGNED_INT_24_8) => glw::GL_DEPTH_COMPONENT24,
        (ChannelOrder::D, ChannelType::UNSIGNED_INT32) => glw::GL_DEPTH_COMPONENT32,
        (ChannelOrder::DS, ChannelType::FLOAT_UNSIGNED_INT_24_8_REV) => glw::GL_DEPTH32F_STENCIL8,
        (ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8) => glw::GL_DEPTH24_STENCIL8,
        _ => {
            return Err(TestError::InternalError(
                "Can't map texture format to GL internal format".to_string(),
            ));
        }
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Every `GL_COMPRESSED_*_ETC2`/`_EAC` enum `map_gl_compressed_tex_format` accepts -
    /// shared between the decodability check and the round-trip check below so the two
    /// stay in step with each other without either silently drifting narrower.
    const ALL_ETC2_EAC: [GLenum; 10] = [
        glw::GL_COMPRESSED_R11_EAC,
        glw::GL_COMPRESSED_SIGNED_R11_EAC,
        glw::GL_COMPRESSED_RG11_EAC,
        glw::GL_COMPRESSED_SIGNED_RG11_EAC,
        glw::GL_COMPRESSED_RGB8_ETC2,
        glw::GL_COMPRESSED_SRGB8_ETC2,
        glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
        glw::GL_COMPRESSED_RGBA8_ETC2_EAC,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
    ];

    /// Every `GL_COMPRESSED_RGBA_ASTC_*`/`GL_COMPRESSED_SRGB8_ALPHA8_ASTC_*` enum - same
    /// sharing reason as `ALL_ETC2_EAC` above.
    const ALL_ASTC: [GLenum; 28] = [
        glw::GL_COMPRESSED_RGBA_ASTC_4x4,
        glw::GL_COMPRESSED_RGBA_ASTC_5x4,
        glw::GL_COMPRESSED_RGBA_ASTC_5x5,
        glw::GL_COMPRESSED_RGBA_ASTC_6x5,
        glw::GL_COMPRESSED_RGBA_ASTC_6x6,
        glw::GL_COMPRESSED_RGBA_ASTC_8x5,
        glw::GL_COMPRESSED_RGBA_ASTC_8x6,
        glw::GL_COMPRESSED_RGBA_ASTC_8x8,
        glw::GL_COMPRESSED_RGBA_ASTC_10x5,
        glw::GL_COMPRESSED_RGBA_ASTC_10x6,
        glw::GL_COMPRESSED_RGBA_ASTC_10x8,
        glw::GL_COMPRESSED_RGBA_ASTC_10x10,
        glw::GL_COMPRESSED_RGBA_ASTC_12x10,
        glw::GL_COMPRESSED_RGBA_ASTC_12x12,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x4,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_5x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_6x6,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x6,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_8x8,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x5,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x6,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x8,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_10x10,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x10,
        glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12,
    ];

    #[test]
    fn map_gl_compressed_tex_format_matches_hand_checked_etc2_and_eac_enums() {
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_RGB8_ETC2),
            Some(vk::Format::ETC2_R8G8B8_UNORM_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_SRGB8_ETC2),
            Some(vk::Format::ETC2_R8G8B8_SRGB_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_RGBA8_ETC2_EAC),
            Some(vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_R11_EAC),
            Some(vk::Format::EAC_R11_UNORM_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_SIGNED_RG11_EAC),
            Some(vk::Format::EAC_R11G11_SNORM_BLOCK)
        );
    }

    /// Both ends of the ASTC size range, UNORM and sRGB, to catch a transposed digit in
    /// the block-size name (`4x4` vs `12x12`) rather than just the first entry.
    #[test]
    fn map_gl_compressed_tex_format_matches_hand_checked_astc_enums() {
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_RGBA_ASTC_4x4),
            Some(vk::Format::ASTC_4X4_UNORM_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4),
            Some(vk::Format::ASTC_4X4_SRGB_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_RGBA_ASTC_12x12),
            Some(vk::Format::ASTC_12X12_UNORM_BLOCK)
        );
        assert_eq!(
            map_gl_compressed_tex_format(glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12),
            Some(vk::Format::ASTC_12X12_SRGB_BLOCK)
        );
    }

    #[test]
    fn map_gl_compressed_tex_format_rejects_uncompressed_and_unknown_enums() {
        assert_eq!(map_gl_compressed_tex_format(glw::GL_RGBA8), None);
        assert_eq!(map_gl_compressed_tex_format(0xDEAD_0000), None);
        // GL_ETC1_RGB8_OES (0x8D64) - deliberately unmapped, see this module's own doc
        // comment on `map_gl_compressed_tex_format`.
        assert_eq!(map_gl_compressed_tex_format(0x8D64), None);
    }

    #[test]
    fn is_compressed_format_agrees_with_map_gl_compressed_tex_format() {
        assert!(is_compressed_format(glw::GL_COMPRESSED_RGB8_ETC2));
        assert!(is_compressed_format(glw::GL_COMPRESSED_RGBA_ASTC_10x10));
        assert!(!is_compressed_format(glw::GL_RGBA8));
    }

    /// Every `vk::Format` this function can produce must be one
    /// `tcu::compressed_texture::get_uncompressed_format` actually decodes - a mapping
    /// to a typo'd or not-yet-decoded `vk::Format` variant would otherwise only surface
    /// the first time a real compressed-texture case tried to use it.
    #[test]
    fn every_mapped_format_is_decodable_by_tcu_compressed_texture() {
        for gl_format in ALL_ETC2_EAC.into_iter().chain(ALL_ASTC) {
            let vk_format = map_gl_compressed_tex_format(gl_format)
                .unwrap_or_else(|| panic!("0x{gl_format:x} should map to a vk::Format"));
            assert!(
                crate::tcu::compressed_texture::get_uncompressed_format(vk_format).is_some(),
                "0x{gl_format:x} mapped to {vk_format:?}, which tcu::compressed_texture cannot decode"
            );
        }
    }

    #[test]
    fn get_gl_format_for_compressed_matches_hand_checked_etc2_and_eac_enums() {
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ETC2_R8G8B8_UNORM_BLOCK),
            Some(glw::GL_COMPRESSED_RGB8_ETC2)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ETC2_R8G8B8_SRGB_BLOCK),
            Some(glw::GL_COMPRESSED_SRGB8_ETC2)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ETC2_R8G8B8A8_UNORM_BLOCK),
            Some(glw::GL_COMPRESSED_RGBA8_ETC2_EAC)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ETC2_R8G8B8A1_SRGB_BLOCK),
            Some(glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::EAC_R11_SNORM_BLOCK),
            Some(glw::GL_COMPRESSED_SIGNED_R11_EAC)
        );
    }

    #[test]
    fn get_gl_format_for_compressed_matches_hand_checked_astc_enums() {
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ASTC_4X4_UNORM_BLOCK),
            Some(glw::GL_COMPRESSED_RGBA_ASTC_4x4)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ASTC_4X4_SRGB_BLOCK),
            Some(glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_4x4)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ASTC_12X12_UNORM_BLOCK),
            Some(glw::GL_COMPRESSED_RGBA_ASTC_12x12)
        );
        assert_eq!(
            get_gl_format_for_compressed(vk::Format::ASTC_12X12_SRGB_BLOCK),
            Some(glw::GL_COMPRESSED_SRGB8_ALPHA8_ASTC_12x12)
        );
    }

    #[test]
    fn get_gl_format_for_compressed_rejects_a_desktop_only_bc_format() {
        // BC1-BC7 have no GL mapping at all - no GLES target samples them, see this
        // function's own doc comment and `tcu::compressed_texture`'s top comment.
        assert_eq!(get_gl_format_for_compressed(vk::Format::BC1_RGB_UNORM_BLOCK), None);
    }

    /// Every GL enum `map_gl_compressed_tex_format` accepts must come back out of its
    /// own inverse unchanged - the two are maintained as separate match expressions
    /// (see `get_gl_format_for_compressed`'s own doc comment for why this file does not
    /// derive one from the other), so nothing stops them drifting apart except a test
    /// that walks every entry both ways.
    #[test]
    fn every_compressed_format_round_trips_through_both_directions() {
        for gl_format in ALL_ETC2_EAC.into_iter().chain(ALL_ASTC) {
            let vk_format = map_gl_compressed_tex_format(gl_format).expect("every listed enum must map forward");
            assert_eq!(
                get_gl_format_for_compressed(vk_format),
                Some(gl_format),
                "0x{gl_format:x} -> {vk_format:?} -> back should be 0x{gl_format:x}"
            );
        }
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/opengl/simplereference/sglrReferenceUtils.hpp / .cpp
//     (namespace sglr::rr_util) - map_gl_blend_equation through map_gl_size
//   framework/opengl/gluTextureUtil.cpp
//     (namespace glu) - map_gl_internal_format, map_gl_channel_type,
//     map_gl_transfer_format, map_gl_tex_internal_format's fallback half, and
//     map_gl_compare_func
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's `DE_ASSERT(false)` default
// arm returns a `_LAST` sentinel; here an unmapped enum is `None`, so a caller that ever
// passes one cannot end up blending with a silently wrong equation.

use crate::glw::{self, GLenum};
use crate::rr::primitive_types::PrimitiveType;
use crate::rr::render_state::{BlendEquation, BlendEquationAdvanced, BlendFunc, StencilOp, TestFunc};
use crate::rr::vertex_attrib::VertexAttribType;
use crate::tcu::pixel::{CompareMode, FilterMode, MipmapFilterMode, WrapMode};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};

/// `sglr::rr_util::mapGLBlendEquation`
pub fn map_gl_blend_equation(equation: GLenum) -> Option<BlendEquation> {
    match equation {
        glw::GL_FUNC_ADD => Some(BlendEquation::Add),
        glw::GL_FUNC_SUBTRACT => Some(BlendEquation::Subtract),
        glw::GL_FUNC_REVERSE_SUBTRACT => Some(BlendEquation::ReverseSubtract),
        glw::GL_MIN => Some(BlendEquation::Min),
        glw::GL_MAX => Some(BlendEquation::Max),
        _ => None,
    }
}

/// `sglr::rr_util::mapGLBlendFunc`
pub fn map_gl_blend_func(func: GLenum) -> Option<BlendFunc> {
    match func {
        glw::GL_ZERO => Some(BlendFunc::Zero),
        glw::GL_ONE => Some(BlendFunc::One),
        glw::GL_SRC_COLOR => Some(BlendFunc::SrcColor),
        glw::GL_ONE_MINUS_SRC_COLOR => Some(BlendFunc::OneMinusSrcColor),
        glw::GL_DST_COLOR => Some(BlendFunc::DstColor),
        glw::GL_ONE_MINUS_DST_COLOR => Some(BlendFunc::OneMinusDstColor),
        glw::GL_SRC_ALPHA => Some(BlendFunc::SrcAlpha),
        glw::GL_ONE_MINUS_SRC_ALPHA => Some(BlendFunc::OneMinusSrcAlpha),
        glw::GL_DST_ALPHA => Some(BlendFunc::DstAlpha),
        glw::GL_ONE_MINUS_DST_ALPHA => Some(BlendFunc::OneMinusDstAlpha),
        glw::GL_CONSTANT_COLOR => Some(BlendFunc::ConstantColor),
        glw::GL_ONE_MINUS_CONSTANT_COLOR => Some(BlendFunc::OneMinusConstantColor),
        glw::GL_CONSTANT_ALPHA => Some(BlendFunc::ConstantAlpha),
        glw::GL_ONE_MINUS_CONSTANT_ALPHA => Some(BlendFunc::OneMinusConstantAlpha),
        glw::GL_SRC_ALPHA_SATURATE => Some(BlendFunc::SrcAlphaSaturate),
        glw::GL_SRC1_COLOR => Some(BlendFunc::Src1Color),
        glw::GL_ONE_MINUS_SRC1_COLOR => Some(BlendFunc::OneMinusSrc1Color),
        glw::GL_SRC1_ALPHA => Some(BlendFunc::Src1Alpha),
        glw::GL_ONE_MINUS_SRC1_ALPHA => Some(BlendFunc::OneMinusSrc1Alpha),
        _ => None,
    }
}

/// `sglr::rr_util::mapGLTestFunc`
pub fn map_gl_test_func(func: GLenum) -> Option<TestFunc> {
    match func {
        glw::GL_ALWAYS => Some(TestFunc::Always),
        glw::GL_EQUAL => Some(TestFunc::Equal),
        glw::GL_GEQUAL => Some(TestFunc::GEqual),
        glw::GL_GREATER => Some(TestFunc::Greater),
        glw::GL_LEQUAL => Some(TestFunc::LEqual),
        glw::GL_LESS => Some(TestFunc::Less),
        glw::GL_NEVER => Some(TestFunc::Never),
        glw::GL_NOTEQUAL => Some(TestFunc::NotEqual),
        _ => None,
    }
}

/// `glu::mapGLCompareFunc` - `GL_TEXTURE_COMPARE_FUNC`'s own mapping, into
/// `tcu::pixel::CompareMode` rather than `map_gl_test_func`'s `rr::render_state::
/// TestFunc` just above. The two cover the same eight GL compare functions but serve
/// unrelated parts of the pipeline (depth/stencil testing versus shadow-sampler
/// comparison) and upstream itself keeps them as two independent functions - kept
/// that way here too rather than converting through `TestFunc`.
pub fn map_gl_compare_func(mode: GLenum) -> Option<CompareMode> {
    match mode {
        glw::GL_LESS => Some(CompareMode::Less),
        glw::GL_LEQUAL => Some(CompareMode::LessOrEqual),
        glw::GL_GREATER => Some(CompareMode::Greater),
        glw::GL_GEQUAL => Some(CompareMode::GreaterOrEqual),
        glw::GL_EQUAL => Some(CompareMode::Equal),
        glw::GL_NOTEQUAL => Some(CompareMode::NotEqual),
        glw::GL_ALWAYS => Some(CompareMode::Always),
        glw::GL_NEVER => Some(CompareMode::Never),
        _ => None,
    }
}

/// `sglr::rr_util::mapGLBlendEquationAdvanced`
pub fn map_gl_blend_equation_advanced(equation: GLenum) -> Option<BlendEquationAdvanced> {
    match equation {
        glw::GL_MULTIPLY_KHR => Some(BlendEquationAdvanced::Multiply),
        glw::GL_SCREEN_KHR => Some(BlendEquationAdvanced::Screen),
        glw::GL_OVERLAY_KHR => Some(BlendEquationAdvanced::Overlay),
        glw::GL_DARKEN_KHR => Some(BlendEquationAdvanced::Darken),
        glw::GL_LIGHTEN_KHR => Some(BlendEquationAdvanced::Lighten),
        glw::GL_COLORDODGE_KHR => Some(BlendEquationAdvanced::ColorDodge),
        glw::GL_COLORBURN_KHR => Some(BlendEquationAdvanced::ColorBurn),
        glw::GL_HARDLIGHT_KHR => Some(BlendEquationAdvanced::HardLight),
        glw::GL_SOFTLIGHT_KHR => Some(BlendEquationAdvanced::SoftLight),
        glw::GL_DIFFERENCE_KHR => Some(BlendEquationAdvanced::Difference),
        glw::GL_EXCLUSION_KHR => Some(BlendEquationAdvanced::Exclusion),
        glw::GL_HSL_HUE_KHR => Some(BlendEquationAdvanced::HslHue),
        glw::GL_HSL_SATURATION_KHR => Some(BlendEquationAdvanced::HslSaturation),
        glw::GL_HSL_COLOR_KHR => Some(BlendEquationAdvanced::HslColor),
        glw::GL_HSL_LUMINOSITY_KHR => Some(BlendEquationAdvanced::HslLuminosity),
        _ => None,
    }
}

/// `sglr::rr_util::mapGLStencilOp`
pub fn map_gl_stencil_op(op: GLenum) -> Option<StencilOp> {
    match op {
        glw::GL_KEEP => Some(StencilOp::Keep),
        glw::GL_ZERO => Some(StencilOp::Zero),
        glw::GL_REPLACE => Some(StencilOp::Replace),
        glw::GL_INCR => Some(StencilOp::Incr),
        glw::GL_DECR => Some(StencilOp::Decr),
        glw::GL_INCR_WRAP => Some(StencilOp::IncrWrap),
        glw::GL_DECR_WRAP => Some(StencilOp::DecrWrap),
        glw::GL_INVERT => Some(StencilOp::Invert),
        _ => None,
    }
}

/// `glu::mapGLWrapMode` (`gluTextureUtil.cpp`) - also upstream's own file-local,
/// self-admittedly duplicated `sglrReferenceContext.cpp::mapGLWrapMode` (its own
/// `\todo [2014-02-19 pyry] Duplicated with code in gluTextureUtil.hpp`), the one
/// `ReferenceContext::texParameteri`/`Texture2D::resolve_sampler` actually need - this
/// port keeps a single copy here instead of two. `GL_CLAMP_TO_BORDER` is deliberately
/// absent, matching `tcu::pixel::WrapMode`'s own narrowing (see that enum's doc comment)
/// at the time this was written - widen both together if a caller ever needs it.
pub fn map_gl_wrap_mode(wrap_mode: GLenum) -> Option<WrapMode> {
    match wrap_mode {
        glw::GL_CLAMP_TO_EDGE => Some(WrapMode::ClampToEdge),
        glw::GL_REPEAT => Some(WrapMode::Repeat),
        glw::GL_MIRRORED_REPEAT => Some(WrapMode::MirroredRepeat),
        _ => None,
    }
}

/// `glu::mapGLMinFilterMode` - split into `tcu::pixel::Sampler`'s own two-axis shape
/// (`FilterMode`, the per-level tap, plus `Option<MipmapFilterMode>`, the mip-blend
/// shape) rather than upstream's single nine-variant `tcu::Sampler::FilterMode` value -
/// see `Sampler`'s own doc comment for why that split exists here. `None` mip-blend for
/// `GL_NEAREST`/`GL_LINEAR` (no mipmapping at all), `Some` for the four `*_MIPMAP_*`
/// variants.
pub fn map_gl_min_filter_mode(filter_mode: GLenum) -> Option<(FilterMode, Option<MipmapFilterMode>)> {
    match filter_mode {
        glw::GL_NEAREST => Some((FilterMode::Nearest, None)),
        glw::GL_LINEAR => Some((FilterMode::Linear, None)),
        glw::GL_NEAREST_MIPMAP_NEAREST => Some((FilterMode::Nearest, Some(MipmapFilterMode::Nearest))),
        glw::GL_NEAREST_MIPMAP_LINEAR => Some((FilterMode::Nearest, Some(MipmapFilterMode::Linear))),
        glw::GL_LINEAR_MIPMAP_NEAREST => Some((FilterMode::Linear, Some(MipmapFilterMode::Nearest))),
        glw::GL_LINEAR_MIPMAP_LINEAR => Some((FilterMode::Linear, Some(MipmapFilterMode::Linear))),
        _ => None,
    }
}

/// `glu::mapGLMagFilterMode` - `GL_TEXTURE_MAG_FILTER`'s own narrower accepted set
/// (`GL_NEAREST`/`GL_LINEAR` only, already enforced by `tex_parameteri`'s own
/// `is_valid_gl_mag_filter` guard before a value ever reaches here).
pub fn map_gl_mag_filter_mode(filter_mode: GLenum) -> Option<FilterMode> {
    match filter_mode {
        glw::GL_NEAREST => Some(FilterMode::Nearest),
        glw::GL_LINEAR => Some(FilterMode::Linear),
        _ => None,
    }
}

/// `GL_TEXTURE_CUBE_MAP_POSITIVE_X..NEGATIVE_Z` (six contiguous GL enum values) back to
/// a `0..=5` face index, in exactly `tcu::get_cube_array_face_index`'s own order
/// (`PositiveX=0, NegativeX=1, PositiveY=2, NegativeY=3, PositiveZ=4, NegativeZ=5`) -
/// confirmed directly against both enums' literal values in `glw.rs`/`tcu::pixel`, so a
/// `rc::TextureCube` face (indexed the same way, see that struct's own doc comment) can
/// use this with no further remapping. `None` for anything else, including plain
/// `GL_TEXTURE_CUBE_MAP` itself (that names the whole object, not one face - callers
/// that accept it as a *binding* target, like `bind_texture`, check for it separately).
pub fn map_gl_cube_map_face_index(target: GLenum) -> Option<u32> {
    if (glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X..=glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z).contains(&target) {
        Some(target - glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X)
    } else {
        None
    }
}

/// `sglr::rr_util::mapGLPrimitiveType`
pub fn map_gl_primitive_type(type_: GLenum) -> Option<PrimitiveType> {
    match type_ {
        glw::GL_TRIANGLES => Some(PrimitiveType::Triangles),
        glw::GL_TRIANGLE_STRIP => Some(PrimitiveType::TriangleStrip),
        glw::GL_TRIANGLE_FAN => Some(PrimitiveType::TriangleFan),
        glw::GL_LINES => Some(PrimitiveType::Lines),
        glw::GL_LINE_STRIP => Some(PrimitiveType::LineStrip),
        glw::GL_LINE_LOOP => Some(PrimitiveType::LineLoop),
        glw::GL_POINTS => Some(PrimitiveType::Points),
        glw::GL_LINES_ADJACENCY => Some(PrimitiveType::LinesAdjacency),
        glw::GL_LINE_STRIP_ADJACENCY => Some(PrimitiveType::LineStripAdjacency),
        glw::GL_TRIANGLES_ADJACENCY => Some(PrimitiveType::TrianglesAdjacency),
        glw::GL_TRIANGLE_STRIP_ADJACENCY => Some(PrimitiveType::TriangleStripAdjacency),
        _ => None,
    }
}

/// `sglr::rr_util::mapGLPureIntegerVertexAttributeType`
pub fn map_gl_pure_integer_vertex_attribute_type(type_: GLenum) -> Option<VertexAttribType> {
    match type_ {
        glw::GL_UNSIGNED_BYTE => Some(VertexAttribType::PureUint8),
        glw::GL_UNSIGNED_SHORT => Some(VertexAttribType::PureUint16),
        glw::GL_UNSIGNED_INT => Some(VertexAttribType::PureUint32),
        glw::GL_BYTE => Some(VertexAttribType::PureInt8),
        glw::GL_SHORT => Some(VertexAttribType::PureInt16),
        glw::GL_INT => Some(VertexAttribType::PureInt32),
        _ => None,
    }
}

/// `sglr::rr_util::mapGLFloatVertexAttributeType` - narrowed to GLES. Upstream's
/// `useClampingNormalization` depends on the context being ES >= 3.0 or desktop GL >=
/// 4.2; this project has no desktop-GL root (see CLAUDE.md's "hodow_cts" section), and
/// every GLES root here is already >= 3.0 where it is ported at all, so the flag is
/// unconditionally `true`. `bgraComponentOrder` is unconditionally `false` for the same
/// reason - `GL_BGRA` is `GL_ARB_vertex_array_bgra`, a desktop-only extension.
pub fn map_gl_float_vertex_attribute_type(type_: GLenum, normalized_integer: bool) -> Option<VertexAttribType> {
    use VertexAttribType::*;
    Some(match type_ {
        glw::GL_FLOAT => Float,
        glw::GL_HALF_FLOAT => Half,
        glw::GL_FIXED => Fixed,
        glw::GL_DOUBLE => Double,

        glw::GL_UNSIGNED_BYTE => {
            if !normalized_integer {
                NonpureUint8
            } else {
                NonpureUnorm8
            }
        }
        glw::GL_UNSIGNED_SHORT => {
            if !normalized_integer {
                NonpureUint16
            } else {
                NonpureUnorm16
            }
        }
        glw::GL_UNSIGNED_INT => {
            if !normalized_integer {
                NonpureUint32
            } else {
                NonpureUnorm32
            }
        }
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => {
            if !normalized_integer {
                NonpureUint2101010Rev
            } else {
                NonpureUnorm2101010Rev
            }
        }
        glw::GL_BYTE => {
            if !normalized_integer {
                NonpureInt8
            } else {
                NonpureSnorm8Clamp
            }
        }
        glw::GL_SHORT => {
            if !normalized_integer {
                NonpureInt16
            } else {
                NonpureSnorm16Clamp
            }
        }
        glw::GL_INT => {
            if !normalized_integer {
                NonpureInt32
            } else {
                NonpureSnorm32Clamp
            }
        }
        glw::GL_INT_2_10_10_10_REV => {
            if !normalized_integer {
                NonpureInt2101010Rev
            } else {
                NonpureSnorm2101010RevClamp
            }
        }
        _ => return None,
    })
}

/// `sglr::rr_util::mapGLSize`
pub fn map_gl_size(size: i32) -> Option<i32> {
    match size {
        1..=4 => Some(size),
        _ if size as GLenum == glw::GL_BGRA => Some(4),
        _ => None,
    }
}

/// `glu::mapGLInternalFormat` (`framework/opengl/gluTextureUtil.cpp`) - every *sized*
/// GL internal format this project's renderbuffer/texture storage needs to resolve to
/// a `tcu::TextureFormat`. Upstream throws `tcu::InternalError` on an unmapped format;
/// `None` is that case here. `GL_SRG8_EXT`/`GL_SR8_EXT` are the two-and
/// one-channel sRGB extension formats upstream itself maps (`EXT_texture_sRGB_R8`/
/// `_RG8`) - kept even though nothing here produces them yet, since the table is
/// ported as a whole rather than filtered to only the entries today's callers reach.
pub fn map_gl_internal_format(internal_format: GLenum) -> Option<TextureFormat> {
    use ChannelOrder::*;
    use ChannelType::*;
    Some(match internal_format {
        glw::GL_RGB5_A1 => TextureFormat::new(RGBA, UNORM_SHORT_5551),
        glw::GL_RGBA4 => TextureFormat::new(RGBA, UNORM_SHORT_4444),
        glw::GL_RGB565 => TextureFormat::new(RGB, UNORM_SHORT_565),
        glw::GL_DEPTH_COMPONENT16 => TextureFormat::new(D, UNORM_INT16),
        glw::GL_STENCIL_INDEX8 => TextureFormat::new(S, UNSIGNED_INT8),

        glw::GL_RGBA32F => TextureFormat::new(RGBA, FLOAT),
        glw::GL_RGBA32I => TextureFormat::new(RGBA, SIGNED_INT32),
        glw::GL_RGBA32UI => TextureFormat::new(RGBA, UNSIGNED_INT32),
        glw::GL_RGBA16 => TextureFormat::new(RGBA, UNORM_INT16),
        glw::GL_RGBA16_SNORM => TextureFormat::new(RGBA, SNORM_INT16),
        glw::GL_RGBA16F => TextureFormat::new(RGBA, HALF_FLOAT),
        glw::GL_RGBA16I => TextureFormat::new(RGBA, SIGNED_INT16),
        glw::GL_RGBA16UI => TextureFormat::new(RGBA, UNSIGNED_INT16),
        glw::GL_RGBA8 => TextureFormat::new(RGBA, UNORM_INT8),
        glw::GL_RGBA8I => TextureFormat::new(RGBA, SIGNED_INT8),
        glw::GL_RGBA8UI => TextureFormat::new(RGBA, UNSIGNED_INT8),
        glw::GL_SRGB8_ALPHA8 => TextureFormat::new(sRGBA, UNORM_INT8),
        glw::GL_RGB10_A2 => TextureFormat::new(RGBA, UNORM_INT_1010102_REV),
        glw::GL_RGB10_A2UI => TextureFormat::new(RGBA, UNSIGNED_INT_1010102_REV),
        glw::GL_RGBA8_SNORM => TextureFormat::new(RGBA, SNORM_INT8),

        glw::GL_RGB8 => TextureFormat::new(RGB, UNORM_INT8),
        glw::GL_R11F_G11F_B10F => TextureFormat::new(RGB, UNSIGNED_INT_11F_11F_10F_REV),
        glw::GL_RGB32F => TextureFormat::new(RGB, FLOAT),
        glw::GL_RGB32I => TextureFormat::new(RGB, SIGNED_INT32),
        glw::GL_RGB32UI => TextureFormat::new(RGB, UNSIGNED_INT32),
        glw::GL_RGB16 => TextureFormat::new(RGB, UNORM_INT16),
        glw::GL_RGB16_SNORM => TextureFormat::new(RGB, SNORM_INT16),
        glw::GL_RGB16F => TextureFormat::new(RGB, HALF_FLOAT),
        glw::GL_RGB16I => TextureFormat::new(RGB, SIGNED_INT16),
        glw::GL_RGB16UI => TextureFormat::new(RGB, UNSIGNED_INT16),
        glw::GL_RGB8_SNORM => TextureFormat::new(RGB, SNORM_INT8),
        glw::GL_RGB8I => TextureFormat::new(RGB, SIGNED_INT8),
        glw::GL_RGB8UI => TextureFormat::new(RGB, UNSIGNED_INT8),
        glw::GL_SRGB8 => TextureFormat::new(sRGB, UNORM_INT8),
        glw::GL_RGB9_E5 => TextureFormat::new(RGB, UNSIGNED_INT_999_E5_REV),
        glw::GL_RGB10 => TextureFormat::new(RGB, UNORM_INT_1010102_REV),

        glw::GL_RG32F => TextureFormat::new(RG, FLOAT),
        glw::GL_RG32I => TextureFormat::new(RG, SIGNED_INT32),
        glw::GL_RG32UI => TextureFormat::new(RG, UNSIGNED_INT32),
        glw::GL_RG16 => TextureFormat::new(RG, UNORM_INT16),
        glw::GL_RG16_SNORM => TextureFormat::new(RG, SNORM_INT16),
        glw::GL_RG16F => TextureFormat::new(RG, HALF_FLOAT),
        glw::GL_RG16I => TextureFormat::new(RG, SIGNED_INT16),
        glw::GL_RG16UI => TextureFormat::new(RG, UNSIGNED_INT16),
        glw::GL_RG8 => TextureFormat::new(RG, UNORM_INT8),
        glw::GL_RG8I => TextureFormat::new(RG, SIGNED_INT8),
        glw::GL_RG8UI => TextureFormat::new(RG, UNSIGNED_INT8),
        glw::GL_RG8_SNORM => TextureFormat::new(RG, SNORM_INT8),
        glw::GL_SRG8_EXT => TextureFormat::new(sRG, UNORM_INT8),

        glw::GL_R32F => TextureFormat::new(R, FLOAT),
        glw::GL_R32I => TextureFormat::new(R, SIGNED_INT32),
        glw::GL_R32UI => TextureFormat::new(R, UNSIGNED_INT32),
        glw::GL_R16 => TextureFormat::new(R, UNORM_INT16),
        glw::GL_R16_SNORM => TextureFormat::new(R, SNORM_INT16),
        glw::GL_R16F => TextureFormat::new(R, HALF_FLOAT),
        glw::GL_R16I => TextureFormat::new(R, SIGNED_INT16),
        glw::GL_R16UI => TextureFormat::new(R, UNSIGNED_INT16),
        glw::GL_R8 => TextureFormat::new(R, UNORM_INT8),
        glw::GL_R8I => TextureFormat::new(R, SIGNED_INT8),
        glw::GL_R8UI => TextureFormat::new(R, UNSIGNED_INT8),
        glw::GL_R8_SNORM => TextureFormat::new(R, SNORM_INT8),
        glw::GL_SR8_EXT => TextureFormat::new(sR, UNORM_INT8),

        glw::GL_BGRA => TextureFormat::new(BGRA, UNORM_INT8),
        glw::GL_BGRA8_EXT => TextureFormat::new(BGRA, UNORM_INT8),

        glw::GL_DEPTH_COMPONENT32F => TextureFormat::new(D, FLOAT),
        glw::GL_DEPTH_COMPONENT24 => TextureFormat::new(D, UNSIGNED_INT_24_8),
        glw::GL_DEPTH_COMPONENT32 => TextureFormat::new(D, UNSIGNED_INT32),
        glw::GL_DEPTH32F_STENCIL8 => TextureFormat::new(DS, FLOAT_UNSIGNED_INT_24_8_REV),
        glw::GL_DEPTH24_STENCIL8 => TextureFormat::new(DS, UNSIGNED_INT_24_8),

        _ => return None,
    })
}

/// `glu::mapGLChannelType` (`static`, `framework/opengl/gluTextureUtil.cpp`) - upstream
/// asserts and returns a sentinel on an unmapped type; `None` is that case here. The
/// `normalized` bit is ignored for types where it does not apply, matching upstream's
/// own note.
fn map_gl_channel_type(data_type: GLenum, normalized: bool) -> Option<ChannelType> {
    use ChannelType::*;
    Some(match data_type {
        glw::GL_UNSIGNED_BYTE => {
            if normalized {
                UNORM_INT8
            } else {
                UNSIGNED_INT8
            }
        }
        glw::GL_BYTE => {
            if normalized {
                SNORM_INT8
            } else {
                SIGNED_INT8
            }
        }
        glw::GL_UNSIGNED_SHORT => {
            if normalized {
                UNORM_INT16
            } else {
                UNSIGNED_INT16
            }
        }
        glw::GL_SHORT => {
            if normalized {
                SNORM_INT16
            } else {
                SIGNED_INT16
            }
        }
        glw::GL_UNSIGNED_INT => {
            if normalized {
                UNORM_INT32
            } else {
                UNSIGNED_INT32
            }
        }
        glw::GL_INT => {
            if normalized {
                SNORM_INT32
            } else {
                SIGNED_INT32
            }
        }
        glw::GL_FLOAT => FLOAT,
        glw::GL_UNSIGNED_SHORT_4_4_4_4 => UNORM_SHORT_4444,
        glw::GL_UNSIGNED_SHORT_5_5_5_1 => UNORM_SHORT_5551,
        glw::GL_UNSIGNED_SHORT_5_6_5 => UNORM_SHORT_565,
        glw::GL_HALF_FLOAT => HALF_FLOAT,
        glw::GL_UNSIGNED_INT_2_10_10_10_REV => {
            if normalized {
                UNORM_INT_1010102_REV
            } else {
                UNSIGNED_INT_1010102_REV
            }
        }
        glw::GL_UNSIGNED_INT_10F_11F_11F_REV => UNSIGNED_INT_11F_11F_10F_REV,
        glw::GL_UNSIGNED_INT_24_8 => UNSIGNED_INT_24_8,
        glw::GL_FLOAT_32_UNSIGNED_INT_24_8_REV => FLOAT_UNSIGNED_INT_24_8_REV,
        glw::GL_UNSIGNED_INT_5_9_9_9_REV => UNSIGNED_INT_999_E5_REV,
        // GL_OES_texture_half_float
        glw::GL_HALF_FLOAT_OES => HALF_FLOAT,
        _ => return None,
    })
}

/// `glu::mapGLTransferFormat`
pub fn map_gl_transfer_format(format: GLenum, data_type: GLenum) -> Option<TextureFormat> {
    use ChannelOrder::*;
    let (order, normalized) = match format {
        glw::GL_ALPHA => (A, true),
        glw::GL_LUMINANCE => (L, true),
        glw::GL_LUMINANCE_ALPHA => (LA, true),
        glw::GL_RGB => (RGB, true),
        glw::GL_RGBA => (RGBA, true),
        glw::GL_BGRA => (BGRA, true),
        glw::GL_RG => (RG, true),
        glw::GL_RED => (R, true),
        glw::GL_RGBA_INTEGER => (RGBA, false),
        glw::GL_RGB_INTEGER => (RGB, false),
        glw::GL_RG_INTEGER => (RG, false),
        glw::GL_RED_INTEGER => (R, false),
        glw::GL_SRGB => (sRGB, false),
        glw::GL_SRGB_ALPHA => (sRGBA, false),
        glw::GL_DEPTH_COMPONENT => (D, true),
        glw::GL_DEPTH_STENCIL => (DS, true),
        _ => return None,
    };
    Some(TextureFormat::new(order, map_gl_channel_type(data_type, normalized)?))
}

/// `(anonymous)::mapInternalFormat` (`framework/opengl/simplereference/sglrReferenceContext.cpp`) -
/// the unsized GLES2-style formats `texImage2D`'s own `internalFormat` parameter still
/// accepts, falling back to [`map_gl_internal_format`] (the *sized* formats) otherwise.
pub fn map_gl_tex_internal_format(internal_format: GLenum) -> Option<TextureFormat> {
    use ChannelOrder::*;
    use ChannelType::UNORM_INT8;
    Some(match internal_format {
        glw::GL_ALPHA => TextureFormat::new(A, UNORM_INT8),
        glw::GL_LUMINANCE => TextureFormat::new(L, UNORM_INT8),
        glw::GL_LUMINANCE_ALPHA => TextureFormat::new(LA, UNORM_INT8),
        glw::GL_RGB => TextureFormat::new(RGB, UNORM_INT8),
        glw::GL_RGBA => TextureFormat::new(RGBA, UNORM_INT8),
        _ => return map_gl_internal_format(internal_format),
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn primitive_type_maps_every_gles_mode() {
        assert_eq!(map_gl_primitive_type(glw::GL_TRIANGLES), Some(PrimitiveType::Triangles));
        assert_eq!(map_gl_primitive_type(glw::GL_POINTS), Some(PrimitiveType::Points));
        assert_eq!(
            map_gl_primitive_type(glw::GL_TRIANGLE_STRIP_ADJACENCY),
            Some(PrimitiveType::TriangleStripAdjacency)
        );
        assert_eq!(map_gl_primitive_type(0xDEAD), None);
    }

    #[test]
    fn pure_integer_type_distinguishes_signed_and_unsigned() {
        assert_eq!(
            map_gl_pure_integer_vertex_attribute_type(glw::GL_UNSIGNED_BYTE),
            Some(VertexAttribType::PureUint8)
        );
        assert_eq!(
            map_gl_pure_integer_vertex_attribute_type(glw::GL_BYTE),
            Some(VertexAttribType::PureInt8)
        );
        assert_eq!(map_gl_pure_integer_vertex_attribute_type(glw::GL_FLOAT), None);
    }

    #[test]
    fn float_type_respects_the_normalized_flag() {
        assert_eq!(
            map_gl_float_vertex_attribute_type(glw::GL_UNSIGNED_BYTE, false),
            Some(VertexAttribType::NonpureUint8)
        );
        assert_eq!(
            map_gl_float_vertex_attribute_type(glw::GL_UNSIGNED_BYTE, true),
            Some(VertexAttribType::NonpureUnorm8)
        );
        assert_eq!(
            map_gl_float_vertex_attribute_type(glw::GL_BYTE, true),
            Some(VertexAttribType::NonpureSnorm8Clamp),
            "ES is always clamp-normalized, never scale"
        );
        assert_eq!(
            map_gl_float_vertex_attribute_type(glw::GL_FLOAT, false),
            Some(VertexAttribType::Float)
        );
    }

    #[test]
    fn size_accepts_one_through_four_and_bgra() {
        assert_eq!(map_gl_size(3), Some(3));
        assert_eq!(map_gl_size(glw::GL_BGRA as i32), Some(4));
        assert_eq!(map_gl_size(5), None);
        assert_eq!(map_gl_size(0), None);
    }

    #[test]
    fn internal_format_maps_the_renderbuffer_formats() {
        assert_eq!(
            map_gl_internal_format(glw::GL_RGBA8),
            Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8))
        );
        assert_eq!(
            map_gl_internal_format(glw::GL_RGB565),
            Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_SHORT_565))
        );
        assert_eq!(
            map_gl_internal_format(glw::GL_DEPTH_COMPONENT16),
            Some(TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT16))
        );
        assert_eq!(
            map_gl_internal_format(glw::GL_STENCIL_INDEX8),
            Some(TextureFormat::new(ChannelOrder::S, ChannelType::UNSIGNED_INT8))
        );
        assert_eq!(
            map_gl_internal_format(glw::GL_DEPTH24_STENCIL8),
            Some(TextureFormat::new(ChannelOrder::DS, ChannelType::UNSIGNED_INT_24_8))
        );
    }

    #[test]
    fn internal_format_rejects_an_unsized_or_unknown_format() {
        assert_eq!(map_gl_internal_format(0xDEAD), None);
    }

    #[test]
    fn transfer_format_combines_format_and_type() {
        assert_eq!(
            map_gl_transfer_format(glw::GL_RGBA, glw::GL_UNSIGNED_BYTE),
            Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8))
        );
        assert_eq!(
            map_gl_transfer_format(glw::GL_RGB, glw::GL_UNSIGNED_SHORT_5_6_5),
            Some(TextureFormat::new(ChannelOrder::RGB, ChannelType::UNORM_SHORT_565))
        );
        assert_eq!(
            map_gl_transfer_format(glw::GL_RGBA_INTEGER, glw::GL_UNSIGNED_BYTE),
            Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT8)),
            "the _INTEGER order variants must not normalize"
        );
        assert_eq!(map_gl_transfer_format(glw::GL_RGBA, 0xDEAD), None);
    }

    #[test]
    fn tex_internal_format_accepts_the_gles2_unsized_formats_too() {
        assert_eq!(
            map_gl_tex_internal_format(glw::GL_RGBA),
            Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8))
        );
        assert_eq!(
            map_gl_tex_internal_format(glw::GL_LUMINANCE),
            Some(TextureFormat::new(ChannelOrder::L, ChannelType::UNORM_INT8))
        );
        // falls back to the sized mapping for anything not GLES2-unsized
        assert_eq!(
            map_gl_tex_internal_format(glw::GL_RGBA8),
            Some(TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8))
        );
    }

    #[test]
    fn wrap_mode_maps_the_three_gles_modes_and_rejects_clamp_to_border() {
        assert_eq!(map_gl_wrap_mode(glw::GL_CLAMP_TO_EDGE), Some(WrapMode::ClampToEdge));
        assert_eq!(map_gl_wrap_mode(glw::GL_REPEAT), Some(WrapMode::Repeat));
        assert_eq!(
            map_gl_wrap_mode(glw::GL_MIRRORED_REPEAT),
            Some(WrapMode::MirroredRepeat)
        );
        assert_eq!(
            map_gl_wrap_mode(glw::GL_CLAMP_TO_BORDER),
            None,
            "not ported - see this function's own doc comment"
        );
        assert_eq!(map_gl_wrap_mode(0xDEAD), None);
    }

    #[test]
    fn min_filter_mode_splits_tap_and_mip_blend_shape() {
        assert_eq!(
            map_gl_min_filter_mode(glw::GL_NEAREST),
            Some((FilterMode::Nearest, None))
        );
        assert_eq!(map_gl_min_filter_mode(glw::GL_LINEAR), Some((FilterMode::Linear, None)));
        assert_eq!(
            map_gl_min_filter_mode(glw::GL_NEAREST_MIPMAP_NEAREST),
            Some((FilterMode::Nearest, Some(MipmapFilterMode::Nearest)))
        );
        assert_eq!(
            map_gl_min_filter_mode(glw::GL_NEAREST_MIPMAP_LINEAR),
            Some((FilterMode::Nearest, Some(MipmapFilterMode::Linear)))
        );
        assert_eq!(
            map_gl_min_filter_mode(glw::GL_LINEAR_MIPMAP_NEAREST),
            Some((FilterMode::Linear, Some(MipmapFilterMode::Nearest)))
        );
        assert_eq!(
            map_gl_min_filter_mode(glw::GL_LINEAR_MIPMAP_LINEAR),
            Some((FilterMode::Linear, Some(MipmapFilterMode::Linear)))
        );
        assert_eq!(map_gl_min_filter_mode(0xDEAD), None);
    }

    #[test]
    fn mag_filter_mode_rejects_the_mipmap_variants() {
        assert_eq!(map_gl_mag_filter_mode(glw::GL_NEAREST), Some(FilterMode::Nearest));
        assert_eq!(map_gl_mag_filter_mode(glw::GL_LINEAR), Some(FilterMode::Linear));
        assert_eq!(
            map_gl_mag_filter_mode(glw::GL_LINEAR_MIPMAP_LINEAR),
            None,
            "GL_TEXTURE_MAG_FILTER never accepts a mipmap mode"
        );
    }

    #[test]
    fn cube_map_face_index_matches_tcu_get_cube_array_face_index_order() {
        // Hand-checked against the literal GL enum values in glw.rs: POSITIVE_X =
        // 0x8515, NEGATIVE_X = 0x8516, POSITIVE_Y = 0x8517, NEGATIVE_Y = 0x8518,
        // POSITIVE_Z = 0x8519, NEGATIVE_Z = 0x851A - six contiguous values, 0..=5 in
        // that order, which is also `tcu::get_cube_array_face_index`'s own order
        // (PositiveX=0, NegativeX=1, PositiveY=2, NegativeY=3, PositiveZ=4, NegativeZ=5).
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP_POSITIVE_X), Some(0));
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_X), Some(1));
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Y), Some(2));
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), Some(3));
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP_POSITIVE_Z), Some(4));
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP_NEGATIVE_Z), Some(5));
        assert_eq!(
            map_gl_cube_map_face_index(glw::GL_TEXTURE_CUBE_MAP),
            None,
            "names the whole object, not one face"
        );
        assert_eq!(map_gl_cube_map_face_index(glw::GL_TEXTURE_2D), None);
    }

    #[test]
    fn compare_func_maps_every_gl_compare_function() {
        assert_eq!(map_gl_compare_func(glw::GL_LESS), Some(CompareMode::Less));
        assert_eq!(map_gl_compare_func(glw::GL_LEQUAL), Some(CompareMode::LessOrEqual));
        assert_eq!(map_gl_compare_func(glw::GL_GREATER), Some(CompareMode::Greater));
        assert_eq!(map_gl_compare_func(glw::GL_GEQUAL), Some(CompareMode::GreaterOrEqual));
        assert_eq!(map_gl_compare_func(glw::GL_EQUAL), Some(CompareMode::Equal));
        assert_eq!(map_gl_compare_func(glw::GL_NOTEQUAL), Some(CompareMode::NotEqual));
        assert_eq!(map_gl_compare_func(glw::GL_ALWAYS), Some(CompareMode::Always));
        assert_eq!(map_gl_compare_func(glw::GL_NEVER), Some(CompareMode::Never));
        assert_eq!(map_gl_compare_func(0xDEAD), None);
    }
}

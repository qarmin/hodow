// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureBorderClampTests.cpp (the file-local helpers)
//   framework/common/tcuTextureUtil.cpp (getTextureBorderColor*, sampleTextureBorder)
//   framework/common/tcuTexture.cpp (lookupBorder, border-aware sampleNearest/Linear2D/3D, gatherArray2DOffsets*)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// `tcu::pixel::Sampler` has no `borderColor` field (a dozen full struct literals across the crate would break), so
// the border colour is carried here as `GenericVec4` next to the sampler, and the reference sampling that needs it
// lives in this file instead of in `tcu::pixel`: `sample_2d`/`sample_3d`/`gather` below are the CLAMP_TO_BORDER
// versions of the upstream functions, used only for the ideal reference image of `texture.border_clamp`. The
// verifier side (`tcu::tex_verifier`, `tcu::tex_compare_verifier`) already takes the resolved colour through
// `LookupPrecision::border_color`/`TexComparePrecision::border_color`.

use crate::glu::texture_util::{
    is_compressed_format, map_gl_compressed_tex_format, map_gl_internal_format, map_gl_transfer_format,
};
use crate::glw::{self, GLenum};
use crate::tcu::TestError;
use crate::tcu::compressed_texture::get_uncompressed_format;
use crate::tcu::pixel::{
    CompareMode, ConstPixelBufferAccess, DepthStencilMode, FilterMode, PixelBufferAccess, TextureLevel, WrapMode,
    exec_compare, get_channel_bit_depth, get_effective_depth_stencil_texture_format, get_texture_format_channel_mask,
    get_texture_format_info, is_fixed_point_depth_texture_format, linear_to_srgb, lookup, srgb_to_linear, wrap,
};
use crate::tcu::tex_verifier::WrapMode as VerifierWrapMode;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};
use crate::tcu::vector::Vec4;

/// `rr::GenericVec4` - four 32-bit words read as float, int or uint depending on the format class.
#[derive(Clone, Copy, Debug, Default, PartialEq)]
pub struct GenericVec4(pub [u32; 4]);

impl GenericVec4 {
    pub fn from_f32(v: [f32; 4]) -> Self {
        Self(v.map(f32::to_bits))
    }

    pub fn from_i32(v: [i32; 4]) -> Self {
        Self(v.map(|x| x as u32))
    }

    pub fn from_u32(v: [u32; 4]) -> Self {
        Self(v)
    }

    pub fn as_f32(&self) -> [f32; 4] {
        self.0.map(f32::from_bits)
    }

    pub fn as_i32(&self) -> [i32; 4] {
        self.0.map(|x| x as i32)
    }

    pub fn as_u32(&self) -> [u32; 4] {
        self.0
    }
}

/// `isDepthFormat` etc. take `tcu::Sampler::DepthStencilMode`, whose `MODE_LAST` is `None` here.
pub type SampleMode = Option<DepthStencilMode>;

/// GL_LUMINANCE, GL_LUMINANCE_ALPHA, GL_ALPHA and GL_BGRA are the "unsized formats are a special case" of the upstream file.
pub fn is_unsized_special(format: GLenum) -> bool {
    format == glw::GL_LUMINANCE
        || format == glw::GL_LUMINANCE_ALPHA
        || format == glw::GL_ALPHA
        || format == glw::GL_BGRA
}

/// `filterRequiresFilterability`
pub fn filter_requires_filterability(filter: GLenum) -> bool {
    match filter {
        glw::GL_NEAREST | glw::GL_NEAREST_MIPMAP_NEAREST => false,
        glw::GL_LINEAR
        | glw::GL_LINEAR_MIPMAP_NEAREST
        | glw::GL_NEAREST_MIPMAP_LINEAR
        | glw::GL_LINEAR_MIPMAP_LINEAR => true,
        _ => false,
    }
}

/// The reference-texture format `glu::Texture2D` gets for `format` - what `glu::mapGLInternalFormat`/
/// `mapGLTransferFormat`/`getUncompressedFormat` answer in upstream's three constructor paths.
pub fn reference_format(format: GLenum) -> Result<TextureFormat, TestError> {
    if is_unsized_special(format) {
        map_gl_transfer_format(format, glw::GL_UNSIGNED_BYTE)
            .ok_or_else(|| TestError::Fail(format!("no reference format for ({format:#x}, GL_UNSIGNED_BYTE)")))
    } else if is_compressed_format(format) {
        let vk_format = map_gl_compressed_tex_format(format)
            .ok_or_else(|| TestError::Fail(format!("unmapped compressed format {format:#x}")))?;
        get_uncompressed_format(vk_format)
            .ok_or_else(|| TestError::Fail(format!("no uncompressed format for {format:#x}")))
    } else {
        map_gl_internal_format(format).ok_or_else(|| TestError::Fail(format!("unmapped sized format {format:#x}")))
    }
}

/// `isDepthFormat`
pub fn is_depth_format(format: GLenum, mode: SampleMode) -> bool {
    if is_unsized_special(format) || is_compressed_format(format) {
        return false;
    }
    match map_gl_internal_format(format) {
        Some(fmt) => match fmt.order {
            ChannelOrder::D => true,
            ChannelOrder::DS => mode == Some(DepthStencilMode::Depth),
            _ => false,
        },
        None => false,
    }
}

/// `isStencilFormat`
pub fn is_stencil_format(format: GLenum, mode: SampleMode) -> bool {
    if is_unsized_special(format) || is_compressed_format(format) {
        return false;
    }
    match map_gl_internal_format(format) {
        Some(fmt) => match fmt.order {
            ChannelOrder::S => true,
            ChannelOrder::DS => mode == Some(DepthStencilMode::Stencil),
            _ => false,
        },
        None => false,
    }
}

/// `tcu::getEffectiveDepthStencilTextureFormat` with `MODE_LAST` falling through to the depth aspect, which only
/// matters for a combined format and no caller passes one without a mode.
pub fn effective_format(format: TextureFormat, mode: SampleMode) -> TextureFormat {
    get_effective_depth_stencil_texture_format(format, mode.unwrap_or(DepthStencilMode::Depth))
}

/// `getFormatChannelClass`
pub fn format_channel_class(format: GLenum, mode: SampleMode) -> Result<TextureChannelClass, TestError> {
    if is_unsized_special(format) {
        return Ok(TextureChannelClass::UnsignedFixedPoint);
    }
    let tex_format = reference_format(format)?;
    Ok(effective_format(tex_format, mode).type_.channel_class())
}

/// `isCoreFilterableFormat`, with `glu::isGLInternalColorFormatFilterable` folded in.
pub fn is_core_filterable_format(format: GLenum, mode: SampleMode, is_texture_float_linear_supported: bool) -> bool {
    let is_luminance_or_alpha =
        format == glw::GL_LUMINANCE || format == glw::GL_ALPHA || format == glw::GL_LUMINANCE_ALPHA;
    let is_unsized_color_format = format == glw::GL_BGRA;
    let is_fp32_format =
        format == glw::GL_RGBA32F || format == glw::GL_RGB32F || format == glw::GL_RG32F || format == glw::GL_R32F;

    if is_luminance_or_alpha || is_unsized_color_format || is_compressed_format(format) {
        return true;
    }
    if is_stencil_format(format, mode) || is_depth_format(format, mode) {
        return false;
    }
    if is_fp32_format {
        return is_texture_float_linear_supported;
    }
    is_gl_internal_color_format_filterable(format)
}

/// `glu::isGLInternalColorFormatFilterable` (its `default: DE_ASSERT(false)` answers `false` here).
fn is_gl_internal_color_format_filterable(format: GLenum) -> bool {
    matches!(
        format,
        glw::GL_R8
            | glw::GL_R8_SNORM
            | glw::GL_RG8
            | glw::GL_RG8_SNORM
            | glw::GL_RGB8
            | glw::GL_RGB8_SNORM
            | glw::GL_RGB565
            | glw::GL_RGBA4
            | glw::GL_RGB5_A1
            | glw::GL_RGBA8
            | glw::GL_RGBA8_SNORM
            | glw::GL_RGB10_A2
            | glw::GL_SR8_EXT
            | glw::GL_SRG8_EXT
            | glw::GL_SRGB8
            | glw::GL_SRGB8_ALPHA8
            | glw::GL_R16F
            | glw::GL_RG16F
            | glw::GL_RGB16F
            | glw::GL_RGBA16F
            | glw::GL_R11F_G11F_B10F
            | glw::GL_RGB9_E5
    )
}

/// `getNBitIntegerMaxValue`
fn n_bit_integer_max_value(is_signed: bool, num_bits: i32) -> i32 {
    if num_bits == 0 {
        0
    } else if is_signed {
        ((1i64 << (num_bits - 1)) - 1) as i32
    } else {
        ((1i64 << num_bits) - 1) as i32
    }
}

/// `getNBitIntegerMinValue`
fn n_bit_integer_min_value(is_signed: bool, num_bits: i32) -> i32 {
    if num_bits == 0 || !is_signed {
        0
    } else {
        (-(1i64 << (num_bits - 1))) as i32
    }
}

/// `getNBitIntegerVec4MaxValue`
pub fn n_bit_integer_vec4_max_value(is_signed: bool, num_bits: [i32; 4]) -> [i32; 4] {
    num_bits.map(|b| n_bit_integer_max_value(is_signed, b))
}

/// `getNBitIntegerVec4MinValue`
pub fn n_bit_integer_vec4_min_value(is_signed: bool, num_bits: [i32; 4]) -> [i32; 4] {
    num_bits.map(|b| n_bit_integer_min_value(is_signed, b))
}

/// `mix(x, y, a)` per component
fn mix4(x: [f32; 4], y: [f32; 4], a: [f32; 4]) -> [f32; 4] {
    std::array::from_fn(|c| x[c] * (1.0 - a[c]) + y[c] * a[c])
}

/// `mapToFormatColorUnits`
pub fn map_to_format_color_units(tex_format: TextureFormat, normalized_range: [f32; 4]) -> GenericVec4 {
    let info = get_texture_format_info(tex_format);

    match tex_format.type_.channel_class() {
        TextureChannelClass::UnsignedFixedPoint => GenericVec4::from_f32(normalized_range),
        TextureChannelClass::SignedFixedPoint => GenericVec4::from_f32(normalized_range.map(|v| v * 2.0 - 1.0)),
        TextureChannelClass::FloatingPoint => GenericVec4::from_f32(std::array::from_fn(|c| {
            info.value_min[c] + normalized_range[c] * info.value_max[c]
        })),
        TextureChannelClass::SignedInteger => {
            GenericVec4::from_i32(mix4(info.value_min, info.value_max, normalized_range).map(|v| v as i32))
        }
        TextureChannelClass::UnsignedInteger => {
            GenericVec4::from_u32(mix4(info.value_min, info.value_max, normalized_range).map(|v| v as u32))
        }
        TextureChannelClass::Last => GenericVec4::default(),
    }
}

/// `tcu::floatToU8`
fn float_to_u8(f: f32) -> i32 {
    ((f * 255.0 + 0.5).floor() as i32).clamp(0, 255)
}

/// `mapToFormatColorRepresentable` - the value is written to a one-texel level of the format and read back, so it is
/// representable, and channels the format lacks are cleared.
pub fn map_to_format_color_representable(
    tex_format: TextureFormat,
    normalized_range: [f32; 4],
) -> Result<GenericVec4, TestError> {
    let in_format_units = map_to_format_color_units(tex_format, normalized_range);
    let channel_mask = get_texture_format_channel_mask(tex_format);

    if tex_format.order.is_srgb() {
        debug_assert_eq!(tex_format.type_, ChannelType::UNORM_INT8);

        // make sure border color (in linear space) can be converted to 8-bit sRGB space without significant loss.
        let srgb = linear_to_srgb(normalized_range);
        let srgb8 = srgb.map(float_to_u8);
        let linearized = srgb_to_linear([
            srgb8[0] as f32 / 255.0,
            srgb8[1] as f32 / 255.0,
            srgb8[2] as f32 / 255.0,
            srgb8[3] as f32 / 255.0,
        ]);

        return Ok(GenericVec4::from_f32(std::array::from_fn(|c| {
            if channel_mask[c] { linearized[c] } else { 0.0 }
        })));
    }

    let mut level = TextureLevel::new(tex_format, 1, 1, 1)?;
    let class = tex_format.type_.channel_class();

    match class {
        TextureChannelClass::SignedFixedPoint
        | TextureChannelClass::UnsignedFixedPoint
        | TextureChannelClass::FloatingPoint => {
            let mut access = level.get_access();
            access.set_pixel(in_format_units.as_f32(), 0, 0, 0);
            let pixel = access.as_const().get_pixel(0, 0, 0);
            Ok(GenericVec4::from_f32(std::array::from_fn(|c| {
                if channel_mask[c] { pixel[c] } else { 0.0 }
            })))
        }
        TextureChannelClass::SignedInteger => {
            let mut access = level.get_access();
            if !access.set_pixel_int(in_format_units.as_i32(), 0, 0, 0) {
                return Err(TestError::NotPorted(format!(
                    "writing integer texels of {tex_format:?}"
                )));
            }
            let pixel = access.as_const().get_pixel_int(0, 0, 0);
            Ok(GenericVec4::from_i32(std::array::from_fn(|c| {
                if channel_mask[c] { pixel[c] } else { 0 }
            })))
        }
        TextureChannelClass::UnsignedInteger => {
            let mut access = level.get_access();
            if !access.set_pixel_int(in_format_units.as_u32().map(|v| v as i32), 0, 0, 0) {
                return Err(TestError::NotPorted(format!(
                    "writing integer texels of {tex_format:?}"
                )));
            }
            let pixel = access.as_const().get_pixel_uint(0, 0, 0);
            Ok(GenericVec4::from_u32(std::array::from_fn(|c| {
                if channel_mask[c] { pixel[c] } else { 0 }
            })))
        }
        TextureChannelClass::Last => Err(TestError::InternalError(format!("no channel class for {tex_format:?}"))),
    }
}

#[derive(Clone, Copy)]
enum BorderSwizzle {
    Zero,
    One,
    Channel(usize),
}

/// `getBorderColorReadSwizzle`
fn border_color_read_swizzle(order: ChannelOrder) -> [BorderSwizzle; 4] {
    use BorderSwizzle::{Channel as C, One, Zero};
    use ChannelOrder::*;

    match order {
        R | sR | D | S => [C(0), Zero, Zero, One],
        A => [Zero, Zero, Zero, C(3)],
        I => [C(0), C(0), C(0), C(0)],
        L => [C(0), C(0), C(0), One],
        LA => [C(0), C(0), C(0), C(3)],
        RG | sRG => [C(0), C(1), Zero, One],
        RA => [C(0), Zero, Zero, C(3)],
        RGB | BGR | sRGB | sBGR => [C(0), C(1), C(2), One],
        RGBA | ARGB | ABGR | BGRA | sRGBA | sBGRA => [C(0), C(1), C(2), C(3)],
        DS => [Zero, Zero, Zero, One],
    }
}

/// `getNBitSignedIntegerVec4MaxValue`/`Min`, `getNBitUnsignedIntegerVec4MaxValue`
fn signed_range(bits: i32) -> (i32, i32) {
    if bits > 0 {
        ((-(1i64 << (bits - 1))) as i32, ((1i64 << (bits - 1)) - 1) as i32)
    } else {
        (0, 0)
    }
}

fn unsigned_max(bits: i32) -> u32 {
    if bits >= 32 {
        u32::MAX
    } else if bits > 0 {
        ((1u64 << bits) - 1) as u32
    } else {
        0
    }
}

/// `getTextureBorderColorFloat`
fn texture_border_color_float(format: TextureFormat, border: &GenericVec4) -> [f32; 4] {
    let class = format.type_.channel_class();
    let map = border_color_read_swizzle(format.order);
    let is_float = class == TextureChannelClass::FloatingPoint;
    let is_signed = class != TextureChannelClass::UnsignedFixedPoint;
    let value_min = if is_signed { -1.0f32 } else { 0.0 };
    let border_f = border.as_f32();

    std::array::from_fn(|c| match map[c] {
        BorderSwizzle::Zero => 0.0,
        BorderSwizzle::One => 1.0,
        // floating point values are not clamped, fixed point ones are clamped to a representable range
        BorderSwizzle::Channel(ch) => {
            if is_float {
                border_f[ch]
            } else {
                border_f[ch].clamp(value_min, 1.0)
            }
        }
    })
}

/// `getTextureBorderColorInt`
fn texture_border_color_int(format: TextureFormat, border: &GenericVec4) -> [i32; 4] {
    let map = border_color_read_swizzle(format.order);
    let channel_bits = get_channel_bit_depth(format.type_);
    let border_i = border.as_i32();

    std::array::from_fn(|c| match map[c] {
        BorderSwizzle::Zero => 0,
        BorderSwizzle::One => 1,
        BorderSwizzle::Channel(ch) => {
            let (min, max) = signed_range(channel_bits[ch]);
            border_i[ch].clamp(min, max)
        }
    })
}

/// `getTextureBorderColorUint`
fn texture_border_color_uint(format: TextureFormat, border: &GenericVec4) -> [u32; 4] {
    let map = border_color_read_swizzle(format.order);
    let channel_bits = get_channel_bit_depth(format.type_);
    let border_u = border.as_u32();

    std::array::from_fn(|c| match map[c] {
        BorderSwizzle::Zero => 0,
        BorderSwizzle::One => 1,
        BorderSwizzle::Channel(ch) => border_u[ch].min(unsigned_max(channel_bits[ch])),
    })
}

/// `lookupBorder` - the border texel as the float vector a lookup of `format` yields.
pub fn lookup_border(format: TextureFormat, border: &GenericVec4) -> [f32; 4] {
    match format.type_.channel_class() {
        TextureChannelClass::FloatingPoint
        | TextureChannelClass::SignedFixedPoint
        | TextureChannelClass::UnsignedFixedPoint => texture_border_color_float(format, border),
        TextureChannelClass::SignedInteger => texture_border_color_int(format, border).map(|v| v as f32),
        TextureChannelClass::UnsignedInteger => texture_border_color_uint(format, border).map(|v| v as f32),
        TextureChannelClass::Last => [-1.0; 4],
    }
}

/// `tcu::Sampler::WrapMode` for the GL wrap enums this file uses (`glu::mapGLWrapMode`).
pub fn map_gl_wrap(mode: GLenum) -> Result<WrapMode, TestError> {
    match mode {
        glw::GL_CLAMP_TO_EDGE => Ok(WrapMode::ClampToEdge),
        glw::GL_CLAMP_TO_BORDER => Ok(WrapMode::ClampToBorder),
        glw::GL_REPEAT => Ok(WrapMode::Repeat),
        glw::GL_MIRRORED_REPEAT => Ok(WrapMode::MirroredRepeat),
        _ => Err(TestError::InternalError(format!("Can't map GL wrap mode {mode:#x}"))),
    }
}

/// The verification side's own copy of the wrap enum.
pub fn to_verifier_wrap(mode: WrapMode) -> VerifierWrapMode {
    match mode {
        WrapMode::ClampToEdge => VerifierWrapMode::ClampToEdge,
        WrapMode::ClampToBorder => VerifierWrapMode::ClampToBorder,
        WrapMode::Repeat => VerifierWrapMode::Repeat,
        WrapMode::MirroredRepeat => VerifierWrapMode::MirroredRepeat,
        WrapMode::MirroredOnce => VerifierWrapMode::MirroredOnce,
    }
}

/// `glu::mapGLCompareFunc`
pub fn map_gl_compare_func(func: GLenum) -> CompareMode {
    match func {
        glw::GL_LESS => CompareMode::Less,
        glw::GL_LEQUAL => CompareMode::LessOrEqual,
        glw::GL_GREATER => CompareMode::Greater,
        glw::GL_GEQUAL => CompareMode::GreaterOrEqual,
        glw::GL_EQUAL => CompareMode::Equal,
        glw::GL_NOTEQUAL => CompareMode::NotEqual,
        glw::GL_ALWAYS => CompareMode::Always,
        glw::GL_NEVER => CompareMode::Never,
        _ => CompareMode::None,
    }
}

/// `glu::getFilterMode` for the two filters used here (`GL_NEAREST`/`GL_LINEAR`).
pub fn map_gl_filter(filter: GLenum) -> Result<FilterMode, TestError> {
    match filter {
        glw::GL_NEAREST => Ok(FilterMode::Nearest),
        glw::GL_LINEAR => Ok(FilterMode::Linear),
        _ => Err(TestError::InternalError(format!(
            "Can't map GL filter mode {filter:#x}"
        ))),
    }
}

fn frac(x: f32) -> f32 {
    x - x.floor()
}

/// One texel of `level`, or the border colour when a CLAMP_TO_BORDER coordinate left the level (`wrap` yields -1/size).
fn tap(level: &ConstPixelBufferAccess<'_>, i: i32, j: i32, k: i32, border: [f32; 4]) -> [f32; 4] {
    let [w, h, d] = level.size();
    if i < 0 || j < 0 || k < 0 || i >= w as i32 || j >= h as i32 || k >= d as i32 {
        border
    } else {
        lookup(level, i, j, k)
    }
}

/// `sampleNearest2D`/`sampleLinear2D` with `CLAMP_TO_BORDER`, normalized coordinates (`border` is `lookup_border`'s result).
pub fn sample_2d(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    filter: FilterMode,
    border: [f32; 4],
    s: f32,
    t: f32,
) -> [f32; 4] {
    let [w, h, _] = level.size();
    let u = s * w as f32;
    let v = t * h as f32;

    match filter {
        FilterMode::Linear => {
            let x0 = (u - 0.5).floor() as i32;
            let y0 = (v - 0.5).floor() as i32;
            let i0 = wrap(wrap_s, x0, w as i32);
            let i1 = wrap(wrap_s, x0 + 1, w as i32);
            let j0 = wrap(wrap_t, y0, h as i32);
            let j1 = wrap(wrap_t, y0 + 1, h as i32);
            let a = frac(u - 0.5);
            let b = frac(v - 0.5);
            let p00 = tap(level, i0, j0, 0, border);
            let p10 = tap(level, i1, j0, 0, border);
            let p01 = tap(level, i0, j1, 0, border);
            let p11 = tap(level, i1, j1, 0, border);

            std::array::from_fn(|c| {
                p00[c] * (1.0 - a) * (1.0 - b) + p10[c] * a * (1.0 - b) + p01[c] * (1.0 - a) * b + p11[c] * a * b
            })
        }
        _ => {
            let i = wrap(wrap_s, u.floor() as i32, w as i32);
            let j = wrap(wrap_t, v.floor() as i32, h as i32);
            tap(level, i, j, 0, border)
        }
    }
}

/// `sample2DCompare` with `CLAMP_TO_BORDER` - every tap is compared before the bilinear blend.
#[allow(clippy::too_many_arguments)]
pub fn sample_2d_compare(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    filter: FilterMode,
    border: [f32; 4],
    compare: CompareMode,
    ref_: f32,
    s: f32,
    t: f32,
) -> f32 {
    let [w, h, _] = level.size();
    let u = s * w as f32;
    let v = t * h as f32;
    let is_fixed_point = is_fixed_point_depth_texture_format(level.format());
    let cmp = |color: [f32; 4]| exec_compare(color, compare, 0, ref_, is_fixed_point);

    match filter {
        FilterMode::Linear => {
            let x0 = (u - 0.5).floor() as i32;
            let y0 = (v - 0.5).floor() as i32;
            let i0 = wrap(wrap_s, x0, w as i32);
            let i1 = wrap(wrap_s, x0 + 1, w as i32);
            let j0 = wrap(wrap_t, y0, h as i32);
            let j1 = wrap(wrap_t, y0 + 1, h as i32);
            let a = frac(u - 0.5);
            let b = frac(v - 0.5);
            let p00 = cmp(tap(level, i0, j0, 0, border));
            let p10 = cmp(tap(level, i1, j0, 0, border));
            let p01 = cmp(tap(level, i0, j1, 0, border));
            let p11 = cmp(tap(level, i1, j1, 0, border));

            p00 * (1.0 - a) * (1.0 - b) + p10 * a * (1.0 - b) + p01 * (1.0 - a) * b + p11 * a * b
        }
        _ => {
            let i = wrap(wrap_s, u.floor() as i32, w as i32);
            let j = wrap(wrap_t, v.floor() as i32, h as i32);
            cmp(tap(level, i, j, 0, border))
        }
    }
}

/// `sampleNearest3D`/`sampleLinear3D` with `CLAMP_TO_BORDER`, normalized coordinates.
#[allow(clippy::too_many_arguments)]
pub fn sample_3d(
    level: &ConstPixelBufferAccess<'_>,
    wraps: [WrapMode; 3],
    filter: FilterMode,
    border: [f32; 4],
    s: f32,
    t: f32,
    r: f32,
) -> [f32; 4] {
    let [w, h, d] = level.size();
    let u = s * w as f32;
    let v = t * h as f32;
    let ww = r * d as f32;

    match filter {
        FilterMode::Linear => {
            let x0 = (u - 0.5).floor() as i32;
            let y0 = (v - 0.5).floor() as i32;
            let z0 = (ww - 0.5).floor() as i32;
            let i = [wrap(wraps[0], x0, w as i32), wrap(wraps[0], x0 + 1, w as i32)];
            let j = [wrap(wraps[1], y0, h as i32), wrap(wraps[1], y0 + 1, h as i32)];
            let k = [wrap(wraps[2], z0, d as i32), wrap(wraps[2], z0 + 1, d as i32)];
            let a = frac(u - 0.5);
            let b = frac(v - 0.5);
            let c = frac(ww - 0.5);
            let mut result = [0.0f32; 4];

            for (kk, &kz) in k.iter().enumerate() {
                for (jj, &jy) in j.iter().enumerate() {
                    for (ii, &ix) in i.iter().enumerate() {
                        let weight = (if ii == 0 { 1.0 - a } else { a })
                            * (if jj == 0 { 1.0 - b } else { b })
                            * (if kk == 0 { 1.0 - c } else { c });
                        let p = tap(level, ix, jy, kz, border);
                        for (r, pc) in result.iter_mut().zip(p) {
                            *r += pc * weight;
                        }
                    }
                }
            }
            result
        }
        _ => {
            let i = wrap(wraps[0], u.floor() as i32, w as i32);
            let j = wrap(wraps[1], v.floor() as i32, h as i32);
            let k = wrap(wraps[2], ww.floor() as i32, d as i32);
            tap(level, i, j, k, border)
        }
    }
}

/// `glu::getDefaultGatherOffsets`
pub const DEFAULT_GATHER_OFFSETS: [[i32; 2]; 4] = [[0, 1], [1, 1], [1, 0], [0, 0]];

/// `fetchGatherArray2DOffsets` for component `component_ndx` (the texel at each offset, border-aware).
fn fetch_gather_offsets(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    border: [f32; 4],
    s: f32,
    t: f32,
    component_ndx: usize,
) -> [f32; 4] {
    let [w, h, _] = level.size();
    let u = s * w as f32;
    let v = t * h as f32;
    let x0 = (u - 0.5).floor() as i32;
    let y0 = (v - 0.5).floor() as i32;

    std::array::from_fn(|i| {
        let sample_x = wrap(wrap_s, x0 + DEFAULT_GATHER_OFFSETS[i][0], w as i32);
        let sample_y = wrap(wrap_t, y0 + DEFAULT_GATHER_OFFSETS[i][1], h as i32);
        tap(level, sample_x, sample_y, 0, border)[component_ndx]
    })
}

/// `gatherArray2DOffsets` (component 0, default offsets)
pub fn gather(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    border: [f32; 4],
    s: f32,
    t: f32,
) -> [f32; 4] {
    fetch_gather_offsets(level, wrap_s, wrap_t, border, s, t, 0)
}

/// `gatherArray2DOffsetsCompare` (default offsets)
#[allow(clippy::too_many_arguments)]
pub fn gather_compare(
    level: &ConstPixelBufferAccess<'_>,
    wrap_s: WrapMode,
    wrap_t: WrapMode,
    border: [f32; 4],
    compare: CompareMode,
    ref_: f32,
    s: f32,
    t: f32,
) -> [f32; 4] {
    let is_fixed_point = is_fixed_point_depth_texture_format(level.format());
    let gathered = fetch_gather_offsets(level, wrap_s, wrap_t, border, s, t, 0);
    std::array::from_fn(|i| exec_compare(gathered, compare, i, ref_, is_fixed_point))
}

/// `tcu::TextureFormatInfo`'s ramp for a freshly generated level, as `genDefaultTexture` needs it.
pub fn gradient_range(format: TextureFormat) -> ([f32; 4], [f32; 4]) {
    let info = get_texture_format_info(format);
    (info.value_min, info.value_max)
}

/// The first `triQuadInterpolate` of the file - four values per vertex, interpolated over the quad's two triangles.
pub fn tri_quad_interpolate(values: &[[f32; 2]; 4], x_factor: f32, y_factor: f32) -> [f32; 2] {
    std::array::from_fn(|c| {
        if x_factor + y_factor < 1.0 {
            values[0][c] + (values[2][c] - values[0][c]) * x_factor + (values[1][c] - values[0][c]) * y_factor
        } else {
            values[3][c]
                + (values[1][c] - values[3][c]) * (1.0 - x_factor)
                + (values[2][c] - values[3][c]) * (1.0 - y_factor)
        }
    })
}

/// `verifyTextureBorderErrors`, ported as written upstream: it clears the error mask to green *first* and only then
/// looks for non-green pixels, so it never finds one and every pixel `computeTextureLookupDiff` rejected is forgiven.
/// Kept verbatim (see `QUIRKS.md`) - the verdict of every non-gather `border_clamp` case depends on it.
pub fn verify_texture_border_errors(error_mask: &mut PixelBufferAccess<'_>, tex_coord: &[f32], w: Vec4) -> i32 {
    let sq = [tex_coord[0], tex_coord[2], tex_coord[4], tex_coord[6]];
    let tq = [tex_coord[1], tex_coord[3], tex_coord[5], tex_coord[7]];
    let [dst_w_u, dst_h_u, _] = error_mask.size();
    let dst_w = dst_w_u as f32;
    let dst_h = dst_h_u as f32;

    let tri_s = [[sq[0], sq[1], sq[2]], [sq[3], sq[2], sq[1]]];
    let tri_t = [[tq[0], tq[1], tq[2]], [tq[3], tq[2], tq[1]]];
    let wq = w.m_data;
    let tri_w = [[wq[0], wq[1], wq[2]], [wq[3], wq[2], wq[1]]];

    const MIN_SUBPIXEL_BITS: i32 = 4;
    let pos_eps = 1.0 / (1 << MIN_SUBPIXEL_BITS) as f32;
    let green = crate::tcu::RGBA::green().to_vec().m_data;
    let red = crate::tcu::RGBA::red().to_vec().m_data;
    let mut num_failed = 0;

    let projected_tri_interpolate = |s: [f32; 3], w: [f32; 3], nx: f32, ny: f32| {
        (s[0] * (1.0 - nx - ny) / w[0] + s[1] * ny / w[1] + s[2] * nx / w[2])
            / ((1.0 - nx - ny) / w[0] + ny / w[1] + nx / w[2])
    };

    crate::tcu::pixel::clear(error_mask, green);

    for py in 0..dst_h_u {
        for px in 0..dst_w_u {
            let err_pix = error_mask.as_const().get_pixel(px, py, 0);

            // Try comparison to ideal reference first, and if that fails use slower verificator.
            if err_pix != green {
                let wx = px as f32 + 0.5;
                let wy = py as f32 + 0.5;
                let nx = wx / dst_w;
                let ny = wy / dst_h;

                let tri0 = (wx - pos_eps) / dst_w + (wy - pos_eps) / dst_h <= 1.0;
                let tri1 = (wx + pos_eps) / dst_w + (wy + pos_eps) / dst_h >= 1.0;
                let mut is_ok = false;

                // Pixel can belong to either of the triangles if it lies close enough to the edge.
                for tri_ndx in (if tri0 { 0 } else { 1 })..=(if tri1 { 1 } else { 0 }) {
                    let tri_nx = if tri_ndx == 1 { 1.0 - nx } else { nx };
                    let tri_ny = if tri_ndx == 1 { 1.0 - ny } else { ny };
                    let coord = [
                        projected_tri_interpolate(tri_s[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                        projected_tri_interpolate(tri_t[tri_ndx], tri_w[tri_ndx], tri_nx, tri_ny),
                    ];

                    // ignore inner-sampling errors for border test
                    if (0.0..=1.0).contains(&coord[0]) && (0.0..=1.0).contains(&coord[1]) {
                        is_ok = true;
                        break;
                    }
                }

                if !is_ok {
                    error_mask.set_pixel(red, px, py, 0);
                    num_failed += 1;
                }
            }
        }
    }
    num_failed
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fTextureBorderClampTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2015 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. NOT COMPILE-CHECKED when written.
//
// Upstream's `TextureBorderClampTest` base class with four subclasses (format, range clamp, per-axis 2D, depth
// compare, unused channel) is one `BorderClampCase2D` here with a `CaseKind`; every `iterate()` call of upstream (one
// per iteration config) runs in one `iterate()` loop, folded through a `ResultCollector`. The 3D per-axis case is
// `BorderClampCase3D`. The `GL 4.5` branches are absent (ES only, `m_isGL45` is false). The border colour lives in
// `border_clamp_util::GenericVec4` next to the sampler instead of in `tcu::Sampler` (see that file). The log carries
// no ideal/error-mask images.

use super::border_clamp_util::{
    DEFAULT_GATHER_OFFSETS, GenericVec4, SampleMode, effective_format, filter_requires_filterability,
    format_channel_class, gather, gather_compare, is_core_filterable_format, is_depth_format, is_stencil_format,
    is_unsized_special, lookup_border, map_gl_compare_func, map_gl_filter, map_gl_wrap,
    map_to_format_color_representable, map_to_format_color_units, n_bit_integer_vec4_max_value,
    n_bit_integer_vec4_min_value, sample_2d, sample_2d_compare, sample_3d, to_verifier_wrap, tri_quad_interpolate,
    verify_texture_border_errors,
};
use crate::gls::texture_test_util::{RandomViewport, TextureRenderer};
use crate::glu::shader_util::Precision;
use crate::glu::texture::Texture2D;
use crate::glu::texture_3d::Texture3D;
use crate::glu::texture_test_util::{
    LodMode, ReferenceParams, SamplerType, TextureType, compute_quad_tex_coord_2d, compute_texture_compare_diff_2d,
    compute_texture_lookup_diff_2d, compute_texture_lookup_diff_3d, get_sampler_type, triangle_interpolate_v3,
};
use crate::glu::texture_test_util_surface::{
    compute_fixed_point_threshold, fill_with_component_gradients_old, get_bits_vec, get_compare_mask,
};
use crate::glu::texture_util::{is_compressed_format, map_gl_compressed_tex_format};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, ShaderType, TestCase, TestCaseGroup, pr, va};
use crate::glw::{self, GLenum};
use crate::tcu::pixel::{
    ConstPixelBufferAccess, DepthStencilMode, FilterMode, PixelBufferAccess, Sampler, TextureLevel,
    get_effective_depth_stencil_access, get_texture_format_bit_depth, get_texture_format_channel_mask,
    get_texture_format_info, into_effective_depth_stencil_access,
};
use crate::tcu::pixel_format::PixelFormat;
use crate::tcu::random::Random;
use crate::tcu::result_collector::ResultCollector;
use crate::tcu::rgba::RGBA;
use crate::tcu::surface::Surface;
use crate::tcu::surface_access::{SurfaceAccess, get_color_mask, to_rgba_masked};
use crate::tcu::tex_compare_verifier::{TexComparePrecision, is_gather_offsets_compare_result_valid_2d};
use crate::tcu::tex_verifier::{LodPrecision, LookupPrecision, is_gather_offsets_result_valid_2d};
use crate::tcu::texture::{TextureChannelClass, TextureFormat};
use crate::tcu::vector::{Vec2, Vec4};
use crate::tcu::{TestError, TestOutcome, TestResult, de_string_hash};
use crate::vk::compressed_formats::{get_block_height, get_block_size_in_bytes, get_block_width, is_astc_format};

const VIEWPORT_WIDTH: i32 = 128;
const VIEWPORT_HEIGHT: i32 = 128;

const FLAG_USE_SHADOW_SAMPLER: u32 = 1 << 0;
const FLAG_TEST_FLOAT_FILTERABLE: u32 = 1 << 1;

#[derive(Clone, Copy, PartialEq, Eq)]
enum SizeType {
    Pot,
    Npot,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum StateType {
    SamplerParam,
    TextureParam,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SamplingFunction {
    Filter,
    Gather,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    Format,
    RangeClamp,
    PerAxis { s_wrap: GLenum, t_wrap: GLenum },
    DepthCompare,
    UnusedChannel,
}

/// `TextureBorderClampTest::IterationConfig`
#[derive(Clone, Default)]
struct IterationConfig {
    p0: [f32; 2],
    p1: [f32; 2],
    border_color: GenericVec4,
    lookup_scale: [f32; 4],
    lookup_bias: [f32; 4],
    min_filter: GLenum,
    mag_filter: GLenum,
    description: String,
    s_wrap: GLenum,
    t_wrap: GLenum,
    compare_mode: GLenum,
    compare_ref: f32,
}

/// `glu::Sampler`
struct GlSampler<'gl> {
    gl: &'gl glw::Functions,
    name: glw::GLuint,
}

impl<'gl> GlSampler<'gl> {
    fn new(gl: &'gl glw::Functions) -> Self {
        let mut name = 0;
        // SAFETY: one name is asked for and one GLuint of output is given.
        unsafe { gl.gen_samplers(1, &mut name) };
        Self { gl, name }
    }
}

impl Drop for GlSampler<'_> {
    fn drop(&mut self) {
        // SAFETY: the name is this wrapper's own and is deleted exactly once.
        unsafe { self.gl.delete_samplers(1, &self.name) };
    }
}

fn is_fixed_class(class: TextureChannelClass) -> bool {
    class == TextureChannelClass::SignedFixedPoint || class == TextureChannelClass::UnsignedFixedPoint
}

/// `de::toString` of a border colour, as `logParams` prints it.
fn border_color_string(class: TextureChannelClass, border: &GenericVec4) -> String {
    match class {
        TextureChannelClass::SignedInteger => format!("{:?}", border.as_i32()),
        TextureChannelClass::UnsignedInteger => format!("{:?}", border.as_u32()),
        _ => format!("{:?}", border.as_f32()),
    }
}

/// `texParameter{fv,Iiv,Iuiv}(target, GL_TEXTURE_BORDER_COLOR, ...)` by channel class.
///
/// # Safety
/// A valid, current GL context with the texture bound to `target`.
unsafe fn set_texture_border_color(
    gl: &glw::Functions,
    target: GLenum,
    class: TextureChannelClass,
    border: &GenericVec4,
) -> Result<(), TestError> {
    unsafe {
        match class {
            TextureChannelClass::SignedFixedPoint
            | TextureChannelClass::UnsignedFixedPoint
            | TextureChannelClass::FloatingPoint => {
                gl.tex_parameterfv(target, glw::GL_TEXTURE_BORDER_COLOR, border.0.as_ptr().cast());
            }
            TextureChannelClass::SignedInteger => {
                gl.tex_parameter_iiv(target, glw::GL_TEXTURE_BORDER_COLOR, border.0.as_ptr().cast())
            }
            TextureChannelClass::UnsignedInteger => {
                gl.tex_parameter_iuiv(target, glw::GL_TEXTURE_BORDER_COLOR, border.0.as_ptr())
            }
            TextureChannelClass::Last => {
                return Err(TestError::InternalError(
                    "border colour of a texture with no channel class".to_string(),
                ));
            }
        }
    }
    Ok(())
}

/// `samplerParameter{fv,Iiv,Iuiv}(sampler, GL_TEXTURE_BORDER_COLOR, ...)` by channel class.
///
/// # Safety
/// A valid, current GL context and a sampler name it generated.
unsafe fn set_sampler_border_color(
    gl: &glw::Functions,
    sampler: glw::GLuint,
    class: TextureChannelClass,
    border: &GenericVec4,
) -> Result<(), TestError> {
    unsafe {
        match class {
            TextureChannelClass::SignedFixedPoint
            | TextureChannelClass::UnsignedFixedPoint
            | TextureChannelClass::FloatingPoint => {
                gl.sampler_parameterfv(sampler, glw::GL_TEXTURE_BORDER_COLOR, border.0.as_ptr().cast());
            }
            TextureChannelClass::SignedInteger => {
                gl.sampler_parameter_iiv(sampler, glw::GL_TEXTURE_BORDER_COLOR, border.0.as_ptr().cast())
            }
            TextureChannelClass::UnsignedInteger => {
                gl.sampler_parameter_iuiv(sampler, glw::GL_TEXTURE_BORDER_COLOR, border.0.as_ptr())
            }
            TextureChannelClass::Last => {
                return Err(TestError::InternalError(
                    "border colour of a sampler with no channel class".to_string(),
                ));
            }
        }
    }
    Ok(())
}

fn level_view<'b>(level: &'b ConstPixelBufferAccess<'_>) -> ConstPixelBufferAccess<'b> {
    ConstPixelBufferAccess::new_with_pitch(level.format(), level.size(), level.pitch(), level.raw())
}

/// `generateDefaultCompressedData`
fn generate_default_compressed_data(format: vulkanalia::vk::Format, width: u32, height: u32) -> Vec<u8> {
    let block_byte_size = get_block_size_in_bytes(format) as usize;
    let num_blocks =
        width.div_ceil(get_block_width(format)) as usize * height.div_ceil(get_block_height(format)) as usize;
    let mut data = vec![0u8; num_blocks * block_byte_size];

    if is_astc_format(format) {
        // generate data that is valid in LDR mode
        const BLOCK: [u8; 16] = [
            252, 253, 255, 255, 255, 255, 255, 255, 223, 251, 28, 206, 54, 251, 160, 174,
        ];
        debug_assert_eq!(block_byte_size, BLOCK.len());
        for block in data.chunks_mut(BLOCK.len()) {
            block.copy_from_slice(&BLOCK);
        }
    } else {
        // any data is ok
        let mut rnd = Random::new(0xabc);
        for byte in data.iter_mut() {
            *byte = (rnd.get_uint32() & 0xff) as u8;
        }
    }
    data
}

/// `genDefaultTexture<glu::Texture2D>`
fn gen_default_texture_2d<'a>(
    context: &'a Context,
    tex_format: GLenum,
    width: u32,
    height: u32,
) -> Result<Texture2D<'a>, TestError> {
    let render_ctx = &context.render_context;

    if is_depth_format(tex_format, Some(DepthStencilMode::Depth))
        || is_stencil_format(tex_format, Some(DepthStencilMode::Stencil))
    {
        // fill different channels with different gradients
        let mut texture = Texture2D::new_sized(render_ctx, tex_format, width, height)?;
        texture.ref_texture_mut().alloc_level(0);

        if is_depth_format(tex_format, Some(DepthStencilMode::Depth)) {
            // fill depth with 0 -> 1
            let mut depth_access =
                into_effective_depth_stencil_access(texture.ref_texture_mut().level_mut(0), DepthStencilMode::Depth);
            fill_with_component_gradients_old(&mut depth_access, [0.0; 4], [1.0; 4]);
        }

        if is_stencil_format(tex_format, Some(DepthStencilMode::Stencil)) {
            // fill stencil with 0 -> max, flipping y to make stencil and depth cases not look identical
            let stencil_format = effective_format(texture.ref_texture().format(), Some(DepthStencilMode::Stencil));
            let info = get_texture_format_info(stencil_format);
            let mut gradient = TextureLevel::new(stencil_format, width, height, 1)?;
            fill_with_component_gradients_old(&mut gradient.get_access(), info.value_max, info.value_min);

            let src = gradient.get_const_access();
            let mut stencil_access =
                into_effective_depth_stencil_access(texture.ref_texture_mut().level_mut(0), DepthStencilMode::Stencil);
            for y in 0..height {
                for x in 0..width {
                    stencil_access.set_pix_stencil(src.get_pix_stencil(x, height - 1 - y, 0), x, y, 0);
                }
            }
        }

        // SAFETY: a current context; `texture` outlives the call.
        unsafe { texture.upload()? };
        Ok(texture)
    } else if !is_compressed_format(tex_format) {
        let mut texture = if is_unsized_special(tex_format) {
            Texture2D::new(render_ctx, tex_format, glw::GL_UNSIGNED_BYTE, width, height)?
        } else {
            Texture2D::new_sized(render_ctx, tex_format, width, height)?
        };

        // Fill level 0 with a gradient min -> max.
        texture.ref_texture_mut().alloc_level(0);
        let info = get_texture_format_info(texture.ref_texture().format());
        fill_with_component_gradients_old(
            &mut texture.ref_texture_mut().level_mut(0),
            info.value_min,
            info.value_max,
        );

        // SAFETY: as above.
        unsafe { texture.upload()? };
        Ok(texture)
    } else {
        let vk_format = map_gl_compressed_tex_format(tex_format)
            .ok_or_else(|| TestError::Fail(format!("unmapped compressed format {tex_format:#x}")))?;
        let data = generate_default_compressed_data(vk_format, width, height);
        let texture = Texture2D::new_compressed(
            render_ctx,
            &context.context_info,
            vk_format,
            width,
            height,
            &[data.as_slice()],
        )?;
        // SAFETY: as above.
        unsafe { texture.upload_compressed()? };
        Ok(texture)
    }
}

/// `genDefaultTexture<glu::Texture3D>` - only the uncompressed colour path is reachable (no 3D depth/compressed case).
fn gen_default_texture_3d<'a>(
    context: &'a Context,
    tex_format: GLenum,
    size: [u32; 3],
) -> Result<Texture3D<'a>, TestError> {
    let mut texture = Texture3D::new_sized(&context.render_context, tex_format, size[0], size[1], size[2])?;

    texture.ref_texture_mut().alloc_level(0);
    let info = get_texture_format_info(texture.ref_texture().format());
    fill_with_component_gradients_old(
        &mut texture.ref_texture_mut().level_mut(0),
        info.value_min,
        info.value_max,
    );

    // SAFETY: a current context; `texture` outlives the call.
    unsafe { texture.upload()? };
    Ok(texture)
}

/// The non-projected `sampleTexture` loop of `glu::TextureTestUtil` for a 2D quad with exact lod (no mipmaps are involved,
/// so the lod never selects anything): one reference colour per pixel, scaled and biased.
fn render_reference_2d(
    dst: &mut PixelBufferAccess<'_>,
    tex_coord: [f32; 8],
    scale: [f32; 4],
    bias: [f32; 4],
    sample: impl Fn(f32, f32) -> [f32; 4],
) {
    let sq = Vec4::new(tex_coord[0], tex_coord[2], tex_coord[4], tex_coord[6]);
    let tq = Vec4::new(tex_coord[1], tex_coord[3], tex_coord[5], tex_coord[7]);
    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let [dw, dh, _] = dst.size();

    for y in 0..dh {
        for x in 0..dw {
            let yf = (y as f32 + 0.5) / dh as f32;
            let xf = (x as f32 + 0.5) / dw as f32;
            let tri_ndx = if xf + yf >= 1.0 { 1 } else { 0 };
            let tri_x = if tri_ndx == 1 { 1.0 - xf } else { xf };
            let tri_y = if tri_ndx == 1 { 1.0 - yf } else { yf };

            let s = triangle_interpolate_v3(tri_s[tri_ndx], tri_x, tri_y);
            let t = triangle_interpolate_v3(tri_t[tri_ndx], tri_x, tri_y);
            let color = sample(s, t);
            dst.set_pixel(std::array::from_fn(|c| color[c] * scale[c] + bias[c]), x, y, 0);
        }
    }
}

/// The 3D counterpart of `render_reference_2d` (`tex_coord` is `[s, t, r]` per vertex).
fn render_reference_3d(
    dst: &mut PixelBufferAccess<'_>,
    tex_coord: [f32; 12],
    scale: [f32; 4],
    bias: [f32; 4],
    sample: impl Fn(f32, f32, f32) -> [f32; 4],
) {
    let sq = Vec4::new(tex_coord[0], tex_coord[3], tex_coord[6], tex_coord[9]);
    let tq = Vec4::new(tex_coord[1], tex_coord[4], tex_coord[7], tex_coord[10]);
    let rq = Vec4::new(tex_coord[2], tex_coord[5], tex_coord[8], tex_coord[11]);
    let tri_s = [sq.swizzle([0, 1, 2]), sq.swizzle([3, 2, 1])];
    let tri_t = [tq.swizzle([0, 1, 2]), tq.swizzle([3, 2, 1])];
    let tri_r = [rq.swizzle([0, 1, 2]), rq.swizzle([3, 2, 1])];
    let [dw, dh, _] = dst.size();

    for y in 0..dh {
        for x in 0..dw {
            let yf = (y as f32 + 0.5) / dh as f32;
            let xf = (x as f32 + 0.5) / dw as f32;
            let tri_ndx = if xf + yf >= 1.0 { 1 } else { 0 };
            let tri_x = if tri_ndx == 1 { 1.0 - xf } else { xf };
            let tri_y = if tri_ndx == 1 { 1.0 - yf } else { yf };

            let s = triangle_interpolate_v3(tri_s[tri_ndx], tri_x, tri_y);
            let t = triangle_interpolate_v3(tri_t[tri_ndx], tri_x, tri_y);
            let r = triangle_interpolate_v3(tri_r[tri_ndx], tri_x, tri_y);
            let color = sample(s, t, r);
            dst.set_pixel(std::array::from_fn(|c| color[c] * scale[c] + bias[c]), x, y, 0);
        }
    }
}

struct BorderClampCase2D {
    name: String,
    kind: CaseKind,
    tex_format: GLenum,
    mode: SampleMode,
    state_type: StateType,
    tex_width: i32,
    tex_height: i32,
    sampling: SamplingFunction,
    filter: GLenum,
    flags: u32,
}

impl BorderClampCase2D {
    fn use_shadow_sampler(&self) -> bool {
        (self.flags & FLAG_USE_SHADOW_SAMPLER) != 0
    }

    /// `getIterationSeed`
    fn iteration_seed(&self, iteration_ndx: usize, config: &IterationConfig) -> u32 {
        de_string_hash(&self.name)
            .wrapping_mul(31)
            .wrapping_add(iteration_ndx as u32)
            .wrapping_mul(31)
            .wrapping_add(self.tex_format)
            .wrapping_mul(31)
            .wrapping_add(config.min_filter)
            .wrapping_mul(31)
            .wrapping_add(config.mag_filter)
            .wrapping_mul(31)
            .wrapping_add(self.tex_width as u32)
            .wrapping_mul(31)
            .wrapping_add(self.tex_height as u32)
    }

    /// The `getIteration` table of the case's subclass, built from `init()`.
    fn generate_iterations(
        &self,
        tex_format: TextureFormat,
        class: TextureChannelClass,
    ) -> Result<Vec<IterationConfig>, TestError> {
        let info = get_texture_format_info(tex_format);
        let mut iterations: Vec<IterationConfig> = Vec::new();

        match self.kind {
            CaseKind::Format => {
                iterations.push(IterationConfig {
                    p0: [-1.5, -3.0],
                    p1: [1.5, 2.5],
                    border_color: map_to_format_color_representable(tex_format, [0.3, 0.7, 0.2, 0.5])?,
                    ..Default::default()
                });
                iterations.push(IterationConfig {
                    p0: [-0.5, 0.75],
                    p1: [0.25, 1.25],
                    border_color: map_to_format_color_representable(tex_format, [0.9, 0.2, 0.4, 0.6])?,
                    ..Default::default()
                });

                for iteration in iterations.iter_mut() {
                    if self.sampling == SamplingFunction::Gather {
                        iteration.lookup_scale = [info.look_up_scale[0]; 4];
                        iteration.lookup_bias = [info.look_up_bias[0]; 4];
                    } else {
                        iteration.lookup_scale = info.look_up_scale;
                        iteration.lookup_bias = info.look_up_bias;
                    }
                    iteration.min_filter = self.filter;
                    iteration.mag_filter = self.filter;
                    iteration.s_wrap = glw::GL_CLAMP_TO_BORDER;
                    iteration.t_wrap = glw::GL_CLAMP_TO_BORDER;
                    iteration.compare_mode = glw::GL_NONE;
                    iteration.compare_ref = 0.0;
                }
            }
            CaseKind::RangeClamp => {
                let is_depth = is_depth_format(self.tex_format, self.mode);
                let is_float = class == TextureChannelClass::FloatingPoint;
                let is_fixed = is_fixed_class(class);
                let is_pure_integer =
                    class == TextureChannelClass::SignedInteger || class == TextureChannelClass::UnsignedInteger;

                if is_depth || is_float {
                    // infinities are commonly used values on depth/float borders
                    iterations.push(IterationConfig {
                        p0: [-1.2, -3.0],
                        p1: [1.2, 2.5],
                        border_color: GenericVec4::from_f32([f32::INFINITY; 4]),
                        // scale & bias to [0.25, 0.5] range to make out-of-range values visible
                        lookup_scale: [0.5; 4],
                        lookup_bias: [0.25; 4],
                        description: "border value infinity".to_string(),
                        ..Default::default()
                    });
                    iterations.push(IterationConfig {
                        p0: [-0.25, -0.75],
                        p1: [2.25, 1.25],
                        border_color: GenericVec4::from_f32([f32::NEG_INFINITY; 4]),
                        lookup_scale: [0.5; 4],
                        lookup_bias: [0.25; 4],
                        description: "border value negative infinity".to_string(),
                        ..Default::default()
                    });
                } else if is_pure_integer {
                    let num_bits = get_texture_format_bit_depth(tex_format);
                    let is_signed = class == TextureChannelClass::SignedInteger;

                    // can't overflow 32bit integers with 32bit integers
                    for bits in num_bits {
                        debug_assert!(bits == 0 || bits == 8 || bits == 16);
                    }

                    let min_value = n_bit_integer_vec4_min_value(is_signed, num_bits);
                    let max_value = n_bit_integer_vec4_max_value(is_signed, num_bits);
                    let value_range: [i32; 4] = std::array::from_fn(|c| max_value[c] - min_value[c]);
                    let div_safe_range: [f32; 4] = value_range.map(|r| if r == 0 { 1.0 } else { r as f32 });
                    let scale_half: [f32; 4] = div_safe_range.map(|r| 0.5 / r);

                    // format max
                    {
                        let value: [i32; 4] = max_value.map(|v| v + 1);
                        iterations.push(IterationConfig {
                            p0: [-1.2, -3.0],
                            p1: [1.2, 2.5],
                            border_color: if is_signed {
                                GenericVec4::from_i32(value)
                            } else {
                                GenericVec4::from_u32(value.map(|v| v as u32))
                            },
                            lookup_scale: scale_half,
                            lookup_bias: if is_signed { [0.5; 4] } else { [0.25; 4] },
                            description: "border values one larger than maximum".to_string(),
                            ..Default::default()
                        });
                    }
                    // format min
                    if is_signed {
                        let value: [i32; 4] = min_value.map(|v| v - 1);
                        iterations.push(IterationConfig {
                            p0: [-0.25, -0.75],
                            p1: [2.25, 1.25],
                            border_color: GenericVec4::from_i32(value),
                            lookup_scale: scale_half,
                            lookup_bias: [0.5; 4],
                            description: "border values one less than minimum".to_string(),
                            ..Default::default()
                        });
                    }
                    // (u)int32 max
                    {
                        iterations.push(IterationConfig {
                            p0: [-1.6, -2.1],
                            p1: [1.2, 3.5],
                            border_color: if is_signed {
                                GenericVec4::from_i32([i32::MAX; 4])
                            } else {
                                GenericVec4::from_u32([u32::MAX; 4])
                            },
                            lookup_scale: scale_half,
                            lookup_bias: [0.25; 4],
                            description: "border values 32-bit maximum".to_string(),
                            ..Default::default()
                        });
                    }
                    // int32 min
                    if is_signed {
                        iterations.push(IterationConfig {
                            p0: [-2.6, -4.0],
                            p1: [1.1, 1.5],
                            border_color: GenericVec4::from_i32([i32::MIN; 4]),
                            lookup_scale: scale_half,
                            lookup_bias: [0.25; 4],
                            description: "border values 0".to_string(),
                            ..Default::default()
                        });
                    }
                } else if is_fixed {
                    let is_signed = class == TextureChannelClass::SignedFixedPoint;
                    // scale & bias to [0.25, 0.5] range to make out-of-range values visible
                    let lookup_bias = if is_signed { [0.5; 4] } else { [0.25; 4] };
                    let lookup_scale = if is_signed { [0.25; 4] } else { [0.5; 4] };

                    iterations.push(IterationConfig {
                        p0: [-1.2, -3.0],
                        p1: [1.2, 2.5],
                        border_color: map_to_format_color_units(tex_format, [1.1, 1.3, 2.2, 1.3]),
                        lookup_scale,
                        lookup_bias,
                        description: "border values larger than maximum".to_string(),
                        ..Default::default()
                    });
                    iterations.push(IterationConfig {
                        p0: [-0.25, -0.75],
                        p1: [2.25, 1.25],
                        border_color: map_to_format_color_units(tex_format, [-0.2, -0.9, -2.4, -0.6]),
                        lookup_scale,
                        lookup_bias,
                        description: "border values less than minimum".to_string(),
                        ..Default::default()
                    });
                } else {
                    return Err(TestError::InternalError(
                        "range clamp case with no usable channel class".to_string(),
                    ));
                }

                // common parameters
                for iteration in iterations.iter_mut() {
                    iteration.min_filter = self.filter;
                    iteration.mag_filter = self.filter;
                    iteration.s_wrap = glw::GL_CLAMP_TO_BORDER;
                    iteration.t_wrap = glw::GL_CLAMP_TO_BORDER;
                    iteration.compare_mode = glw::GL_NONE;
                    iteration.compare_ref = 0.0;
                }
            }
            CaseKind::PerAxis { s_wrap, t_wrap } => {
                let mut iteration = IterationConfig {
                    p0: [-0.25, -0.75],
                    p1: [2.25, 1.25],
                    border_color: map_to_format_color_representable(tex_format, [0.4, 0.9, 0.1, 0.2])?,
                    ..Default::default()
                };

                if self.sampling == SamplingFunction::Gather {
                    iteration.lookup_scale = [info.look_up_scale[0]; 4];
                    iteration.lookup_bias = [info.look_up_bias[0]; 4];
                } else {
                    iteration.lookup_scale = info.look_up_scale;
                    iteration.lookup_bias = info.look_up_bias;
                }

                iteration.min_filter = self.filter;
                iteration.mag_filter = self.filter;
                iteration.s_wrap = s_wrap;
                iteration.t_wrap = t_wrap;
                iteration.compare_mode = glw::GL_NONE;
                iteration.compare_ref = 0.0;
                iterations.push(iteration);
            }
            CaseKind::DepthCompare => {
                let quad = |border: f32, description: &str, compare_mode: GLenum, compare_ref: f32| IterationConfig {
                    p0: [-0.15, -0.35],
                    p1: [1.25, 1.1],
                    border_color: GenericVec4::from_f32([border, 0.0, 0.0, 0.0]),
                    description: description.to_string(),
                    compare_mode,
                    compare_ref,
                    ..Default::default()
                };

                // 0.5 <= 0.7
                iterations.push(quad(0.7, "Border color in [0, 1] range", glw::GL_LEQUAL, 0.5));
                // 1.5 <= 1.0
                iterations.push(quad(1.5, "Border color > 1, should be clamped", glw::GL_LEQUAL, 1.0));
                // -0.5 >= 0.0
                iterations.push(quad(-0.5, "Border color < 0, should be clamped", glw::GL_GEQUAL, 0.0));
                // inf < 1.25
                iterations.push(quad(
                    f32::INFINITY,
                    "Border color == inf, should be clamped; ref > 1",
                    glw::GL_LESS,
                    1.25,
                ));
                // -inf > -0.5
                iterations.push(quad(
                    f32::NEG_INFINITY,
                    "Border color == inf, should be clamped; ref < 0",
                    glw::GL_GREATER,
                    -0.5,
                ));

                // common parameters
                for iteration in iterations.iter_mut() {
                    iteration.lookup_scale = [1.0; 4];
                    iteration.lookup_bias = [0.0; 4];
                    iteration.min_filter = self.filter;
                    iteration.mag_filter = self.filter;
                    iteration.s_wrap = glw::GL_CLAMP_TO_BORDER;
                    iteration.t_wrap = glw::GL_CLAMP_TO_BORDER;
                }
            }
            CaseKind::UnusedChannel => {
                let channel_mask = get_texture_format_channel_mask(tex_format);
                let max_channel_value = if channel_mask[0] {
                    info.value_max[0]
                } else if channel_mask[1] {
                    info.value_max[1]
                } else if channel_mask[2] {
                    info.value_max[2]
                } else {
                    info.value_max[3]
                };

                let effective_colors = map_to_format_color_representable(tex_format, [0.6; 4])?;
                let non_effective_colors = match class {
                    TextureChannelClass::UnsignedFixedPoint
                    | TextureChannelClass::SignedFixedPoint
                    | TextureChannelClass::FloatingPoint => GenericVec4::from_f32([max_channel_value * 0.8; 4]),
                    TextureChannelClass::SignedInteger => GenericVec4::from_i32([(max_channel_value * 0.8) as i32; 4]),
                    TextureChannelClass::UnsignedInteger => {
                        GenericVec4::from_u32([(max_channel_value * 0.8) as u32; 4])
                    }
                    TextureChannelClass::Last => {
                        return Err(TestError::InternalError(
                            "unused channel case with no channel class".to_string(),
                        ));
                    }
                };

                // `selectComponents`: the effective colour where the format has the channel, the other one elsewhere
                let border_color = GenericVec4::from_u32(std::array::from_fn(|c| {
                    if channel_mask[c] {
                        effective_colors.0[c]
                    } else {
                        non_effective_colors.0[c]
                    }
                }));

                iterations.push(IterationConfig {
                    p0: [-0.25, -0.75],
                    p1: [2.25, 1.25],
                    border_color,
                    lookup_scale: info.look_up_scale,
                    lookup_bias: info.look_up_bias,
                    min_filter: glw::GL_NEAREST,
                    mag_filter: glw::GL_NEAREST,
                    s_wrap: glw::GL_CLAMP_TO_BORDER,
                    t_wrap: glw::GL_CLAMP_TO_BORDER,
                    compare_mode: glw::GL_NONE,
                    compare_ref: 0.0,
                    description: "Setting values to unused border color components".to_string(),
                });
            }
        }

        Ok(iterations)
    }

    /// `genSamplerParams`
    fn gen_sampler_params(
        &self,
        config: &IterationConfig,
        tex_format: TextureFormat,
    ) -> Result<ReferenceParams, TestError> {
        let mut sampler = Sampler::clamp_to_edge(map_gl_filter(config.min_filter)?);
        sampler.wrap_s = map_gl_wrap(config.s_wrap)?;
        sampler.wrap_t = map_gl_wrap(config.t_wrap)?;
        sampler.normalized_coords = true;
        sampler.seamless_cube_map = false;
        sampler.compare = if !self.use_shadow_sampler() {
            crate::tcu::pixel::CompareMode::None
        } else {
            map_gl_compare_func(config.compare_mode)
        };

        let mut ref_params = ReferenceParams::new(TextureType::Texture2D, sampler, LodMode::Exact);
        ref_params.base.sampler_type = if !self.use_shadow_sampler() {
            get_sampler_type(tex_format)
        } else {
            SamplerType::Shadow
        };
        ref_params.base.color_scale = Vec4::from_array(config.lookup_scale);
        ref_params.base.color_bias = Vec4::from_array(config.lookup_bias);
        ref_params.base.ref_ = config.compare_ref;

        // in gather, weird mapping is most likely an error
        if self.sampling == SamplingFunction::Gather {
            debug_assert!(config.lookup_scale.iter().all(|&v| v == config.lookup_scale[0]));
            debug_assert!(config.lookup_bias.iter().all(|&v| v == config.lookup_bias[0]));
        }

        Ok(ref_params)
    }

    /// `genGatherProgram`
    fn gen_gather_sources(&self, context: &Context, class: TextureChannelClass) -> Result<ProgramSources, TestError> {
        let decl = context.context_type().glsl_version().declaration();
        let vertex = format!(
            "{decl}\n\
             in highp vec4 a_position;\n\
             in highp vec2 a_texcoord;\n\
             out highp vec2 v_texcoord;\n\
             void main()\n\
             {{\n\
             \x20   gl_Position = a_position;\n\
             \x20   v_texcoord = a_texcoord;\n\
             }}\n"
        );

        let (sampler_type, lookup) = if self.use_shadow_sampler() {
            ("sampler2DShadow", "textureGather(u_sampler, v_texcoord, u_ref)")
        } else {
            match class {
                TextureChannelClass::UnsignedFixedPoint
                | TextureChannelClass::SignedFixedPoint
                | TextureChannelClass::FloatingPoint => ("sampler2D", "textureGather(u_sampler, v_texcoord)"),
                TextureChannelClass::SignedInteger => ("isampler2D", "vec4(textureGather(u_sampler, v_texcoord))"),
                TextureChannelClass::UnsignedInteger => ("usampler2D", "vec4(textureGather(u_sampler, v_texcoord))"),
                TextureChannelClass::Last => {
                    return Err(TestError::InternalError(
                        "gather program for a format with no channel class".to_string(),
                    ));
                }
            }
        };
        let ref_uniform = if self.use_shadow_sampler() {
            "uniform highp float u_ref;\n"
        } else {
            ""
        };

        let fragment = format!(
            "{decl}\n\
             uniform highp {sampler_type} u_sampler;\n\
             uniform highp vec4 u_colorScale;\n\
             uniform highp vec4 u_colorBias;\n\
             {ref_uniform}in highp vec2 v_texcoord;\n\
             layout(location=0) out highp vec4 o_color;\n\
             void main()\n\
             {{\n\
             \x20   o_color = {lookup} * u_colorScale + u_colorBias;\n\
             }}\n"
        );

        Ok(ProgramSources::default()
            .with(ShaderType::Vertex, vertex)
            .with(ShaderType::Fragment, fragment))
    }

    /// `logParams`
    fn log_params(&self, config: &IterationConfig, class: TextureChannelClass) {
        log::info!(
            "Rendering full screen quad, tex coords bottom-left: {:?}, top-right {:?}\nBorder color is {}\nTexture lookup bias: {:?}\nTexture lookup scale: {:?}\nFilters: min = {:#x}, mag = {:#x}\nWrap mode: s = {:#x}, t = {:#x}",
            config.p0,
            config.p1,
            border_color_string(class, &config.border_color),
            config.lookup_bias,
            config.lookup_scale,
            config.min_filter,
            config.mag_filter,
            config.s_wrap,
            config.t_wrap
        );

        match self.mode {
            Some(DepthStencilMode::Depth) => log::info!("Depth stencil texture mode is DEPTH_COMPONENT"),
            Some(DepthStencilMode::Stencil) => log::info!("Depth stencil texture mode is STENCIL_INDEX"),
            None => {}
        }

        if config.compare_mode != glw::GL_NONE {
            log::info!(
                "Texture mode is COMPARE_REF_TO_TEXTURE, mode = {:#x}\nCompare reference value = {}",
                config.compare_mode,
                config.compare_ref
            );
        }
    }

    /// `renderTo` + `renderQuad`
    #[allow(clippy::too_many_arguments)]
    fn render_to(
        &self,
        context: &Context,
        texture: &Texture2D<'_>,
        renderer: &mut Option<TextureRenderer<'_>>,
        gather_program: &Option<ShaderProgram<'_>>,
        class: TextureChannelClass,
        config: &IterationConfig,
        sampler_params: &ReferenceParams,
        tex_coord: [f32; 8],
        viewport: RandomViewport,
    ) -> Result<Surface, TestError> {
        let gl = context.gl();
        let mut surface = Surface::new(VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
        let sampler_object;

        // SAFETY: plain state setting on the current context; the pointers handed to the border colour calls outlive them.
        unsafe {
            // Bind to unit 0.
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_2D, texture.gl_texture());

            match self.mode {
                Some(DepthStencilMode::Depth) => gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    glw::GL_DEPTH_COMPONENT as i32,
                ),
                Some(DepthStencilMode::Stencil) => gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_DEPTH_STENCIL_TEXTURE_MODE,
                    glw::GL_STENCIL_INDEX as i32,
                ),
                None => {}
            }

            if config.compare_mode == glw::GL_NONE {
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_MODE, glw::GL_NONE as i32);
                gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_COMPARE_FUNC, glw::GL_ALWAYS as i32);
            } else {
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_TEXTURE_COMPARE_MODE,
                    glw::GL_COMPARE_REF_TO_TEXTURE as i32,
                );
                gl.tex_parameteri(
                    glw::GL_TEXTURE_2D,
                    glw::GL_TEXTURE_COMPARE_FUNC,
                    config.compare_mode as i32,
                );
            }

            match self.state_type {
                StateType::TextureParam => {
                    // Setup filtering and wrap modes.
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, config.s_wrap as i32);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, config.t_wrap as i32);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, config.min_filter as i32);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, config.mag_filter as i32);
                    set_texture_border_color(gl, glw::GL_TEXTURE_2D, class, &config.border_color)?;
                    sampler_object = None;
                }
                StateType::SamplerParam => {
                    let blue: [f32; 4] = [0.0, 0.0, 1.0, 1.0];

                    // Setup filtering and wrap modes to bad values
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_REPEAT as i32);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_REPEAT as i32);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
                    gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
                    // just set some unlikely color
                    gl.tex_parameterfv(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_BORDER_COLOR, blue.as_ptr());

                    // setup sampler to correct values
                    let sampler = GlSampler::new(gl);
                    gl.sampler_parameteri(sampler.name, glw::GL_TEXTURE_WRAP_S, config.s_wrap as i32);
                    gl.sampler_parameteri(sampler.name, glw::GL_TEXTURE_WRAP_T, config.t_wrap as i32);
                    gl.sampler_parameteri(sampler.name, glw::GL_TEXTURE_MIN_FILTER, config.min_filter as i32);
                    gl.sampler_parameteri(sampler.name, glw::GL_TEXTURE_MAG_FILTER, config.mag_filter as i32);
                    set_sampler_border_color(gl, sampler.name, class, &config.border_color)?;
                    gl.bind_sampler(0, sampler.name);
                    sampler_object = Some(sampler);
                }
            }
        }
        glu::expect_no_error(gl, "Set texturing state")?;

        // SAFETY: plain state setting on the current context.
        unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };

        // use TextureRenderer for basic rendering, use custom for gather
        if self.sampling == SamplingFunction::Filter {
            let renderer = renderer
                .as_mut()
                .ok_or_else(|| TestError::InternalError("no texture renderer".to_string()))?;
            renderer.render_quad(0, &tex_coord, &sampler_params.base)?;
        } else {
            let program = gather_program
                .as_ref()
                .ok_or_else(|| TestError::InternalError("no gather program".to_string()))?;
            let position: [f32; 16] = [
                -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
            ];
            let indices: [u16; 6] = [0, 1, 2, 2, 1, 3];
            let vertex_arrays = [
                va::float("a_position", 4, 4, 0, &position),
                va::float("a_texcoord", 2, 4, 0, &tex_coord),
            ];
            let prog = program.program();

            // SAFETY: a program that built; NUL-terminated names against it.
            unsafe {
                gl.use_program(prog);
                gl.uniform_1i(gl.get_uniform_location(prog, c"u_sampler".as_ptr()), 0);
                if self.use_shadow_sampler() {
                    gl.uniform_1f(
                        gl.get_uniform_location(prog, c"u_ref".as_ptr()),
                        sampler_params.base.ref_,
                    );
                }
                gl.uniform_4fv(
                    gl.get_uniform_location(prog, c"u_colorScale".as_ptr()),
                    1,
                    sampler_params.base.color_scale.m_data.as_ptr(),
                );
                gl.uniform_4fv(
                    gl.get_uniform_location(prog, c"u_colorBias".as_ptr()),
                    1,
                    sampler_params.base.color_bias.m_data.as_ptr(),
                );
            }

            glu::draw(&context.render_context, prog, &vertex_arrays, &pr::triangles(&indices))?;
        }

        glu::read_pixels(
            &context.render_context,
            viewport.x,
            viewport.y,
            &mut surface.get_access(),
        )?;
        drop(sampler_object);
        Ok(surface)
    }

    /// `verifyImage`
    #[allow(clippy::too_many_arguments)]
    fn verify_image(
        &self,
        context: &Context,
        level: &ConstPixelBufferAccess<'_>,
        rendered: &Surface,
        config: &IterationConfig,
        sampler_params: &ReferenceParams,
        tex_format: TextureFormat,
        tex_coord: [f32; 8],
        result: &mut ResultCollector,
    ) -> Result<(), TestError> {
        let pixel_format = context.render_target().pixel_format();
        let lod_precision = LodPrecision {
            derivate_bits: 18,
            lod_bits: 5,
        };
        let border = lookup_border(tex_format, &config.border_color);
        #[allow(clippy::needless_late_init)]
        let verification_ok;

        if sampler_params.sampler.compare == crate::tcu::pixel::CompareMode::None {
            let is_nearest_only = sampler_params.sampler.filter == FilterMode::Nearest;
            let is_srgb = tex_format.order.is_srgb();
            let color_error_bits = if is_nearest_only && !is_srgb { 1 } else { 2 };
            let color_bits = get_bits_vec(pixel_format).map(|b| (b - color_error_bits).max(0));
            let threshold = compute_fixed_point_threshold(color_bits);
            let color_scale = sampler_params.base.color_scale.m_data;
            let lookup_precision = LookupPrecision {
                color_threshold: std::array::from_fn(|c| threshold[c] / color_scale[c]),
                coord_bits: [20, 20, 0],
                uvw_bits: [5, 5, 0],
                color_mask: get_compare_mask(pixel_format),
                border_color: border,
            };

            verification_ok = if self.sampling == SamplingFunction::Filter {
                self.verify_texture_sample_result(
                    pixel_format,
                    level,
                    rendered,
                    tex_coord,
                    sampler_params,
                    &lod_precision,
                    &lookup_precision,
                    border,
                )?
            } else {
                self.verify_texture_gather_result(
                    pixel_format,
                    level,
                    rendered,
                    tex_coord,
                    sampler_params,
                    &lookup_precision,
                    border,
                )
            };
        } else {
            let result_bits = (pixel_format.red_bits - 1).max(0);
            let tex_compare_precision = TexComparePrecision {
                coord_bits: [20, 20, 0],
                uvw_bits: [7, 7, 0],
                pcf_bits: 5,
                reference_bits: 16,
                result_bits,
                border_color: config.border_color.as_f32()[0],
            };
            let low_quality_tex_compare_precision = TexComparePrecision {
                coord_bits: [20, 20, 0],
                uvw_bits: [4, 4, 0],
                pcf_bits: 0,
                reference_bits: 16,
                result_bits,
                border_color: config.border_color.as_f32()[0],
            };
            let low_quality_lod_precision = LodPrecision {
                derivate_bits: 18,
                lod_bits: 4,
            };

            verification_ok = if self.sampling == SamplingFunction::Filter {
                self.verify_texture_compare_result(
                    pixel_format,
                    level,
                    rendered,
                    tex_coord,
                    sampler_params,
                    &tex_compare_precision,
                    &low_quality_tex_compare_precision,
                    &lod_precision,
                    &low_quality_lod_precision,
                    border,
                    result,
                )?
            } else {
                self.verify_texture_gather_cmp_result(
                    pixel_format,
                    level,
                    rendered,
                    tex_coord,
                    sampler_params,
                    &tex_compare_precision,
                    &low_quality_tex_compare_precision,
                    border,
                    result,
                )
            };
        }

        if !verification_ok {
            result.fail("Image verification failed");
        }
        Ok(())
    }

    /// `verifyTextureSampleResult`
    #[allow(clippy::too_many_arguments)]
    fn verify_texture_sample_result(
        &self,
        pixel_format: PixelFormat,
        level: &ConstPixelBufferAccess<'_>,
        rendered: &Surface,
        tex_coord: [f32; 8],
        sampler_params: &ReferenceParams,
        lod_precision: &LodPrecision,
        lookup_precision: &LookupPrecision,
        border: [f32; 4],
    ) -> Result<bool, TestError> {
        let mut reference = Surface::new(rendered.get_width(), rendered.get_height());
        let mut error_mask = Surface::new(rendered.get_width(), rendered.get_height());
        let sampler = sampler_params.sampler;

        SurfaceAccess::new(&mut reference, pixel_format).write_with(|access| {
            render_reference_2d(
                access,
                tex_coord,
                sampler_params.base.color_scale.m_data,
                sampler_params.base.color_bias.m_data,
                |s, t| sample_2d(level, sampler.wrap_s, sampler.wrap_t, sampler.filter, border, s, t),
            )
        })?;

        let levels = [level_view(level)];
        let mut num_failed_pixels = compute_texture_lookup_diff_2d(
            &rendered.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            sampler_params,
            lookup_precision,
            lod_precision,
        );

        if num_failed_pixels > 0 {
            num_failed_pixels =
                verify_texture_border_errors(&mut error_mask.get_access(), &tex_coord, sampler_params.base.w);
        }

        if num_failed_pixels > 0 {
            log::error!("ERROR: Result verification failed, got {num_failed_pixels} invalid pixels!");
        }
        Ok(num_failed_pixels == 0)
    }

    /// `verifyTextureCompareResult`
    #[allow(clippy::too_many_arguments)]
    fn verify_texture_compare_result(
        &self,
        pixel_format: PixelFormat,
        level: &ConstPixelBufferAccess<'_>,
        rendered: &Surface,
        tex_coord: [f32; 8],
        sampler_params: &ReferenceParams,
        tex_compare_precision: &TexComparePrecision,
        low_quality_tex_compare_precision: &TexComparePrecision,
        lod_precision: &LodPrecision,
        low_quality_lod_precision: &LodPrecision,
        border: [f32; 4],
        result: &mut ResultCollector,
    ) -> Result<bool, TestError> {
        let color_error_bits = 1;
        let non_shadow_bits = get_bits_vec(pixel_format).map(|b| (b - color_error_bits).max(0));
        let non_shadow_threshold_all = compute_fixed_point_threshold(non_shadow_bits);
        let non_shadow_threshold = [
            non_shadow_threshold_all[1],
            non_shadow_threshold_all[2],
            non_shadow_threshold_all[3],
        ];
        let mut reference = Surface::new(rendered.get_width(), rendered.get_height());
        let mut error_mask = Surface::new(rendered.get_width(), rendered.get_height());
        let sampler = sampler_params.sampler;

        SurfaceAccess::new(&mut reference, pixel_format).write_with(|access| {
            render_reference_2d(
                access,
                tex_coord,
                sampler_params.base.color_scale.m_data,
                sampler_params.base.color_bias.m_data,
                |s, t| {
                    let value = sample_2d_compare(
                        level,
                        sampler.wrap_s,
                        sampler.wrap_t,
                        sampler.filter,
                        border,
                        sampler.compare,
                        sampler_params.base.ref_,
                        s,
                        t,
                    );
                    [value, 0.0, 0.0, 1.0]
                },
            )
        })?;

        let levels = [level_view(level)];
        let mut num_failed_pixels = compute_texture_compare_diff_2d(
            &rendered.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coord,
            sampler_params,
            tex_compare_precision,
            lod_precision,
            non_shadow_threshold,
        );

        if num_failed_pixels > 0 {
            log::warn!("Warning: Verification assuming high-quality PCF filtering failed.");

            num_failed_pixels = compute_texture_compare_diff_2d(
                &rendered.get_const_access(),
                &reference.get_const_access(),
                &mut error_mask.get_access(),
                &levels,
                tex_coord,
                sampler_params,
                low_quality_tex_compare_precision,
                low_quality_lod_precision,
                non_shadow_threshold,
            );

            if num_failed_pixels > 0 {
                num_failed_pixels =
                    verify_texture_border_errors(&mut error_mask.get_access(), &tex_coord, sampler_params.base.w);
            }

            if num_failed_pixels > 0 {
                log::error!("ERROR: Verification against low precision requirements failed, failing test case.");
            } else if result.to_status().code() == TestResult::Pass {
                result.add_result(TestResult::QualityWarning, "Low-quality result".to_string());
            }
        }

        if num_failed_pixels > 0 {
            log::error!("ERROR: Result verification failed, got {num_failed_pixels} invalid pixels!");
        }
        Ok(num_failed_pixels == 0)
    }

    /// `verifyTextureGatherResult`
    #[allow(clippy::too_many_arguments)]
    fn verify_texture_gather_result(
        &self,
        pixel_format: PixelFormat,
        level: &ConstPixelBufferAccess<'_>,
        rendered: &Surface,
        tex_coord_array: [f32; 8],
        sampler_params: &ReferenceParams,
        lookup_precision: &LookupPrecision,
        border: [f32; 4],
    ) -> bool {
        let tex_coords: [[f32; 2]; 4] = std::array::from_fn(|i| [tex_coord_array[i * 2], tex_coord_array[i * 2 + 1]]);
        let fb_colormask = get_color_mask(pixel_format);
        let sampler = sampler_params.sampler;
        let scale = sampler_params.base.color_scale.m_data;
        let bias = sampler_params.base.color_bias.m_data;
        let rendered_access = rendered.get_const_access();
        let mut reference = Surface::new(rendered.get_width(), rendered.get_height());
        let mut error_mask = Surface::new(rendered.get_width(), rendered.get_height());
        let mut num_failed_pixels = 0;

        crate::tcu::pixel::clear(&mut error_mask.get_access(), RGBA::green().to_vec().m_data);

        for py in 0..reference.get_height() {
            for px in 0..reference.get_width() {
                let viewport_coord = [
                    (px as f32 + 0.5) / reference.get_width() as f32,
                    (py as f32 + 0.5) / reference.get_height() as f32,
                ];
                let tex_coord = tri_quad_interpolate(&tex_coords, viewport_coord[0], viewport_coord[1]);
                let reference_value = gather(
                    level,
                    sampler.wrap_s,
                    sampler.wrap_t,
                    border,
                    tex_coord[0],
                    tex_coord[1],
                );
                let reference_pixel: [f32; 4] = std::array::from_fn(|c| reference_value[c] * scale[c] + bias[c]);
                let result_pixel = rendered_access.get_pixel(px as u32, py as u32, 0);
                let result_value: [f32; 4] = std::array::from_fn(|c| (result_pixel[c] - bias[c]) / scale[c]);

                reference.set_pixel(px, py, to_rgba_masked(Vec4::from_array(reference_value), fb_colormask));

                if (0..4).any(|c| {
                    lookup_precision.color_mask[c]
                        && (result_pixel[c] - reference_pixel[c]).abs() > lookup_precision.color_threshold[c]
                }) && !is_gather_offsets_result_valid_2d(
                    level,
                    to_verifier_wrap(sampler.wrap_s),
                    to_verifier_wrap(sampler.wrap_t),
                    true,
                    lookup_precision,
                    tex_coord,
                    0,
                    DEFAULT_GATHER_OFFSETS,
                    result_value,
                ) {
                    error_mask.set_pixel(px, py, RGBA::red());
                    num_failed_pixels += 1;
                }
            }
        }

        if num_failed_pixels > 0 {
            log::error!("ERROR: Result verification failed, got {num_failed_pixels} invalid pixels!");
        }
        num_failed_pixels == 0
    }

    /// `verifyTextureGatherCmpResult`
    #[allow(clippy::too_many_arguments)]
    fn verify_texture_gather_cmp_result(
        &self,
        pixel_format: PixelFormat,
        level: &ConstPixelBufferAccess<'_>,
        rendered: &Surface,
        tex_coord_array: [f32; 8],
        sampler_params: &ReferenceParams,
        tex_compare_precision: &TexComparePrecision,
        low_quality_tex_compare_precision: &TexComparePrecision,
        border: [f32; 4],
        result: &mut ResultCollector,
    ) -> bool {
        let tex_coords: [[f32; 2]; 4] = std::array::from_fn(|i| [tex_coord_array[i * 2], tex_coord_array[i * 2 + 1]]);
        let color_mask = get_compare_mask(pixel_format);
        let fb_colormask = get_color_mask(pixel_format);
        let sampler = sampler_params.sampler;
        let rendered_access = rendered.get_const_access();
        let mut reference = Surface::new(rendered.get_width(), rendered.get_height());
        let mut error_mask = Surface::new(rendered.get_width(), rendered.get_height());
        let mut num_failed_pixels = 0;
        let mut low_quality = false;

        crate::tcu::pixel::clear(&mut error_mask.get_access(), RGBA::green().to_vec().m_data);

        for py in 0..reference.get_height() {
            for px in 0..reference.get_width() {
                let viewport_coord = [
                    (px as f32 + 0.5) / reference.get_width() as f32,
                    (py as f32 + 0.5) / reference.get_height() as f32,
                ];
                let tex_coord = tri_quad_interpolate(&tex_coords, viewport_coord[0], viewport_coord[1]);
                let ref_z = sampler_params.base.ref_;
                let reference_value = gather_compare(
                    level,
                    sampler.wrap_s,
                    sampler.wrap_t,
                    border,
                    sampler.compare,
                    ref_z,
                    tex_coord[0],
                    tex_coord[1],
                );
                let result_value = rendered_access.get_pixel(px as u32, py as u32, 0);

                reference.set_pixel(px, py, to_rgba_masked(Vec4::from_array(reference_value), fb_colormask));

                if (0..4).any(|c| color_mask[c] && reference_value[c] != result_value[c]) {
                    let wrap_s = to_verifier_wrap(sampler.wrap_s);
                    let wrap_t = to_verifier_wrap(sampler.wrap_t);

                    if !is_gather_offsets_compare_result_valid_2d(
                        level,
                        &sampler,
                        wrap_s,
                        wrap_t,
                        tex_compare_precision,
                        tex_coord,
                        DEFAULT_GATHER_OFFSETS,
                        ref_z,
                        result_value,
                    ) {
                        low_quality = true;

                        // fall back to low quality verification
                        if !is_gather_offsets_compare_result_valid_2d(
                            level,
                            &sampler,
                            wrap_s,
                            wrap_t,
                            low_quality_tex_compare_precision,
                            tex_coord,
                            DEFAULT_GATHER_OFFSETS,
                            ref_z,
                            result_value,
                        ) {
                            error_mask.set_pixel(px, py, RGBA::red());
                            num_failed_pixels += 1;
                        }
                    }
                }
            }
        }

        if num_failed_pixels > 0 {
            log::error!("ERROR: Result verification failed, got {num_failed_pixels} invalid pixels!");
        } else if low_quality {
            log::warn!("Warning: Verification assuming high-quality PCF filtering failed.");
            result.add_result(TestResult::QualityWarning, "Low-quality result".to_string());
        }
        num_failed_pixels == 0
    }
}

impl TestCase for BorderClampCase2D {
    fn name(&self) -> &str {
        &self.name
    }

    /// The prerequisite half of `TextureBorderClampTest::init`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let supports_es32 = context.context_type().supports(3, 2);
        let info = &context.context_info;
        let is_texture_float_linear_supported = info.is_extension_supported("GL_OES_texture_float_linear");
        let core_filterable = is_core_filterable_format(self.tex_format, self.mode, is_texture_float_linear_supported);

        if (self.flags & FLAG_TEST_FLOAT_FILTERABLE) != 0
            && !core_filterable
            && filter_requires_filterability(self.filter)
        {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_texture_float_linear extension".to_string(),
            ));
        }

        if !supports_es32 && !info.is_extension_supported("GL_EXT_texture_border_clamp") {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_border_clamp extension".to_string(),
            ));
        }

        let is_astc = map_gl_compressed_tex_format(self.tex_format).is_some_and(is_astc_format);
        if is_astc && !supports_es32 && !info.is_extension_supported("GL_KHR_texture_compression_astc_ldr") {
            return Err(TestError::NotSupported(
                "Test requires GL_KHR_texture_compression_astc_ldr extension".to_string(),
            ));
        }

        if self.tex_format == glw::GL_BGRA && !info.is_extension_supported("GL_EXT_texture_format_BGRA8888") {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_format_BGRA8888 extension".to_string(),
            ));
        }

        let render_target = context.render_target();
        if render_target.width < VIEWPORT_WIDTH || render_target.height < VIEWPORT_HEIGHT {
            return Err(TestError::NotSupported(format!(
                "Test requires {VIEWPORT_WIDTH}x{VIEWPORT_HEIGHT} viewport"
            )));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();

        // resources
        let texture = gen_default_texture_2d(context, self.tex_format, self.tex_width as u32, self.tex_height as u32)?;
        let class = format_channel_class(self.tex_format, self.mode)?;
        let tex_format = effective_format(texture.ref_texture().format(), self.mode);

        log::info!(
            "Created texture with format {:#x}, size ({}, {})\nSetting sampling state using {}",
            self.tex_format,
            self.tex_width,
            self.tex_height,
            if self.state_type == StateType::TextureParam {
                "texture state"
            } else {
                "sampler state"
            }
        );

        let mut renderer: Option<TextureRenderer<'_>> = None;
        let mut gather_program: Option<ShaderProgram<'_>> = None;

        if self.sampling == SamplingFunction::Filter {
            renderer = Some(TextureRenderer::new(
                render_ctx,
                context.context_type().glsl_version(),
                Precision::HighP,
            ));
        } else {
            let program = ShaderProgram::new(gl, &self.gen_gather_sources(context, class)?);
            log::info!("Using texture gather to sample texture");
            if !program.is_ok() {
                return Err(TestError::Fail("failed to build program".to_string()));
            }
            gather_program = Some(program);
        }

        let iterations = self.generate_iterations(tex_format, class)?;
        let mut result = ResultCollector::new("");

        for (iteration_ndx, config) in iterations.iter().enumerate() {
            let sampler_params = self.gen_sampler_params(config, tex_format)?;
            let viewport = RandomViewport::new(
                &render_target,
                VIEWPORT_WIDTH,
                VIEWPORT_HEIGHT,
                self.iteration_seed(iteration_ndx, config),
            );
            let tex_coord = compute_quad_tex_coord_2d(
                Vec2::new(config.p0[0], config.p0[1]),
                Vec2::new(config.p1[0], config.p1[1]),
            );

            log::info!(
                "Iteration {}{}",
                iteration_ndx + 1,
                if config.description.is_empty() {
                    String::new()
                } else {
                    format!(" - {}", config.description)
                }
            );
            self.log_params(config, class);

            let rendered = self.render_to(
                context,
                &texture,
                &mut renderer,
                &gather_program,
                class,
                config,
                &sampler_params,
                tex_coord,
                viewport,
            )?;

            let base = texture.ref_texture().level(0);
            let level = get_effective_depth_stencil_access(&base, self.mode.unwrap_or(DepthStencilMode::Depth));
            self.verify_image(
                context,
                &level,
                &rendered,
                config,
                &sampler_params,
                tex_format,
                tex_coord,
                &mut result,
            )?;
        }

        Ok(result.to_status())
    }
}

/// `TextureBorderClampPerAxisCase3D`
struct BorderClampCase3D {
    name: String,
    tex_format: GLenum,
    size: [u32; 3],
    filter: GLenum,
    s_wrap: GLenum,
    t_wrap: GLenum,
    r_wrap: GLenum,
}

impl BorderClampCase3D {
    /// `getCaseSeed`
    fn case_seed(&self) -> u32 {
        de_string_hash(&self.name)
            .wrapping_mul(31)
            .wrapping_add(self.tex_format)
            .wrapping_mul(31)
            .wrapping_add(self.filter)
            .wrapping_mul(31)
            .wrapping_add(self.s_wrap)
            .wrapping_mul(31)
            .wrapping_add(self.t_wrap)
            .wrapping_mul(31)
            .wrapping_add(self.r_wrap)
            .wrapping_mul(31)
            .wrapping_add(self.size[0])
            .wrapping_mul(31)
            .wrapping_add(self.size[1])
            .wrapping_mul(31)
            .wrapping_add(self.size[2])
    }
}

impl TestCase for BorderClampCase3D {
    fn name(&self) -> &str {
        &self.name
    }

    /// The prerequisite half of `TextureBorderClampPerAxisCase3D::init`.
    fn check_support(&self, context: &Context) -> Result<(), TestError> {
        let supports_es32 = context.context_type().supports(3, 2);
        let info = &context.context_info;
        let is_texture_float_linear_supported = info.is_extension_supported("GL_OES_texture_float_linear");
        let core_filterable = is_core_filterable_format(self.tex_format, None, is_texture_float_linear_supported);

        if !core_filterable && filter_requires_filterability(self.filter) {
            return Err(TestError::NotSupported(
                "Test requires GL_OES_texture_float_linear extension".to_string(),
            ));
        }

        if !supports_es32 && !info.is_extension_supported("GL_EXT_texture_border_clamp") {
            return Err(TestError::NotSupported(
                "Test requires GL_EXT_texture_border_clamp extension".to_string(),
            ));
        }

        let render_target = context.render_target();
        if render_target.width < VIEWPORT_WIDTH || render_target.height < VIEWPORT_HEIGHT {
            return Err(TestError::NotSupported(format!(
                "Test requires {VIEWPORT_WIDTH}x{VIEWPORT_HEIGHT} viewport"
            )));
        }
        Ok(())
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let render_ctx = &context.render_context;
        let gl = context.gl();
        let render_target = context.render_target();
        let pixel_format = render_target.pixel_format();

        // resources
        let texture = gen_default_texture_3d(context, self.tex_format, self.size)?;
        let mut renderer = TextureRenderer::new(render_ctx, context.context_type().glsl_version(), Precision::HighP);
        let tex_format = texture.ref_texture().format();
        let info = get_texture_format_info(tex_format);
        let class = format_channel_class(self.tex_format, None)?;

        log::info!(
            "Created 3D texture with format {:#x}, size {:?}",
            self.tex_format,
            self.size
        );

        // tex coord
        log::info!("Setting tex coords bottom-left: (-1, -1, -1.5), top-right (2, 2, 2.5)");
        let tex_coords: [f32; 12] = [-1.0, -1.0, -1.5, -1.0, 2.0, 0.5, 2.0, -1.0, 0.5, 2.0, 2.0, 2.5];

        // set render params
        let border_color = map_to_format_color_representable(tex_format, [0.2, 0.6, 0.9, 0.4])?;
        let lookup_scale = info.look_up_scale;
        let lookup_bias = info.look_up_bias;

        let mut sampler = Sampler::clamp_to_edge(map_gl_filter(self.filter)?);
        sampler.wrap_s = map_gl_wrap(self.s_wrap)?;
        sampler.wrap_t = map_gl_wrap(self.t_wrap)?;
        sampler.wrap_r = map_gl_wrap(self.r_wrap)?;
        sampler.normalized_coords = true;
        sampler.seamless_cube_map = false;
        let mut sampler_params = ReferenceParams::new(TextureType::Texture3D, sampler, LodMode::Exact);
        sampler_params.base.sampler_type = get_sampler_type(tex_format);
        sampler_params.base.color_scale = Vec4::from_array(lookup_scale);
        sampler_params.base.color_bias = Vec4::from_array(lookup_bias);

        log::info!(
            "Border color is {}\nTexture lookup bias: {:?}\nTexture lookup scale: {:?}\nFilter: {:#x}\nWrap mode: s = {:#x}, t = {:#x}, r = {:#x}",
            border_color_string(class, &border_color),
            lookup_bias,
            lookup_scale,
            self.filter,
            self.s_wrap,
            self.t_wrap,
            self.r_wrap
        );

        // renderTo
        let viewport = RandomViewport::new(&render_target, VIEWPORT_WIDTH, VIEWPORT_HEIGHT, self.case_seed());
        let mut rendered = Surface::new(VIEWPORT_WIDTH, VIEWPORT_HEIGHT);

        // SAFETY: plain state setting on the current context; the pointers handed to the border colour call outlive it.
        unsafe {
            // Bind to unit 0.
            gl.active_texture(glw::GL_TEXTURE0);
            gl.bind_texture(glw::GL_TEXTURE_3D, texture.gl_texture());

            // Setup filtering and wrap modes.
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_S, self.s_wrap as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_T, self.t_wrap as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_WRAP_R, self.r_wrap as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MIN_FILTER, self.filter as i32);
            gl.tex_parameteri(glw::GL_TEXTURE_3D, glw::GL_TEXTURE_MAG_FILTER, self.filter as i32);
            set_texture_border_color(gl, glw::GL_TEXTURE_3D, class, &border_color)?;
        }
        glu::expect_no_error(gl, "Set texturing state")?;

        // SAFETY: plain state setting on the current context.
        unsafe { gl.viewport(viewport.x, viewport.y, viewport.width, viewport.height) };
        renderer.render_quad(0, &tex_coords, &sampler_params.base)?;
        glu::read_pixels(render_ctx, viewport.x, viewport.y, &mut rendered.get_access())?;

        // verifyImage
        let color_error_bits = 2;
        let color_bits = get_bits_vec(pixel_format).map(|b| (b - color_error_bits).max(0));
        let threshold = compute_fixed_point_threshold(color_bits);
        let lod_precision = LodPrecision {
            derivate_bits: 18,
            lod_bits: 5,
        };
        let lookup_precision = LookupPrecision {
            color_threshold: std::array::from_fn(|c| threshold[c] / lookup_scale[c]),
            coord_bits: [20, 20, 0],
            uvw_bits: [5, 5, 0],
            color_mask: get_compare_mask(pixel_format),
            border_color: lookup_border(tex_format, &border_color),
        };
        let border = lookup_precision.border_color;
        let wraps = [sampler.wrap_s, sampler.wrap_t, sampler.wrap_r];
        let level = texture.ref_texture().level(0);
        let mut reference = Surface::new(rendered.get_width(), rendered.get_height());
        let mut error_mask = Surface::new(rendered.get_width(), rendered.get_height());

        SurfaceAccess::new(&mut reference, pixel_format).write_with(|access| {
            render_reference_3d(access, tex_coords, lookup_scale, lookup_bias, |s, t, r| {
                sample_3d(&level, wraps, sampler.filter, border, s, t, r)
            })
        })?;

        let levels = [level_view(&level)];
        let mut num_failed_pixels = compute_texture_lookup_diff_3d(
            &rendered.get_const_access(),
            &reference.get_const_access(),
            &mut error_mask.get_access(),
            &levels,
            tex_coords,
            &sampler_params,
            &lookup_precision,
            &lod_precision,
        );

        if num_failed_pixels > 0 {
            num_failed_pixels =
                verify_texture_border_errors(&mut error_mask.get_access(), &tex_coords, sampler_params.base.w);
        }

        if num_failed_pixels > 0 {
            log::error!("ERROR: Result verification failed, got {num_failed_pixels} invalid pixels!");
            Ok(crate::tcu::TestStatus::fail("Image verification failed"))
        } else {
            Ok(crate::tcu::TestStatus::pass("Pass"))
        }
    }
}

/// `{name, GL internal format, depth/stencil mode}` rows of the upstream tables
type FormatRow = (&'static str, GLenum, SampleMode);

const NONE: SampleMode = None;
const DEPTH: SampleMode = Some(DepthStencilMode::Depth);
const STENCIL: SampleMode = Some(DepthStencilMode::Stencil);

/// `s_filters`
const FILTERS: [(&str, GLenum, SamplingFunction); 3] = [
    ("nearest", glw::GL_NEAREST, SamplingFunction::Filter),
    ("linear", glw::GL_LINEAR, SamplingFunction::Filter),
    ("gather", glw::GL_NEAREST, SamplingFunction::Gather),
];

#[allow(clippy::too_many_arguments)]
fn case_2d(
    name: &str,
    kind: CaseKind,
    format: GLenum,
    mode: SampleMode,
    state_type: StateType,
    size: (i32, i32),
    sampling: SamplingFunction,
    filter: GLenum,
    flags: u32,
) -> Box<dyn TestCase> {
    Box::new(BorderClampCase2D {
        name: name.to_string(),
        kind,
        tex_format: format,
        mode,
        state_type,
        tex_width: size.0,
        tex_height: size.1,
        sampling,
        filter,
        flags,
    })
}

fn create_formats_group() -> TestCaseGroup {
    const FORMATS: &[FormatRow] = &[
        ("luminance", glw::GL_LUMINANCE, NONE),
        ("alpha", glw::GL_ALPHA, NONE),
        ("luminance_alpha", glw::GL_LUMINANCE_ALPHA, NONE),
        ("bgra", glw::GL_BGRA, NONE),
        ("r8", glw::GL_R8, NONE),
        ("r8_snorm", glw::GL_R8_SNORM, NONE),
        ("rg8", glw::GL_RG8, NONE),
        ("rg8_snorm", glw::GL_RG8_SNORM, NONE),
        ("rgb8", glw::GL_RGB8, NONE),
        ("rgb8_snorm", glw::GL_RGB8_SNORM, NONE),
        ("rgb565", glw::GL_RGB565, NONE),
        ("rgba4", glw::GL_RGBA4, NONE),
        ("rgb5_a1", glw::GL_RGB5_A1, NONE),
        ("rgba8", glw::GL_RGBA8, NONE),
        ("rgba8_snorm", glw::GL_RGBA8_SNORM, NONE),
        ("rgb10_a2", glw::GL_RGB10_A2, NONE),
        ("rgb10_a2ui", glw::GL_RGB10_A2UI, NONE),
        ("srgb8", glw::GL_SRGB8, NONE),
        ("srgb8_alpha8", glw::GL_SRGB8_ALPHA8, NONE),
        ("r16f", glw::GL_R16F, NONE),
        ("rg16f", glw::GL_RG16F, NONE),
        ("rgb16f", glw::GL_RGB16F, NONE),
        ("rgba16f", glw::GL_RGBA16F, NONE),
        ("r32f", glw::GL_R32F, NONE),
        ("rg32f", glw::GL_RG32F, NONE),
        ("rgb32f", glw::GL_RGB32F, NONE),
        ("rgba32f", glw::GL_RGBA32F, NONE),
        ("r11f_g11f_b10f", glw::GL_R11F_G11F_B10F, NONE),
        ("rgb9_e5", glw::GL_RGB9_E5, NONE),
        ("r8i", glw::GL_R8I, NONE),
        ("r8ui", glw::GL_R8UI, NONE),
        ("r16i", glw::GL_R16I, NONE),
        ("r16ui", glw::GL_R16UI, NONE),
        ("r32i", glw::GL_R32I, NONE),
        ("r32ui", glw::GL_R32UI, NONE),
        ("rg8i", glw::GL_RG8I, NONE),
        ("rg8ui", glw::GL_RG8UI, NONE),
        ("rg16i", glw::GL_RG16I, NONE),
        ("rg16ui", glw::GL_RG16UI, NONE),
        ("rg32i", glw::GL_RG32I, NONE),
        ("rg32ui", glw::GL_RG32UI, NONE),
        ("rgb8i", glw::GL_RGB8I, NONE),
        ("rgb8ui", glw::GL_RGB8UI, NONE),
        ("rgb16i", glw::GL_RGB16I, NONE),
        ("rgb16ui", glw::GL_RGB16UI, NONE),
        ("rgb32i", glw::GL_RGB32I, NONE),
        ("rgb32ui", glw::GL_RGB32UI, NONE),
        ("rgba8i", glw::GL_RGBA8I, NONE),
        ("rgba8ui", glw::GL_RGBA8UI, NONE),
        ("rgba16i", glw::GL_RGBA16I, NONE),
        ("rgba16ui", glw::GL_RGBA16UI, NONE),
        ("rgba32i", glw::GL_RGBA32I, NONE),
        ("rgba32ui", glw::GL_RGBA32UI, NONE),
        ("depth_component16", glw::GL_DEPTH_COMPONENT16, DEPTH),
        ("depth_component24", glw::GL_DEPTH_COMPONENT24, DEPTH),
        ("depth_component32f", glw::GL_DEPTH_COMPONENT32F, DEPTH),
        ("stencil_index8", glw::GL_STENCIL_INDEX8, STENCIL),
        ("depth24_stencil8_sample_depth", glw::GL_DEPTH24_STENCIL8, DEPTH),
        ("depth32f_stencil8_sample_depth", glw::GL_DEPTH32F_STENCIL8, DEPTH),
        ("depth24_stencil8_sample_stencil", glw::GL_DEPTH24_STENCIL8, STENCIL),
        ("depth32f_stencil8_sample_stencil", glw::GL_DEPTH32F_STENCIL8, STENCIL),
        ("compressed_r11_eac", glw::GL_COMPRESSED_R11_EAC, NONE),
        ("compressed_signed_r11_eac", glw::GL_COMPRESSED_SIGNED_R11_EAC, NONE),
        ("compressed_rg11_eac", glw::GL_COMPRESSED_RG11_EAC, NONE),
        ("compressed_signed_rg11_eac", glw::GL_COMPRESSED_SIGNED_RG11_EAC, NONE),
        ("compressed_rgb8_etc2", glw::GL_COMPRESSED_RGB8_ETC2, NONE),
        ("compressed_srgb8_etc2", glw::GL_COMPRESSED_SRGB8_ETC2, NONE),
        (
            "compressed_rgb8_punchthrough_alpha1_etc2",
            glw::GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2,
            NONE,
        ),
        (
            "compressed_srgb8_punchthrough_alpha1_etc2",
            glw::GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2,
            NONE,
        ),
        ("compressed_rgba8_etc2_eac", glw::GL_COMPRESSED_RGBA8_ETC2_EAC, NONE),
        (
            "compressed_srgb8_alpha8_etc2_eac",
            glw::GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC,
            NONE,
        ),
    ];

    let mut formats_group = TestCaseGroup::new("formats");

    // .format
    for &(format_name, format, sample_mode) in FORMATS.iter() {
        let is_compressed = is_compressed_format(format);
        let core_filterable = is_core_filterable_format(format, sample_mode, true);
        let mut format_group = TestCaseGroup::new(format_name);

        // .nearest .linear .gather
        for &(filter_name, filter, sampling) in FILTERS.iter() {
            // [not-compressed] .size_pot .size_npot  [compressed] .size_tile_multiple (also pot) .size_not_tile_multiple (also npot)
            for size_type in [SizeType::Pot, SizeType::Npot] {
                let is_npot_case = size_type == SizeType::Npot;
                let size_name = match (is_compressed, is_npot_case) {
                    (false, false) => "size_pot",
                    (false, true) => "size_npot",
                    (true, false) => "size_tile_multiple",
                    (true, true) => "size_not_tile_multiple",
                };
                let case_name = format!("{filter_name}_{size_name}");
                let size = if is_npot_case { (17, 31) } else { (32, 16) };

                if core_filterable || !filter_requires_filterability(filter) {
                    format_group.add_child(case_2d(
                        &case_name,
                        CaseKind::Format,
                        format,
                        sample_mode,
                        StateType::TextureParam,
                        size,
                        sampling,
                        filter,
                        FLAG_TEST_FLOAT_FILTERABLE,
                    ));
                }
            }
        }

        formats_group.add_child(format_group);
    }
    formats_group
}

fn create_range_clamp_group() -> TestCaseGroup {
    const FORMATS: &[FormatRow] = &[
        ("unorm_color", glw::GL_R8, NONE),
        ("snorm_color", glw::GL_R8_SNORM, NONE),
        ("float_color", glw::GL_RG32F, NONE),
        ("int_color", glw::GL_R8I, NONE),
        ("uint_color", glw::GL_R16UI, NONE),
        ("srgb_color", glw::GL_SRGB8_ALPHA8, NONE),
        ("unorm_depth", glw::GL_DEPTH_COMPONENT24, DEPTH),
        ("float_depth", glw::GL_DEPTH_COMPONENT32F, DEPTH),
        ("uint_stencil", glw::GL_STENCIL_INDEX8, STENCIL),
        (
            "float_depth_uint_stencil_sample_depth",
            glw::GL_DEPTH32F_STENCIL8,
            DEPTH,
        ),
        (
            "float_depth_uint_stencil_sample_stencil",
            glw::GL_DEPTH32F_STENCIL8,
            STENCIL,
        ),
        ("unorm_depth_uint_stencil_sample_depth", glw::GL_DEPTH24_STENCIL8, DEPTH),
        (
            "unorm_depth_uint_stencil_sample_stencil",
            glw::GL_DEPTH24_STENCIL8,
            STENCIL,
        ),
        ("compressed_color", glw::GL_COMPRESSED_RG11_EAC, NONE),
    ];

    let mut range_clamp_group = TestCaseGroup::new("range_clamp");

    for &(format_name, format, sample_mode) in FORMATS.iter() {
        for &(filter_name, filter, sampling) in FILTERS.iter() {
            let case_name = format!("{filter_name}_{format_name}");
            let core_filterable = is_core_filterable_format(format, sample_mode, true);

            if sampling == SamplingFunction::Gather {
                continue;
            }

            if core_filterable || !filter_requires_filterability(filter) {
                range_clamp_group.add_child(case_2d(
                    &case_name,
                    CaseKind::RangeClamp,
                    format,
                    sample_mode,
                    StateType::TextureParam,
                    (8, 32),
                    SamplingFunction::Filter,
                    filter,
                    FLAG_TEST_FLOAT_FILTERABLE,
                ));
            }
        }
    }
    range_clamp_group
}

fn create_sampler_group() -> TestCaseGroup {
    const FORMATS: &[FormatRow] = &[
        ("unorm_color", glw::GL_R8, NONE),
        ("snorm_color", glw::GL_R8_SNORM, NONE),
        ("float_color", glw::GL_RG32F, NONE),
        ("int_color", glw::GL_R8I, NONE),
        ("uint_color", glw::GL_R16UI, NONE),
        ("unorm_depth", glw::GL_DEPTH_COMPONENT24, DEPTH),
        ("float_depth", glw::GL_DEPTH_COMPONENT32F, DEPTH),
        ("uint_stencil", glw::GL_STENCIL_INDEX8, STENCIL),
        ("compressed_color", glw::GL_COMPRESSED_RG11_EAC, NONE),
    ];

    let mut sampler_group = TestCaseGroup::new("sampler");

    for &(case_name, format, sample_mode) in FORMATS.iter() {
        sampler_group.add_child(case_2d(
            case_name,
            CaseKind::Format,
            format,
            sample_mode,
            StateType::SamplerParam,
            (32, 16),
            SamplingFunction::Filter,
            glw::GL_NEAREST,
            FLAG_TEST_FLOAT_FILTERABLE,
        ));
    }
    sampler_group
}

fn create_per_axis_group() -> TestCaseGroup {
    struct PerAxisFormat {
        name: &'static str,
        format: GLenum,
        mode: SampleMode,
        supports_3d: bool,
    }
    const fn pf(name: &'static str, format: GLenum, mode: SampleMode, supports_3d: bool) -> PerAxisFormat {
        PerAxisFormat {
            name,
            format,
            mode,
            supports_3d,
        }
    }
    struct WrapConfig {
        name: &'static str,
        s_wrap: GLenum,
        t_wrap: GLenum,
        r_wrap: GLenum,
        is_3d: bool,
    }
    const fn wc(name: &'static str, s_wrap: GLenum, t_wrap: GLenum, r_wrap: GLenum, is_3d: bool) -> WrapConfig {
        WrapConfig {
            name,
            s_wrap,
            t_wrap,
            r_wrap,
            is_3d,
        }
    }

    const TARGETS: [(&str, bool); 2] = [("texture_2d", false), ("texture_3d", true)];
    const FORMATS: &[PerAxisFormat] = &[
        pf("unorm_color", glw::GL_RG8, NONE, true),
        pf("snorm_color", glw::GL_RG8_SNORM, NONE, true),
        pf("float_color", glw::GL_R32F, NONE, true),
        pf("int_color", glw::GL_RG16I, NONE, true),
        pf("uint_color", glw::GL_R8UI, NONE, true),
        pf("unorm_depth", glw::GL_DEPTH_COMPONENT16, DEPTH, false),
        pf("float_depth", glw::GL_DEPTH32F_STENCIL8, DEPTH, false),
        pf("uint_stencil", glw::GL_DEPTH32F_STENCIL8, STENCIL, false),
        pf("compressed_color", glw::GL_COMPRESSED_RGB8_ETC2, NONE, false),
    ];
    const WRAP_CONFIGS: &[WrapConfig] = &[
        // 2d configs
        wc(
            "s_clamp_to_edge_t_clamp_to_border",
            glw::GL_CLAMP_TO_EDGE,
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_NONE,
            false,
        ),
        wc(
            "s_repeat_t_clamp_to_border",
            glw::GL_REPEAT,
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_NONE,
            false,
        ),
        wc(
            "s_mirrored_repeat_t_clamp_to_border",
            glw::GL_MIRRORED_REPEAT,
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_NONE,
            false,
        ),
        // 3d configs
        wc(
            "s_clamp_to_border_t_clamp_to_border_r_clamp_to_border",
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_CLAMP_TO_BORDER,
            true,
        ),
        wc(
            "s_clamp_to_border_t_clamp_to_border_r_repeat",
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_REPEAT,
            true,
        ),
        wc(
            "s_mirrored_repeat_t_clamp_to_border_r_repeat",
            glw::GL_MIRRORED_REPEAT,
            glw::GL_CLAMP_TO_BORDER,
            glw::GL_REPEAT,
            true,
        ),
        wc(
            "s_repeat_t_mirrored_repeat_r_clamp_to_border",
            glw::GL_REPEAT,
            glw::GL_MIRRORED_REPEAT,
            glw::GL_CLAMP_TO_BORDER,
            true,
        ),
    ];

    let mut per_axis_group = TestCaseGroup::new("per_axis_wrap_mode");

    // .texture_nd
    for &(target_name, is_3d) in TARGETS.iter() {
        let mut target_group = TestCaseGroup::new(target_name);

        // .format
        for format in FORMATS.iter() {
            if is_3d && !format.supports_3d {
                continue;
            }

            let core_filterable = is_core_filterable_format(format.format, format.mode, true);
            let mut format_group = TestCaseGroup::new(format.name);

            // .linear .nearest .gather
            for &(filter_name, filter, sampling) in FILTERS.iter() {
                if !core_filterable && filter_requires_filterability(filter) {
                    // skip linear on pure integers
                    continue;
                } else if sampling == SamplingFunction::Gather && is_3d {
                    // skip gather on 3d
                    continue;
                }

                let mut filtering_group = TestCaseGroup::new(filter_name);

                // .s_XXX_t_XXX(_r_XXX)
                for wrap_config in WRAP_CONFIGS.iter() {
                    if wrap_config.is_3d != is_3d {
                        continue;
                    }

                    for size_type in [SizeType::Pot, SizeType::Npot] {
                        let is_npot_case = size_type == SizeType::Npot;
                        let size_name_extension = if is_npot_case { "_npot" } else { "_pot" };
                        let case_name = format!("{}{}", wrap_config.name, size_name_extension);

                        if !is_3d {
                            let size = if is_npot_case { (7, 9) } else { (16, 8) };
                            filtering_group.add_child(case_2d(
                                &case_name,
                                CaseKind::PerAxis {
                                    s_wrap: wrap_config.s_wrap,
                                    t_wrap: wrap_config.t_wrap,
                                },
                                format.format,
                                format.mode,
                                StateType::TextureParam,
                                size,
                                sampling,
                                filter,
                                FLAG_TEST_FLOAT_FILTERABLE,
                            ));
                        } else {
                            let size = if is_npot_case { [13, 5, 7] } else { [8, 16, 4] };
                            filtering_group.add_child(Box::new(BorderClampCase3D {
                                name: case_name,
                                tex_format: format.format,
                                size,
                                filter,
                                s_wrap: wrap_config.s_wrap,
                                t_wrap: wrap_config.t_wrap,
                                r_wrap: wrap_config.r_wrap,
                            }) as Box<dyn TestCase>);
                        }
                    }
                }

                format_group.add_child(filtering_group);
            }

            target_group.add_child(format_group);
        }

        per_axis_group.add_child(target_group);
    }
    per_axis_group
}

fn create_depth_compare_group() -> TestCaseGroup {
    const FORMATS: &[(&str, GLenum)] = &[
        ("depth_component16", glw::GL_DEPTH_COMPONENT16),
        ("depth_component24", glw::GL_DEPTH_COMPONENT24),
        ("depth24_stencil8", glw::GL_DEPTH24_STENCIL8),
        ("depth32f_stencil8", glw::GL_DEPTH32F_STENCIL8),
    ];

    let mut compare_group = TestCaseGroup::new("depth_compare_mode");

    for &(format_name, format) in FORMATS.iter() {
        let mut format_group = TestCaseGroup::new(format_name);

        // (format).(linear|nearest|gather)_(pot|npot)
        for &(filter_name, filter, sampling) in FILTERS.iter() {
            for size_type in [SizeType::Pot, SizeType::Npot] {
                let is_npot_case = size_type == SizeType::Npot;
                let size_name = if is_npot_case { "size_npot" } else { "size_pot" };
                let case_name = format!("{filter_name}_{size_name}");
                let size = if is_npot_case { (13, 17) } else { (32, 16) };

                format_group.add_child(case_2d(
                    &case_name,
                    CaseKind::DepthCompare,
                    format,
                    DEPTH,
                    StateType::TextureParam,
                    size,
                    sampling,
                    filter,
                    FLAG_USE_SHADOW_SAMPLER,
                ));
            }
        }

        compare_group.add_child(format_group);
    }
    compare_group
}

fn create_unused_channels_group() -> TestCaseGroup {
    const FORMATS: &[FormatRow] = &[
        ("r8", glw::GL_R8, NONE),
        ("rg8_snorm", glw::GL_RG8_SNORM, NONE),
        ("rgb8", glw::GL_RGB8, NONE),
        ("rg32f", glw::GL_RG32F, NONE),
        ("r16i", glw::GL_RG16I, NONE),
        ("luminance", glw::GL_LUMINANCE, NONE),
        ("alpha", glw::GL_ALPHA, NONE),
        ("luminance_alpha", glw::GL_LUMINANCE_ALPHA, NONE),
        ("depth_component16", glw::GL_DEPTH_COMPONENT16, DEPTH),
        ("depth_component32f", glw::GL_DEPTH_COMPONENT32F, DEPTH),
        ("stencil_index8", glw::GL_STENCIL_INDEX8, STENCIL),
        ("depth32f_stencil8_sample_depth", glw::GL_DEPTH32F_STENCIL8, DEPTH),
        ("depth32f_stencil8_sample_stencil", glw::GL_DEPTH32F_STENCIL8, STENCIL),
        ("depth24_stencil8_sample_depth", glw::GL_DEPTH24_STENCIL8, DEPTH),
        ("depth24_stencil8_sample_stencil", glw::GL_DEPTH24_STENCIL8, STENCIL),
        ("compressed_r11_eac", glw::GL_COMPRESSED_R11_EAC, NONE),
    ];

    let mut unused_group = TestCaseGroup::new("unused_channels");

    for &(name, format, mode) in FORMATS.iter() {
        unused_group.add_child(case_2d(
            name,
            CaseKind::UnusedChannel,
            format,
            mode,
            StateType::TextureParam,
            (8, 8),
            SamplingFunction::Filter,
            glw::GL_NEAREST,
            0,
        ));
    }
    unused_group
}

/// `TextureBorderClampTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("border_clamp");
    group.add_child(create_formats_group());
    group.add_child(create_range_clamp_group());
    group.add_child(create_sampler_group());
    group.add_child(create_per_axis_group());
    group.add_child(create_depth_compare_group());
    group.add_child(create_unused_channels_group());
    group
}

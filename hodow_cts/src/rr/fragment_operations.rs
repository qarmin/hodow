// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/referencerenderer/rrFragmentOperations.hpp / .cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// What is ported: the scissor test, the stencil and depth tests (both the float and the
// quantized-integer depth-compare branches - `execute_depth_compare`'s own doc comment
// has why a `D24S8`-style buffer genuinely needs the latter, not just the former with
// extra steps), standard and advanced (`GL_KHR_blend_equation_advanced`) blending, the
// colour write over a floating-point / fixed-point colour target, and the integer
// colour write path too (`executeSignedValueWrite`/`executeUnsignedValueWrite`, via
// `render`'s own dispatch on `colorbuffer_class` - integer targets never blend, matching
// upstream exactly: GL only defines blending over float/normalized-fixed-point targets,
// so the whole blend section is skipped for them). All of it is genuinely
// multisample-aware (`render`'s `num_samples_per_fragment = color_buffer.size()[0]`
// addressing, and `Fragment::sample_depths` below), since
// `rr::renderer::RenderTarget::get_num_samples` now reports a real sample count instead
// of a hardcoded 1 - see that module's own doc comment for the rest of what changed to
// drive this end to end.
//
// Enabling the integer colour path needed one upstream fact this port had been silently
// skipping: upstream's `Fragment::value`/`value1` are plain `GenericVec4` copies
// (`fragment.value = fragmentOutputArray[...]`, no `.get<T>()` call at all) - the
// reinterpretation as float/int32/uint32 happens only once `render` knows the colour
// buffer's real channel class. `Fragment::value` here used to be narrowed to `[f32; 4]`,
// so `rr::renderer::write_fragment_packets` had to call `.get_float()` unconditionally
// to fill it - silently reinterpreting an Int32/Uint32 fragment-shader output's bits as
// a float before an integer colour target could ever see them. `value`/`value1` are now
// `[u32; 4]` raw bits (`GenericVec4::raw_bits()`), exactly like upstream's own
// `GenericVec4`, and the float path below reinterprets them with `value_as_float()`/
// `value1_as_float()`.
//
// What is **not** ported, and asserts rather than silently doing nothing:
// `executeDepthBoundsTest` (`EXT_depth_bounds_test`) is ported for the Vulkan depth tests, which are its only users.

use crate::rr::rasterizer::RASTERIZER_MAX_SAMPLES_PER_FRAGMENT;
use crate::rr::render_state::{
    BlendEquation, BlendEquationAdvanced, BlendFunc, BlendMode, BlendState, FaceType, FragmentOperationState,
    StencilOp, StencilState, TestFunc, WindowRectangle,
};
use crate::tcu::pixel::{PixelBufferAccess, linear_to_srgb, srgb_to_linear};
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureChannelClass, TextureFormat};

/// `rr::Fragment`.
///
/// Upstream's `sampleDepths` is a `const float*` pointing at an already-populated
/// per-sample depth array (owned by `rr::renderer`'s rasterization scratch buffers, see
/// that module's `write_fragment_packets`); the equivalent borrow would tie this type's
/// lifetime to that buffer for no benefit, so this port owns a fixed-size
/// `[f32; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT]` array instead and copies into it - the
/// same trade `rr::rasterizer`'s own per-sample edge-function arrays already make.
/// `Fragment::single_sampled` fills index 0 and leaves the rest at 0.0 for the two
/// single-sampled producers (`gls::fragment_op_util`, `gles3::functional::draw_buffers_indexed_tests`)
/// that never read past `sample_depths[0]` anyway (both construct a 1-sample multisample
/// view via `get_multisample_access`, so `num_samples_per_fragment` is always 1 there).
///
/// `value`/`value1` are upstream's `GenericVec4` by value, kept here as the same raw
/// 32-bit lanes (`GenericVec4::raw_bits()`) rather than a `GenericVec4` directly, so this
/// module does not need to depend on `rr::generic_vector` for a type it only ever reads
/// back through `value_as_float`/`value_as_int` once `render` has determined the
/// colour buffer's real channel class - exactly the reinterpretation upstream performs
/// implicitly via `GenericVec4::get<T>()` at the point of use. There is no
/// `value_as_uint`: `GenericVec4::from_uint` stores a `u32` lane's bits unchanged, so
/// `value`/`raw_bits()` already *is* the unsigned reinterpretation.
#[derive(Debug, Clone, Copy)]
pub struct Fragment {
    pub pixel_coord: [i32; 2],
    pub value: [u32; 4],
    pub value1: [u32; 4],
    pub coverage: u32,
    pub sample_depths: [f32; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT],
}

impl Fragment {
    /// Convenience constructor for a single-sampled producer - see this struct's own
    /// doc comment for why those are safe to build this way. Both callers of this
    /// (`gls::fragment_op_util`, `gles3::functional::draw_buffers_indexed_tests`) only
    /// ever render into float colour targets, so they still hand over plain `[f32; 4]`
    /// colours here; this constructor does the float-to-bits conversion for them.
    pub fn single_sampled(pixel_coord: [i32; 2], value: [f32; 4], value1: [f32; 4], coverage: u32, depth: f32) -> Self {
        let mut sample_depths = [0.0f32; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];
        sample_depths[0] = depth;
        Self {
            pixel_coord,
            value: value.map(f32::to_bits),
            value1: value1.map(f32::to_bits),
            coverage,
            sample_depths,
        }
    }

    /// `GenericVec4::get<float>()` applied to `value`.
    fn value_as_float(&self) -> [f32; 4] {
        self.value.map(f32::from_bits)
    }

    /// `GenericVec4::get<float>()` applied to `value1`.
    fn value1_as_float(&self) -> [f32; 4] {
        self.value1.map(f32::from_bits)
    }

    /// `GenericVec4::get<int32_t>()` applied to `value` - a `u32 as i32` cast is a
    /// bit-preserving reinterpretation in Rust, exactly the `GenericVec4::bits[i] as
    /// int32_t` upstream performs.
    fn value_as_int(&self) -> [i32; 4] {
        self.value.map(|b| b as i32)
    }
}

/// `SAMPLE_REGISTER_SIZE`
const SAMPLE_REGISTER_SIZE: usize = 64;

/// `FragmentProcessor::SampleData`
#[derive(Debug, Clone, Copy, Default)]
struct SampleData {
    is_alive: bool,
    stencil_passed: bool,
    depth_passed: bool,
    clamped_blend_src_color: [f32; 4],
    clamped_blend_src1_color: [f32; 4],
    clamped_blend_dst_color: [f32; 4],
    blend_src_factor_rgb: [f32; 3],
    blend_src_factor_a: f32,
    blend_dst_factor_rgb: [f32; 3],
    blend_dst_factor_a: f32,
    blended_rgb: [f32; 3],
    blended_a: f32,
    /// `SampleInfo::signedValue`/`unsignedValue` - the integer colour-target path's
    /// counterpart to `blended_rgb`/`blended_a` above. Never populated and populated
    /// are mutually exclusive per `render` call, decided once by `colorbuffer_class`.
    signed_value: [i32; 4],
    unsigned_value: [u32; 4],
}

/// `rr::maskedBitReplace`
fn masked_bit_replace(old_value: i32, new_value: i32, mask: u32) -> i32 {
    (old_value & !(mask as i32)) | (new_value & mask as i32)
}

/// `rr::isInsideRect`
fn is_inside_rect(point: [i32; 2], rect: &WindowRectangle) -> bool {
    point[0] >= rect.left
        && point[0] < rect.left + rect.width
        && point[1] >= rect.bottom
        && point[1] < rect.bottom + rect.height
}

/// One `TESTFUNC_*` comparison, generic over whatever ordered type the two depth
/// buffer branches below compare with (`f32` for the float path, `u32` for the
/// quantized-integer path) - upstream repeats this same eight-way switch inline inside
/// each of its two macro-generated variants.
fn test_func_compare<T: PartialOrd>(func: TestFunc, sample: T, buffer: T) -> bool {
    match func {
        TestFunc::Never => false,
        TestFunc::Always => true,
        TestFunc::Less => sample < buffer,
        TestFunc::LEqual => sample <= buffer,
        TestFunc::Greater => sample > buffer,
        TestFunc::GEqual => sample >= buffer,
        TestFunc::Equal => sample == buffer,
        TestFunc::NotEqual => sample != buffer,
    }
}

/// `SAMPLE_REGISTER_DEPTH_COMPARE_UI`'s "convert input float to target buffer format
/// for comparison" step: writes `value` through a throwaway 1x1 access of the depth
/// buffer's own format (exactly upstream's local `tcu::PixelBufferAccess access(...,
/// &buffer)`) and reads back the quantized result as a raw unsigned integer, the same
/// representation `get_pixel_uint64` reads the real depth buffer through just above.
fn quantize_depth_to_format(value: f32, format: TextureFormat) -> u32 {
    let pixel_size = format
        .pixel_size()
        .expect("a depth buffer's own format must be representable - TextureLevel::new already required this")
        as usize;
    let mut scratch = [0u8; 8];
    debug_assert!(
        pixel_size <= scratch.len(),
        "no depth format needs more than 8 bytes per texel"
    );
    let mut access = PixelBufferAccess::new(format, [1, 1, 1], &mut scratch[..pixel_size]);
    access.set_pix_depth(value, 0, 0, 0);
    access.as_const().get_pixel_uint64(0, 0, 0)[0] as u32
}

/// `tcu::floatToU8` - upstream's approximate conversion, kept rather than replaced by a
/// round-to-nearest one so the RGBA8 fast path below agrees with the C++ bit for bit.
fn float_to_u8(fv: f32) -> u8 {
    let uv = fv.to_bits();
    let iv = uv as i32;

    let e = (126 - (iv >> 23)) as u32;
    let mut m = uv;

    m &= 0x00ff_ffff;
    m |= 0x0080_0000;
    m = (m << 8).wrapping_sub(m);
    m = if e > 8 { e } else { 0x0080_0000 + (m >> e) };

    (m >> 24) as u8
}

fn clamp4(v: [f32; 4], min: [f32; 4], max: [f32; 4]) -> [f32; 4] {
    [
        v[0].clamp(min[0], max[0]),
        v[1].clamp(min[1], max[1]),
        v[2].clamp(min[2], max[2]),
        v[3].clamp(min[3], max[3]),
    ]
}

/// `rr::unpremultiply`
fn unpremultiply(v: [f32; 4]) -> [f32; 4] {
    if v[3] > 0.0 {
        [v[0] / v[3], v[1] / v[3], v[2] / v[3], v[3]]
    } else {
        // \note upstream asserts v.xyz() == 0 here; not re-asserted, since an input that
        // violates it just produces the same all-zero result the assert would have let
        // through anyway.
        [0.0, 0.0, 0.0, 0.0]
    }
}

/// `rrFragmentOperations.cpp`'s anonymous `namespace advblend` - the per-mode blend
/// formulas for `GL_KHR_blend_equation_advanced`, each over one channel in [0, 1].
mod advblend {
    fn min_comp(v: [f32; 3]) -> f32 {
        v[0].min(v[1]).min(v[2])
    }

    fn max_comp(v: [f32; 3]) -> f32 {
        v[0].max(v[1]).max(v[2])
    }

    fn luminosity(rgb: [f32; 3]) -> f32 {
        rgb[0] * 0.3 + rgb[1] * 0.59 + rgb[2] * 0.11
    }

    fn saturation(rgb: [f32; 3]) -> f32 {
        max_comp(rgb) - min_comp(rgb)
    }

    /// `advblend::setLum`
    pub(super) fn set_lum(cbase: [f32; 3], clum: [f32; 3]) -> [f32; 3] {
        let lbase = luminosity(cbase);
        let llum = luminosity(clum);
        let ldiff = llum - lbase;
        let color = [cbase[0] + ldiff, cbase[1] + ldiff, cbase[2] + ldiff];
        let min_c = min_comp(color);
        let max_c = max_comp(color);

        if min_c < 0.0 {
            let denom = if llum != min_c { llum - min_c } else { 1.0 };
            [
                llum + (color[0] - llum) * llum / denom,
                llum + (color[1] - llum) * llum / denom,
                llum + (color[2] - llum) * llum / denom,
            ]
        } else if max_c > 1.0 {
            let denom = if llum != max_c { max_c - llum } else { 1.0 };
            [
                llum + (color[0] - llum) * (1.0 - llum) / denom,
                llum + (color[1] - llum) * (1.0 - llum) / denom,
                llum + (color[2] - llum) * (1.0 - llum) / denom,
            ]
        } else {
            color
        }
    }

    /// `advblend::setLumSat`
    pub(super) fn set_lum_sat(cbase: [f32; 3], csat: [f32; 3], clum: [f32; 3]) -> [f32; 3] {
        let minbase = min_comp(cbase);
        let sbase = saturation(cbase);
        let ssat = saturation(csat);
        let color = if sbase > 0.0 {
            [
                (cbase[0] - minbase) * ssat / sbase,
                (cbase[1] - minbase) * ssat / sbase,
                (cbase[2] - minbase) * ssat / sbase,
            ]
        } else {
            [0.0, 0.0, 0.0]
        };

        set_lum(color, clum)
    }

    pub(super) fn multiply(src: f32, dst: f32) -> f32 {
        src * dst
    }
    pub(super) fn screen(src: f32, dst: f32) -> f32 {
        src + dst - src * dst
    }
    pub(super) fn darken(src: f32, dst: f32) -> f32 {
        src.min(dst)
    }
    pub(super) fn lighten(src: f32, dst: f32) -> f32 {
        src.max(dst)
    }
    pub(super) fn difference(src: f32, dst: f32) -> f32 {
        (dst - src).abs()
    }
    pub(super) fn exclusion(src: f32, dst: f32) -> f32 {
        src + dst - 2.0 * src * dst
    }

    pub(super) fn overlay(src: f32, dst: f32) -> f32 {
        if dst <= 0.5 {
            2.0 * src * dst
        } else {
            1.0 - 2.0 * (1.0 - src) * (1.0 - dst)
        }
    }

    pub(super) fn colordodge(src: f32, dst: f32) -> f32 {
        if dst <= 0.0 {
            0.0
        } else if src < 1.0 {
            1.0f32.min(dst / (1.0 - src))
        } else {
            1.0
        }
    }

    pub(super) fn colorburn(src: f32, dst: f32) -> f32 {
        if dst >= 1.0 {
            1.0
        } else if src > 0.0 {
            1.0 - 1.0f32.min((1.0 - dst) / src)
        } else {
            0.0
        }
    }

    pub(super) fn hardlight(src: f32, dst: f32) -> f32 {
        if src <= 0.5 {
            2.0 * src * dst
        } else {
            1.0 - 2.0 * (1.0 - src) * (1.0 - dst)
        }
    }

    pub(super) fn softlight(src: f32, dst: f32) -> f32 {
        if src <= 0.5 {
            dst - (1.0 - 2.0 * src) * dst * (1.0 - dst)
        } else if dst <= 0.25 {
            dst + (2.0 * src - 1.0) * dst * ((16.0 * dst - 12.0) * dst + 3.0)
        } else {
            dst + (2.0 * src - 1.0) * (dst.sqrt() - dst)
        }
    }
}

/// `rr::FragmentProcessor`
#[derive(Debug)]
pub struct FragmentProcessor {
    sample_register: [SampleData; SAMPLE_REGISTER_SIZE],
}

impl Default for FragmentProcessor {
    fn default() -> Self {
        Self::new()
    }
}

impl FragmentProcessor {
    pub fn new() -> Self {
        Self {
            sample_register: [SampleData::default(); SAMPLE_REGISTER_SIZE],
        }
    }

    /// `FragmentProcessor::executeScissorTest`
    fn execute_scissor_test(
        &mut self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        scissor_rect: &WindowRectangle,
    ) {
        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            if self.sample_register[reg_sample_ndx].is_alive {
                let frag_ndx = frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment;

                if !is_inside_rect(input_fragments[frag_ndx].pixel_coord, scissor_rect) {
                    self.sample_register[reg_sample_ndx].is_alive = false;
                }
            }
        }
    }

    /// `FragmentProcessor::executeStencilCompare`
    fn execute_stencil_compare(
        &mut self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        stencil_state: &StencilState,
        num_stencil_bits: i32,
        stencil_buffer: &PixelBufferAccess<'_>,
    ) {
        let clamped_stencil_ref = stencil_state.reference.clamp(0, (1 << num_stencil_bits) - 1);

        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            if !self.sample_register[reg_sample_ndx].is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let stencil_buffer_value = stencil_buffer.get_pix_stencil(
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            ) as i32;
            let masked_ref = stencil_state.comp_mask as i32 & clamped_stencil_ref;
            let masked_buf = stencil_state.comp_mask as i32 & stencil_buffer_value;

            self.sample_register[reg_sample_ndx].stencil_passed = match stencil_state.func {
                TestFunc::Never => false,
                TestFunc::Always => true,
                TestFunc::Less => masked_ref < masked_buf,
                TestFunc::LEqual => masked_ref <= masked_buf,
                TestFunc::Greater => masked_ref > masked_buf,
                TestFunc::GEqual => masked_ref >= masked_buf,
                TestFunc::Equal => masked_ref == masked_buf,
                TestFunc::NotEqual => masked_ref != masked_buf,
            };
        }
    }

    /// `rr`'s stencil-op evaluation, which the C++ spells as one macro arm per op.
    fn stencil_op_value(
        op: StencilOp,
        stencil_buffer_value: i32,
        clamped_stencil_ref: i32,
        num_stencil_bits: i32,
    ) -> i32 {
        let max = (1 << num_stencil_bits) - 1;
        match op {
            StencilOp::Keep => stencil_buffer_value,
            StencilOp::Zero => 0,
            StencilOp::Replace => clamped_stencil_ref,
            StencilOp::Incr => (stencil_buffer_value + 1).clamp(0, max),
            StencilOp::Decr => (stencil_buffer_value - 1).clamp(0, max),
            StencilOp::IncrWrap => (stencil_buffer_value + 1) & max,
            StencilOp::DecrWrap => (stencil_buffer_value - 1) & max,
            StencilOp::Invert => !stencil_buffer_value & max,
        }
    }

    /// `FragmentProcessor::executeStencilSFail`
    fn execute_stencil_sfail(
        &mut self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        stencil_state: &StencilState,
        num_stencil_bits: i32,
        stencil_buffer: &mut PixelBufferAccess<'_>,
    ) {
        let clamped_stencil_ref = stencil_state.reference.clamp(0, (1 << num_stencil_bits) - 1);

        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = self.sample_register[reg_sample_ndx];
            if !sample.is_alive || sample.stencil_passed {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let (x, y, z) = (
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            );
            let stencil_buffer_value = stencil_buffer.get_pix_stencil(x, y, z) as i32;
            let new_value = Self::stencil_op_value(
                stencil_state.s_fail,
                stencil_buffer_value,
                clamped_stencil_ref,
                num_stencil_bits,
            );

            stencil_buffer.set_pix_stencil(
                masked_bit_replace(stencil_buffer_value, new_value, stencil_state.write_mask) as u32,
                x,
                y,
                z,
            );
            self.sample_register[reg_sample_ndx].is_alive = false;
        }
    }

    /// `FragmentProcessor::executeDepthBoundsTest`
    fn execute_depth_bounds_test(
        &mut self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        min_depth_bound: f32,
        max_depth_bound: f32,
        depth_buffer: &PixelBufferAccess<'_>,
    ) {
        let format = depth_buffer.format();
        let is_float_depth = matches!(
            format.type_,
            ChannelType::FLOAT | ChannelType::FLOAT_UNSIGNED_INT_24_8_REV
        );

        // Bounds converted to the buffer's own format for the fixed point comparison.
        let (min_bound_uint, max_bound_uint) = if is_float_depth {
            (0, 0)
        } else {
            (
                quantize_depth_to_format(min_depth_bound, format),
                quantize_depth_to_format(max_depth_bound, format),
            )
        };

        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            if !self.sample_register[reg_sample_ndx].is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let (x, y) = (frag.pixel_coord[0] as u32, frag.pixel_coord[1] as u32);

            let in_range = if is_float_depth {
                let depth_buffer_value = depth_buffer.get_pix_depth(frag_sample_ndx as u32, x, y);
                (min_depth_bound..=max_depth_bound).contains(&depth_buffer_value)
            } else {
                let depth_buffer_value =
                    depth_buffer.as_const().get_pixel_uint64(frag_sample_ndx as u32, x, y)[0] as u32;
                (min_bound_uint..=max_bound_uint).contains(&depth_buffer_value)
            };

            if !in_range {
                self.sample_register[reg_sample_ndx].is_alive = false;
            }
        }
    }

    /// `FragmentProcessor::executeDepthCompare`. Upstream splits into
    /// `SAMPLE_REGISTER_DEPTH_COMPARE_F`/`_UI` depending on whether the depth buffer's
    /// own channel type is `FLOAT`/`FLOAT_UNSIGNED_INT_24_8_REV` - every other depth
    /// format (`UNORM_INT24`/`UNORM_INT16`, i.e. the common `D24S8`/`D16` case, see
    /// `tcu::pixel::effective_depth_stencil_view`'s own `Depth` arms) is compared as a
    /// **quantized integer**, not as a normalized float. This is not an equivalent
    /// reformulation of the same comparison: `GEQUAL`/`LESS`/`EQUAL` at a value that
    /// falls between two quantization steps of a `D24S8` buffer compares differently
    /// depending on whether the incoming sample depth is rounded to the buffer's own
    /// grid *before* comparing (upstream's behaviour) or compared as full-precision
    /// floats against an already-quantized buffer value (what reading the buffer back
    /// through `get_pix_depth` and comparing as `f32` would do instead) - the whole
    /// point of `quantize_depth_to_format` below is putting both sides on the same grid
    /// before asking which is bigger.
    fn execute_depth_compare(
        &mut self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        depth_func: TestFunc,
        depth_buffer: &PixelBufferAccess<'_>,
    ) {
        let format = depth_buffer.format();
        let is_float_depth = matches!(
            format.type_,
            ChannelType::FLOAT | ChannelType::FLOAT_UNSIGNED_INT_24_8_REV
        );

        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            if !self.sample_register[reg_sample_ndx].is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let (x, y) = (frag.pixel_coord[0] as u32, frag.pixel_coord[1] as u32);

            self.sample_register[reg_sample_ndx].depth_passed = if is_float_depth {
                let depth_buffer_value = depth_buffer.get_pix_depth(frag_sample_ndx as u32, x, y);
                let sample_depth = frag.sample_depths[frag_sample_ndx].clamp(0.0, 1.0);
                test_func_compare(depth_func, sample_depth, depth_buffer_value)
            } else {
                let depth_buffer_value =
                    depth_buffer.as_const().get_pixel_uint64(frag_sample_ndx as u32, x, y)[0] as u32;
                let sample_depth = quantize_depth_to_format(frag.sample_depths[frag_sample_ndx], format);
                test_func_compare(depth_func, sample_depth, depth_buffer_value)
            };
        }
    }

    /// `FragmentProcessor::executeDepthWrite`
    fn execute_depth_write(
        &self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        depth_buffer: &mut PixelBufferAccess<'_>,
    ) {
        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = self.sample_register[reg_sample_ndx];
            if !sample.is_alive || !sample.depth_passed {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let clamped_depth = frag.sample_depths[frag_sample_ndx].clamp(0.0, 1.0);

            depth_buffer.set_pix_depth(
                clamped_depth,
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            );
        }
    }

    /// `FragmentProcessor::executeStencilDpFailAndPass`
    fn execute_stencil_dp_fail_and_pass(
        &mut self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        stencil_state: &StencilState,
        num_stencil_bits: i32,
        stencil_buffer: &mut PixelBufferAccess<'_>,
    ) {
        let clamped_stencil_ref = stencil_state.reference.clamp(0, (1 << num_stencil_bits) - 1);

        for (op, want_depth_passed) in [(stencil_state.dp_fail, false), (stencil_state.dp_pass, true)] {
            for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                let sample = self.sample_register[reg_sample_ndx];
                if !sample.is_alive || sample.depth_passed != want_depth_passed {
                    continue;
                }
                let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
                let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
                let (x, y, z) = (
                    frag_sample_ndx as u32,
                    frag.pixel_coord[0] as u32,
                    frag.pixel_coord[1] as u32,
                );
                let stencil_buffer_value = stencil_buffer.get_pix_stencil(x, y, z) as i32;
                let new_value = Self::stencil_op_value(op, stencil_buffer_value, clamped_stencil_ref, num_stencil_bits);

                stencil_buffer.set_pix_stencil(
                    masked_bit_replace(stencil_buffer_value, new_value, stencil_state.write_mask) as u32,
                    x,
                    y,
                    z,
                );
            }
        }
    }

    /// `FragmentProcessor::executeBlendFactorComputeRGB`
    fn execute_blend_factor_compute_rgb(&mut self, blend_color: [f32; 4], blend_rgb_state: &BlendState) {
        for (func, is_src) in [(blend_rgb_state.src_func, true), (blend_rgb_state.dst_func, false)] {
            for sample in self.sample_register.iter_mut() {
                if !sample.is_alive {
                    continue;
                }
                let src = sample.clamped_blend_src_color;
                let src1 = sample.clamped_blend_src1_color;
                let dst = sample.clamped_blend_dst_color;

                let rgb3 = |v: [f32; 4]| [v[0], v[1], v[2]];
                let one_minus = |v: [f32; 3]| [1.0 - v[0], 1.0 - v[1], 1.0 - v[2]];
                let splat = |s: f32| [s, s, s];

                let factor = match func {
                    BlendFunc::Zero => splat(0.0),
                    BlendFunc::One => splat(1.0),
                    BlendFunc::SrcColor => rgb3(src),
                    BlendFunc::OneMinusSrcColor => one_minus(rgb3(src)),
                    BlendFunc::DstColor => rgb3(dst),
                    BlendFunc::OneMinusDstColor => one_minus(rgb3(dst)),
                    BlendFunc::SrcAlpha => splat(src[3]),
                    BlendFunc::OneMinusSrcAlpha => splat(1.0 - src[3]),
                    BlendFunc::DstAlpha => splat(dst[3]),
                    BlendFunc::OneMinusDstAlpha => splat(1.0 - dst[3]),
                    BlendFunc::ConstantColor => rgb3(blend_color),
                    BlendFunc::OneMinusConstantColor => one_minus(rgb3(blend_color)),
                    BlendFunc::ConstantAlpha => splat(blend_color[3]),
                    BlendFunc::OneMinusConstantAlpha => splat(1.0 - blend_color[3]),
                    BlendFunc::SrcAlphaSaturate => splat(src[3].min(1.0 - dst[3])),
                    BlendFunc::Src1Color => rgb3(src1),
                    BlendFunc::OneMinusSrc1Color => one_minus(rgb3(src1)),
                    BlendFunc::Src1Alpha => splat(src1[3]),
                    BlendFunc::OneMinusSrc1Alpha => splat(1.0 - src1[3]),
                };

                if is_src {
                    sample.blend_src_factor_rgb = factor;
                } else {
                    sample.blend_dst_factor_rgb = factor;
                }
            }
        }
    }

    /// `FragmentProcessor::executeBlendFactorComputeA`
    fn execute_blend_factor_compute_a(&mut self, blend_color: [f32; 4], blend_a_state: &BlendState) {
        for (func, is_src) in [(blend_a_state.src_func, true), (blend_a_state.dst_func, false)] {
            for sample in self.sample_register.iter_mut() {
                if !sample.is_alive {
                    continue;
                }
                let src = sample.clamped_blend_src_color;
                let src1 = sample.clamped_blend_src1_color;
                let dst = sample.clamped_blend_dst_color;

                let factor = match func {
                    BlendFunc::Zero => 0.0,
                    BlendFunc::One => 1.0,
                    BlendFunc::SrcColor | BlendFunc::SrcAlpha => src[3],
                    BlendFunc::OneMinusSrcColor | BlendFunc::OneMinusSrcAlpha => 1.0 - src[3],
                    BlendFunc::DstColor | BlendFunc::DstAlpha => dst[3],
                    BlendFunc::OneMinusDstColor | BlendFunc::OneMinusDstAlpha => 1.0 - dst[3],
                    BlendFunc::ConstantColor | BlendFunc::ConstantAlpha => blend_color[3],
                    BlendFunc::OneMinusConstantColor | BlendFunc::OneMinusConstantAlpha => 1.0 - blend_color[3],
                    BlendFunc::SrcAlphaSaturate => 1.0,
                    BlendFunc::Src1Color | BlendFunc::Src1Alpha => src1[3],
                    BlendFunc::OneMinusSrc1Color | BlendFunc::OneMinusSrc1Alpha => 1.0 - src1[3],
                };

                if is_src {
                    sample.blend_src_factor_a = factor;
                } else {
                    sample.blend_dst_factor_a = factor;
                }
            }
        }
    }

    /// `FragmentProcessor::executeBlend`
    fn execute_blend(&mut self, blend_rgb_state: &BlendState, blend_a_state: &BlendState) {
        for sample in self.sample_register.iter_mut() {
            if !sample.is_alive {
                continue;
            }
            let src_color = sample.clamped_blend_src_color;
            let dst_color = sample.clamped_blend_dst_color;

            let src_rgb = [src_color[0], src_color[1], src_color[2]];
            let dst_rgb = [dst_color[0], dst_color[1], dst_color[2]];
            let sf = sample.blend_src_factor_rgb;
            let df = sample.blend_dst_factor_rgb;

            sample.blended_rgb = match blend_rgb_state.equation {
                BlendEquation::Add => [
                    src_rgb[0] * sf[0] + dst_rgb[0] * df[0],
                    src_rgb[1] * sf[1] + dst_rgb[1] * df[1],
                    src_rgb[2] * sf[2] + dst_rgb[2] * df[2],
                ],
                BlendEquation::Subtract => [
                    src_rgb[0] * sf[0] - dst_rgb[0] * df[0],
                    src_rgb[1] * sf[1] - dst_rgb[1] * df[1],
                    src_rgb[2] * sf[2] - dst_rgb[2] * df[2],
                ],
                BlendEquation::ReverseSubtract => [
                    dst_rgb[0] * df[0] - src_rgb[0] * sf[0],
                    dst_rgb[1] * df[1] - src_rgb[1] * sf[1],
                    dst_rgb[2] * df[2] - src_rgb[2] * sf[2],
                ],
                BlendEquation::Min => [
                    src_rgb[0].min(dst_rgb[0]),
                    src_rgb[1].min(dst_rgb[1]),
                    src_rgb[2].min(dst_rgb[2]),
                ],
                BlendEquation::Max => [
                    src_rgb[0].max(dst_rgb[0]),
                    src_rgb[1].max(dst_rgb[1]),
                    src_rgb[2].max(dst_rgb[2]),
                ],
            };

            sample.blended_a = match blend_a_state.equation {
                BlendEquation::Add => {
                    src_color[3] * sample.blend_src_factor_a + dst_color[3] * sample.blend_dst_factor_a
                }
                BlendEquation::Subtract => {
                    src_color[3] * sample.blend_src_factor_a - dst_color[3] * sample.blend_dst_factor_a
                }
                BlendEquation::ReverseSubtract => {
                    dst_color[3] * sample.blend_dst_factor_a - src_color[3] * sample.blend_src_factor_a
                }
                BlendEquation::Min => src_color[3].min(dst_color[3]),
                BlendEquation::Max => src_color[3].max(dst_color[3]),
            };
        }
    }

    /// `FragmentProcessor::executeAdvancedBlend`
    ///
    /// Upstream spells the per-sample precompute and the equation dispatch as macros
    /// (`SAMPLE_REGISTER_ADV_BLEND`/`_HSL`) expanded once per `case`; here they are one
    /// closure each, called from the `match` arm instead of textually repeated.
    fn execute_advanced_blend(&mut self, equation: BlendEquationAdvanced) {
        // Pre-compute factors & compute alpha.
        // \note clampedBlend*Color contains clamped & unpremultiplied colors.
        for sample in self.sample_register.iter_mut() {
            if !sample.is_alive {
                continue;
            }
            let src_color = sample.clamped_blend_src_color;
            let dst_color = sample.clamped_blend_dst_color;
            let src_a = src_color[3];
            let dst_a = dst_color[3];
            let p0 = src_a * dst_a;
            let p1 = src_a * (1.0 - dst_a);
            let p2 = dst_a * (1.0 - src_a);
            let bias = [
                src_color[0] * p1 + dst_color[0] * p2,
                src_color[1] * p1 + dst_color[1] * p2,
                src_color[2] * p1 + dst_color[2] * p2,
            ];

            sample.blend_src_factor_rgb = bias;
            sample.blend_src_factor_a = p0;
            sample.blended_a = p0 + p1 + p2;
        }

        let per_channel = |sample: &mut SampleData, func: fn(f32, f32) -> f32| {
            let src = sample.clamped_blend_src_color;
            let dst = sample.clamped_blend_dst_color;
            let bias = sample.blend_src_factor_rgb;
            let p0 = sample.blend_src_factor_a;
            sample.blended_rgb = [
                func(src[0], dst[0]) * p0 + bias[0],
                func(src[1], dst[1]) * p0 + bias[1],
                func(src[2], dst[2]) * p0 + bias[2],
            ];
        };
        let hsl = |sample: &mut SampleData, color: [f32; 3]| {
            let bias = sample.blend_src_factor_rgb;
            let p0 = sample.blend_src_factor_a;
            sample.blended_rgb = [
                color[0] * p0 + bias[0],
                color[1] * p0 + bias[1],
                color[2] * p0 + bias[2],
            ];
        };
        let rgb3 = |v: [f32; 4]| [v[0], v[1], v[2]];

        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            if !self.sample_register[reg_sample_ndx].is_alive {
                continue;
            }
            let sample = &mut self.sample_register[reg_sample_ndx];
            let src_color = rgb3(sample.clamped_blend_src_color);
            let dst_color = rgb3(sample.clamped_blend_dst_color);

            match equation {
                BlendEquationAdvanced::Multiply => per_channel(sample, advblend::multiply),
                BlendEquationAdvanced::Screen => per_channel(sample, advblend::screen),
                BlendEquationAdvanced::Overlay => per_channel(sample, advblend::overlay),
                BlendEquationAdvanced::Darken => per_channel(sample, advblend::darken),
                BlendEquationAdvanced::Lighten => per_channel(sample, advblend::lighten),
                BlendEquationAdvanced::ColorDodge => per_channel(sample, advblend::colordodge),
                BlendEquationAdvanced::ColorBurn => per_channel(sample, advblend::colorburn),
                BlendEquationAdvanced::HardLight => per_channel(sample, advblend::hardlight),
                BlendEquationAdvanced::SoftLight => per_channel(sample, advblend::softlight),
                BlendEquationAdvanced::Difference => per_channel(sample, advblend::difference),
                BlendEquationAdvanced::Exclusion => per_channel(sample, advblend::exclusion),
                BlendEquationAdvanced::HslHue => hsl(sample, advblend::set_lum_sat(src_color, dst_color, dst_color)),
                BlendEquationAdvanced::HslSaturation => {
                    hsl(sample, advblend::set_lum_sat(dst_color, src_color, dst_color))
                }
                BlendEquationAdvanced::HslColor => hsl(sample, advblend::set_lum(src_color, dst_color)),
                BlendEquationAdvanced::HslLuminosity => hsl(sample, advblend::set_lum(dst_color, src_color)),
            }
        }
    }

    /// `FragmentProcessor::executeColorWrite`
    fn execute_color_write(
        &self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        is_srgb: bool,
        color_buffer: &mut PixelBufferAccess<'_>,
    ) {
        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = &self.sample_register[reg_sample_ndx];
            if !sample.is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let mut combined_color = [
                sample.blended_rgb[0],
                sample.blended_rgb[1],
                sample.blended_rgb[2],
                sample.blended_a,
            ];

            if is_srgb {
                combined_color = linear_to_srgb(combined_color);
            }

            color_buffer.set_pixel(
                combined_color,
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            );
        }
    }

    /// `FragmentProcessor::executeRGBA8ColorWrite`
    fn execute_rgba8_color_write(
        &self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        color_buffer: &mut PixelBufferAccess<'_>,
    ) {
        let frag_stride = 4usize;
        let [_, x_stride, y_stride] = color_buffer.pitch();

        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = self.sample_register[reg_sample_ndx];
            if !sample.is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let offset = frag_sample_ndx * frag_stride
                + frag.pixel_coord[0] as usize * x_stride
                + frag.pixel_coord[1] as usize * y_stride;
            let dst = &mut color_buffer.raw_mut()[offset..offset + 4];

            dst[0] = float_to_u8(sample.blended_rgb[0]);
            dst[1] = float_to_u8(sample.blended_rgb[1]);
            dst[2] = float_to_u8(sample.blended_rgb[2]);
            dst[3] = float_to_u8(sample.blended_a);
        }
    }

    /// `FragmentProcessor::executeMaskedColorWrite`
    // The C++ takes these eight too; splitting them into a struct would make the
    // one call site read less like `executeMaskedColorWrite(...)` does upstream.
    #[allow(clippy::too_many_arguments)]
    fn execute_masked_color_write(
        &self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        color_mask_factor: [f32; 4],
        color_mask_negation_factor: [f32; 4],
        is_srgb: bool,
        color_buffer: &mut PixelBufferAccess<'_>,
    ) {
        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = self.sample_register[reg_sample_ndx];
            if !sample.is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let (x, y, z) = (
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            );
            let original_color = color_buffer.as_const().get_pixel(x, y, z);
            let mut new_color = [
                sample.blended_rgb[0],
                sample.blended_rgb[1],
                sample.blended_rgb[2],
                sample.blended_a,
            ];

            if is_srgb {
                new_color = linear_to_srgb(new_color);
            }

            for c in 0..4 {
                new_color[c] = color_mask_factor[c] * new_color[c] + color_mask_negation_factor[c] * original_color[c];
            }

            color_buffer.set_pixel(new_color, x, y, z);
        }
    }

    /// `FragmentProcessor::executeSignedValueWrite` - `tcu::select(signedValue,
    /// originalValue, colorMask)`: keep the new signed value on a masked-in channel,
    /// the colour buffer's own existing value on a masked-out one.
    fn execute_signed_value_write(
        &self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        color_mask: [bool; 4],
        color_buffer: &mut PixelBufferAccess<'_>,
    ) {
        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = self.sample_register[reg_sample_ndx];
            if !sample.is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let (x, y, z) = (
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            );
            let original_value = color_buffer.as_const().get_pixel_int(x, y, z);

            let mut new_value = sample.signed_value;
            for c in 0..4 {
                if !color_mask[c] {
                    new_value[c] = original_value[c];
                }
            }

            let wrote = color_buffer.set_pixel_int(new_value, x, y, z);
            debug_assert!(
                wrote,
                "signed-integer colour write landed on a channel type TextureLevel::new already refused to create"
            );
        }
    }

    /// `FragmentProcessor::executeUnsignedValueWrite`. `set_pixel_int` already writes
    /// an unsigned channel type's raw bit pattern rather than clamping a signed value
    /// into it (see `int_to_channel_bytes`'s own `UNSIGNED_INT32` arm) - the same
    /// bit-preserving `u32 -> i32 -> (write path) -> u32` round trip
    /// `Fragment::value_as_int` relies on for the signed path above, just run the other
    /// way, which is exactly upstream's own `UVec4::cast<int32_t>()` before its shared
    /// `setPixel(const IVec4&)` write path.
    fn execute_unsigned_value_write(
        &self,
        frag_ndx_offset: usize,
        num_samples_per_fragment: usize,
        input_fragments: &[Fragment],
        color_mask: [bool; 4],
        color_buffer: &mut PixelBufferAccess<'_>,
    ) {
        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
            let sample = self.sample_register[reg_sample_ndx];
            if !sample.is_alive {
                continue;
            }
            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
            let frag = &input_fragments[frag_ndx_offset + reg_sample_ndx / num_samples_per_fragment];
            let (x, y, z) = (
                frag_sample_ndx as u32,
                frag.pixel_coord[0] as u32,
                frag.pixel_coord[1] as u32,
            );
            let original_value = color_buffer.as_const().get_pixel_uint64(x, y, z);

            let mut new_value = sample.unsigned_value;
            for c in 0..4 {
                if !color_mask[c] {
                    new_value[c] = original_value[c] as u32;
                }
            }

            let wrote = color_buffer.set_pixel_int(new_value.map(|v| v as i32), x, y, z);
            debug_assert!(
                wrote,
                "unsigned-integer colour write landed on a channel type TextureLevel::new already refused to create"
            );
        }
    }

    /// `FragmentProcessor::render`
    ///
    /// The depth and stencil buffers are `Option` where the C++ takes a possibly-empty
    /// access, which is how it spells the same thing.
    pub fn render(
        &mut self,
        color_buffer: &mut PixelBufferAccess<'_>,
        depth_buffer: Option<&mut PixelBufferAccess<'_>>,
        stencil_buffer: Option<&mut PixelBufferAccess<'_>>,
        input_fragments: &[Fragment],
        fragment_facing: FaceType,
        state: &FragmentOperationState,
    ) {
        // code bitshifts numStencilBits, avoid undefined behavior
        assert!(state.num_stencil_bits < 32);

        let mut depth_buffer = depth_buffer;
        let mut stencil_buffer = stencil_buffer;
        let do_depth_test = depth_buffer.is_some() && state.depth_test_enabled;
        let do_stencil_test = stencil_buffer.is_some() && state.stencil_test_enabled;
        let do_depth_bounds_test = depth_buffer.is_some() && state.depth_bounds_test_enabled;
        let stencil_state = state.stencil_states[fragment_facing as usize];

        let colorbuffer_class = color_buffer.format().channel_class();

        let num_fragments = input_fragments.len();
        let num_samples_per_fragment = color_buffer.size()[0] as usize;
        let total_num_samples = num_fragments * num_samples_per_fragment;
        // \note totalNumSamples/SAMPLE_REGISTER_SIZE rounded up.
        let num_sample_groups = total_num_samples.div_ceil(SAMPLE_REGISTER_SIZE);
        let color_mask_factor = state.color_mask.map(|m| if m { 1.0f32 } else { 0.0 });
        let color_mask_negation_factor = state.color_mask.map(|m| if m { 0.0f32 } else { 1.0 });
        let srgb_target = state.srgb_enabled && color_buffer.format().order.is_srgb();

        assert!(SAMPLE_REGISTER_SIZE.is_multiple_of(num_samples_per_fragment));

        // Divide the fragments' samples into groups of size SAMPLE_REGISTER_SIZE, and perform
        // the per-sample operations for one group at a time.

        for sample_group_ndx in 0..num_sample_groups {
            // The index of the fragment of the sample at the beginning of m_sampleRegisters.
            let group_first_frag_ndx = (sample_group_ndx * SAMPLE_REGISTER_SIZE) / num_samples_per_fragment;

            // Initialize sample data in the sample register.

            for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                let frag_ndx = group_first_frag_ndx + reg_sample_ndx / num_samples_per_fragment;
                let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;

                self.sample_register[reg_sample_ndx].is_alive =
                    frag_ndx < num_fragments && (input_fragments[frag_ndx].coverage & (1u32 << frag_sample_ndx)) != 0;
                // \note This will stay true if depth test is disabled.
                self.sample_register[reg_sample_ndx].depth_passed = true;
            }

            // Scissor test.

            if state.scissor_test_enabled {
                self.execute_scissor_test(
                    group_first_frag_ndx,
                    num_samples_per_fragment,
                    input_fragments,
                    &state.scissor_rectangle,
                );
            }

            if do_depth_bounds_test {
                let depth = depth_buffer.as_mut().expect("checked by do_depth_bounds_test");
                self.execute_depth_bounds_test(
                    group_first_frag_ndx,
                    num_samples_per_fragment,
                    input_fragments,
                    state.min_depth_bound,
                    state.max_depth_bound,
                    depth,
                );
            }

            // Stencil test.

            if do_stencil_test {
                let stencil = stencil_buffer.as_mut().expect("checked by do_stencil_test");
                self.execute_stencil_compare(
                    group_first_frag_ndx,
                    num_samples_per_fragment,
                    input_fragments,
                    &stencil_state,
                    state.num_stencil_bits,
                    stencil,
                );
                self.execute_stencil_sfail(
                    group_first_frag_ndx,
                    num_samples_per_fragment,
                    input_fragments,
                    &stencil_state,
                    state.num_stencil_bits,
                    stencil,
                );
            }

            // Depth test.
            // \note Current value of isAlive is needed for dpPass and dpFail, so it's only updated after them and not right after depth test.

            if do_depth_test {
                let depth = depth_buffer.as_mut().expect("checked by do_depth_test");
                self.execute_depth_compare(
                    group_first_frag_ndx,
                    num_samples_per_fragment,
                    input_fragments,
                    state.depth_func,
                    depth,
                );

                if state.depth_mask {
                    self.execute_depth_write(group_first_frag_ndx, num_samples_per_fragment, input_fragments, depth);
                }
            }

            // Do dpFail and dpPass stencil writes.

            if do_stencil_test {
                let stencil = stencil_buffer.as_mut().expect("checked by do_stencil_test");
                self.execute_stencil_dp_fail_and_pass(
                    group_first_frag_ndx,
                    num_samples_per_fragment,
                    input_fragments,
                    &stencil_state,
                    state.num_stencil_bits,
                    stencil,
                );
            }

            // Kill the samples that failed depth test.

            if do_depth_test {
                for sample in self.sample_register.iter_mut() {
                    sample.is_alive = sample.is_alive && sample.depth_passed;
                }
            }

            // Paint fragments to target. Upstream's `switch (fragmentDataType)`:
            // integer colour targets skip blending entirely (GL defines blending only
            // over float/normalized-fixed-point targets) and go straight to a plain
            // masked write of the fragment's own raw integer value.
            match colorbuffer_class {
                TextureChannelClass::SignedInteger => {
                    for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                        if !self.sample_register[reg_sample_ndx].is_alive {
                            continue;
                        }
                        let frag = &input_fragments[group_first_frag_ndx + reg_sample_ndx / num_samples_per_fragment];
                        self.sample_register[reg_sample_ndx].signed_value = frag.value_as_int();
                    }

                    if state.color_mask[0] || state.color_mask[1] || state.color_mask[2] || state.color_mask[3] {
                        self.execute_signed_value_write(
                            group_first_frag_ndx,
                            num_samples_per_fragment,
                            input_fragments,
                            state.color_mask,
                            color_buffer,
                        );
                    }
                }
                TextureChannelClass::UnsignedInteger => {
                    for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                        if !self.sample_register[reg_sample_ndx].is_alive {
                            continue;
                        }
                        let frag = &input_fragments[group_first_frag_ndx + reg_sample_ndx / num_samples_per_fragment];
                        // `frag.value` is already the raw bits `GenericVec4::from_uint`
                        // would have stored - no reinterpretation needed.
                        self.sample_register[reg_sample_ndx].unsigned_value = frag.value;
                    }

                    if state.color_mask[0] || state.color_mask[1] || state.color_mask[2] || state.color_mask[3] {
                        self.execute_unsigned_value_write(
                            group_first_frag_ndx,
                            num_samples_per_fragment,
                            input_fragments,
                            state.color_mask,
                            color_buffer,
                        );
                    }
                }
                _ => {
                    // Select min/max clamping values for blending factors and operands.
                    let (min_clamp_value, max_clamp_value) = match colorbuffer_class {
                        TextureChannelClass::UnsignedFixedPoint => ([0.0f32; 4], [1.0f32; 4]),
                        TextureChannelClass::SignedFixedPoint => ([-1.0f32; 4], [1.0f32; 4]),
                        // No clamping
                        _ => ([f32::NEG_INFINITY; 4], [f32::INFINITY; 4]),
                    };

                    // Blend calculation - only if using blend.
                    if state.blend_mode == BlendMode::Standard {
                        // Put dst color to register, doing srgb-to-linear conversion if needed.
                        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                            if !self.sample_register[reg_sample_ndx].is_alive {
                                continue;
                            }
                            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
                            let frag =
                                &input_fragments[group_first_frag_ndx + reg_sample_ndx / num_samples_per_fragment];
                            let dst_color = color_buffer.as_const().get_pixel(
                                frag_sample_ndx as u32,
                                frag.pixel_coord[0] as u32,
                                frag.pixel_coord[1] as u32,
                            );

                            let sample = &mut self.sample_register[reg_sample_ndx];
                            sample.clamped_blend_src_color =
                                clamp4(frag.value_as_float(), min_clamp_value, max_clamp_value);
                            sample.clamped_blend_src1_color =
                                clamp4(frag.value1_as_float(), min_clamp_value, max_clamp_value);
                            sample.clamped_blend_dst_color = clamp4(
                                if srgb_target {
                                    srgb_to_linear(dst_color)
                                } else {
                                    dst_color
                                },
                                min_clamp_value,
                                max_clamp_value,
                            );
                        }

                        // Calculate blend factors to register.
                        self.execute_blend_factor_compute_rgb(state.blend_color, &state.blend_rgb_state);
                        self.execute_blend_factor_compute_a(state.blend_color, &state.blend_a_state);

                        // Compute blended color.
                        self.execute_blend(&state.blend_rgb_state, &state.blend_a_state);
                    } else if state.blend_mode == BlendMode::Advanced {
                        // Unpremultiply colors for blending, and do sRGB->linear if necessary.
                        // \todo [2014-03-17 pyry] Re-consider clampedBlend*Color var names
                        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                            if !self.sample_register[reg_sample_ndx].is_alive {
                                continue;
                            }
                            let frag_sample_ndx = reg_sample_ndx % num_samples_per_fragment;
                            let frag =
                                &input_fragments[group_first_frag_ndx + reg_sample_ndx / num_samples_per_fragment];
                            let src_color = frag.value_as_float();
                            let dst_color = color_buffer.as_const().get_pixel(
                                frag_sample_ndx as u32,
                                frag.pixel_coord[0] as u32,
                                frag.pixel_coord[1] as u32,
                            );

                            let sample = &mut self.sample_register[reg_sample_ndx];
                            sample.clamped_blend_src_color =
                                unpremultiply(clamp4(src_color, min_clamp_value, max_clamp_value));
                            sample.clamped_blend_dst_color = unpremultiply(clamp4(
                                if srgb_target {
                                    srgb_to_linear(dst_color)
                                } else {
                                    dst_color
                                },
                                min_clamp_value,
                                max_clamp_value,
                            ));
                        }

                        let equation = state
                            .blend_equation_advanced
                            .expect("blend_mode == Advanced implies an equation is set");
                        self.execute_advanced_blend(equation);
                    } else {
                        // Not using blend - just put values to register as-is.
                        assert_eq!(state.blend_mode, BlendMode::None);
                        for reg_sample_ndx in 0..SAMPLE_REGISTER_SIZE {
                            if !self.sample_register[reg_sample_ndx].is_alive {
                                continue;
                            }
                            let frag =
                                &input_fragments[group_first_frag_ndx + reg_sample_ndx / num_samples_per_fragment];
                            let value = frag.value_as_float();

                            self.sample_register[reg_sample_ndx].blended_rgb = [value[0], value[1], value[2]];
                            self.sample_register[reg_sample_ndx].blended_a = value[3];
                        }
                    }

                    // Clamp result values in sample register
                    if colorbuffer_class != TextureChannelClass::FloatingPoint {
                        for sample in self.sample_register.iter_mut() {
                            if !sample.is_alive {
                                continue;
                            }
                            for c in 0..3 {
                                sample.blended_rgb[c] =
                                    sample.blended_rgb[c].clamp(min_clamp_value[c], max_clamp_value[c]);
                            }
                            sample.blended_a = sample.blended_a.clamp(min_clamp_value[3], max_clamp_value[3]);
                        }
                    }

                    // Finally, write the colors to the color buffer.

                    if state.color_mask[0] && state.color_mask[1] && state.color_mask[2] && state.color_mask[3] {
                        if color_buffer.format() == TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8) {
                            self.execute_rgba8_color_write(
                                group_first_frag_ndx,
                                num_samples_per_fragment,
                                input_fragments,
                                color_buffer,
                            );
                        } else {
                            self.execute_color_write(
                                group_first_frag_ndx,
                                num_samples_per_fragment,
                                input_fragments,
                                srgb_target,
                                color_buffer,
                            );
                        }
                    } else if state.color_mask[0] || state.color_mask[1] || state.color_mask[2] || state.color_mask[3] {
                        self.execute_masked_color_write(
                            group_first_frag_ndx,
                            num_samples_per_fragment,
                            input_fragments,
                            color_mask_factor,
                            color_mask_negation_factor,
                            srgb_target,
                            color_buffer,
                        );
                    }
                }
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::tcu::pixel::TextureLevel;

    #[test]
    fn float_to_u8_matches_round_to_nearest() {
        // Upstream's bit trick is meant to be `round(f * 255)` over [0, 1]; a
        // disagreement here would be a transcription error, not an intended difference.
        for i in 0..=255u32 {
            let f = i as f32 / 255.0;
            assert_eq!(float_to_u8(f), i as u8, "f = {f}");
        }
        assert_eq!(float_to_u8(0.0), 0);
        assert_eq!(float_to_u8(1.0), 255);
    }

    /// The bug this guards against: before `Fragment` carried a `sample_depths` array,
    /// a single `depth: f32` was compared against *every* sample of a fragment, so two
    /// samples of the same pixel with genuinely different incoming depths (as a sloped
    /// MSAA triangle produces) could never disagree on the depth test. Two samples of
    /// one 1x1, 2-sample pixel, one fragment with `sample_depths = [0.3, 0.7]` against
    /// a depth buffer pre-filled with 0.5 at both samples and `TESTFUNC_LESS`: sample 0
    /// (0.3 < 0.5) must pass and get written, sample 1 (0.7 < 0.5 is false) must fail
    /// and stay untouched - both the colour buffer and the depth buffer, independently
    /// per sample.
    #[test]
    fn depth_test_and_write_are_evaluated_independently_per_sample() {
        const NUM_SAMPLES: u32 = 2;
        let color_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let depth_format = TextureFormat::new(ChannelOrder::D, ChannelType::FLOAT);

        let mut color_level = TextureLevel::new(color_format, NUM_SAMPLES, 1, 1).unwrap();
        let mut depth_level = TextureLevel::new(depth_format, NUM_SAMPLES, 1, 1).unwrap();

        {
            let mut depth_access = depth_level.get_access();
            depth_access.set_pix_depth(0.5, 0, 0, 0);
            depth_access.set_pix_depth(0.5, 1, 0, 0);
        }

        let mut sample_depths = [0.0f32; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT];
        sample_depths[0] = 0.3;
        sample_depths[1] = 0.7;
        let fragment = Fragment {
            pixel_coord: [0, 0],
            value: [1.0f32, 1.0, 1.0, 1.0].map(f32::to_bits),
            value1: [0u32; 4],
            coverage: 0b11, // both samples live
            sample_depths,
        };

        let state = FragmentOperationState {
            depth_test_enabled: true,
            depth_func: TestFunc::Less,
            depth_mask: true,
            ..FragmentOperationState::default()
        };

        let mut processor = FragmentProcessor::new();
        {
            let mut color_access = color_level.get_access();
            let mut depth_access = depth_level.get_access();
            processor.render(
                &mut color_access,
                Some(&mut depth_access),
                None,
                &[fragment],
                FaceType::Front,
                &state,
            );
        }

        let color0 = color_level.get_const_access().get_pixel(0, 0, 0);
        assert_eq!(
            color0,
            [1.0, 1.0, 1.0, 1.0],
            "sample 0 (depth 0.3 < buffer's 0.5) should have passed and been painted"
        );
        assert!(
            (depth_level.get_const_access().get_pix_depth(0, 0, 0) - 0.3).abs() < 1e-6,
            "sample 0's depth buffer entry should have been updated to the fragment's own per-sample depth"
        );

        let color1 = color_level.get_const_access().get_pixel(1, 0, 0);
        assert_eq!(
            color1,
            [0.0, 0.0, 0.0, 0.0],
            "sample 1 (depth 0.7, not < buffer's 0.5) should have failed and stayed untouched"
        );
        assert!(
            (depth_level.get_const_access().get_pix_depth(1, 0, 0) - 0.5).abs() < 1e-6,
            "sample 1's depth buffer entry must be unchanged by a failed depth test"
        );
    }

    /// The bug the integer colour write path fixes: before this round,
    /// `rr::renderer::write_fragment_packets` called `.get_float()` unconditionally to
    /// fill `Fragment::value`, so an `Int32`/`Uint32` fragment-shader output's raw bits
    /// were always reinterpreted as `f32` before `render` ever saw them, and `render`
    /// itself then asserted outright on an integer colour buffer. `Fragment::value_as_int`
    /// recovers the exact `i32` value `GenericVec4::from_int` encoded (`u32 as i32` is a
    /// bit-preserving cast in Rust), and `execute_signed_value_write` writes it through
    /// unmodified - no blending, no float clamp, matching `GL_RGBA32I`'s own semantics.
    #[test]
    fn signed_integer_colorbuffer_writes_the_raw_fragment_value_with_no_blending() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(format, 1, 1, 1).unwrap();

        let fragment = Fragment {
            pixel_coord: [0, 0],
            value: [5i32, -3, 100, -7].map(|v| v as u32),
            value1: [0u32; 4],
            coverage: 1, // the single sample is live
            sample_depths: [0.0; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT],
        };

        let state = FragmentOperationState::default();
        let mut processor = FragmentProcessor::new();
        {
            let mut color_access = level.get_access();
            processor.render(&mut color_access, None, None, &[fragment], FaceType::Front, &state);
        }

        assert_eq!(level.get_const_access().get_pixel_int(0, 0, 0), [5, -3, 100, -7]);
    }

    /// `executeSignedValueWrite`'s `tcu::select(signedValue, originalValue, colorMask)`:
    /// a masked-off channel keeps the colour buffer's own existing value rather than
    /// being overwritten, exactly like the float write path's colour mask already does.
    #[test]
    fn signed_integer_colorbuffer_respects_a_partial_color_mask() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::SIGNED_INT32);
        let mut level = TextureLevel::new(format, 1, 1, 1).unwrap();
        {
            let mut access = level.get_access();
            assert!(access.set_pixel_int([11, 22, 33, 44], 0, 0, 0));
        }

        let fragment = Fragment {
            pixel_coord: [0, 0],
            value: [5i32, -3, 100, -7].map(|v| v as u32),
            value1: [0u32; 4],
            coverage: 1,
            sample_depths: [0.0; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT],
        };

        // Only channels 0 and 2 are writable.
        let state = FragmentOperationState {
            color_mask: [true, false, true, false],
            ..FragmentOperationState::default()
        };
        let mut processor = FragmentProcessor::new();
        {
            let mut color_access = level.get_access();
            processor.render(&mut color_access, None, None, &[fragment], FaceType::Front, &state);
        }

        assert_eq!(
            level.get_const_access().get_pixel_int(0, 0, 0),
            [5, 22, 100, 44],
            "masked-in channels (0, 2) take the fragment's value; masked-out channels (1, 3) keep the buffer's own"
        );
    }

    /// The unsigned counterpart: `0xFFFF_FFFE` is a negative number as `i32`, so a bug
    /// anywhere in the `u32 -> i32 -> set_pixel_int -> u32` round trip (see
    /// `execute_unsigned_value_write`'s own doc comment) would show up as this value
    /// round-tripping to something other than itself.
    #[test]
    fn unsigned_integer_colorbuffer_round_trips_a_value_with_its_high_bit_set() {
        let format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32);
        let mut level = TextureLevel::new(format, 1, 1, 1).unwrap();

        let fragment = Fragment {
            pixel_coord: [0, 0],
            value: [0xFFFF_FFFEu32, 0, 42, 1],
            value1: [0u32; 4],
            coverage: 1,
            sample_depths: [0.0; RASTERIZER_MAX_SAMPLES_PER_FRAGMENT],
        };

        let state = FragmentOperationState::default();
        let mut processor = FragmentProcessor::new();
        {
            let mut color_access = level.get_access();
            processor.render(&mut color_access, None, None, &[fragment], FaceType::Front, &state);
        }

        let got = level.get_const_access().get_pixel_uint64(0, 0, 0);
        assert_eq!(got, [0xFFFF_FFFE, 0, 42, 1]);
    }

    /// `quantize_depth_to_format` is what `execute_depth_compare` leans on for a
    /// non-float depth format: the `D`/`UNORM_INT24` view `tcu::get_effective_depth_stencil_access_mut`
    /// produces for a real `D24S8` attachment (see that function's own test coverage in
    /// `tcu::pixel`). Round-trip it through `set_pix_depth`/`get_pixel_uint64` directly
    /// (bypassing `FragmentProcessor` entirely) and check it lands on the expected
    /// 24-bit grid point for a value with an exact representation, so a transcription
    /// error in the byte offsets/widths shows up here rather than only inside a much
    /// harder-to-debug depth-test pass/fail.
    #[test]
    fn quantize_depth_to_format_matches_a_direct_set_pix_depth_round_trip() {
        let format = TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT24);

        // 1.0 and 0.0 have exact 24-bit representations (16_777_215 and 0), so there is
        // no rounding-mode ambiguity to reason about by hand.
        assert_eq!(quantize_depth_to_format(1.0, format), 16_777_215);
        assert_eq!(quantize_depth_to_format(0.0, format), 0);

        // Cross-check against the real depth buffer write path at a value with an exact
        // representation too (one quarter of the range: 16_777_215 / 4 = 4_194_303.75,
        // rounds to 4_194_304 - not hand-verified independently here, just checked for
        // *agreement* between the two call sites, which is what would catch one of them
        // drifting out of sync with the other after a future edit).
        let mut level = TextureLevel::new(format, 1, 1, 1).unwrap();
        level.get_access().set_pix_depth(0.25, 0, 0, 0);
        let direct = level.get_const_access().get_pixel_uint64(0, 0, 0)[0] as u32;
        assert_eq!(quantize_depth_to_format(0.25, format), direct);
    }

    /// The bug this closes: before this round, `execute_depth_compare` always read the
    /// depth buffer through `get_pix_depth` (a normalized `f32`) and compared it against
    /// the full-precision incoming sample depth directly - which is *not* the same
    /// comparison upstream performs for a non-float depth format. Upstream quantizes the
    /// incoming sample depth to the buffer's own grid first (`quantize_depth_to_format`)
    /// and compares the two *integers*. The margin here (0.25 vs the buffer's 0.5, each
    /// about 4.2M quantization steps apart on a 24-bit grid) is large enough that no
    /// rounding-mode difference between the two approaches could flip the verdict - the
    /// point of this test is only confirming the integer branch runs and reaches the
    /// right answer, not probing a near-boundary case.
    #[test]
    fn quantized_integer_depth_buffer_is_compared_on_its_own_grid_not_as_a_float() {
        let depth_format = TextureFormat::new(ChannelOrder::D, ChannelType::UNORM_INT24);
        let color_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8);
        let state = FragmentOperationState {
            depth_test_enabled: true,
            depth_func: TestFunc::Less,
            depth_mask: true,
            ..FragmentOperationState::default()
        };

        // Sample depth 0.25 < buffer's 0.5: passes, paints, and updates the depth buffer.
        {
            let mut depth_level = TextureLevel::new(depth_format, 1, 1, 1).unwrap();
            let mut color_level = TextureLevel::new(color_format, 1, 1, 1).unwrap();
            depth_level.get_access().set_pix_depth(0.5, 0, 0, 0);

            let fragment = Fragment::single_sampled([0, 0], [1.0, 1.0, 1.0, 1.0], [0.0; 4], 1, 0.25);
            let mut processor = FragmentProcessor::new();
            {
                let mut color_access = color_level.get_access();
                let mut depth_access = depth_level.get_access();
                processor.render(
                    &mut color_access,
                    Some(&mut depth_access),
                    None,
                    &[fragment],
                    FaceType::Front,
                    &state,
                );
            }

            assert_eq!(
                color_level.get_const_access().get_pixel(0, 0, 0),
                [1.0, 1.0, 1.0, 1.0],
                "0.25 < 0.5 on the quantized grid should have passed"
            );
            assert!(
                depth_level.get_const_access().get_pixel_uint64(0, 0, 0)[0] < 8_000_000,
                "the depth buffer should have been overwritten down towards 0.25's own quantized value"
            );
        }

        // Sample depth 0.75, not < buffer's 0.5: fails, leaves both buffers untouched.
        {
            let mut depth_level = TextureLevel::new(depth_format, 1, 1, 1).unwrap();
            let mut color_level = TextureLevel::new(color_format, 1, 1, 1).unwrap();
            depth_level.get_access().set_pix_depth(0.5, 0, 0, 0);
            let original_depth_bits = depth_level.get_const_access().get_pixel_uint64(0, 0, 0)[0];

            let fragment = Fragment::single_sampled([0, 0], [1.0, 1.0, 1.0, 1.0], [0.0; 4], 1, 0.75);
            let mut processor = FragmentProcessor::new();
            {
                let mut color_access = color_level.get_access();
                let mut depth_access = depth_level.get_access();
                processor.render(
                    &mut color_access,
                    Some(&mut depth_access),
                    None,
                    &[fragment],
                    FaceType::Front,
                    &state,
                );
            }

            assert_eq!(
                color_level.get_const_access().get_pixel(0, 0, 0),
                [0.0, 0.0, 0.0, 0.0],
                "0.75 is not < 0.5 on the quantized grid, so this must fail"
            );
            assert_eq!(
                depth_level.get_const_access().get_pixel_uint64(0, 0, 0)[0],
                original_depth_bits,
                "a failed depth test must not write the depth buffer"
            );
        }
    }
}

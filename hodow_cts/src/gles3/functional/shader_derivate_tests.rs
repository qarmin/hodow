// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderDerivateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// No rasterised reference: the shader's argument is a value the case itself made linear
// in screen space, so the derivative it should produce is a constant the host can write
// down. What the case is actually about is how much error a conformant driver is allowed
// - `dFdx` may sample anywhere within the pixel and its neighbours, may flush subnormals
// and need only carry the declared precision - so almost all of this file is the three
// error bounds upstream computes, not the rendering.
//
// The error masks are dropped. They only ever reach upstream's log as an image, and this
// binary writes no images; every verdict here comes from the same counting of failed
// pixels that fills them.

use crate::glu::shader_util::{DataType, Precision};
use crate::glu::{self, Context, ProgramSources, ShaderProgram, TestCase, TestCaseGroup};
use crate::glw::{self, GLenum, GLuint};
use crate::tcu::float::Float32;
use crate::tcu::interval::Interval;
use crate::tcu::pixel::{ConstPixelBufferAccess, PixelBufferAccess, TextureLevel};
use crate::tcu::string_template::StringTemplate;
use crate::tcu::texture::{ChannelOrder, ChannelType, TextureFormat};
use crate::tcu::{Random, TestError, TestOutcome, TestResult, TestStatus, de_string_hash};

const VIEWPORT_WIDTH: i32 = 167;
const VIEWPORT_HEIGHT: i32 = 103;
const FBO_WIDTH: i32 = 99;
const FBO_HEIGHT: i32 = 133;
const MAX_FAILED_MESSAGES: i32 = 10;

/// `DerivateFunc`
#[derive(Clone, Copy, PartialEq, Eq)]
enum DerivateFunc {
    Dfdx,
    Dfdy,
    Fwidth,
}

/// `SurfaceType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum SurfaceType {
    DefaultFramebuffer,
    UnormFbo,
    /// \note Uses RGBA32UI fbo actually, since FP rendertargets are not in core spec.
    FloatFbo,
}

/// `getDerivateFuncName`
fn get_derivate_func_name(func: DerivateFunc) -> &'static str {
    match func {
        DerivateFunc::Dfdx => "dFdx",
        DerivateFunc::Dfdy => "dFdy",
        DerivateFunc::Fwidth => "fwidth",
    }
}

/// `getDerivateFuncCaseName`
fn get_derivate_func_case_name(func: DerivateFunc) -> &'static str {
    match func {
        DerivateFunc::Dfdx => "dfdx",
        DerivateFunc::Dfdy => "dfdy",
        DerivateFunc::Fwidth => "fwidth",
    }
}

/// `getDerivateMask`
fn get_derivate_mask(type_: DataType) -> [bool; 4] {
    match type_ {
        DataType::Float => [true, false, false, false],
        DataType::FloatVec2 => [true, true, false, false],
        DataType::FloatVec3 => [true, true, true, false],
        DataType::FloatVec4 => [true, true, true, true],
        _ => unreachable!("derivate cases only use float and vecN"),
    }
}

/// `readDerivate`
fn read_derivate(
    surface: &ConstPixelBufferAccess<'_>,
    deriv_scale: [f32; 4],
    deriv_bias: [f32; 4],
    x: u32,
    y: u32,
) -> [f32; 4] {
    let pixel = surface.get_pixel(x, y, 0);
    std::array::from_fn(|c| (pixel[c] - deriv_bias[c]) / deriv_scale[c])
}

/// `getCompExpBits`
fn get_comp_exp_bits(v: [f32; 4]) -> [u32; 4] {
    std::array::from_fn(|c| Float32::new(v[c]).exponent_bits())
}

/// `computeFloatingPointError`
fn compute_floating_point_error(value: f32, num_accurate_bits: i32) -> f32 {
    let num_garbage_bits = 23 - num_accurate_bits;
    let mask = (1u32 << num_garbage_bits) - 1u32;
    let exp = Float32::new(value).exponent().max(-3);

    Float32::construct(1, exp, (1 << 23) | mask).as_float() - Float32::construct(1, exp, 1 << 23).as_float()
}

/// `getNumMantissaBits`
fn get_num_mantissa_bits(precision: Precision) -> i32 {
    match precision {
        Precision::HighP => 23,
        Precision::MediumP => 10,
        Precision::LowP => 6,
    }
}

/// `getMinExponent`
fn get_min_exponent(precision: Precision) -> i32 {
    match precision {
        Precision::HighP => -126,
        Precision::MediumP => -14,
        Precision::LowP => -8,
    }
}

/// `getSingleULPForExponent`
fn get_single_ulp_for_exponent(exp: i32, num_mantissa_bits: i32) -> f32 {
    if num_mantissa_bits > 0 {
        debug_assert!(num_mantissa_bits <= 23);

        let ulp_bit_ndx = 23 - num_mantissa_bits;
        Float32::construct(1, exp, (1 << 23) | (1 << ulp_bit_ndx)).as_float()
            - Float32::construct(1, exp, 1 << 23).as_float()
    } else {
        debug_assert!(num_mantissa_bits == 0);
        Float32::construct(1, exp, 1 << 23).as_float()
    }
}

/// `getSingleULPForValue`
fn get_single_ulp_for_value(value: f32, num_mantissa_bits: i32) -> f32 {
    get_single_ulp_for_exponent(Float32::new(value).exponent(), num_mantissa_bits)
}

/// `convertFloatFlushToZeroRtn`
fn convert_float_flush_to_zero_rtn(value: f32, min_exponent: i32, num_accurate_bits: i32) -> f32 {
    if value == 0.0 {
        0.0
    } else {
        let input_float = Float32::new(value);
        let num_truncated_bits = 23 - num_accurate_bits;
        let trunc_mask = (1u32 << num_truncated_bits) - 1u32;

        if value > 0.0 {
            if value > 0.0 && Float32::new(value).exponent() < min_exponent {
                // flush to zero if possible
                0.0
            } else {
                // just mask away non-representable bits
                Float32::construct(1, input_float.exponent(), input_float.mantissa() & !trunc_mask).as_float()
            }
        } else if input_float.mantissa() & trunc_mask != 0 {
            // decrement one ulp if truncated bits are non-zero (i.e. if value is not representable)
            Float32::construct(-1, input_float.exponent(), input_float.mantissa() & !trunc_mask).as_float()
                - get_single_ulp_for_exponent(input_float.exponent(), num_accurate_bits)
        } else {
            // value is representable, no need to do anything
            value
        }
    }
}

/// `convertFloatFlushToZeroRtp`
fn convert_float_flush_to_zero_rtp(value: f32, min_exponent: i32, num_accurate_bits: i32) -> f32 {
    -convert_float_flush_to_zero_rtn(-value, min_exponent, num_accurate_bits)
}

/// `addErrorUlp`
fn add_error_ulp(value: f32, num_ulps: f32, num_mantissa_bits: i32) -> f32 {
    value + num_ulps * get_single_ulp_for_value(value, num_mantissa_bits)
}

/// `INTERPOLATION_LOST_BITS` - number mantissa of bits allowed to be lost in varying
/// interpolation.
const INTERPOLATION_LOST_BITS: i32 = 3;

/// `getInterpolationLostBitsWarning`
fn get_interpolation_lost_bits_warning(precision: Precision) -> i32 {
    match precision {
        Precision::HighP => 9,
        Precision::MediumP => 3,
        Precision::LowP => 3,
    }
}

/// The shared body of `getDerivateThreshold` and `getDerivateThresholdWarning`, which
/// differ only in how many bits interpolation is allowed to lose.
fn derivate_threshold(
    precision: Precision,
    value_min: [f32; 4],
    value_max: [f32; 4],
    expected_derivate: [f32; 4],
    lost_bits: i32,
) -> [f32; 4] {
    let base_bits = get_num_mantissa_bits(precision);
    let deriv_exp = get_comp_exp_bits(expected_derivate);
    let exp_min = get_comp_exp_bits(value_min);
    let exp_max = get_comp_exp_bits(value_max);

    std::array::from_fn(|c| {
        let max_value_exp = exp_min[c].max(exp_max[c]);
        let num_bits_lost = max_value_exp - max_value_exp.min(deriv_exp[c]);
        let num_accurate_bits = (base_bits - num_bits_lost as i32 - lost_bits).max(0);
        compute_floating_point_error(expected_derivate[c], num_accurate_bits)
    })
}

/// `getDerivateThreshold`
fn get_derivate_threshold(
    precision: Precision,
    value_min: [f32; 4],
    value_max: [f32; 4],
    expected_derivate: [f32; 4],
) -> [f32; 4] {
    derivate_threshold(
        precision,
        value_min,
        value_max,
        expected_derivate,
        INTERPOLATION_LOST_BITS,
    )
}

/// `getDerivateThresholdWarning`
fn get_derivate_threshold_warning(
    precision: Precision,
    value_min: [f32; 4],
    value_max: [f32; 4],
    expected_derivate: [f32; 4],
) -> [f32; 4] {
    derivate_threshold(
        precision,
        value_min,
        value_max,
        expected_derivate,
        get_interpolation_lost_bits_warning(precision),
    )
}

/// `VerificationLogging`
#[derive(Clone, Copy, PartialEq, Eq)]
enum VerificationLogging {
    LogAll,
    LogNothing,
}

/// `verifyConstantDerivate`
fn verify_constant_derivate(
    result: &ConstPixelBufferAccess<'_>,
    data_type: DataType,
    reference: [f32; 4],
    threshold: [f32; 4],
    scale: [f32; 4],
    bias: [f32; 4],
    log_policy: VerificationLogging,
) -> TestResult {
    let num_comps = data_type.scalar_size();
    let mask = get_derivate_mask(data_type).map(|b| !b);
    let mut num_failed_pixels = 0;

    if log_policy == VerificationLogging::LogAll {
        log::debug!(
            "Expecting {} with threshold {}",
            log_vec_comps(reference, num_comps),
            log_vec_comps(threshold, num_comps)
        );
    }

    let [width, height, _] = result.size();
    for y in 0..height {
        for x in 0..width {
            let res_derivate = read_derivate(result, scale, bias, x, y);
            let is_ok = (0..4).all(|c| (reference[c] - res_derivate[c]).abs() <= threshold[c] || mask[c]);

            if !is_ok {
                if num_failed_pixels < MAX_FAILED_MESSAGES && log_policy == VerificationLogging::LogAll {
                    let diff: [f32; 4] = std::array::from_fn(|c| (reference[c] - res_derivate[c]).abs());
                    log::debug!(
                        "FAIL: got {}, diff = {}, at x = {x}, y = {y}",
                        log_vec_comps(res_derivate, num_comps),
                        log_vec_comps(diff, num_comps)
                    );
                }
                num_failed_pixels += 1;
            }
        }
    }

    if num_failed_pixels > 0 && log_policy == VerificationLogging::LogAll {
        log::debug!("FAIL: found {num_failed_pixels} failed pixels");
    }

    if num_failed_pixels == 0 {
        TestResult::Pass
    } else {
        TestResult::Fail
    }
}

/// `LogVecComps` - the first `num_comps` components, as upstream prints them.
fn log_vec_comps(v: [f32; 4], num_comps: i32) -> String {
    let comps: Vec<String> = v[..num_comps as usize].iter().map(|c| c.to_string()).collect();
    if num_comps == 1 {
        comps[0].clone()
    } else {
        format!("({})", comps.join(", "))
    }
}

/// `Linear2DFunctionEvaluator`
struct Linear2DFunctionEvaluator {
    matrix: [[f32; 3]; 4],
}

impl Linear2DFunctionEvaluator {
    /// ```text
    ///       .-----.
    ///       | s_x |
    ///   M x | s_y |
    ///       | 1.0 |
    ///       '-----'
    /// ```
    fn evaluate_at(&self, screen_x: f32, screen_y: f32) -> [f32; 4] {
        let position = [screen_x, screen_y, 1.0];
        std::array::from_fn(|r| {
            self.matrix[r][0] * position[0] + self.matrix[r][1] * position[1] + self.matrix[r][2] * position[2]
        })
    }
}

/// `reverifyConstantDerivateWithFlushRelaxations`
#[allow(clippy::too_many_arguments)]
fn reverify_constant_derivate_with_flush_relaxations(
    result: &ConstPixelBufferAccess<'_>,
    data_type: DataType,
    precision: Precision,
    deriv_scale: [f32; 4],
    deriv_bias: [f32; 4],
    surface_threshold: [f32; 4],
    derivate_func: DerivateFunc,
    function: &Linear2DFunctionEvaluator,
) -> TestResult {
    debug_assert!(derivate_func == DerivateFunc::Dfdx || derivate_func == DerivateFunc::Dfdy);

    let division_error_ulps = 2.5f32;

    let num_components = data_type.scalar_size() as usize;
    let num_bits = get_num_mantissa_bits(precision);
    let min_exponent = get_min_exponent(precision);

    let num_varying_sample_bits = num_bits - INTERPOLATION_LOST_BITS;
    let mut num_failed_pixels = 0;

    // search for failed pixels
    let [width, height, _] = result.size();
    for y in 0..height {
        for x in 0..width {
            //                 flushToZero?(f2z?(functionValueCurrent) - f2z?(functionValueBefore))
            // flushToZero? ( ------------------------------------------------------------------------ +- 2.5 ULP )
            //                                                  dx

            let result_derivative = read_derivate(result, deriv_scale, deriv_bias, x, y);

            // sample at the front of the back pixel and the back of the front pixel to cover the whole area of
            // legal sample positions. In general case this is NOT OK, but we know that the target function is
            // (mostly*) linear which allows us to take the sample points at arbitrary points. This gets us the
            // maximum difference possible in exponents which are used in error bound calculations.
            // * non-linearity may happen around zero or with very high function values due to subnorms not
            //   behaving well.
            let (fx, fy) = (x as f32, y as f32);
            let function_value_forward = if derivate_func == DerivateFunc::Dfdx {
                function.evaluate_at(fx + 2.0, fy + 0.5)
            } else {
                function.evaluate_at(fx + 0.5, fy + 2.0)
            };
            let function_value_backward = if derivate_func == DerivateFunc::Dfdx {
                function.evaluate_at(fx - 1.0, fy + 0.5)
            } else {
                function.evaluate_at(fx + 0.5, fy - 1.0)
            };

            // check components separately
            for c in 0..num_components {
                // Simulate interpolation. Add allowed interpolation error and round to target precision. Allow one half ULP (i.e. correct rounding)
                let forward_component = Interval::new(
                    convert_float_flush_to_zero_rtn(
                        add_error_ulp(function_value_forward[c], -0.5, num_varying_sample_bits),
                        min_exponent,
                        num_bits,
                    ) as f64,
                    convert_float_flush_to_zero_rtp(
                        add_error_ulp(function_value_forward[c], 0.5, num_varying_sample_bits),
                        min_exponent,
                        num_bits,
                    ) as f64,
                );
                let backward_component = Interval::new(
                    convert_float_flush_to_zero_rtn(
                        add_error_ulp(function_value_backward[c], -0.5, num_varying_sample_bits),
                        min_exponent,
                        num_bits,
                    ) as f64,
                    convert_float_flush_to_zero_rtp(
                        add_error_ulp(function_value_backward[c], 0.5, num_varying_sample_bits),
                        min_exponent,
                        num_bits,
                    ) as f64,
                );
                let max_value_exp = Float32::new(forward_component.lo() as f32)
                    .exponent()
                    .max(Float32::new(forward_component.hi() as f32).exponent())
                    .max(Float32::new(backward_component.lo() as f32).exponent())
                    .max(Float32::new(backward_component.hi() as f32).exponent());

                // subtraction in numerator will likely cause a cancellation of the most
                // significant bits. Apply error bounds.

                let numerator = forward_component - backward_component;
                let numerator_lo_exp = Float32::new(numerator.lo() as f32).exponent();
                let numerator_hi_exp = Float32::new(numerator.hi() as f32).exponent();
                // must clamp to zero since if forward and backward components have different
                // sign, numerator might have larger exponent than its operands.
                let numerator_lo_bits_lost = 0.max(max_value_exp - numerator_lo_exp);
                let numerator_hi_bits_lost = 0.max(max_value_exp - numerator_hi_exp);
                let numerator_lo_bits = 0.max(num_bits - numerator_lo_bits_lost);
                let numerator_hi_bits = 0.max(num_bits - numerator_hi_bits_lost);

                let numerator_range = Interval::new(
                    convert_float_flush_to_zero_rtn(numerator.lo() as f32, min_exponent, numerator_lo_bits) as f64,
                    convert_float_flush_to_zero_rtp(numerator.hi() as f32, min_exponent, numerator_hi_bits) as f64,
                );

                // legal sample area is anywhere within this and neighboring pixels (i.e. size = 3)
                let division_range = numerator_range / 3.0;
                let division_result_range = Interval::new(
                    convert_float_flush_to_zero_rtn(
                        add_error_ulp(division_range.lo() as f32, -division_error_ulps, num_bits),
                        min_exponent,
                        num_bits,
                    ) as f64,
                    convert_float_flush_to_zero_rtp(
                        add_error_ulp(division_range.hi() as f32, division_error_ulps, num_bits),
                        min_exponent,
                        num_bits,
                    ) as f64,
                );
                let final_result_range = Interval::new(
                    division_result_range.lo() - surface_threshold[c] as f64,
                    division_result_range.hi() + surface_threshold[c] as f64,
                );

                if result_derivative[c] as f64 >= final_result_range.lo()
                    && result_derivative[c] as f64 <= final_result_range.hi()
                {
                    // value ok
                } else {
                    if num_failed_pixels < MAX_FAILED_MESSAGES {
                        log::debug!(
                            "Error in pixel at {x}, {y} with component {c} (channel {}): dFd{} ~= {}, valid range [{}, {}]",
                            "rgba".as_bytes()[c] as char,
                            if derivate_func == DerivateFunc::Dfdx { 'x' } else { 'y' },
                            result_derivative[c],
                            final_result_range.lo(),
                            final_result_range.hi()
                        );
                    }

                    num_failed_pixels += 1;
                }
            }
        }
    }

    if num_failed_pixels > 0 {
        log::debug!("FAIL: found {num_failed_pixels} failed pixels");
    }

    if num_failed_pixels == 0 {
        TestResult::Pass
    } else {
        TestResult::Fail
    }
}

/// `genVertexSource`
fn gen_vertex_source(coord_type: DataType, precision: Precision) -> Result<String, TestError> {
    debug_assert!(coord_type.is_float_or_vec());

    const VERTEX_TMPL: &str = "#version 300 es\n\
                               in highp vec4 a_position;\n\
                               in ${PRECISION} ${DATATYPE} a_coord;\n\
                               out ${PRECISION} ${DATATYPE} v_coord;\n\
                               void main (void)\n\
                               {\n\
                               \x20   gl_Position = a_position;\n\
                               \x20   v_coord = a_coord;\n\
                               }\n";

    StringTemplate::new(VERTEX_TMPL).specialize(&[
        ("PRECISION", precision.name().to_string()),
        ("DATATYPE", coord_type.name().to_string()),
    ])
}

/// The `${CAST_TO_OUTPUT}` substitution every one of the three case classes builds the
/// same way, out of the result's type and whether it is packed into an integer target.
fn cast_to_output(data_type: DataType, pack_to_int: bool) -> String {
    let expr = match data_type {
        DataType::FloatVec4 => "res",
        DataType::FloatVec3 => "vec4(res, 1.0)",
        DataType::FloatVec2 => "vec4(res, 0.0, 1.0)",
        _ => "vec4(res, 0.0, 0.0, 1.0)",
    };
    if pack_to_int {
        format!("floatBitsToUint({expr})")
    } else {
        expr.to_string()
    }
}

/// The `m_coordMin`/`m_coordMax` (and, for the texture cases, `m_texValueMin`/
/// `m_texValueMax`) pair each precision uses.
fn value_range(precision: Precision) -> ([f32; 4], [f32; 4]) {
    match precision {
        Precision::HighP => ([-97.0, 0.2, 71.0, 74.0], [-13.2, -77.0, 44.0, 76.0]),
        Precision::MediumP => ([-37.0, 47.0, -7.0, 0.0], [-1.0, 12.0, 7.0, 19.0]),
        Precision::LowP => ([0.0, -1.0, 0.0, 1.0], [1.0, 1.0, -1.0, -1.0]),
    }
}

/// The scale - bias that normalizes the derivative of a value ramping from `min` to
/// `max` across a `w` x `h` viewport into the 0..1 range. Shared by `LinearDerivateCase`
/// and `TextureDerivateCase`, which compute it identically off their own value range.
fn normalizing_scale(func: DerivateFunc, value_min: [f32; 4], value_max: [f32; 4], w: f32, h: f32) -> [f32; 4] {
    let range: [f32; 4] = std::array::from_fn(|c| value_max[c] - value_min[c]);
    let dx_div = [w, w, w * 0.5, -w * 0.5];
    let dy_div = [h, h, h * 0.5, -h * 0.5];
    let dx: [f32; 4] = std::array::from_fn(|c| range[c] / dx_div[c]);
    let dy: [f32; 4] = std::array::from_fn(|c| range[c] / dy_div[c]);

    match func {
        DerivateFunc::Dfdx => std::array::from_fn(|c| 0.5 / dx[c]),
        DerivateFunc::Dfdy => std::array::from_fn(|c| 0.5 / dy[c]),
        DerivateFunc::Fwidth => std::array::from_fn(|c| 0.5 / (dx[c].abs() + dy[c].abs())),
    }
}

/// Which of the three concrete cases a `TriangleDerivateCase` is.
///
/// Upstream is three subclasses of `TriangleDerivateCase`; the shape that matters -
/// `init` fills the base's fields, `iterate` is shared and calls back into `verify` -
/// is kept, with the virtual calls dispatched on this instead.
#[derive(Clone, Copy, PartialEq, Eq)]
enum CaseKind {
    /// `ConstantDerivateCase`
    Constant,
    /// `LinearDerivateCase`, with the fragment-shader template the group registers it with.
    Linear(&'static str),
    /// `TextureDerivateCase`
    Texture,
}

/// `TriangleDerivateCase` and its three subclasses' constructor arguments.
struct TriangleDerivateCase {
    name: String,
    kind: CaseKind,
    func: DerivateFunc,

    data_type: DataType,
    precision: Precision,

    coord_data_type: DataType,
    coord_precision: Precision,

    surface_type: SurfaceType,
    num_samples: i32,
    hint: GLenum,

    use_asymmetric_coords: bool,
}

/// What `init` computes: everything `iterate` and `verify` read that depends on the
/// render target's size, which is not known until there is a context.
struct InitData {
    fragment_src: String,
    coord_min: [f32; 4],
    coord_max: [f32; 4],
    deriv_scale: [f32; 4],
    deriv_bias: [f32; 4],
    /// `TextureDerivateCase::m_texValueMin` / `m_texValueMax`, and the gradient level
    /// they fill. Absent for the other two kinds.
    texture: Option<TextureData>,
}

struct TextureData {
    value_min: [f32; 4],
    value_max: [f32; 4],
    internal_format: GLenum,
    level: TextureLevel,
}

impl TriangleDerivateCase {
    fn new(name: String, kind: CaseKind, func: DerivateFunc, data_type: DataType, precision: Precision) -> Self {
        Self {
            name,
            kind,
            func,
            data_type,
            precision,
            coord_data_type: data_type,
            coord_precision: precision,
            surface_type: SurfaceType::DefaultFramebuffer,
            num_samples: 0,
            hint: glw::GL_DONT_CARE,
            use_asymmetric_coords: false,
        }
    }

    /// `ConstantDerivateCase::ConstantDerivateCase`
    fn constant(name: String, func: DerivateFunc, type_: DataType) -> Self {
        Self::new(name, CaseKind::Constant, func, type_, Precision::HighP)
    }

    /// `LinearDerivateCase::LinearDerivateCase`
    #[allow(clippy::too_many_arguments)]
    fn linear(
        name: String,
        func: DerivateFunc,
        type_: DataType,
        precision: Precision,
        hint: GLenum,
        surface_type: SurfaceType,
        num_samples: i32,
        fragment_src_tmpl: &'static str,
    ) -> Self {
        Self {
            hint,
            surface_type,
            num_samples,
            use_asymmetric_coords: true,
            ..Self::new(name, CaseKind::Linear(fragment_src_tmpl), func, type_, precision)
        }
    }

    /// `TextureDerivateCase::TextureDerivateCase`
    fn texture(
        name: String,
        func: DerivateFunc,
        type_: DataType,
        precision: Precision,
        hint: GLenum,
        surface_type: SurfaceType,
        num_samples: i32,
    ) -> Self {
        Self {
            coord_data_type: DataType::FloatVec2,
            coord_precision: Precision::HighP,
            hint,
            surface_type,
            num_samples,
            ..Self::new(name, CaseKind::Texture, func, type_, precision)
        }
    }

    /// `TriangleDerivateCase::getViewportSize`
    fn get_viewport_size(&self, context: &Context) -> (i32, i32) {
        if self.surface_type == SurfaceType::DefaultFramebuffer {
            let target = context.render_target();
            (target.width.min(VIEWPORT_WIDTH), target.height.min(VIEWPORT_HEIGHT))
        } else {
            (FBO_WIDTH, FBO_HEIGHT)
        }
    }

    /// `TriangleDerivateCase::getSurfaceThreshold`
    fn get_surface_threshold(&self, context: &Context) -> [f32; 4] {
        match self.surface_type {
            SurfaceType::DefaultFramebuffer => {
                let pixel_format = context.render_target().pixel_format();
                let channel_bits = [
                    pixel_format.red_bits,
                    pixel_format.green_bits,
                    pixel_format.blue_bits,
                    pixel_format.alpha_bits,
                ];
                std::array::from_fn(|c| (1i32 << (8 - channel_bits[c])) as f32 / 255.0)
            }
            SurfaceType::UnormFbo => [1.0 / 255.0; 4],
            SurfaceType::FloatFbo => [0.0; 4],
        }
    }
}

/// `ConstantDerivateCase::init`
fn init_constant(case: &TriangleDerivateCase) -> Result<InitData, TestError> {
    const FRAGMENT_TMPL: &str = "#version 300 es\n\
                                 layout(location = 0) out mediump vec4 o_color;\n\
                                 uniform ${PRECISION} ${DATATYPE} u_scale;\n\
                                 uniform ${PRECISION} ${DATATYPE} u_bias;\n\
                                 void main (void)\n\
                                 {\n\
                                 \x20   ${PRECISION} ${DATATYPE} res = ${FUNC}(${VALUE}) * u_scale + u_bias;\n\
                                 \x20   o_color = ${CAST_TO_OUTPUT};\n\
                                 }\n";

    let value = match case.data_type {
        DataType::FloatVec4 => "vec4(1.0, 7.2, -1e5, 0.0)",
        DataType::FloatVec3 => "vec3(1e2, 8.0, 0.01)",
        DataType::FloatVec2 => "vec2(-0.0, 2.7)",
        _ => "7.7",
    };

    let fragment_src = StringTemplate::new(FRAGMENT_TMPL).specialize(&[
        ("PRECISION", case.precision.name().to_string()),
        ("DATATYPE", case.data_type.name().to_string()),
        ("FUNC", get_derivate_func_name(case.func).to_string()),
        ("VALUE", value.to_string()),
        ("CAST_TO_OUTPUT", cast_to_output(case.data_type, false)),
    ])?;

    Ok(InitData {
        fragment_src,
        coord_min: [0.0; 4],
        coord_max: [0.0; 4],
        deriv_scale: [1e3; 4],
        deriv_bias: [0.5; 4],
        texture: None,
    })
}

/// `LinearDerivateCase::init`
fn init_linear(case: &TriangleDerivateCase, context: &Context, fragment_tmpl: &str) -> Result<InitData, TestError> {
    let (viewport_w, viewport_h) = case.get_viewport_size(context);
    let w = viewport_w as f32;
    let h = viewport_h as f32;
    let pack_to_int = case.surface_type == SurfaceType::FloatFbo;

    let fragment_src = StringTemplate::new(fragment_tmpl).specialize(&[
        (
            "OUTPUT_TYPE",
            if pack_to_int {
                DataType::UintVec4
            } else {
                DataType::FloatVec4
            }
            .name()
            .to_string(),
        ),
        (
            "OUTPUT_PREC",
            if pack_to_int { Precision::HighP } else { case.precision }
                .name()
                .to_string(),
        ),
        ("PRECISION", case.precision.name().to_string()),
        ("DATATYPE", case.data_type.name().to_string()),
        ("FUNC", get_derivate_func_name(case.func).to_string()),
        ("CAST_TO_OUTPUT", cast_to_output(case.data_type, pack_to_int)),
    ])?;

    let (coord_min, coord_max) = value_range(case.precision);

    let (deriv_scale, deriv_bias) = if case.surface_type == SurfaceType::FloatFbo {
        // No scale or bias used for accuracy.
        ([1.0; 4], [0.0; 4])
    } else {
        // Compute scale - bias that normalizes to 0..1 range.
        (normalizing_scale(case.func, coord_min, coord_max, w, h), [0.0; 4])
    };

    Ok(InitData {
        fragment_src,
        coord_min,
        coord_max,
        deriv_scale,
        deriv_bias,
        texture: None,
    })
}

/// `TextureDerivateCase::init`
fn init_texture(case: &TriangleDerivateCase, context: &Context) -> Result<InitData, TestError> {
    const FRAGMENT_TMPL: &str = "#version 300 es\n\
                                 in highp vec2 v_coord;\n\
                                 layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
                                 uniform ${PRECISION} sampler2D u_sampler;\n\
                                 uniform ${PRECISION} ${DATATYPE} u_scale;\n\
                                 uniform ${PRECISION} ${DATATYPE} u_bias;\n\
                                 void main (void)\n\
                                 {\n\
                                 \x20   ${PRECISION} vec4 tex = texture(u_sampler, v_coord);\n\
                                 \x20   ${PRECISION} ${DATATYPE} res = ${FUNC}(tex${SWIZZLE}) * u_scale + u_bias;\n\
                                 \x20   o_color = ${CAST_TO_OUTPUT};\n\
                                 }\n";

    // Generate shader
    let pack_to_int = case.surface_type == SurfaceType::FloatFbo;
    let swizzle = match case.data_type {
        DataType::FloatVec4 => "",
        DataType::FloatVec3 => ".xyz",
        DataType::FloatVec2 => ".xy",
        _ => ".x",
    };

    let fragment_src = StringTemplate::new(FRAGMENT_TMPL).specialize(&[
        (
            "OUTPUT_TYPE",
            if pack_to_int {
                DataType::UintVec4
            } else {
                DataType::FloatVec4
            }
            .name()
            .to_string(),
        ),
        (
            "OUTPUT_PREC",
            if pack_to_int { Precision::HighP } else { case.precision }
                .name()
                .to_string(),
        ),
        ("PRECISION", case.precision.name().to_string()),
        ("DATATYPE", case.data_type.name().to_string()),
        ("FUNC", get_derivate_func_name(case.func).to_string()),
        ("SWIZZLE", swizzle.to_string()),
        ("CAST_TO_OUTPUT", cast_to_output(case.data_type, pack_to_int)),
    ])?;

    // Texture size matches viewport and nearest sampling is used. Thus texture sampling
    // is equal to just interpolating the texture value range.

    // Determine value range for texture.
    let (tex_value_min, tex_value_max) = value_range(case.precision);

    // Lowp and mediump cases use RGBA16F format, while highp uses RGBA32F.
    let (viewport_w, viewport_h) = case.get_viewport_size(context);
    let internal_format = if case.precision == Precision::HighP {
        glw::GL_RGBA32F
    } else {
        glw::GL_RGBA16F
    };
    let level_format = if case.precision == Precision::HighP {
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT)
    } else {
        TextureFormat::new(ChannelOrder::RGBA, ChannelType::HALF_FLOAT)
    };
    let mut level = TextureLevel::new(level_format, viewport_w as u32, viewport_h as u32, 1)?;

    // Fill with gradients.
    {
        let mut level0 = level.get_access();
        let [level_w, level_h, _] = level0.size();
        for y in 0..level_h {
            for x in 0..level_w {
                let xf = (x as f32 + 0.5) / level_w as f32;
                let yf = (y as f32 + 0.5) / level_h as f32;
                // Make x and y data to have dependency to both axes so that dfdx(tex).y and dfdy(tex).x are nonzero.
                let s = [xf + yf / 2.0, yf + xf / 2.0, (xf + yf) / 2.0, 1.0 - (xf + yf) / 2.0];
                let color: [f32; 4] =
                    std::array::from_fn(|c| tex_value_min[c] + (tex_value_max[c] - tex_value_min[c]) * s[c]);
                level0.set_pixel(color, x, y, 0);
            }
        }
    }

    let (deriv_scale, deriv_bias) = if case.surface_type == SurfaceType::FloatFbo {
        // No scale or bias used for accuracy.
        ([1.0; 4], [0.0; 4])
    } else {
        // Compute scale - bias that normalizes to 0..1 range.
        (
            normalizing_scale(
                case.func,
                tex_value_min,
                tex_value_max,
                viewport_w as f32,
                viewport_h as f32,
            ),
            [0.0; 4],
        )
    };

    Ok(InitData {
        fragment_src,
        // Texture coordinates
        coord_min: [0.0; 4],
        coord_max: [1.0; 4],
        deriv_scale,
        deriv_bias,
        texture: Some(TextureData {
            value_min: tex_value_min,
            value_max: tex_value_max,
            internal_format,
            level,
        }),
    })
}

/// `TextureDerivateCase::setupRenderState`
///
/// # Safety
/// A current context and a linked program that declares `u_sampler`.
unsafe fn setup_texture_render_state(gl: &glw::Functions, program: GLuint, texture: GLuint) {
    const TEX_UNIT: i32 = 1;

    // SAFETY: the texture is this case's own and the uniform location comes from the program.
    unsafe {
        gl.active_texture(glw::GL_TEXTURE0 + TEX_UNIT as GLenum);
        gl.bind_texture(glw::GL_TEXTURE_2D, texture);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MIN_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_MAG_FILTER, glw::GL_NEAREST as i32);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_S, glw::GL_CLAMP_TO_EDGE as i32);
        gl.tex_parameteri(glw::GL_TEXTURE_2D, glw::GL_TEXTURE_WRAP_T, glw::GL_CLAMP_TO_EDGE as i32);

        gl.uniform_1i(gl.get_uniform_location(program, c"u_sampler".as_ptr()), TEX_UNIT);
    }
}

/// `getTransferAlignment`/`computePixelStore` - what `GL_UNPACK_ALIGNMENT` has to be for
/// a tightly packed run of this format not to be padded.
fn compute_pixel_store(format: TextureFormat) -> i32 {
    let pixel_size = format.pixel_size().unwrap_or(1);
    if pixel_size.is_power_of_two() {
        pixel_size.min(8) as i32
    } else {
        1
    }
}

impl TestCase for TriangleDerivateCase {
    fn name(&self) -> &str {
        &self.name
    }

    /// `TriangleDerivateCase::iterate`, preceded by the subclass's `init`.
    fn iterate(&self, context: &Context) -> TestOutcome {
        let init = match self.kind {
            CaseKind::Constant => init_constant(self)?,
            CaseKind::Linear(tmpl) => init_linear(self, context, tmpl)?,
            CaseKind::Texture => init_texture(self, context)?,
        };

        let gl = context.gl();
        let program = ShaderProgram::new(
            gl,
            &ProgramSources::vtx_frag(
                gen_vertex_source(self.coord_data_type, self.coord_precision)?,
                init.fragment_src.clone(),
            ),
        );
        let mut rnd = Random::new(de_string_hash(&self.name) ^ 0x000b_bc24);
        let use_fbo = self.surface_type != SurfaceType::DefaultFramebuffer;
        let fbo_format = if self.surface_type == SurfaceType::FloatFbo {
            glw::GL_RGBA32UI
        } else {
            glw::GL_RGBA8
        };
        let (viewport_w, viewport_h) = self.get_viewport_size(context);
        let target = context.render_target();
        let viewport_x = if use_fbo {
            0
        } else {
            rnd.get_int(0, target.width - viewport_w)
        };
        let viewport_y = if use_fbo {
            0
        } else {
            rnd.get_int(0, target.height - viewport_h)
        };
        let fbo = glu::Framebuffer::new(gl);
        let rbo = glu::Renderbuffer::new(gl);

        if !program.is_ok() {
            return Err(TestError::Fail("Compile failed".to_string()));
        }

        if use_fbo {
            // SAFETY: the framebuffer and renderbuffer are this case's own.
            unsafe {
                gl.bind_renderbuffer(glw::GL_RENDERBUFFER, rbo.get());
                gl.renderbuffer_storage_multisample(
                    glw::GL_RENDERBUFFER,
                    self.num_samples,
                    fbo_format,
                    viewport_w,
                    viewport_h,
                );
                gl.bind_framebuffer(glw::GL_FRAMEBUFFER, fbo.get());
                gl.framebuffer_renderbuffer(
                    glw::GL_FRAMEBUFFER,
                    glw::GL_COLOR_ATTACHMENT0,
                    glw::GL_RENDERBUFFER,
                    rbo.get(),
                );
                if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                    return Err(TestError::Fail("Framebuffer is not complete".to_string()));
                }
            }
        }

        let result = self.render_and_verify(
            context, &program, &init, viewport_x, viewport_y, viewport_w, viewport_h, fbo_format,
        );

        // The FBO is this case's own; the next case would otherwise inherit it.
        // SAFETY: unbinding needs only a current context.
        unsafe { gl.bind_framebuffer(glw::GL_FRAMEBUFFER, 0) };

        result
    }
}

impl TriangleDerivateCase {
    /// The draw, the readback and the verification - the body of
    /// `TriangleDerivateCase::iterate` after the framebuffer is up.
    #[allow(clippy::too_many_arguments)]
    fn render_and_verify(
        &self,
        context: &Context,
        program: &ShaderProgram<'_>,
        init: &InitData,
        viewport_x: i32,
        viewport_y: i32,
        viewport_w: i32,
        viewport_h: i32,
        fbo_format: GLenum,
    ) -> TestOutcome {
        let gl = context.gl();
        let use_fbo = self.surface_type != SurfaceType::DefaultFramebuffer;

        // The texture the fragment shader samples, when there is one. Created here rather
        // than in `init` because it is a GL object and `init` produces only host data.
        let texture = init.texture.as_ref().map(|tex| {
            let handle = glu::Texture::new(gl);
            let transfer =
                glu::get_transfer_format(tex.level.format()).expect("RGBA32F/RGBA16F both have a transfer format");
            let [level_w, level_h, _] = tex.level.size();
            // SAFETY: the level is `level_w * level_h * pixelSize` bytes, which is what
            // the transfer format makes GL read.
            unsafe {
                gl.bind_texture(glw::GL_TEXTURE_2D, handle.get());
                gl.pixel_storei(glw::GL_UNPACK_ALIGNMENT, compute_pixel_store(tex.level.format()));
                gl.tex_image_2d(
                    glw::GL_TEXTURE_2D,
                    0,
                    tex.internal_format as i32,
                    level_w as i32,
                    level_h as i32,
                    0,
                    transfer.format,
                    transfer.data_type,
                    tex.level.data().as_ptr().cast(),
                );
            }
            handle
        });

        // Draw
        {
            let positions: [f32; 16] = [
                -1.0, -1.0, 0.0, 1.0, -1.0, 1.0, 0.0, 1.0, 1.0, -1.0, 0.0, 1.0, 1.0, 1.0, 0.0, 1.0,
            ];
            let (min, max) = (init.coord_min, init.coord_max);
            let mut coords: [f32; 16] = [
                min[0],
                min[1],
                min[2],
                max[3],
                min[0],
                max[1],
                (min[2] + max[2]) * 0.5,
                (min[3] + max[3]) * 0.5,
                max[0],
                min[1],
                (min[2] + max[2]) * 0.5,
                (min[3] + max[3]) * 0.5,
                max[0],
                max[1],
                max[2],
                min[3],
            ];

            // For linear tests we want varying data x and y to vary along both axes
            // to get nonzero x for dfdy and nonzero y for dfdx. To make the gradient
            // the same for both triangles we set vertices 2 and 3 to middle values.
            // This way the values go from min -> (max+min) / 2 or (max+min) / 2 -> max
            // depending on the triangle, but the derivative is the same for both.
            if self.use_asymmetric_coords {
                coords[4] = (min[0] + max[0]) * 0.5;
                coords[8] = coords[4];
                coords[5] = (min[1] + max[1]) * 0.5;
                coords[9] = coords[5];
            }

            let vertex_arrays = [
                glu::va::float("a_position", 4, 4, 0, &positions),
                glu::va::float("a_coord", 4, 4, 0, &coords),
            ];
            let indices: [u16; 6] = [0, 2, 1, 2, 3, 1];

            // SAFETY: the uniform locations come from this program, and a location of -1
            // is the documented no-op.
            unsafe {
                gl.clear_color(0.125, 0.25, 0.5, 1.0);
                gl.clear(glw::GL_COLOR_BUFFER_BIT | glw::GL_DEPTH_BUFFER_BIT | glw::GL_STENCIL_BUFFER_BIT);
                gl.disable(glw::GL_DITHER);

                gl.use_program(program.program());

                let scale_loc = gl.get_uniform_location(program.program(), c"u_scale".as_ptr());
                let bias_loc = gl.get_uniform_location(program.program(), c"u_bias".as_ptr());

                match self.data_type {
                    DataType::Float => {
                        gl.uniform_1f(scale_loc, init.deriv_scale[0]);
                        gl.uniform_1f(bias_loc, init.deriv_bias[0]);
                    }
                    DataType::FloatVec2 => {
                        gl.uniform_2fv(scale_loc, 1, init.deriv_scale.as_ptr());
                        gl.uniform_2fv(bias_loc, 1, init.deriv_bias.as_ptr());
                    }
                    DataType::FloatVec3 => {
                        gl.uniform_3fv(scale_loc, 1, init.deriv_scale.as_ptr());
                        gl.uniform_3fv(bias_loc, 1, init.deriv_bias.as_ptr());
                    }
                    _ => {
                        gl.uniform_4fv(scale_loc, 1, init.deriv_scale.as_ptr());
                        gl.uniform_4fv(bias_loc, 1, init.deriv_bias.as_ptr());
                    }
                }
            }

            crate::gls::shader_render_case::setup_default_uniforms(context, program.program());
            if let Some(handle) = &texture {
                // SAFETY: as above.
                unsafe { setup_texture_render_state(gl, program.program(), handle.get()) };
            }

            // SAFETY: a current context.
            unsafe {
                gl.hint(glw::GL_FRAGMENT_SHADER_DERIVATIVE_HINT, self.hint);
            }
            glu::expect_no_error(gl, "Setup program state")?;

            // SAFETY: as above.
            unsafe { gl.viewport(viewport_x, viewport_y, viewport_w, viewport_h) };
            glu::draw(
                &context.render_context,
                program.program(),
                &vertex_arrays,
                &glu::pr::triangles(&indices),
            )?;
            glu::expect_no_error(gl, "Draw")?;
        }

        // Read back results
        let is_msaa = use_fbo && self.num_samples > 0;
        let res_fbo = glu::Framebuffer::new(gl);
        let res_rbo = glu::Renderbuffer::new(gl);
        let mut result = TextureLevel::new(
            if self.surface_type == SurfaceType::FloatFbo {
                TextureFormat::new(ChannelOrder::RGBA, ChannelType::FLOAT)
            } else {
                TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNORM_INT8)
            },
            viewport_w as u32,
            viewport_h as u32,
            1,
        )?;

        {
            // Resolve if necessary
            if is_msaa {
                // SAFETY: both objects are this case's own.
                unsafe {
                    gl.bind_renderbuffer(glw::GL_RENDERBUFFER, res_rbo.get());
                    gl.renderbuffer_storage_multisample(glw::GL_RENDERBUFFER, 0, fbo_format, viewport_w, viewport_h);
                    gl.bind_framebuffer(glw::GL_DRAW_FRAMEBUFFER, res_fbo.get());
                    gl.framebuffer_renderbuffer(
                        glw::GL_DRAW_FRAMEBUFFER,
                        glw::GL_COLOR_ATTACHMENT0,
                        glw::GL_RENDERBUFFER,
                        res_rbo.get(),
                    );
                    if gl.check_framebuffer_status(glw::GL_FRAMEBUFFER) != glw::GL_FRAMEBUFFER_COMPLETE {
                        return Err(TestError::Fail("Resolve framebuffer is not complete".to_string()));
                    }

                    gl.blit_framebuffer(
                        0,
                        0,
                        viewport_w,
                        viewport_h,
                        0,
                        0,
                        viewport_w,
                        viewport_h,
                        glw::GL_COLOR_BUFFER_BIT,
                        glw::GL_NEAREST,
                    );
                    glu::expect_no_error(gl, "Resolve blit")?;

                    gl.bind_framebuffer(glw::GL_READ_FRAMEBUFFER, res_fbo.get());
                }
            }

            match self.surface_type {
                SurfaceType::DefaultFramebuffer | SurfaceType::UnormFbo => {
                    glu::read_pixels(
                        &context.render_context,
                        viewport_x,
                        viewport_y,
                        &mut result.get_access(),
                    )?;
                }
                SurfaceType::FloatFbo => {
                    // The data is float, but there is no core FP render target, so it comes
                    // back as the integer bit patterns `floatBitsToUint` wrote.
                    let transfer_format = TextureFormat::new(ChannelOrder::RGBA, ChannelType::UNSIGNED_INT32);
                    let size = result.size();
                    let mut transfer_access = PixelBufferAccess::new(transfer_format, size, result.data_mut());
                    glu::read_pixels(&context.render_context, viewport_x, viewport_y, &mut transfer_access)?;
                }
            }

            glu::expect_no_error(gl, "Read pixels")?;
        }

        // Verify
        let test_result = self.verify(context, init, &result.get_const_access());

        Ok(match test_result {
            TestResult::Pass => TestStatus::pass("Pass"),
            TestResult::QualityWarning => TestStatus::new(TestResult::QualityWarning, "QualityWarning"),
            other => TestStatus::new(other, "Fail"),
        })
    }

    /// `ConstantDerivateCase::verify` / `LinearDerivateCase::verify` /
    /// `TextureDerivateCase::verify`.
    fn verify(&self, context: &Context, init: &InitData, result: &ConstPixelBufferAccess<'_>) -> TestResult {
        match self.kind {
            CaseKind::Constant => {
                // Derivate of constant argument should always be 0
                let reference = [0.0f32; 4];
                let surface_threshold = self.get_surface_threshold(context);
                let threshold: [f32; 4] = std::array::from_fn(|c| surface_threshold[c] / init.deriv_scale[c].abs());

                verify_constant_derivate(
                    result,
                    self.data_type,
                    reference,
                    threshold,
                    init.deriv_scale,
                    init.deriv_bias,
                    VerificationLogging::LogAll,
                )
            }
            CaseKind::Linear(_) => self.verify_linear(context, init, result),
            CaseKind::Texture => self.verify_texture(context, init, result),
        }
    }

    /// `LinearDerivateCase::verify`
    fn verify_linear(&self, context: &Context, init: &InitData, result: &ConstPixelBufferAccess<'_>) -> TestResult {
        let x_scale = [0.5f32, 0.5, 0.5, -0.5];
        let y_scale = [0.5f32, 0.5, 0.5, -0.5];

        let base_threshold = self.get_surface_threshold(context);
        let surface_threshold: [f32; 4] = std::array::from_fn(|c| base_threshold[c] / init.deriv_scale[c].abs());
        let [width, height, _] = result.size();

        if self.func == DerivateFunc::Dfdx || self.func == DerivateFunc::Dfdy {
            let is_x = self.func == DerivateFunc::Dfdx;
            let div = if is_x { width as f32 } else { height as f32 };
            let scale = if is_x { x_scale } else { y_scale };
            let mut reference: [f32; 4] = std::array::from_fn(|c| (init.coord_max[c] - init.coord_min[c]) / div);
            let op_threshold = get_derivate_threshold(self.precision, init.coord_min, init.coord_max, reference);
            let op_threshold_w =
                get_derivate_threshold_warning(self.precision, init.coord_min, init.coord_max, reference);
            let threshold: [f32; 4] = std::array::from_fn(|c| surface_threshold[c].max(op_threshold[c]));
            let threshold_w: [f32; 4] = std::array::from_fn(|c| surface_threshold[c].max(op_threshold_w[c]));

            // adjust the reference value for the correct dfdx or dfdy sample adjacency
            reference = std::array::from_fn(|c| reference[c] * scale[c]);

            // short circuit if result is strictly within the normal value error bounds.
            // This improves performance significantly.
            if verify_constant_derivate(
                result,
                self.data_type,
                reference,
                threshold,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogNothing,
            ) == TestResult::Pass
            {
                return TestResult::Pass;
            }

            // Check with relaxed threshold value
            if verify_constant_derivate(
                result,
                self.data_type,
                reference,
                threshold_w,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogNothing,
            ) == TestResult::Pass
            {
                return TestResult::QualityWarning;
            }

            // some pixels exceed error bounds calculated for normal values. Verify that these
            // potentially invalid pixels are in fact valid due to (for example) subnorm flushing.
            let (viewport_w, viewport_h) = self.get_viewport_size(context);
            let w = viewport_w as f32;
            let h = viewport_h as f32;
            let value_ramp: [f32; 4] = std::array::from_fn(|c| init.coord_max[c] - init.coord_min[c]);
            let function = Linear2DFunctionEvaluator {
                matrix: [
                    [(value_ramp[0] / w) / 2.0, (value_ramp[0] / h) / 2.0, init.coord_min[0]],
                    [(value_ramp[1] / w) / 2.0, (value_ramp[1] / h) / 2.0, init.coord_min[1]],
                    [
                        value_ramp[2] / w / 2.0,
                        value_ramp[2] / h / 2.0,
                        (init.coord_min[2] + init.coord_min[2]) / 2.0,
                    ],
                    [
                        -value_ramp[3] / w / 2.0,
                        -value_ramp[3] / h / 2.0,
                        (init.coord_max[3] + init.coord_max[3]) / 2.0,
                    ],
                ],
            };

            reverify_constant_derivate_with_flush_relaxations(
                result,
                self.data_type,
                self.precision,
                init.deriv_scale,
                init.deriv_bias,
                surface_threshold,
                self.func,
                &function,
            )
        } else {
            debug_assert!(self.func == DerivateFunc::Fwidth);
            let w = width as f32;
            let h = height as f32;

            let dx: [f32; 4] = std::array::from_fn(|c| (init.coord_max[c] - init.coord_min[c]) / w * x_scale[c]);
            let dy: [f32; 4] = std::array::from_fn(|c| (init.coord_max[c] - init.coord_min[c]) / h * y_scale[c]);
            let reference: [f32; 4] = std::array::from_fn(|c| dx[c].abs() + dy[c].abs());
            let coord_min_x: [f32; 4] = std::array::from_fn(|c| init.coord_min[c] * x_scale[c]);
            let coord_max_x: [f32; 4] = std::array::from_fn(|c| init.coord_max[c] * x_scale[c]);
            let coord_min_y: [f32; 4] = std::array::from_fn(|c| init.coord_min[c] * y_scale[c]);
            let coord_max_y: [f32; 4] = std::array::from_fn(|c| init.coord_max[c] * y_scale[c]);
            let dx_threshold = get_derivate_threshold(self.precision, coord_min_x, coord_max_x, dx);
            let dy_threshold = get_derivate_threshold(self.precision, coord_min_y, coord_max_y, dy);
            let dx_threshold_w = get_derivate_threshold_warning(self.precision, coord_min_x, coord_max_x, dx);
            let dy_threshold_w = get_derivate_threshold_warning(self.precision, coord_min_y, coord_max_y, dy);
            let threshold: [f32; 4] =
                std::array::from_fn(|c| surface_threshold[c].max(dx_threshold[c].max(dy_threshold[c])));
            let threshold_w: [f32; 4] =
                std::array::from_fn(|c| surface_threshold[c].max(dx_threshold_w[c].max(dy_threshold_w[c])));

            let mut test_result = verify_constant_derivate(
                result,
                self.data_type,
                reference,
                threshold,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogAll,
            );

            // return if result is pass
            if test_result == TestResult::Pass {
                return test_result;
            }

            // re-check with relaxed threshold
            test_result = verify_constant_derivate(
                result,
                self.data_type,
                reference,
                threshold_w,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogAll,
            );

            // if with relaxed threshold test is passing then mark the result with quality warning.
            if test_result == TestResult::Pass {
                test_result = TestResult::QualityWarning;
            }

            test_result
        }
    }

    /// `TextureDerivateCase::verify`
    fn verify_texture(&self, context: &Context, init: &InitData, result: &ConstPixelBufferAccess<'_>) -> TestResult {
        let tex = init.texture.as_ref().expect("a texture case always has texture data");
        let [full_width, full_height, _] = result.size();

        // \note Edges are ignored in comparison
        if full_width < 2 || full_height < 2 {
            // Upstream throws tcu::NotSupportedError here; no render target this runs on
            // is that small, so reaching it would be a harness problem rather than a
            // driver one.
            return TestResult::Fail;
        }

        let compare_area = result.get_subregion(1, 1, 0, full_width - 2, full_height - 2, 1);
        let x_scale = [1.0f32, 0.5, 0.5, -0.5];
        let y_scale = [0.5f32, 1.0, 0.5, -0.5];
        let w = full_width as f32;
        let h = full_height as f32;

        let base_threshold = self.get_surface_threshold(context);
        let surface_threshold: [f32; 4] = std::array::from_fn(|c| base_threshold[c] / init.deriv_scale[c].abs());

        if self.func == DerivateFunc::Dfdx || self.func == DerivateFunc::Dfdy {
            let is_x = self.func == DerivateFunc::Dfdx;
            let div = if is_x { w } else { h };
            let scale = if is_x { x_scale } else { y_scale };
            let mut reference: [f32; 4] = std::array::from_fn(|c| (tex.value_max[c] - tex.value_min[c]) / div);
            let op_threshold = get_derivate_threshold(self.precision, tex.value_min, tex.value_max, reference);
            let op_threshold_w =
                get_derivate_threshold_warning(self.precision, tex.value_min, tex.value_max, reference);
            let threshold: [f32; 4] = std::array::from_fn(|c| surface_threshold[c].max(op_threshold[c]));
            let threshold_w: [f32; 4] = std::array::from_fn(|c| surface_threshold[c].max(op_threshold_w[c]));

            // adjust the reference value for the correct dfdx or dfdy sample adjacency
            reference = std::array::from_fn(|c| reference[c] * scale[c]);

            // short circuit if result is strictly within the normal value error bounds.
            // This improves performance significantly.
            if verify_constant_derivate(
                &compare_area,
                self.data_type,
                reference,
                threshold,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogNothing,
            ) == TestResult::Pass
            {
                return TestResult::Pass;
            }

            // Re-check with relaxed threshold
            if verify_constant_derivate(
                &compare_area,
                self.data_type,
                reference,
                threshold_w,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogNothing,
            ) == TestResult::Pass
            {
                return TestResult::QualityWarning;
            }

            // some pixels exceed error bounds calculated for normal values. Verify that these
            // potentially invalid pixels are in fact valid due to (for example) subnorm flushing.
            let value_ramp: [f32; 4] = std::array::from_fn(|c| tex.value_max[c] - tex.value_min[c]);
            let function = Linear2DFunctionEvaluator {
                matrix: [
                    [value_ramp[0] / w, (value_ramp[0] / h) / 2.0, tex.value_min[0]],
                    [(value_ramp[1] / w) / 2.0, value_ramp[1] / h, tex.value_min[1]],
                    [
                        value_ramp[2] / w / 2.0,
                        value_ramp[2] / h / 2.0,
                        (tex.value_min[2] + tex.value_min[2]) / 2.0,
                    ],
                    [
                        -value_ramp[3] / w / 2.0,
                        -value_ramp[3] / h / 2.0,
                        (tex.value_max[3] + tex.value_max[3]) / 2.0,
                    ],
                ],
            };

            reverify_constant_derivate_with_flush_relaxations(
                &compare_area,
                self.data_type,
                self.precision,
                init.deriv_scale,
                init.deriv_bias,
                surface_threshold,
                self.func,
                &function,
            )
        } else {
            debug_assert!(self.func == DerivateFunc::Fwidth);
            let dx: [f32; 4] = std::array::from_fn(|c| (tex.value_max[c] - tex.value_min[c]) / w * x_scale[c]);
            let dy: [f32; 4] = std::array::from_fn(|c| (tex.value_max[c] - tex.value_min[c]) / h * y_scale[c]);
            let reference: [f32; 4] = std::array::from_fn(|c| dx[c].abs() + dy[c].abs());
            let min_x: [f32; 4] = std::array::from_fn(|c| tex.value_min[c] * x_scale[c]);
            let max_x: [f32; 4] = std::array::from_fn(|c| tex.value_max[c] * x_scale[c]);
            let min_y: [f32; 4] = std::array::from_fn(|c| tex.value_min[c] * y_scale[c]);
            let max_y: [f32; 4] = std::array::from_fn(|c| tex.value_max[c] * y_scale[c]);
            let dx_threshold = get_derivate_threshold(self.precision, min_x, max_x, dx);
            let dy_threshold = get_derivate_threshold(self.precision, min_y, max_y, dy);
            let dx_threshold_w = get_derivate_threshold_warning(self.precision, min_x, max_x, dx);
            let dy_threshold_w = get_derivate_threshold_warning(self.precision, min_y, max_y, dy);
            let threshold: [f32; 4] =
                std::array::from_fn(|c| surface_threshold[c].max(dx_threshold[c].max(dy_threshold[c])));
            let threshold_w: [f32; 4] =
                std::array::from_fn(|c| surface_threshold[c].max(dx_threshold_w[c].max(dy_threshold_w[c])));

            let mut test_result = verify_constant_derivate(
                &compare_area,
                self.data_type,
                reference,
                threshold,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogAll,
            );

            if test_result == TestResult::Pass {
                return test_result;
            }

            // Re-Check with relaxed threshold
            test_result = verify_constant_derivate(
                &compare_area,
                self.data_type,
                reference,
                threshold_w,
                init.deriv_scale,
                init.deriv_bias,
                VerificationLogging::LogAll,
            );

            // If test is passing with relaxed threshold then mark quality warning
            if test_result == TestResult::Pass {
                test_result = TestResult::QualityWarning;
            }

            test_result
        }
    }
}

/// `s_linearDerivateCases`
const LINEAR_DERIVATE_CASES: &[(&str, &str)] = &[
    (
        "linear",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res = ${FUNC}(v_coord) * u_scale + u_bias;\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "in_function",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         \n\
         ${PRECISION} ${DATATYPE} computeRes (${PRECISION} ${DATATYPE} value)\n\
         {\n\
         \x20   return ${FUNC}(v_coord) * u_scale + u_bias;\n\
         }\n\
         \n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res = computeRes(v_coord);\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "static_if",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res;\n\
         \x20   if (false)\n\
         \x20       res = ${FUNC}(-v_coord) * u_scale + u_bias;\n\
         \x20   else\n\
         \x20       res = ${FUNC}(v_coord) * u_scale + u_bias;\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "static_loop",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res = ${DATATYPE}(0.0);\n\
         \x20   for (int i = 0; i < 2; i++)\n\
         \x20       res += ${FUNC}(v_coord * float(i));\n\
         \x20   res = res * u_scale + u_bias;\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "static_switch",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res;\n\
         \x20   switch (1)\n\
         \x20   {\n\
         \x20       case 0: res = ${FUNC}(-v_coord) * u_scale + u_bias;    break;\n\
         \x20       case 1: res = ${FUNC}(v_coord) * u_scale + u_bias;    break;\n\
         \x20   }\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "uniform_if",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         uniform bool ub_true;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res;\n\
         \x20   if (ub_true)\
         \x20       res = ${FUNC}(v_coord) * u_scale + u_bias;\n\
         \x20   else\n\
         \x20       res = ${FUNC}(-v_coord) * u_scale + u_bias;\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "uniform_loop",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         uniform int ui_two;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res = ${DATATYPE}(0.0);\n\
         \x20   for (int i = 0; i < ui_two; i++)\n\
         \x20       res += ${FUNC}(v_coord * float(i));\n\
         \x20   res = res * u_scale + u_bias;\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
    (
        "uniform_switch",
        "#version 300 es\n\
         in ${PRECISION} ${DATATYPE} v_coord;\n\
         layout(location = 0) out ${OUTPUT_PREC} ${OUTPUT_TYPE} o_color;\n\
         uniform ${PRECISION} ${DATATYPE} u_scale;\n\
         uniform ${PRECISION} ${DATATYPE} u_bias;\n\
         uniform int ui_one;\n\
         void main (void)\n\
         {\n\
         \x20   ${PRECISION} ${DATATYPE} res;\n\
         \x20   switch (ui_one)\n\
         \x20   {\n\
         \x20       case 0: res = ${FUNC}(-v_coord) * u_scale + u_bias;    break;\n\
         \x20       case 1: res = ${FUNC}(v_coord) * u_scale + u_bias;    break;\n\
         \x20   }\n\
         \x20   o_color = ${CAST_TO_OUTPUT};\n\
         }\n",
    ),
];

/// `s_fboConfigs`
const FBO_CONFIGS: &[(&str, SurfaceType, i32)] = &[
    ("fbo", SurfaceType::DefaultFramebuffer, 0),
    ("fbo_msaa2", SurfaceType::UnormFbo, 2),
    ("fbo_msaa4", SurfaceType::UnormFbo, 4),
    ("fbo_float", SurfaceType::FloatFbo, 0),
];

/// `s_hints`
const HINTS: &[(&str, GLenum)] = &[("fastest", glw::GL_FASTEST), ("nicest", glw::GL_NICEST)];

/// `s_hintFboConfigs`
const HINT_FBO_CONFIGS: &[(&str, SurfaceType, i32)] = &[
    ("default", SurfaceType::DefaultFramebuffer, 0),
    ("fbo_msaa4", SurfaceType::UnormFbo, 4),
    ("fbo_float", SurfaceType::FloatFbo, 0),
];

/// `s_textureConfigs`
const TEXTURE_CONFIGS: &[(&str, SurfaceType, i32, GLenum)] = &[
    ("basic", SurfaceType::DefaultFramebuffer, 0, glw::GL_DONT_CARE),
    ("msaa4", SurfaceType::UnormFbo, 4, glw::GL_DONT_CARE),
    ("float_fastest", SurfaceType::FloatFbo, 0, glw::GL_FASTEST),
    ("float_nicest", SurfaceType::FloatFbo, 0, glw::GL_NICEST),
];

/// The `vecSize` x `precNdx` loop every group below is, in upstream's own order.
const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

fn boxed(case: TriangleDerivateCase) -> Box<dyn TestCase> {
    Box::new(case)
}

fn data_type_for_vec_size(vec_size: i32) -> DataType {
    if vec_size > 1 {
        glu::get_data_type_float_vec(vec_size)
    } else {
        DataType::Float
    }
}

/// `ShaderDerivateTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("derivate");

    // .dfdx, .dfdy, .fwidth
    for function in [DerivateFunc::Dfdx, DerivateFunc::Dfdy, DerivateFunc::Fwidth] {
        let mut function_group = TestCaseGroup::new(get_derivate_func_case_name(function));

        // .constant - no precision variants, checks that derivate of constant arguments is 0
        {
            let mut constant_group = TestCaseGroup::new("constant");

            for vec_size in 1..=4 {
                let data_type = data_type_for_vec_size(vec_size);
                constant_group.add_child(boxed(TriangleDerivateCase::constant(
                    data_type.name().to_string(),
                    function,
                    data_type,
                )));
            }

            function_group.add_child(constant_group);
        }

        // Cases based on LinearDerivateCase
        for (case_name, source) in LINEAR_DERIVATE_CASES {
            let mut linear_case_group = TestCaseGroup::new(*case_name);

            for vec_size in 1..=4 {
                for precision in PRECISIONS {
                    let data_type = data_type_for_vec_size(vec_size);
                    let surface_type = SurfaceType::DefaultFramebuffer;
                    let num_samples = 0;
                    let hint = glw::GL_DONT_CARE;

                    if *case_name != "linear" && precision == Precision::LowP {
                        continue; // Skip as lowp doesn't actually produce any bits when rendered to default FB.
                    }

                    let name = format!("{}_{}", data_type.name(), precision.name());
                    linear_case_group.add_child(boxed(TriangleDerivateCase::linear(
                        name,
                        function,
                        data_type,
                        precision,
                        hint,
                        surface_type,
                        num_samples,
                        source,
                    )));
                }
            }

            function_group.add_child(linear_case_group);
        }

        // Fbo cases
        for (config_name, surface_type, num_samples) in FBO_CONFIGS {
            let mut fbo_group = TestCaseGroup::new(*config_name);
            // use source from .linear group
            let source = LINEAR_DERIVATE_CASES[0].1;

            for vec_size in 1..=4 {
                for precision in PRECISIONS {
                    let data_type = data_type_for_vec_size(vec_size);
                    let hint = glw::GL_DONT_CARE;

                    if *surface_type != SurfaceType::FloatFbo && precision == Precision::LowP {
                        continue; // Skip as lowp doesn't actually produce any bits when rendered to U8 RT.
                    }

                    let name = format!("{}_{}", data_type.name(), precision.name());
                    fbo_group.add_child(boxed(TriangleDerivateCase::linear(
                        name,
                        function,
                        data_type,
                        precision,
                        hint,
                        *surface_type,
                        *num_samples,
                        source,
                    )));
                }
            }

            function_group.add_child(fbo_group);
        }

        // .fastest, .nicest
        for (hint_name, hint) in HINTS {
            let mut hint_group = TestCaseGroup::new(*hint_name);
            // use source from .linear group
            let source = LINEAR_DERIVATE_CASES[0].1;

            for (fbo_name, surface_type, num_samples) in HINT_FBO_CONFIGS {
                let mut fbo_group = TestCaseGroup::new(*fbo_name);

                for vec_size in 1..=4 {
                    for precision in PRECISIONS {
                        let data_type = data_type_for_vec_size(vec_size);

                        if *surface_type != SurfaceType::FloatFbo && precision == Precision::LowP {
                            continue; // Skip as lowp doesn't actually produce any bits when rendered to U8 RT.
                        }

                        let name = format!("{}_{}", data_type.name(), precision.name());
                        fbo_group.add_child(boxed(TriangleDerivateCase::linear(
                            name,
                            function,
                            data_type,
                            precision,
                            *hint,
                            *surface_type,
                            *num_samples,
                            source,
                        )));
                    }
                }

                hint_group.add_child(fbo_group);
            }

            function_group.add_child(hint_group);
        }

        // .texture
        {
            let mut texture_group = TestCaseGroup::new("texture");

            for (config_name, surface_type, num_samples, hint) in TEXTURE_CONFIGS {
                let mut case_group = TestCaseGroup::new(*config_name);

                for vec_size in 1..=4 {
                    for precision in PRECISIONS {
                        let data_type = data_type_for_vec_size(vec_size);

                        if *surface_type != SurfaceType::FloatFbo && precision == Precision::LowP {
                            continue; // Skip as lowp doesn't actually produce any bits when rendered to U8 RT.
                        }

                        let name = format!("{}_{}", data_type.name(), precision.name());
                        case_group.add_child(boxed(TriangleDerivateCase::texture(
                            name,
                            function,
                            data_type,
                            precision,
                            *hint,
                            *surface_type,
                            *num_samples,
                        )));
                    }
                }

                texture_group.add_child(case_group);
            }

            function_group.add_child(texture_group);
        }

        group.add_child(function_group);
    }

    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderDerivateTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The `constant`, `linear` (all its templates but `linear_vec8`), `fbo`, `fbo_msaa2`, `fbo_msaa4`, `fbo_float` and `texture` cases of every derivative function are ported (`ConstantDerivateCase` and `LinearDerivateCase`, over the
// ShaderRenderCase harness with a verifier in place of the reference image); `linear_vec8` (VK_EXT_shader_long_vector) is not. The float target is RGBA32UI holding the bits of the floats, as upstream.
// The `linear` verifier is `verifyConstantDerivate` and, for dfdx and dfdy, `reverifyConstantDerivateWithFlushRelaxations`. The shaders are written by
// `scripts/gen_shader_render_derivate.py`.

use vulkanalia::vk;

use super::shader_render::{CustomGeometry, ShaderEvalContext, ShaderRenderCase, TextureSpec, UniformValue, case_key};
use crate::tcu::float::Float16;
use crate::vkt::{TestCase, TestCaseGroup};

const SUBGROUP_FUNCS: [&str; 2] = ["dfdxsubgroup", "dfdysubgroup"];
const FUNCS: [&str; 9] = [
    "dfdx",
    "dfdxfine",
    "dfdxcoarse",
    "dfdy",
    "dfdyfine",
    "dfdycoarse",
    "fwidth",
    "fwidthfine",
    "fwidthcoarse",
];
const TYPES: [(&str, usize); 4] = [("float", 1), ("vec2", 2), ("vec3", 3), ("vec4", 4)];

/// `ConstantDerivateCase`: `derivScale` 1e3 and `derivBias` 0.5 as the uniforms Scale and Bias
fn constant_case(func: &'static str, type_name: &'static str, num_comps: usize) -> ShaderRenderCase {
    const SCALE: f32 = 1e3;
    const BIAS: f32 = 0.5;
    let uniforms = vec![
        (0, UniformValue::Vec4s([[SCALE; 4]; 4])),
        (1, UniformValue::Vec4s([[BIAS; 4]; 4])),
    ];
    let key = case_key("derivate", &format!("{func}_constant_{type_name}"));
    // `verifyConstantDerivate`: the derivative read back from the colour is zero, within one 8 bit step divided by the scale, in the components of the type
    let verifier = move |pixels: &[u8]| {
        let threshold = (1.0f32 / 255.0) / SCALE.abs();
        pixels
            .chunks_exact(4)
            .all(|pixel| (0..num_comps).all(|c| ((f32::from(pixel[c]) / 255.0 - BIAS) / SCALE).abs() <= threshold))
    };
    ShaderRenderCase::with_closure(
        type_name.to_string(),
        key,
        false,
        Box::new(|_: &mut ShaderEvalContext| {}),
        uniforms,
    )
    .with_verifier(Box::new(verifier))
}

const LINEAR_CASES: [&str; 13] = [
    "linear",
    "in_function",
    "static_if",
    "static_loop",
    "static_switch",
    "uniform_if",
    "uniform_loop",
    "uniform_switch",
    "dynamic_if",
    "dynamic_loop",
    "dynamic_switch",
    "output_store",
    "private_store",
];
const VIEWPORT_WIDTH: u32 = 99;
const VIEWPORT_HEIGHT: u32 = 133;
const INTERPOLATION_LOST_BITS: i32 = 3;

type Vec4 = [f32; 4];

fn exponent(value: f32) -> i32 {
    ((value.to_bits() >> 23) & 0xff) as i32 - 127
}

fn compute_float_error(value: f32, num_accurate_bits: i32) -> f32 {
    let mask = (1u32 << (23 - num_accurate_bits)) - 1;
    let base = ((exponent(value) + 127).clamp(0, 254) as u32) << 23;
    f32::from_bits(base | mask) - f32::from_bits(base)
}

fn mantissa_bits(precision: &str) -> i32 {
    match precision {
        "highp" => 23,
        "mediump" => 10,
        _ => 6,
    }
}

/// `getDerivateThreshold`
fn derivate_threshold(precision: &str, value_min: Vec4, value_max: Vec4, expected: Vec4) -> Vec4 {
    let base_bits = mantissa_bits(precision);
    let exp_bits = |v: f32| ((v.to_bits() >> 23) & 0xff) as i32;
    std::array::from_fn(|c| {
        let max_value_exp = exp_bits(value_min[c]).max(exp_bits(value_max[c]));
        let bits_lost = max_value_exp - max_value_exp.min(exp_bits(expected[c]));
        compute_float_error(expected[c], (base_bits - bits_lost - INTERPOLATION_LOST_BITS).max(0))
    })
}

type Interval = (f32, f32);

fn mantissa(value: f32) -> u32 {
    value.to_bits() & 0x7f_ffff
}

fn construct(negative: bool, exp: i32, mantissa: u32) -> f32 {
    f32::from_bits((u32::from(negative) << 31) | (((exp + 127).clamp(0, 254) as u32) << 23) | (mantissa & 0x7f_ffff))
}

fn single_ulp_for_exponent(exp: i32, num_mantissa_bits: i32) -> f32 {
    2f32.powi(exp - num_mantissa_bits)
}

fn add_error_ulp(value: f32, num_ulps: f32, num_mantissa_bits: i32) -> f32 {
    value + num_ulps * single_ulp_for_exponent(exponent(value), num_mantissa_bits)
}

fn convert_flush_to_zero_rtn(value: f32, min_exponent: i32, num_accurate_bits: i32) -> f32 {
    if value == 0.0 {
        return 0.0;
    }
    let trunc_mask = (1u32 << (23 - num_accurate_bits)) - 1;
    if value > 0.0 {
        if exponent(value) < min_exponent {
            0.0
        } else {
            construct(false, exponent(value), mantissa(value) & !trunc_mask)
        }
    } else if mantissa(value) & trunc_mask != 0 {
        construct(true, exponent(value), mantissa(value) & !trunc_mask)
            - single_ulp_for_exponent(exponent(value), num_accurate_bits)
    } else {
        value
    }
}

fn convert_flush_to_zero_rtp(value: f32, min_exponent: i32, num_accurate_bits: i32) -> f32 {
    -convert_flush_to_zero_rtn(-value, min_exponent, num_accurate_bits)
}

/// `reverifyConstantDerivateWithFlushRelaxations` for the `dfdx` and `dfdy` functions
fn reverify_with_flush_relaxations(
    derivatives: &[Vec4],
    width: usize,
    num_comps: usize,
    precision: &str,
    surface_threshold: Vec4,
    func: &str,
    matrix: [[f32; 3]; 4],
) -> bool {
    let is_x = func.starts_with("dfdx");
    let evaluate = |screen_x: f32, screen_y: f32| -> Vec4 {
        std::array::from_fn(|row| matrix[row][0] * screen_x + matrix[row][1] * screen_y + matrix[row][2])
    };
    let division_error_ulps = 2.5;
    let num_bits = mantissa_bits(precision);
    let min_exponent = match precision {
        "highp" => -126,
        "mediump" => -14,
        _ => -8,
    };
    let num_varying_sample_bits = num_bits - INTERPOLATION_LOST_BITS;
    let simulate = |value: f32| -> Interval {
        (
            convert_flush_to_zero_rtn(
                add_error_ulp(value, -0.5, num_varying_sample_bits),
                min_exponent,
                num_bits,
            ),
            convert_flush_to_zero_rtp(
                add_error_ulp(value, 0.5, num_varying_sample_bits),
                min_exponent,
                num_bits,
            ),
        )
    };
    derivatives.iter().enumerate().all(|(index, derivative)| {
        let (x, y) = ((index % width) as f32, (index / width) as f32);
        // upstream picks the backward sample of dfdx with `isDfdyFunc`, kept as it is
        let forward = if is_x {
            evaluate(x + 2.0, y + 0.5)
        } else {
            evaluate(x + 0.5, y + 2.0)
        };
        let backward = if !is_x {
            evaluate(x - 1.0, y + 0.5)
        } else {
            evaluate(x + 0.5, y - 1.0)
        };
        (0..num_comps).all(|c| {
            let result_derivative = derivative[c];
            let (forward_component, backward_component) = (simulate(forward[c]), simulate(backward[c]));
            let max_value_exp = [
                forward_component.0,
                forward_component.1,
                backward_component.0,
                backward_component.1,
            ]
            .into_iter()
            .map(exponent)
            .max()
            .unwrap();
            let numerator = (
                forward_component.0 - backward_component.1,
                forward_component.1 - backward_component.0,
            );
            let lo_bits = (num_bits - (max_value_exp - exponent(numerator.0)).max(0)).max(0);
            let hi_bits = (num_bits - (max_value_exp - exponent(numerator.1)).max(0)).max(0);
            let numerator_range = (
                convert_flush_to_zero_rtn(numerator.0, min_exponent, lo_bits),
                convert_flush_to_zero_rtp(numerator.1, min_exponent, hi_bits),
            );
            let division_range = (numerator_range.0 / 3.0, numerator_range.1 / 3.0);
            let lo = convert_flush_to_zero_rtn(
                add_error_ulp(division_range.0, -division_error_ulps, num_bits),
                min_exponent,
                num_bits,
            ) - surface_threshold[c];
            let hi = convert_flush_to_zero_rtp(
                add_error_ulp(division_range.1, division_error_ulps, num_bits),
                min_exponent,
                num_bits,
            ) + surface_threshold[c];
            result_derivative >= lo && result_derivative <= hi
        })
    })
}

/// The values of `LinearDerivateCase`: the coordinate range and the scale mapping the derivative into 0..1
fn linear_values(func: &str, precision: &str) -> (Vec4, Vec4, Vec4) {
    let (coord_min, coord_max) = match precision {
        "highp" => ([-97.0, 0.2, 71.0, 74.0], [-13.2, -77.0, 44.0, 76.0]),
        "mediump" => ([-37.0, 47.0, -7.0, 0.0], [-1.0, 12.0, 7.0, 19.0]),
        _ => ([0.0, -1.0, 0.0, 1.0], [1.0, 1.0, -1.0, -1.0]),
    };
    let (w, h) = (VIEWPORT_WIDTH as f32, VIEWPORT_HEIGHT as f32);
    let dx: Vec4 = std::array::from_fn(|c| (coord_max[c] - coord_min[c]) / [w, w, w * 0.5, -w * 0.5][c]);
    let dy: Vec4 = std::array::from_fn(|c| (coord_max[c] - coord_min[c]) / [h, h, h * 0.5, -h * 0.5][c]);
    let deriv_scale = std::array::from_fn(|c| {
        if func.starts_with("dfdx") {
            0.5 / dx[c]
        } else if func.starts_with("dfdy") {
            0.5 / dy[c]
        } else {
            0.5 / (dx[c].abs() + dy[c].abs())
        }
    });
    (coord_min, coord_max, deriv_scale)
}

/// `LinearDerivateCase` with the `linear` and `in_function` templates over `TriangleDerivateCaseInstance`
fn linear_case(
    func: &'static str,
    case_name: &'static str,
    type_name: &'static str,
    num_comps: usize,
    precision: &'static str,
    float_target: bool,
    samples: vk::SampleCountFlags,
    textured: bool,
) -> ShaderRenderCase {
    let (coord_min, coord_max, deriv_scale) = linear_values(func, precision);
    // `LinearDerivateCase`: no scale or bias into the float target, for accuracy
    let deriv_scale = if float_target { [1.0; 4] } else { deriv_scale };
    let mut uniforms = vec![
        (0, UniformValue::Vec4s([deriv_scale; 4])),
        (1, UniformValue::Vec4s([[0.0; 4]; 4])),
    ];
    // `LinearDerivateUniformSetup::setup`: UB_TRUE and UI_ONE are 1, UI_TWO is 2, at binding 2
    match case_name {
        "uniform_if" | "uniform_switch" | "dynamic_if" | "dynamic_loop" | "dynamic_switch" => {
            uniforms.push((2, UniformValue::Int(1)))
        }
        "uniform_loop" => uniforms.push((2, UniformValue::Int(2))),
        _ => {}
    }
    let key_case = match (textured, float_target) {
        (true, true) => "texturefloat",
        (true, false) => "texture",
        (false, true) => "fbofloat",
        (false, false) => case_name,
    };
    let key = case_key("derivate", &format!("{func}_{key_case}_{type_name}_{precision}"));
    // The texture cases sample with coordinates over 0..1, and the ramp of the verification is the one of the texture
    let (geometry_min, geometry_max) = if textured {
        ([0.0; 4], [1.0; 4])
    } else {
        (coord_min, coord_max)
    };
    let geometry = CustomGeometry {
        positions: vec![
            [-1.0, -1.0, 0.0, 1.0],
            [-1.0, 1.0, 0.0, 1.0],
            [1.0, -1.0, 0.0, 1.0],
            [1.0, 1.0, 0.0, 1.0],
        ],
        coords: vec![
            [geometry_min[0], geometry_min[1], geometry_min[2], geometry_max[3]],
            [
                geometry_min[0],
                geometry_max[1],
                (geometry_min[2] + geometry_max[2]) * 0.5,
                (geometry_min[3] + geometry_max[3]) * 0.5,
            ],
            [
                geometry_max[0],
                geometry_min[1],
                (geometry_min[2] + geometry_max[2]) * 0.5,
                (geometry_min[3] + geometry_max[3]) * 0.5,
            ],
            [geometry_max[0], geometry_max[1], geometry_max[2], geometry_min[3]],
        ],
        indices: vec![0, 2, 1, 2, 3, 1],
    };
    let demote = case_name == "private_store" || case_name == "output_store";
    // `LinearDerivateCaseInstance::verify` through `verifyConstantDerivate`
    let verifier = move |pixels: &[u8]| {
        let surface_threshold: Vec4 = std::array::from_fn(|c| {
            if float_target {
                0.0
            } else {
                (1.0 / 255.0) / deriv_scale[c].abs()
            }
        });
        // `readDerivate`: the pixel of the target (8 bit unorm, or the bits of four floats) scaled back to the derivative
        let derivatives: Vec<Vec4> = if float_target {
            pixels
                .chunks_exact(16)
                .map(|pixel| {
                    std::array::from_fn(|c| {
                        let bits =
                            u32::from_ne_bytes([pixel[4 * c], pixel[4 * c + 1], pixel[4 * c + 2], pixel[4 * c + 3]]);
                        f32::from_bits(bits) / deriv_scale[c]
                    })
                })
                .collect()
        } else {
            pixels
                .chunks_exact(4)
                .map(|pixel| std::array::from_fn(|c| f32::from(pixel[c]) / 255.0 / deriv_scale[c]))
                .collect()
        };
        let (w, h) = (VIEWPORT_WIDTH as f32, VIEWPORT_HEIGHT as f32);
        let x_scale = [1.0, 0.0, 0.5, -0.5];
        let y_scale = [0.0, 1.0, 0.5, -0.5];
        let ramp: Vec4 = std::array::from_fn(|c| coord_max[c] - coord_min[c]);
        let (reference, threshold): (Vec4, Vec4) = if func.starts_with("fwidth") {
            let dx: Vec4 = std::array::from_fn(|c| ramp[c] / w * x_scale[c]);
            let dy: Vec4 = std::array::from_fn(|c| ramp[c] / h * y_scale[c]);
            let scaled = |min_max: Vec4, scale: Vec4| -> Vec4 { std::array::from_fn(|c| min_max[c] * scale[c]) };
            let dx_threshold =
                derivate_threshold(precision, scaled(coord_min, x_scale), scaled(coord_max, x_scale), dx);
            let dy_threshold =
                derivate_threshold(precision, scaled(coord_min, y_scale), scaled(coord_max, y_scale), dy);
            (
                std::array::from_fn(|c| dx[c].abs() + dy[c].abs()),
                std::array::from_fn(|c| surface_threshold[c].max(dx_threshold[c].max(dy_threshold[c]))),
            )
        } else {
            let is_x = func.starts_with("dfdx");
            let (div, scale) = if is_x { (w, x_scale) } else { (h, y_scale) };
            let unscaled: Vec4 = std::array::from_fn(|c| ramp[c] / div);
            let op_threshold = derivate_threshold(precision, coord_min, coord_max, unscaled);
            (
                std::array::from_fn(|c| unscaled[c] * scale[c]),
                std::array::from_fn(|c| surface_threshold[c].max(op_threshold[c])),
            )
        };
        // `TextureDerivateCaseInstance::verify` ignores the edges of the image
        let (derivatives, width) = if textured {
            let width = VIEWPORT_WIDTH as usize;
            let rows = derivatives.chunks_exact(width);
            let cropped: Vec<Vec4> = rows
                .skip(1)
                .take(VIEWPORT_HEIGHT as usize - 2)
                .flat_map(|row| row[1..width - 1].iter().copied())
                .collect();
            (cropped, width - 2)
        } else {
            (derivatives, VIEWPORT_WIDTH as usize)
        };
        // `verifyConstantDerivate` skips the odd rows when `demoteToHelperInvocation`
        let fast_ok = derivatives.iter().enumerate().all(|(index, derivative)| {
            if demote && (index / width) % 2 == 1 {
                return true;
            }
            (0..num_comps).all(|c| (reference[c] - derivative[c]).abs() <= threshold[c])
        });
        if fast_ok || func.starts_with("fwidth") {
            return fast_ok;
        }
        let matrix = [
            [ramp[0] / w, 0.0, coord_min[0]],
            [0.0, ramp[1] / h, coord_min[1]],
            [
                ramp[2] / w / 2.0,
                ramp[2] / h / 2.0,
                (coord_min[2] + coord_min[2]) / 2.0,
            ],
            [
                -ramp[3] / w / 2.0,
                -ramp[3] / h / 2.0,
                (coord_max[3] + coord_max[3]) / 2.0,
            ],
        ];
        reverify_with_flush_relaxations(
            &derivatives,
            width,
            num_comps,
            precision,
            surface_threshold,
            func,
            matrix,
        )
    };
    let case = ShaderRenderCase::with_closure(
        format!("{type_name}_{precision}"),
        key,
        false,
        Box::new(|_: &mut ShaderEvalContext| {}),
        uniforms,
    )
    .with_render_size(VIEWPORT_WIDTH, VIEWPORT_HEIGHT)
    .with_geometry(geometry)
    .with_verifier(Box::new(verifier));
    let case = if textured {
        case.with_texture(derivate_texture(precision, coord_min, coord_max))
    } else {
        case
    };
    let case = if float_target {
        case.with_color_format(vk::Format::R32G32B32A32_UINT)
    } else {
        case
    };
    let case = if samples != vk::SampleCountFlags::_1 {
        case.with_sample_count(samples)
    } else {
        case
    };
    let case = if demote { case.requires_demote() } else { case };
    if case_name.starts_with("dynamic_") || func.ends_with("subgroup") {
        case.requires_quad_subgroups()
    } else {
        case
    }
}

/// The texture of `TextureDerivateCaseInstance`: RGBA32F for highp and RGBA16F otherwise, a gradient of the value range over the viewport
fn derivate_texture(precision: &str, value_min: Vec4, value_max: Vec4) -> TextureSpec {
    let half = precision != "highp";
    let (width, height) = (VIEWPORT_WIDTH, VIEWPORT_HEIGHT);
    let mut data = Vec::new();
    for y in 0..height {
        for x in 0..width {
            let xf = (x as f32 + 0.5) / width as f32;
            let yf = (y as f32 + 0.5) / height as f32;
            let s = [xf, yf, (xf + yf) / 2.0, 1.0 - (xf + yf) / 2.0];
            for c in 0..4 {
                let value = value_min[c] + (value_max[c] - value_min[c]) * s[c];
                if half {
                    data.extend_from_slice(&Float16::new(value).bits().to_ne_bytes());
                } else {
                    data.extend_from_slice(&value.to_ne_bytes());
                }
            }
        }
    }
    TextureSpec {
        binding: 2,
        format: if half {
            vk::Format::R16G16B16A16_SFLOAT
        } else {
            vk::Format::R32G32B32A32_SFLOAT
        },
        width,
        height,
        data,
        linear: false,
    }
}

/// The `texture` group of a function: `basic`, `msaa4` and `float`
fn texture_group(func: &'static str) -> TestCaseGroup {
    let mut texture = TestCaseGroup::new("texture");
    for (name, float_target, samples) in [
        ("basic", false, vk::SampleCountFlags::_1),
        ("msaa4", false, vk::SampleCountFlags::_4),
        ("float", true, vk::SampleCountFlags::_1),
    ] {
        let mut group = TestCaseGroup::new(name);
        for (type_name, num_comps) in TYPES {
            for precision in ["lowp", "mediump", "highp"] {
                if !float_target && precision == "lowp" {
                    continue;
                }
                group.add_child(Box::new(linear_case(
                    func,
                    "texture",
                    type_name,
                    num_comps,
                    precision,
                    float_target,
                    samples,
                    true,
                )) as Box<dyn TestCase>);
            }
        }
        texture.add_child(group);
    }
    texture
}

/// The `fbo`, `fbo_msaa2`, `fbo_msaa4` and `fbo_float` groups: the `linear` template into the 8 bit unorm target (multisampled and resolved
/// for the msaa ones) or into the RGBA32UI target holding floats, with the quad broadcast shaders for the subgroup functions
fn fbo_group(
    func: &'static str,
    name: &'static str,
    float_target: bool,
    samples: vk::SampleCountFlags,
) -> TestCaseGroup {
    let mut fbo = TestCaseGroup::new(name);
    for (type_name, num_comps) in TYPES {
        for precision in ["lowp", "mediump", "highp"] {
            // Skipped as lowp does not produce any bits when rendered to an 8 bit target.
            if !float_target && precision == "lowp" {
                continue;
            }
            fbo.add_child(Box::new(linear_case(
                func,
                "fbo",
                type_name,
                num_comps,
                precision,
                float_target,
                samples,
                false,
            )) as Box<dyn TestCase>);
        }
    }
    fbo
}

fn add_fbo_groups(func_group: &mut TestCaseGroup, func: &'static str) {
    func_group.add_child(fbo_group(func, "fbo", false, vk::SampleCountFlags::_1));
    func_group.add_child(fbo_group(func, "fbo_msaa2", false, vk::SampleCountFlags::_2));
    func_group.add_child(fbo_group(func, "fbo_msaa4", false, vk::SampleCountFlags::_4));
    func_group.add_child(fbo_group(func, "fbo_float", true, vk::SampleCountFlags::_1));
}

/// `ShaderDerivateTests::init`, the `constant` and the first two linear groups
pub fn create_derivate_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("derivate");
    for func in FUNCS {
        let mut func_group = TestCaseGroup::new(func);
        let mut constant = TestCaseGroup::new("constant");
        for (type_name, num_comps) in TYPES {
            constant.add_child(Box::new(constant_case(func, type_name, num_comps)) as Box<dyn TestCase>);
        }
        func_group.add_child(constant);
        for case_name in LINEAR_CASES {
            let mut linear = TestCaseGroup::new(case_name);
            for (type_name, num_comps) in TYPES {
                for precision in ["lowp", "mediump", "highp"] {
                    if case_name != "linear" && precision == "lowp" {
                        continue;
                    }
                    linear.add_child(Box::new(linear_case(
                        func,
                        case_name,
                        type_name,
                        num_comps,
                        precision,
                        false,
                        vk::SampleCountFlags::_1,
                        false,
                    )) as Box<dyn TestCase>);
                }
            }
            func_group.add_child(linear);
        }
        add_fbo_groups(&mut func_group, func);
        func_group.add_child(texture_group(func));
        group.add_child(func_group);
    }
    for func in SUBGROUP_FUNCS {
        let mut func_group = TestCaseGroup::new(func);
        add_fbo_groups(&mut func_group, func);
        group.add_child(func_group);
    }
    group
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmFloatControls2Tests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2023 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the compute cases (`ComputeTestGroupBuilder`, arguments read from the input buffer) is in
// `shaders/manifest/spirv_assembly_float_controls2.toml`, written by `scripts/gen_spirv_assembly_float_controls2_manifest.py`, and the `spec` of a case names
// the ValueIds it reads and expects. As upstream, the expected output buffer carries the ValueId of the result and `checkFloats` resolves it to what the
// result may be. The graphics half (`GraphicsTestGroupBuilder`, vertex and fragment stage of every case, arguments read from the input buffer) runs through
// `graphics_shader_case.rs`; its vertex and fragment programs are in `spirv_assembly_float_controls2_graphics.toml`.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, VerifyIo};
use super::graphics_shader_case::SpvAsmGraphicsShaderCase;
use super::utils::{float16_to_float32, float32_to_float16};
use crate::generated::shaders::spirv_assembly_float_controls2::ALL_FLOAT_CONTROLS2_CASE;
use crate::generated::shaders::spirv_assembly_float_controls2_graphics::ALL_FLOAT_CONTROLS2_GRAPHICS_CASE;
use crate::tcu::float_format::FloatFormat;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

/// The `rust_type` of the manifest entries: one test case of the `float_controls2` compute group.
#[derive(Clone, Copy)]
pub struct FloatControls2Case {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

const V_UNUSED: u32 = 0;
const V_MINUS_INF: u32 = 1;
const V_MINUS_ONE: u32 = 2;
const V_MINUS_ZERO: u32 = 3;
const V_ZERO: u32 = 4;
const V_HALF: u32 = 5;
const V_ONE: u32 = 6;
const V_TWO: u32 = 7;
const V_INF: u32 = 8;
const V_ZERO_POINT_ONE: u32 = 9;
const V_TWENTY_FIVE_POINT_EIGHT: u32 = 10;
const V_HUGE: u32 = 11;
const V_TINY: u32 = 12;
const V_MINUS_TINY: u32 = 13;
const V_MAX: u32 = 14;
const V_NAN: u32 = 15;
const V_PI: u32 = 16;
const V_MINUS_PI: u32 = 17;
const V_PI_DIV_2: u32 = 18;
const V_MINUS_PI_DIV_2: u32 = 19;
const V_PI_DIV_4: u32 = 20;
const V_MINUS_PI_DIV_4: u32 = 21;
const V_3_PI_DIV_4: u32 = 22;
const V_MINUS_3_PI_DIV_4: u32 = 23;
const V_ONE_OR_NAN: u32 = 24;
const V_SIGN_NAN: u32 = 25;
const V_ZERO_OR_MINUS_ZERO: u32 = 26;
const V_ZERO_OR_ONE: u32 = 27;
const V_TRIG_ONE: u32 = 28;

/// `TypeValues<double>::getValue`
fn value_f64(id: u32) -> f64 {
    use std::f64::consts::{FRAC_PI_2, FRAC_PI_4, PI};
    match id {
        V_MINUS_INF => f64::NEG_INFINITY,
        V_MINUS_ONE => -1.0,
        V_MINUS_ZERO => -0.0,
        V_HALF => 0.5,
        V_ONE => 1.0,
        V_TWO => 2.0,
        V_INF => f64::INFINITY,
        V_ZERO_POINT_ONE => 0.1,
        V_TWENTY_FIVE_POINT_EIGHT => 25.8,
        V_HUGE => 1.79769313486231530898e+308,
        V_TINY => 2.22507385850720138309e-308,
        V_MINUS_TINY => -2.22507385850720138309e-308,
        V_MAX => f64::MAX,
        V_NAN => f64::NAN,
        V_PI => PI,
        V_MINUS_PI => -PI,
        V_PI_DIV_2 => FRAC_PI_2,
        V_MINUS_PI_DIV_2 => -FRAC_PI_2,
        V_PI_DIV_4 => FRAC_PI_4,
        V_MINUS_PI_DIV_4 => -FRAC_PI_4,
        V_3_PI_DIV_4 => 3.0 * FRAC_PI_4,
        V_MINUS_3_PI_DIV_4 => -3.0 * FRAC_PI_4,
        _ => 0.0,
    }
}

/// `TypeValues<float>::getValue`
fn value_f32(id: u32) -> f32 {
    use std::f32::consts::{FRAC_PI_2, FRAC_PI_4, PI};
    match id {
        V_MINUS_INF => f32::NEG_INFINITY,
        V_MINUS_ONE => -1.0,
        V_MINUS_ZERO => -0.0,
        V_HALF => 0.5,
        V_ONE => 1.0,
        V_TWO => 2.0,
        V_INF => f32::INFINITY,
        V_ZERO_POINT_ONE => 0.1,
        V_TWENTY_FIVE_POINT_EIGHT => 25.8,
        V_HUGE => 3.40282306073709652508e+38_f64 as f32,
        V_TINY => 1.17549435082228750797e-38_f64 as f32,
        V_MINUS_TINY => -1.17549435082228750797e-38_f64 as f32,
        V_MAX => f32::MAX,
        V_NAN => f32::NAN,
        V_PI => PI,
        V_MINUS_PI => -PI,
        V_PI_DIV_2 => FRAC_PI_2,
        V_MINUS_PI_DIV_2 => -FRAC_PI_2,
        V_PI_DIV_4 => FRAC_PI_4,
        V_MINUS_PI_DIV_4 => -FRAC_PI_4,
        V_3_PI_DIV_4 => (3.0 * std::f64::consts::FRAC_PI_4) as f32,
        V_MINUS_3_PI_DIV_4 => (-3.0 * std::f64::consts::FRAC_PI_4) as f32,
        _ => 0.0,
    }
}

/// `TypeValues<deFloat16>::getValue`: the bits of the value.
fn value_f16_bits(id: u32) -> u16 {
    match id {
        V_MINUS_INF => 0xfc00,
        V_MINUS_ZERO => 0x8000,
        V_ZERO => 0x0000,
        V_HUGE => 0x7bfd,
        V_TINY => 0x0400,
        V_MINUS_TINY => 0x8400,
        V_MAX => 0x7bff,
        V_INF => 0x7c00,
        V_NAN => 0x7cf0,
        V_UNUSED => float32_to_float16(0.0),
        other => float32_to_float16(value_f32(other)),
    }
}

/// The bits a float of `width` bits holds for the ValueId.
fn value_bits(width: u32, id: u32) -> u64 {
    match width {
        16 => u64::from(value_f16_bits(id)),
        32 => u64::from(value_f32(id).to_bits()),
        _ => value_f64(id).to_bits(),
    }
}

fn read_bits<const WIDTH: u32>(bytes: &[u8]) -> u64 {
    let size = (WIDTH / 8) as usize;
    let mut raw = [0u8; 8];
    raw[..size].copy_from_slice(&bytes[..size]);
    u64::from_le_bytes(raw)
}

fn is_nan<const WIDTH: u32>(bits: u64) -> bool {
    match WIDTH {
        16 => (bits & 0x7c00) == 0x7c00 && (bits & 0x03ff) != 0,
        32 => f32::from_bits(bits as u32).is_nan(),
        _ => f64::from_bits(bits).is_nan(),
    }
}

fn as_f64<const WIDTH: u32>(bits: u64) -> f64 {
    match WIDTH {
        16 => f64::from(float16_to_float32(bits as u16)),
        32 => f64::from(f32::from_bits(bits as u32)),
        _ => f64::from_bits(bits),
    }
}

/// `valMatches`
fn val_matches<const WIDTH: u32>(returned: u64, expected: u32) -> bool {
    if expected == V_NAN && is_nan::<WIDTH>(returned) {
        return true;
    }
    returned == value_bits(WIDTH, expected)
}

/// `isEither`
fn is_either<const WIDTH: u32>(returned: u64, first: u32, second: u32) -> bool {
    val_matches::<WIDTH>(returned, first) || val_matches::<WIDTH>(returned, second)
}

/// `isTrigULPResultCorrect`
fn is_trig_ulp_result_correct<const WIDTH: u32>(returned: u64, expected: u32) -> bool {
    let format = if WIDTH == 16 {
        FloatFormat::new(-14, 15, 10, true)
    } else {
        FloatFormat::new(-126, 127, 23, true)
    };
    let reference = value_f64(expected);
    let ulp = if WIDTH == 16 { 5.0 } else { 4096.0 };
    let precision = format.ulp(reference, ulp);
    (as_f64::<WIDTH>(returned) - reference).abs() < precision
}

/// `isTrigAbsResultCorrect`
fn is_trig_abs_result_correct<const WIDTH: u32>(returned: u64) -> bool {
    let precision = if WIDTH == 32 { 2.0f64.powi(-11) } else { 2.0f64.powi(-7) };
    (as_f64::<WIDTH>(returned) - 1.0).abs() < precision
}

/// `compareBytes`
fn compare_bytes<const WIDTH: u32>(expected_bytes: &[u8], output: &[u8]) -> bool {
    let returned = read_bits::<WIDTH>(output);
    let expected_id = read_bits::<WIDTH>(expected_bytes) as u32;

    match expected_id {
        V_SIGN_NAN => [V_MINUS_ONE, V_MINUS_ZERO, V_ZERO, V_ONE]
            .iter()
            .any(|&id| val_matches::<WIDTH>(returned, id)),
        V_ZERO_OR_MINUS_ZERO => is_either::<WIDTH>(returned, V_ZERO, V_MINUS_ZERO),
        V_ZERO_OR_ONE => is_either::<WIDTH>(returned, V_ZERO, V_ONE),
        V_ONE_OR_NAN => is_either::<WIDTH>(returned, V_ONE, V_NAN),
        V_TRIG_ONE => is_trig_abs_result_correct::<WIDTH>(returned),
        V_PI | V_MINUS_PI | V_PI_DIV_2 | V_MINUS_PI_DIV_2 | V_PI_DIV_4 | V_MINUS_PI_DIV_4 | V_3_PI_DIV_4
        | V_MINUS_3_PI_DIV_4 => is_trig_ulp_result_correct::<WIDTH>(returned, expected_id),
        _ => val_matches::<WIDTH>(returned, expected_id),
    }
}

/// `checkFloats`
fn check_floats<const WIDTH: u32>(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected_outputs: &[Vec<u8>]) -> bool {
    outputs.len() == expected_outputs.len()
        && outputs
            .iter()
            .zip(expected_outputs)
            .all(|(output, expected)| compare_bytes::<WIDTH>(expected, output))
}

fn field(spec: &str, key: &str) -> u32 {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("float controls 2 spec without {key}"))
        .parse()
        .unwrap_or_else(|_| panic!("float controls 2 spec with a bad {key}"))
}

fn le_bytes(bits: u64, width: u32) -> Vec<u8> {
    bits.to_le_bytes()[..(width / 8) as usize].to_vec()
}

/// `TypeValues::constructInputBuffer`
fn input_buffer(width: u32, first: u32, second: u32) -> Vec<u8> {
    let mut bytes = le_bytes(value_bits(width, first), width);
    bytes.extend(le_bytes(value_bits(width, second), width));
    bytes
}

/// `TypeValues::constructOutputBuffer`: the ValueId stored as the float type's bits, twice for fp16 so that the buffer is four bytes.
fn output_buffer(width: u32, result: u32) -> Vec<u8> {
    let mut bytes = le_bytes(u64::from(result), width);
    if width == 16 {
        bytes.extend(le_bytes(u64::from(result), width));
    }
    bytes
}

/// The `rust_type` of the graphics manifest entries: one test case of the `float_controls2` graphics group.
#[derive(Clone, Copy)]
pub struct FloatControls2GraphicsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

fn make_shader_spec(spec: &str) -> ComputeShaderSpec {
    let in_width = field(spec, "w");
    let out_width = field(spec, "ow");

    let mut features = Vec::new();
    if field(spec, "f64") != 0 {
        features.push(RequiredFeature::ShaderFloat64);
    }
    if field(spec, "st16") != 0 {
        features.push(RequiredFeature::StorageBuffer16BitAccess);
        features.push(RequiredFeature::UniformAndStorageBuffer16BitAccess);
    }
    if field(spec, "sf16") != 0 {
        features.push(RequiredFeature::ShaderFloat16);
    }

    let mut properties = Vec::new();
    if field(spec, "sz") != 0 {
        properties.push((in_width, "SignedZeroInfNanPreserve"));
    }
    if field(spec, "rte") != 0 {
        properties.push((in_width, "RoundingModeRTE"));
    }

    let verify_io: VerifyIo = match out_width {
        16 => check_floats::<16>,
        32 => check_floats::<32>,
        _ => check_floats::<64>,
    };

    ComputeShaderSpec {
        inputs: vec![input_buffer(in_width, field(spec, "a"), field(spec, "b"))],
        outputs: vec![output_buffer(out_width, field(spec, "r"))],
        num_work_groups: [1, 1, 1],
        extensions: vec!["VK_KHR_shader_float_controls2".to_string()],
        spirv_1_3: true,
        spirv_version_minor: Some(2),
        verify_io: Some(verify_io),
        features,
        float_controls2: true,
        extra_float_controls_properties: properties,
        ..Default::default()
    }
}

fn make_case(case: &FloatControls2Case, leaf: &str) -> Box<dyn TestCase> {
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec: make_shader_spec(case.spec),
        programs: case.programs,
    })
}

fn make_graphics_case(case: &FloatControls2GraphicsCase, leaf: &str) -> Box<dyn TestCase> {
    Box::new(SpvAsmGraphicsShaderCase {
        name: leaf.to_string(),
        spec: make_shader_spec(case.spec),
        programs: case.programs,
    })
}

/// `createFloatControls2ComputeGroup` as the groups of its path below `compute` and the test case.
pub fn create_float_controls2_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_FLOAT_CONTROLS2_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.insert(0, "float_controls2");
            (segments, make_case(case, leaf))
        })
        .collect()
}

/// `createFloatControls2GraphicsGroup` as the groups of its path below `graphics` and the test case.
pub fn create_float_controls2_graphics_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_FLOAT_CONTROLS2_GRAPHICS_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            segments.insert(0, "float_controls2");
            (segments, make_graphics_case(case, leaf))
        })
        .collect()
}

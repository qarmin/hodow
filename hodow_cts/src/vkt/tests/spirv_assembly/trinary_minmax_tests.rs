// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmTrinaryMinMaxTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of the 132 cases is in `shaders/manifest/spirv_assembly_trinary_minmax.toml` (written by
// `scripts/gen_spirv_assembly_trinary_minmax_manifest.py`); the operation, the type and the random seed ride along as `spec`. `OperationManager` is ported as it is:
// the operands are drawn from `de::Random(seed)` by the generator of the type, the reference is `min3`, `max3` or `mid3` over three operands compared the way the C++
// compares them (integers by value, `tcu::Float` through `asDouble`), and every component of every operation is compared byte for byte. The 100 operations run on the
// compute case of the assembly groups, whose output mask leaves the fourth component of a vec3 alone.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase};
use crate::generated::shaders::spirv_assembly_trinary_minmax::ALL_TRINARY_MIN_MAX_CASE;
use crate::tcu::random::Random;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const NUM_OPERATIONS: usize = 100;

/// The `rust_type` of the manifest entries: one `TrinaryMinMaxCase`.
#[derive(Clone, Copy)]
pub struct TrinaryMinMaxCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Operation {
    Min,
    Max,
    Mid,
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum BaseType {
    Int,
    Uint,
    Float,
}

struct Params {
    operation: Operation,
    base_type: BaseType,
    size_bytes: usize,
    components: usize,
    seed: u32,
}

impl Params {
    fn effective_components(&self) -> usize {
        if self.components == 3 { 4 } else { self.components }
    }

    fn operand_size(&self) -> usize {
        self.effective_components() * self.size_bytes
    }
}

fn parse(spec: &str) -> Params {
    let field = |key: &str| -> &str {
        spec.split(';')
            .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
            .unwrap_or_else(|| panic!("trinary min max spec without {key}"))
    };
    Params {
        operation: match field("op") {
            "min" => Operation::Min,
            "max" => Operation::Max,
            _ => Operation::Mid,
        },
        base_type: match field("base") {
            "i" => BaseType::Int,
            "u" => BaseType::Uint,
            _ => BaseType::Float,
        },
        size_bytes: field("size").parse::<usize>().expect("a size") / 8,
        components: field("components").parse().expect("a component count"),
        seed: field("seed").parse().expect("a seed"),
    }
}

/// `tcu::Float<..>(double)` rounded to nearest even, as the bits of a binary16.
fn f64_to_f16_bits(value: f64) -> u16 {
    let bits = value.to_bits();
    let sign = ((bits >> 63) as u16) << 15;
    let exponent = ((bits >> 52) & 0x7ff) as i32;
    let mantissa = bits & ((1u64 << 52) - 1);

    if exponent == 0x7ff {
        return sign | 0x7c00 | if mantissa != 0 { 0x200 } else { 0 };
    }

    let half_exponent = exponent - 1023 + 15;
    if half_exponent >= 0x1f {
        return sign | 0x7c00;
    }

    if half_exponent <= 0 {
        // Subnormal in binary16: the 53 bit significand shifted down to units of 2^-24.
        let significand = mantissa | (1u64 << 52);
        let shift = 28 - (exponent - 1023);
        if shift >= 64 {
            return sign;
        }
        let shift = shift as u32;
        let mut quotient = significand >> shift;
        let remainder = significand & ((1u64 << shift) - 1);
        let half = 1u64 << (shift - 1);
        if remainder > half || (remainder == half && quotient & 1 == 1) {
            quotient += 1;
        }
        return sign | quotient as u16;
    }

    let mut half_mantissa = (mantissa >> 42) as u16;
    let remainder = mantissa & ((1u64 << 42) - 1);
    let half = 1u64 << 41;
    let mut half_exponent = half_exponent as u16;
    if remainder > half || (remainder == half && half_mantissa & 1 == 1) {
        half_mantissa += 1;
        if half_mantissa == 0x400 {
            half_mantissa = 0;
            half_exponent += 1;
            if half_exponent >= 0x1f {
                return sign | 0x7c00;
            }
        }
    }
    sign | (half_exponent << 10) | half_mantissa
}

fn f16_bits_to_f64(bits: u16) -> f64 {
    let sign = if bits & 0x8000 != 0 { -1.0 } else { 1.0 };
    let exponent = i32::from((bits >> 10) & 0x1f);
    let mantissa = f64::from(bits & 0x3ff);
    match exponent {
        0 => sign * mantissa * 2.0f64.powi(-24),
        31 if mantissa == 0.0 => sign * f64::INFINITY,
        31 => f64::NAN,
        _ => sign * (1.0 + mantissa / 1024.0) * 2.0f64.powi(exponent - 15),
    }
}

/// The value of a component read as a double, which is how `tcu::Float::operator<` compares.
fn float_as_double(raw: u64, size_bytes: usize) -> f64 {
    match size_bytes {
        2 => f16_bits_to_f64(raw as u16),
        4 => f64::from(f32::from_bits(raw as u32)),
        _ => f64::from_bits(raw),
    }
}

fn float_is_denorm(raw: u64, size_bytes: usize) -> bool {
    match size_bytes {
        2 => (raw >> 10) & 0x1f == 0 && raw & 0x3ff != 0,
        4 => (raw >> 23) & 0xff == 0 && raw & 0x7f_ffff != 0,
        _ => (raw >> 52) & 0x7ff == 0 && raw & ((1u64 << 52) - 1) != 0,
    }
}

fn float_inf_bits(sign: i32, size_bytes: usize) -> u64 {
    let negative = u64::from(sign < 0);
    match size_bytes {
        2 => (negative << 15) | 0x7c00,
        4 => (negative << 31) | 0x7f80_0000,
        _ => (negative << 63) | 0x7ff0_0000_0000_0000,
    }
}

fn float_from_double(value: f64, size_bytes: usize) -> u64 {
    match size_bytes {
        2 => u64::from(f64_to_f16_bits(value)),
        4 => u64::from((value as f32).to_bits()),
        _ => value.to_bits(),
    }
}

fn largest_normal(sign: i32, size_bytes: usize) -> f64 {
    let magnitude = match size_bytes {
        2 => 65504.0,
        4 => f64::from(f32::MAX),
        _ => f64::MAX,
    };
    f64::from(sign) * magnitude
}

/// `OperationManager::genFloat<T>`
fn gen_float(rnd: &mut Random, size_bytes: usize) -> u64 {
    if rnd.get_int(1, 10) == 1 {
        return float_inf_bits(if rnd.get_bool() { 1 } else { -1 }, size_bytes);
    }
    loop {
        let value = float_from_double(
            rnd.get_double_range(largest_normal(-1, size_bytes), largest_normal(1, size_bytes)),
            size_bytes,
        );
        if !float_is_denorm(value, size_bytes) {
            return value;
        }
    }
}

/// The generator of the type: one component, as the raw bits.
fn gen_component(rnd: &mut Random, params: &Params) -> u64 {
    match params.base_type {
        BaseType::Float => gen_float(rnd, params.size_bytes),
        _ => match params.size_bytes {
            1 => u64::from(rnd.get_uint8()),
            2 => u64::from(rnd.get_uint16()),
            4 => u64::from(rnd.get_uint32()),
            _ => rnd.get_uint64(),
        },
    }
}

/// `a < b` for two components of the type, as `std::min`, `std::max` and `std::sort` compare them.
fn less(params: &Params, a: u64, b: u64) -> bool {
    let bits = (params.size_bytes * 8) as u32;
    match params.base_type {
        BaseType::Float => float_as_double(a, params.size_bytes) < float_as_double(b, params.size_bytes),
        BaseType::Uint => a < b,
        BaseType::Int => {
            let extend = |value: u64| ((value << (64 - bits)) as i64) >> (64 - bits);
            extend(a) < extend(b)
        }
    }
}

/// `min3`, `max3` and `mid3` of `OperationManager`.
fn calc(params: &Params, operands: [u64; 3]) -> u64 {
    match params.operation {
        Operation::Min => operands
            .iter()
            .copied()
            .reduce(|result, next| if less(params, next, result) { next } else { result })
            .expect("three operands"),
        Operation::Max => operands
            .iter()
            .copied()
            .reduce(|result, next| if less(params, result, next) { next } else { result })
            .expect("three operands"),
        Operation::Mid => {
            // The insertion sort std::sort uses for so few elements.
            let mut sorted = operands;
            for i in 1..3 {
                let value = sorted[i];
                let mut j = i;
                if less(params, value, sorted[0]) {
                    while j > 0 {
                        sorted[j] = sorted[j - 1];
                        j -= 1;
                    }
                    sorted[0] = value;
                } else {
                    while less(params, value, sorted[j - 1]) {
                        sorted[j] = sorted[j - 1];
                        j -= 1;
                    }
                    sorted[j] = value;
                }
            }
            sorted[1]
        }
    }
}

fn write_component(buffer: &mut [u8], offset: usize, raw: u64, size_bytes: usize) {
    buffer[offset..offset + size_bytes].copy_from_slice(&raw.to_le_bytes()[..size_bytes]);
}

fn read_component(buffer: &[u8], offset: usize, size_bytes: usize) -> u64 {
    let mut bytes = [0u8; 8];
    bytes[..size_bytes].copy_from_slice(&buffer[offset..offset + size_bytes]);
    u64::from_le_bytes(bytes)
}

fn required_features(params: &Params) -> Vec<RequiredFeature> {
    let mut features = Vec::new();
    match (params.base_type, params.size_bytes) {
        (BaseType::Float, 2) => features.push(RequiredFeature::ShaderFloat16),
        (BaseType::Float, 8) => features.push(RequiredFeature::ShaderFloat64),
        (BaseType::Int | BaseType::Uint, 1) => features.push(RequiredFeature::ShaderInt8),
        (BaseType::Int | BaseType::Uint, 2) => features.push(RequiredFeature::ShaderInt16),
        (BaseType::Int | BaseType::Uint, 8) => features.push(RequiredFeature::ShaderInt64),
        _ => {}
    }
    match params.size_bytes {
        1 => features.push(RequiredFeature::StorageBuffer8BitAccess),
        2 => features.push(RequiredFeature::StorageBuffer16BitAccess),
        _ => {}
    }
    features
}

fn make_case(case: &TrinaryMinMaxCase, leaf: &str) -> Box<dyn TestCase> {
    let params = parse(case.spec);
    let operand_size = params.operand_size();
    let size = params.size_bytes;

    // `genInputBuffer` and `calculateResult`
    let mut rnd = Random::new(params.seed);
    let mut input = vec![0u8; NUM_OPERATIONS * 3 * operand_size];
    for operand_ndx in 0..NUM_OPERATIONS * 3 {
        for component in 0..params.components {
            let raw = gen_component(&mut rnd, &params);
            write_component(&mut input, operand_ndx * operand_size + component * size, raw, size);
        }
    }

    let mut reference = vec![0u8; NUM_OPERATIONS * operand_size];
    let mut mask = vec![0u8; NUM_OPERATIONS * operand_size];
    for operation in 0..NUM_OPERATIONS {
        for component in 0..params.components {
            let operands = [0, 1, 2].map(|operand| {
                read_component(
                    &input,
                    (operation * 3 + operand) * operand_size + component * size,
                    size,
                )
            });
            let offset = operation * operand_size + component * size;
            write_component(&mut reference, offset, calc(&params, operands), size);
            mask[offset..offset + size].fill(0xff);
        }
    }

    let mut extensions = vec![
        "VK_KHR_storage_buffer_storage_class".to_string(),
        "VK_AMD_shader_trinary_minmax".to_string(),
    ];
    match size {
        1 => extensions.push("VK_KHR_8bit_storage".to_string()),
        2 => extensions.push("VK_KHR_16bit_storage".to_string()),
        _ => {}
    }

    let spec = ComputeShaderSpec {
        inputs: vec![input],
        outputs: vec![reference],
        output_masks: vec![mask],
        num_work_groups: [NUM_OPERATIONS as u32, 1, 1],
        extensions,
        features: required_features(&params),
        spirv_1_5: true,
        fail_message: "Value mismatch in an operation",
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// `createTrinaryMinMaxGroup`, as the groups of each case path below `instruction` and the case.
pub fn create_trinary_minmax_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_TRINARY_MIN_MAX_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderPackingFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are written by `scripts/gen_shader_executor_programs.py` (`packing_function_specs`) and run
// through the ShaderExecutor in `vkt/tests/shaderexecutor`; the twelve case classes of upstream are one `Op` variant each. Upstream runs the instance on
// every queue of the kind; this runs it on the universal queue.

use crate::tcu::float::{Float16, Float32};
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::shaderexecutor::{
    ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_shader, execute, executor_programs,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `glu::Precision`, the two a case is registered with.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Precision {
    MediumP,
    HighP,
}

impl Precision {
    fn postfix(self) -> &'static str {
        match self {
            Self::MediumP => "_mediump",
            Self::HighP => "_highp",
        }
    }
}

fn shader_type_postfix(shader_type: ShaderType) -> &'static str {
    match shader_type {
        ShaderType::Vertex => "_vertex",
        ShaderType::Fragment => "_fragment",
        ShaderType::Geometry => "_geometry",
        ShaderType::TessellationControl => "_tess_control",
        ShaderType::TessellationEvaluation => "_tess_eval",
        ShaderType::Compute => "_compute",
        ShaderType::Task => "_task",
        ShaderType::Mesh => "_mesh",
    }
}

/// `deRoundFloatToInt32`
fn round_float_to_int32(x: f32) -> i32 {
    if x >= 0.0 { (x + 0.5) as i32 } else { (x - 0.5) as i32 }
}

/// `getUlpDiff`
fn get_ulp_diff(a: f32, b: f32) -> u32 {
    let a_bits = Float32::new(a).bits();
    let b_bits = Float32::new(b).bits();
    if a_bits > b_bits {
        a_bits - b_bits
    } else {
        b_bits - a_bits
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Op {
    PackSnorm2x16,
    UnpackSnorm2x16,
    PackUnorm2x16,
    UnpackUnorm2x16,
    PackHalf2x16,
    UnpackHalf2x16,
    PackSnorm4x8,
    UnpackSnorm4x8,
    PackUnorm4x8,
    UnpackUnorm4x8,
}

impl Op {
    fn function_name(self) -> &'static str {
        match self {
            Self::PackSnorm2x16 => "packsnorm2x16",
            Self::UnpackSnorm2x16 => "unpacksnorm2x16",
            Self::PackUnorm2x16 => "packunorm2x16",
            Self::UnpackUnorm2x16 => "unpackunorm2x16",
            Self::PackHalf2x16 => "packhalf2x16",
            Self::UnpackHalf2x16 => "unpackhalf2x16",
            Self::PackSnorm4x8 => "packsnorm4x8",
            Self::UnpackSnorm4x8 => "unpacksnorm4x8",
            Self::PackUnorm4x8 => "packunorm4x8",
            Self::UnpackUnorm4x8 => "unpackunorm4x8",
        }
    }

    /// The key of the generator's spec: `pack_<name>_<precision>`, `unpack_<name>` or the two half functions.
    fn spec_key(self, precision: Precision) -> String {
        let pack_name = |name: &str| format!("pack_{name}_{}", &precision.postfix()[1..]);
        match self {
            Self::PackSnorm2x16 => pack_name("snorm2x16"),
            Self::PackUnorm2x16 => pack_name("unorm2x16"),
            Self::PackSnorm4x8 => pack_name("snorm4x8"),
            Self::PackUnorm4x8 => pack_name("unorm4x8"),
            Self::UnpackSnorm2x16 => "unpack_snorm2x16".to_string(),
            Self::UnpackUnorm2x16 => "unpack_unorm2x16".to_string(),
            Self::UnpackSnorm4x8 => "unpack_snorm4x8".to_string(),
            Self::UnpackUnorm4x8 => "unpack_unorm4x8".to_string(),
            Self::PackHalf2x16 => "pack_half2x16".to_string(),
            Self::UnpackHalf2x16 => "unpack_half2x16".to_string(),
        }
    }

    /// Whether the registration loops over the precisions (the pack functions, but not packHalf2x16).
    fn has_precision(self) -> bool {
        matches!(
            self,
            Self::PackSnorm2x16 | Self::PackUnorm2x16 | Self::PackSnorm4x8 | Self::PackUnorm4x8
        )
    }

    /// The width of the float vector the function packs or unpacks.
    fn vec_size(self) -> u32 {
        match self {
            Self::PackSnorm4x8 | Self::UnpackSnorm4x8 | Self::PackUnorm4x8 | Self::UnpackUnorm4x8 => 4,
            _ => 2,
        }
    }

    fn is_pack(self) -> bool {
        matches!(
            self,
            Self::PackSnorm2x16 | Self::PackUnorm2x16 | Self::PackHalf2x16 | Self::PackSnorm4x8 | Self::PackUnorm4x8
        )
    }

    fn seed(self) -> u32 {
        if self == Self::PackSnorm4x8 { 0x42f2c0 } else { 0x776002 }
    }
}

static PACK_SPEC_2: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("in0", ScalarKind::Float, 2)],
    outputs: &[Symbol::new("out0", ScalarKind::Uint, 1)],
};
static PACK_SPEC_4: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("in0", ScalarKind::Float, 4)],
    outputs: &[Symbol::new("out0", ScalarKind::Uint, 1)],
};
static UNPACK_SPEC_2: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("in0", ScalarKind::Uint, 1)],
    outputs: &[Symbol::new("out0", ScalarKind::Float, 2)],
};
static UNPACK_SPEC_4: ShaderSpec = ShaderSpec {
    inputs: &[Symbol::new("in0", ScalarKind::Uint, 1)],
    outputs: &[Symbol::new("out0", ScalarKind::Float, 4)],
};

struct PackingCase {
    name: String,
    op: Op,
    precision: Precision,
    shader_type: ShaderType,
}

impl PackingCase {
    fn spec(&self) -> &'static ShaderSpec {
        match (self.op.is_pack(), self.op.vec_size()) {
            (true, 2) => &PACK_SPEC_2,
            (true, _) => &PACK_SPEC_4,
            (false, 2) => &UNPACK_SPEC_2,
            (false, _) => &UNPACK_SPEC_4,
        }
    }
}

impl TestCase for PackingCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_shader(context, self.shader_type)
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.op.spec_key(self.precision), self.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(PackingInstance { context, case: self })
    }
}

struct PackingInstance<'a> {
    context: &'a Context<'a>,
    case: &'a PackingCase,
}

fn random_vector(rnd: &mut Random, size: usize, min: f32, max: f32) -> Vec<f32> {
    (0..size).map(|_| rnd.get_float_range(min, max)).collect()
}

fn f32_bytes(values: &[Vec<f32>]) -> Vec<u8> {
    values.iter().flatten().flat_map(|value| value.to_ne_bytes()).collect()
}

fn u32_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn decode_u32(bytes: &[u8]) -> Vec<u32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]))
        .collect()
}

fn decode_f32(bytes: &[u8]) -> Vec<f32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| f32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]))
        .collect()
}

/// `composeHalfFloat`, with the sign given as "negative".
fn compose_half_float(negative: bool, exponent: u32, significand: u32) -> u16 {
    assert!(exponent & !((1 << 5) - 1) == 0);
    assert!(significand & !((1 << 10) - 1) == 0);
    ((((u32::from(negative)) << 5 | exponent) << 10) | significand) as u16
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum SubnormalizedConversionType {
    Unknown,
    Converted,
    ZeroFlushed,
}

/// `UnpackHalf2x16CaseInstance::checkValue`
fn check_half_value(in_value: u16, out_value: f32, conversion: &mut SubnormalizedConversionType) -> bool {
    let temp = Float16::from_bits(in_value);
    let reference = temp.as_float();
    let ref_bits = Float32::new(reference).bits();
    let res_bits = Float32::new(out_value).bits();
    let bit_match = (ref_bits ^ res_bits) == 0;
    let denorm = temp.is_denorm();

    if *conversion != SubnormalizedConversionType::Converted && denorm {
        // The result may be flushed to zero, of the matching sign or not, or be converted exactly; one choice is kept for the whole run.
        if res_bits == 0 || (reference < 0.0 && res_bits == 0x80000000) {
            *conversion = SubnormalizedConversionType::ZeroFlushed;
            return true;
        }
        if *conversion != SubnormalizedConversionType::ZeroFlushed && bit_match {
            *conversion = SubnormalizedConversionType::Converted;
            return true;
        }
        return false;
    }

    bit_match
}

impl PackingInstance<'_> {
    /// `executeTest` of the case class
    fn execute_test(&self) -> TestOutcome {
        let case = self.case;
        let op = case.op;
        let mut rnd = Random::new(de_string_hash(&case.name) ^ op.seed());

        if op.is_pack() && op != Op::PackHalf2x16 {
            let size = op.vec_size() as usize;
            let signed = matches!(op, Op::PackSnorm2x16 | Op::PackSnorm4x8);
            let max_diff = match (op, case.precision) {
                (Op::PackSnorm2x16, Precision::HighP) => 1,
                (Op::PackSnorm2x16, Precision::MediumP) => 33,
                (Op::PackUnorm2x16, Precision::HighP) => 1,
                (Op::PackUnorm2x16, Precision::MediumP) => 65,
                (_, Precision::HighP) => 1,
                (_, Precision::MediumP) => 1,
            };

            let mut inputs: Vec<Vec<f32>> = Vec::new();
            let (specials, mostly_in_range, large): (Vec<Vec<f32>>, (f32, f32), (f32, f32)) = match op {
                Op::PackSnorm2x16 => (
                    vec![
                        vec![0.0, 0.0],
                        vec![-1.0, 1.0],
                        vec![0.5, -0.5],
                        vec![-1.5, 1.5],
                        vec![0.25, -0.75],
                    ],
                    (-1.25, 1.25),
                    (-0.5e6, 0.5e6),
                ),
                Op::PackUnorm2x16 => (
                    vec![
                        vec![0.0, 0.0],
                        vec![0.5, 1.0],
                        vec![1.0, 0.5],
                        vec![-0.5, 1.5],
                        vec![0.25, 0.75],
                    ],
                    (0.0, 1.25),
                    (-1e5, 0.9e6),
                ),
                Op::PackSnorm4x8 => (
                    vec![
                        vec![0.0, 0.0, 0.0, 0.0],
                        vec![-1.0, 1.0, -1.0, 1.0],
                        vec![0.5, -0.5, -0.5, 0.5],
                        vec![-1.5, 1.5, -1.5, 1.5],
                        vec![0.25, -0.75, -0.25, 0.75],
                    ],
                    (-1.25, 1.25),
                    (-0.5e6, 0.5e6),
                ),
                _ => (
                    vec![
                        vec![0.0, 0.0, 0.0, 0.0],
                        vec![-1.0, 1.0, -1.0, 1.0],
                        vec![0.5, -0.5, -0.5, 0.5],
                        vec![-1.5, 1.5, -1.5, 1.5],
                        vec![0.25, -0.75, -0.25, 0.75],
                    ],
                    (-0.125, 1.125),
                    (-1e5, 0.9e6),
                ),
            };
            inputs.extend(specials);
            for _ in 0..15 {
                inputs.push(random_vector(&mut rnd, size, mostly_in_range.0, mostly_in_range.1));
            }
            for _ in 0..80 {
                inputs.push(random_vector(&mut rnd, size, large.0, large.1));
            }

            let num_values = inputs.len();
            let mut output_bytes = vec![0u8; num_values * 4];
            execute(
                self.context,
                case.shader_type,
                case.spec(),
                None,
                num_values,
                &[&f32_bytes(&inputs)],
                &mut [&mut output_bytes[..]],
                None,
            )?;
            let outputs = decode_u32(&output_bytes);

            let (scale, min, max, bits) = match op {
                Op::PackSnorm2x16 => (32767.0f32, -(1 << 15), (1 << 15) - 1, 16u32),
                Op::PackUnorm2x16 => (65535.0, 0, (1 << 16) - 1, 16),
                Op::PackSnorm4x8 => (127.0, -(1 << 7), (1 << 7) - 1, 8),
                _ => (255.0, 0, (1 << 8) - 1, 8),
            };
            let (clamp_min, clamp_max) = if signed { (-1.0f32, 1.0f32) } else { (0.0, 1.0) };

            let mut num_failed = 0;
            for val_ndx in 0..num_values {
                let reference: Vec<u32> = (0..size)
                    .map(|c| {
                        let rounded = round_float_to_int32(inputs[val_ndx][c].clamp(clamp_min, clamp_max) * scale)
                            .clamp(min, max);
                        // (uint16_t) or (uint8_t) cast of the clamped value
                        (rounded as u32) & ((1u32 << bits) - 1)
                    })
                    .collect();
                let res = outputs[val_ndx];
                let mut failed = false;
                for (c, &ref_c) in reference.iter().enumerate() {
                    let res_c = (res >> (bits * c as u32)) & ((1u32 << bits) - 1);
                    let diff = (ref_c as i32 - res_c as i32).abs();
                    if diff > max_diff {
                        failed = true;
                    }
                }
                if failed {
                    if num_failed < 10 {
                        log::error!(
                            "ERROR: Mismatch in value {val_ndx}, expected pack({:?}) = {:#x}, got {res:#x}, max diff = {max_diff}",
                            inputs[val_ndx],
                            reference
                                .iter()
                                .enumerate()
                                .fold(0u32, |acc, (c, v)| acc | (v << (bits * c as u32)))
                        );
                    }
                    num_failed += 1;
                }
            }
            log::info!("{} / {} values passed", num_values - num_failed, num_values);
            return Ok(if num_failed == 0 {
                TestStatus::pass("Pass")
            } else {
                TestStatus::fail("Result comparison failed")
            });
        }

        if op == Op::PackHalf2x16 {
            let max_diff = 0; // Values can be represented exactly in mediump.
            let mut inputs: Vec<Vec<f32>> = vec![
                vec![0.0, 0.0],
                vec![0.5, 1.0],
                vec![1.0, 0.5],
                vec![-0.5, 1.5],
                vec![0.25, 0.75],
            ];
            {
                let (min_exp, max_exp) = (-14, 15);
                for _ in 0..95 {
                    let mut v = vec![0.0f32; 2];
                    for component in v.iter_mut() {
                        let s = if rnd.get_bool() { 1 } else { -1 };
                        let exp = rnd.get_int(min_exp, max_exp);
                        let mantissa = rnd.get_uint32() & ((1 << 23) - 1);
                        *component =
                            Float32::construct(s, if exp != 0 { exp } else { 1 }, (1u32 << 23) | mantissa).as_float();
                    }
                    inputs.push(v);
                }
            }
            // Convert input values to fp16 and back to make sure they can be represented exactly in mediump.
            for input in inputs.iter_mut() {
                *input = vec![Float16::new(input[0]).as_float(), Float16::new(input[1]).as_float()];
            }

            let num_values = inputs.len();
            let mut output_bytes = vec![0u8; num_values * 4];
            execute(
                self.context,
                case.shader_type,
                case.spec(),
                None,
                num_values,
                &[&f32_bytes(&inputs)],
                &mut [&mut output_bytes[..]],
                None,
            )?;
            let outputs = decode_u32(&output_bytes);

            let mut num_failed = 0;
            for val_ndx in 0..num_values {
                let ref0 = Float16::new(inputs[val_ndx][0]).bits();
                let ref1 = Float16::new(inputs[val_ndx][1]).bits();
                let res = outputs[val_ndx];
                let (res0, res1) = ((res & 0xffff) as u16, (res >> 16) as u16);
                let diff0 = (i32::from(ref0) - i32::from(res0)).abs();
                let diff1 = (i32::from(ref1) - i32::from(res1)).abs();
                if diff0 > max_diff || diff1 > max_diff {
                    if num_failed < 10 {
                        log::error!(
                            "ERROR: Mismatch in value {val_ndx}, expected packHalf2x16({:?}) = {:#x}, got {res:#x}",
                            inputs[val_ndx],
                            (u32::from(ref1) << 16) | u32::from(ref0)
                        );
                    }
                    num_failed += 1;
                }
            }
            log::info!("{} / {} values passed", num_values - num_failed, num_values);
            return Ok(if num_failed == 0 {
                TestStatus::pass("Pass")
            } else {
                TestStatus::fail("Result comparison failed")
            });
        }

        // The unpack functions
        let mut inputs: Vec<u32> = Vec::new();
        if op == Op::UnpackHalf2x16 {
            let (min_exp, max_exp) = (-14, 15);
            let mant_bits = 10u32;
            let mant_bit_mask = (1u32 << mant_bits) - 1;
            let half = |value: f32| u32::from(Float16::new(value).bits());
            let raw = |negative: bool, exponent: u32, mantissa: u32| {
                u32::from(Float16::from_bits(compose_half_float(negative, exponent, mantissa)).bits())
            };

            // Special values.
            inputs.push((half(0.0) << 16) | half(1.0));
            inputs.push((half(1.0) << 16) | half(0.0));
            inputs.push((half(-1.0) << 16) | half(0.5));
            inputs.push((half(0.5) << 16) | half(-0.5));
            // Special subnormal value: single lowest bit set
            inputs.push((raw(false, 0, 1) << 16) | raw(true, 0, 1));
            // Special subnormal value: single highest fraction bit set
            inputs.push((raw(true, 0, 1 << (mant_bits - 1)) << 16) | raw(false, 0, 1 << (mant_bits - 1)));
            // Special subnormal value: all fraction bits set
            inputs.push((raw(false, 0, mant_bit_mask) << 16) | raw(true, 0, mant_bit_mask));

            // Construct random values.
            for _ in 0..90 {
                let mut in_val = 0u32;
                for c in 0..2 {
                    let s = if rnd.get_bool() { 1 } else { -1 };
                    let exp = rnd.get_int(min_exp, max_exp);
                    let mantissa = rnd.get_uint32() & mant_bit_mask;
                    let value =
                        Float16::construct(s, if exp != 0 { exp } else { 1 }, ((1u32 << 10) | mantissa) as u16).bits();
                    in_val |= u32::from(value) << (16 * c);
                }
                inputs.push(in_val);
            }
            for _ in 0..15 {
                let mut in_val = 0u32;
                for c in 0..2 {
                    let negative = !rnd.get_bool();
                    let mantissa = rnd.get_uint32() & mant_bit_mask;
                    let value = raw(negative, 0, mantissa);
                    in_val |= value << (16 * c);
                }
                inputs.push(in_val);
            }
        } else {
            inputs.extend([0x00000000, 0x7fff8000, 0x80007fff, 0xffffffff, 0x0001fffe]);
            for _ in 0..95 {
                inputs.push(rnd.get_uint32());
            }
        }

        let num_values = inputs.len();
        let size = op.vec_size() as usize;
        let mut output_bytes = vec![0u8; num_values * size * 4];
        execute(
            self.context,
            case.shader_type,
            case.spec(),
            None,
            num_values,
            &[&u32_bytes(&inputs)],
            &mut [&mut output_bytes[..]],
            None,
        )?;
        let outputs = decode_f32(&output_bytes);

        let mut num_failed = 0;
        let mut conversion = SubnormalizedConversionType::Unknown;
        for val_ndx in 0..num_values {
            let input = inputs[val_ndx];
            let results = &outputs[val_ndx * size..(val_ndx + 1) * size];

            let ok = match op {
                Op::UnpackHalf2x16 => {
                    let (in0, in1) = ((input & 0xffff) as u16, (input >> 16) as u16);
                    // checkValue is called for both values even when the first failed: it may fix the conversion type.
                    let value0 = check_half_value(in0, results[0], &mut conversion);
                    let value1 = check_half_value(in1, results[1], &mut conversion);
                    value0 && value1
                }
                _ => {
                    let max_diff = 1; // Rounding error.
                    (0..size).all(|c| {
                        let reference = match op {
                            Op::UnpackSnorm2x16 => {
                                ((input >> (16 * c)) as u16 as i16 as f32 / 32767.0).clamp(-1.0, 1.0)
                            }
                            Op::UnpackUnorm2x16 => (input >> (16 * c)) as u16 as f32 / 65535.0,
                            Op::UnpackSnorm4x8 => ((input >> (8 * c)) as u8 as i8 as f32 / 127.0).clamp(-1.0, 1.0),
                            _ => (input >> (8 * c)) as u8 as f32 / 255.0,
                        };
                        get_ulp_diff(reference, results[c]) <= max_diff
                    })
                }
            };

            if !ok {
                if num_failed < 10 {
                    log::error!("ERROR: Mismatch in value {val_ndx}, expected unpack({input:#x}), got {results:?}");
                }
                num_failed += 1;
            }
        }
        log::info!("{} / {} values passed", num_values - num_failed, num_values);
        Ok(if num_failed == 0 {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Result comparison failed")
        })
    }
}

impl TestInstance for PackingInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        self.execute_test()
    }
}

/// `ShaderPackingFunctionTests::init`
pub fn create_packing_function_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pack_unpack");
    let all_shader_types = [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Geometry,
        ShaderType::TessellationControl,
        ShaderType::TessellationEvaluation,
        ShaderType::Compute,
    ];
    let new_shader_types = [ShaderType::Geometry, ShaderType::Compute];

    let mut add = |op: Op, shader_types: &[ShaderType]| {
        let precisions: &[Precision] = if op.has_precision() {
            &[Precision::MediumP, Precision::HighP]
        } else {
            &[Precision::HighP]
        };
        for &precision in precisions {
            for &shader_type in shader_types {
                let precision_postfix = if op.has_precision() { precision.postfix() } else { "" };
                let name = format!(
                    "{}{}{}",
                    op.function_name(),
                    precision_postfix,
                    shader_type_postfix(shader_type)
                );
                group.add_child(Box::new(PackingCase {
                    name,
                    op,
                    precision,
                    shader_type,
                }) as Box<dyn TestCase>);
            }
        }
    };

    // New built-in functions in GLES 3.1
    add(Op::PackSnorm4x8, &all_shader_types);
    add(Op::UnpackSnorm4x8, &all_shader_types);
    add(Op::PackUnorm4x8, &all_shader_types);
    add(Op::UnpackUnorm4x8, &all_shader_types);

    // GLES 3 functions in new shader types.
    add(Op::PackSnorm2x16, &new_shader_types);
    add(Op::UnpackSnorm2x16, &new_shader_types);
    add(Op::PackUnorm2x16, &new_shader_types);
    add(Op::UnpackUnorm2x16, &new_shader_types);
    add(Op::PackHalf2x16, &new_shader_types);
    add(Op::UnpackHalf2x16, &new_shader_types);

    group
}

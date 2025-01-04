// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderCommonFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The compute shaders are written by `scripts/gen_shader_executor_programs.py` (`common_function_specs`)
// and run through the ShaderExecutor; the case classes of upstream are one `Func` variant each.
// The 64 bit float cases run (ScalarKind::Double); the vec5 cases (VK_EXT_shader_long_vector) use `vector<float, 5>` types and `GL_EXT_long_vector` in the generated shaders. Upstream runs the
// instance on every queue of the kind; this runs it on the universal queue.

use vulkanalia::vk;

use crate::tcu::float::{Float16, Float32};
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::shaderexecutor::{
    ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_long_vector, check_support_shader, execute,
    executor_programs,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Precision {
    MediumP,
    HighP,
}

impl Precision {
    fn name(self) -> &'static str {
        match self {
            Self::MediumP => "mediump",
            Self::HighP => "highp",
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Func {
    Abs,
    Sign,
    Isnan,
    Isinf,
    FloatBitsToInt,
    FloatBitsToUint,
    IntBitsToFloat,
    UintBitsToFloat,
    ClampConstArrayDynamicIndex,
}

impl Func {
    /// The `common_<key>_<base><size>_<precision>` key of the generator's spec.
    fn key(self) -> &'static str {
        match self {
            Self::Abs => "abs",
            Self::Sign => "sign",
            Self::Isnan => "isnan",
            Self::Isinf => "isinf",
            Self::FloatBitsToInt => "floatbitstoint",
            Self::FloatBitsToUint => "floatbitstouint",
            Self::IntBitsToFloat => "intbitstofloat",
            Self::UintBitsToFloat => "uintbitstofloat",
            Self::ClampConstArrayDynamicIndex => "clamp_const_array_dynamic_index",
        }
    }
}

#[derive(Clone, Copy)]
struct CaseParams {
    func: Func,
    /// The kind of the input: Int, Uint or Float
    kind: ScalarKind,
    size: u32,
    precision: Precision,
    double: bool,
}

fn build_spec(params: &CaseParams) -> ShaderSpec {
    let size = params.size;
    let (inputs, outputs): (Vec<Symbol>, Vec<Symbol>) = match params.func {
        Func::Abs | Func::Sign => (
            vec![Symbol::new("in0", ScalarKind::Int, size)],
            vec![Symbol::new("out0", ScalarKind::Int, size)],
        ),
        Func::Isnan | Func::Isinf => (
            vec![Symbol::new(
                "in0",
                if params.double {
                    ScalarKind::Double
                } else {
                    ScalarKind::Float
                },
                size,
            )],
            vec![Symbol::new("out0", ScalarKind::Bool, size)],
        ),
        Func::FloatBitsToInt => (
            vec![Symbol::new("in0", ScalarKind::Float, size)],
            vec![Symbol::new("out0", ScalarKind::Int, size)],
        ),
        Func::FloatBitsToUint => (
            vec![Symbol::new("in0", ScalarKind::Float, size)],
            vec![Symbol::new("out0", ScalarKind::Uint, size)],
        ),
        Func::IntBitsToFloat => (
            vec![Symbol::new("in0", ScalarKind::Int, size)],
            vec![Symbol::new("out0", ScalarKind::Float, size)],
        ),
        Func::UintBitsToFloat => (
            vec![Symbol::new("in0", ScalarKind::Uint, size)],
            vec![Symbol::new("out0", ScalarKind::Float, size)],
        ),
        Func::ClampConstArrayDynamicIndex => (
            vec![Symbol::new("in0", ScalarKind::Int, 1)],
            vec![Symbol::new("out0", ScalarKind::Float, 2)],
        ),
    };
    ShaderSpec {
        inputs: inputs.leak(),
        outputs: outputs.leak(),
    }
}

fn spec_key(params: &CaseParams) -> String {
    if params.func == Func::ClampConstArrayDynamicIndex {
        return format!("common_{}", params.func.key());
    }
    if params.double {
        return format!("common_{}_double{}", params.func.key(), params.size);
    }
    let base = match params.kind {
        ScalarKind::Int => "int",
        ScalarKind::Uint => "uint",
        _ => "float",
    };
    format!(
        "common_{}_{}{}_{}",
        params.func.key(),
        base,
        params.size,
        params.precision.name()
    )
}

struct CommonFunctionCase {
    name: String,
    params: CaseParams,
    spec: ShaderSpec,
    spec_key: String,
}

impl CommonFunctionCase {
    fn new(name: String, params: CaseParams) -> Self {
        Self {
            name,
            params,
            spec: build_spec(&params),
            spec_key: spec_key(&params),
        }
    }

    fn num_values(&self) -> usize {
        if self.params.func == Func::ClampConstArrayDynamicIndex {
            4
        } else {
            100
        }
    }
}

impl TestCase for CommonFunctionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        if self.params.double && context.get_device_features().shader_float64 == vk::FALSE {
            return Err(TestError::NotSupported(
                "64-bit floats not supported by the implementation".to_string(),
            ));
        }
        check_support_shader(context, ShaderType::Compute)?;
        if self.params.size == 5 {
            check_support_long_vector(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.spec_key, ShaderType::Compute)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(CommonFunctionInstance { context, case: self })
    }
}

struct CommonFunctionInstance<'a> {
    context: &'a Context<'a>,
    case: &'a CommonFunctionCase,
}

/// `getMaxUlpDiffFromBits`
fn get_max_ulp_diff_from_bits(num_accurate_bits: u32, num_total_bits: u32) -> u64 {
    (1u64 << (num_total_bits - num_accurate_bits)) - 1
}

/// `getMinMantissaBits` of a float type
fn get_min_mantissa_bits(precision: Precision) -> u32 {
    match precision {
        Precision::MediumP => 10,
        Precision::HighP => 23,
    }
}

/// `getUlpDiff`
fn get_ulp_diff(a: f32, b: f32) -> u32 {
    let a_bits = Float32::new(a).bits();
    let b_bits = Float32::new(b).bits();
    a_bits.abs_diff(b_bits)
}

/// `getUlpDiffIgnoreZeroSign`
fn get_ulp_diff_ignore_zero_sign(a: f32, b: f32) -> u32 {
    if Float32::new(a).is_zero() {
        get_ulp_diff(Float32::construct(Float32::new(b).sign(), 0, 0).as_float(), b)
    } else if Float32::new(b).is_zero() {
        get_ulp_diff(a, Float32::construct(Float32::new(a).sign(), 0, 0).as_float())
    } else {
        get_ulp_diff(a, b)
    }
}

/// `infNanRandomFloats`, the 32 bit half
fn inf_nan_random_floats(num_values: usize, scalar_size: usize, name: &str, precision: Precision) -> Vec<u32> {
    let mut rnd = Random::new(de_string_hash(name) ^ 0xc2a39f);
    let min_mantissa_bits = get_min_mantissa_bits(precision);
    let num_mantissa_bits = 23u32;
    let mantissa_mask =
        !get_max_ulp_diff_from_bits(min_mantissa_bits, num_mantissa_bits) & ((1u64 << num_mantissa_bits) - 1);
    let exponent_bits = 8u32;
    let exponent_mask = (1u32 << exponent_bits) - 1;
    let exponent_bias = 127u64;

    let mut values = Vec::with_capacity(num_values * scalar_size);
    for _ in 0..num_values * scalar_size {
        // Roughly 25% chance of each of Inf and NaN
        let is_inf = rnd.get_float() > 0.75;
        let is_nan = !is_inf && rnd.get_float() > 0.66;
        let m = rnd.get_uint64() & mantissa_mask;
        let e = u64::from(rnd.get_uint32() & exponent_mask);
        let sign = u64::from(rnd.get_uint32() & 0x1);

        // Ensure the 'quiet' bit is set on NaNs (also ensures we don't generate inf by mistake)
        let mantissa = if is_inf {
            0
        } else if is_nan {
            (1u64 << (num_mantissa_bits - 1)) | m
        } else {
            m
        };
        let exp = if is_nan || is_inf {
            u64::from(exponent_mask)
        } else {
            e.min(exponent_bias)
        };
        let value =
            (sign << (num_mantissa_bits + exponent_bits)) | (exp << num_mantissa_bits) | u64::from(mantissa as u32);
        values.push(value as u32);
    }
    values
}

/// `infNanRandomFloats`, the 64 bit half: every value is two words, low word first
fn inf_nan_random_doubles(num_values: usize, scalar_size: usize, name: &str) -> Vec<u32> {
    let mut rnd = Random::new(de_string_hash(name) ^ 0xc2a39f);
    let num_mantissa_bits = 52u32;
    let mantissa_mask = (1u64 << num_mantissa_bits) - 1;
    let exponent_bits = 11u32;
    let exponent_mask = (1u32 << exponent_bits) - 1;
    let exponent_bias = 1023u64;

    let mut values = Vec::with_capacity(num_values * scalar_size * 2);
    for _ in 0..num_values * scalar_size {
        let is_inf = rnd.get_float() > 0.75;
        let is_nan = !is_inf && rnd.get_float() > 0.66;
        let m = rnd.get_uint64() & mantissa_mask;
        let e = u64::from(rnd.get_uint32() & exponent_mask);
        let sign = u64::from(rnd.get_uint32() & 0x1);

        let mantissa = if is_inf {
            0
        } else if is_nan {
            (1u64 << (num_mantissa_bits - 1)) | m
        } else {
            m
        };
        let exp = if is_nan || is_inf {
            u64::from(exponent_mask)
        } else {
            e.min(exponent_bias)
        };
        let value =
            (sign << (num_mantissa_bits + exponent_bits)) | (exp << num_mantissa_bits) | u64::from(mantissa as u32);
        values.push(value as u32);
        values.push((value >> 32) as u32);
    }
    values
}

fn to_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn from_bytes(bytes: &[u8]) -> Vec<u32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]))
        .collect()
}

impl CommonFunctionInstance<'_> {
    /// `getInputValues`, as the bits of the 32 bit values
    fn get_input_values(&self, num_values: usize) -> Vec<u32> {
        let params = &self.case.params;
        let name = self.case.name.as_str();
        let scalar_size = params.size as usize;
        let count = num_values * scalar_size;
        let precision = params.precision;

        match params.func {
            Func::Abs => {
                let ranges = [(-(1 << 15) + 1, (1 << 15) - 1), (i32::MIN + 1, i32::MAX)];
                let (min, max) = ranges[if precision == Precision::HighP { 1 } else { 0 }];
                let mut rnd = Random::new(de_string_hash(name) ^ 0x235fac);
                (0..count).map(|_| rnd.get_int(min, max) as u32).collect()
            }
            Func::Sign => {
                let ranges = [(-(1 << 15), (1 << 15) - 1), (i32::MIN, i32::MAX)];
                let (min, max) = ranges[if precision == Precision::HighP { 1 } else { 0 }];
                let mut rnd = Random::new(de_string_hash(name) ^ 0x324);
                let mut values = vec![0u32; count];
                values[..scalar_size].fill(1);
                values[scalar_size..2 * scalar_size].fill((-1i32) as u32);
                values[2 * scalar_size..3 * scalar_size].fill(0);
                for value in values.iter_mut().skip(3 * scalar_size) {
                    *value = rnd.get_int(min, max) as u32;
                }
                values
            }
            Func::Isnan | Func::Isinf if params.double => inf_nan_random_doubles(num_values, scalar_size, name),
            Func::Isnan | Func::Isinf => inf_nan_random_floats(num_values, scalar_size, name, precision),
            Func::FloatBitsToInt | Func::FloatBitsToUint => {
                let (min, max) = if precision == Precision::HighP {
                    (-1e7f32, 1e7f32)
                } else {
                    (-1e3f32, 1e3f32)
                };
                let mut rnd = Random::new(de_string_hash(name) ^ 0x2790a);
                (0..count).map(|_| rnd.get_float_range(min, max).to_bits()).collect()
            }
            Func::IntBitsToFloat | Func::UintBitsToFloat => {
                let mut rnd = Random::new(de_string_hash(name) ^ 0xbbb225);
                // Filled as floats.
                (0..count).map(|_| rnd.get_float_range(-1e8, 1e8).to_bits()).collect()
            }
            Func::ClampConstArrayDynamicIndex => (0..num_values).map(|ndx| (ndx % 4) as u32).collect(),
        }
    }

    /// `compare` of the case class for one element
    fn compare(&self, inputs: &[u32], outputs: &[u32]) -> Result<(), String> {
        let params = &self.case.params;
        let scalar_size = params.size as usize;
        let precision = params.precision;

        match params.func {
            Func::Abs => {
                for comp_ndx in 0..scalar_size {
                    let in0 = inputs[comp_ndx] as i32;
                    let out0 = outputs[comp_ndx] as i32;
                    let ref0 = in0.wrapping_abs();
                    if out0 != ref0 {
                        return Err(format!("Expected [{comp_ndx}] = {ref0}"));
                    }
                }
            }
            Func::Sign => {
                for comp_ndx in 0..scalar_size {
                    let in0 = inputs[comp_ndx] as i32;
                    let out0 = outputs[comp_ndx] as i32;
                    let ref0 = if in0 < 0 {
                        -1
                    } else if in0 > 0 {
                        1
                    } else {
                        0
                    };
                    if out0 != ref0 {
                        return Err(format!("Expected [{comp_ndx}] = {ref0}"));
                    }
                }
            }
            Func::Isnan | Func::Isinf if params.double => {
                for comp_ndx in 0..scalar_size {
                    let out0 = outputs[comp_ndx] != 0;
                    let in0 =
                        f64::from_bits(u64::from(inputs[comp_ndx * 2]) | (u64::from(inputs[comp_ndx * 2 + 1]) << 32));
                    let reference = if params.func == Func::Isnan {
                        in0.is_nan()
                    } else {
                        in0.is_infinite()
                    };
                    if out0 != reference {
                        return Err(format!("Expected [{comp_ndx}] = {reference}"));
                    }
                }
            }
            Func::Isnan => {
                for comp_ndx in 0..scalar_size {
                    let out0 = outputs[comp_ndx] != 0;
                    let in0 = f32::from_bits(inputs[comp_ndx]);
                    let reference = Float32::new(in0).is_nan();
                    // NaN support only required for highp. Otherwise just check for false positives.
                    let ok = if precision == Precision::HighP {
                        out0 == reference
                    } else {
                        reference || !out0
                    };
                    if !ok {
                        return Err(format!("Expected [{comp_ndx}] = {reference}"));
                    }
                }
            }
            Func::Isinf => {
                for comp_ndx in 0..scalar_size {
                    let out0 = outputs[comp_ndx] != 0;
                    let in0 = f32::from_bits(inputs[comp_ndx]);
                    let (reference, ok) = if precision == Precision::HighP {
                        // Only highp is required to support inf/nan
                        let reference = Float32::new(in0).is_inf();
                        (reference, out0 == reference)
                    } else {
                        // Inf support is optional, check that inputs that are not Inf in mediump don't result in true.
                        let reference = Float16::new(in0).is_inf();
                        (reference, out0 || !reference)
                    };
                    if !ok {
                        return Err(format!("Expected [{comp_ndx}] = {reference}"));
                    }
                }
            }
            Func::FloatBitsToInt | Func::FloatBitsToUint => {
                let max_ulp_diff = get_max_ulp_diff_from_bits(get_min_mantissa_bits(precision), 23) as i64;
                for comp_ndx in 0..scalar_size {
                    let in0 = f32::from_bits(inputs[comp_ndx]);
                    let out0 = outputs[comp_ndx];
                    let ref_out0 = Float32::new(in0).bits();
                    let ulp_diff = (i64::from(out0 as i32) - i64::from(ref_out0 as i32)).abs();
                    if ulp_diff > max_ulp_diff {
                        return Err(format!(
                            "Expected [{comp_ndx}] = {ref_out0:#x} with threshold {max_ulp_diff:#x}, got diff {ulp_diff:#x}"
                        ));
                    }
                }
            }
            Func::IntBitsToFloat | Func::UintBitsToFloat => {
                for comp_ndx in 0..scalar_size {
                    let in0 = f32::from_bits(inputs[comp_ndx]);
                    let out0 = f32::from_bits(outputs[comp_ndx]);
                    let ulp_diff = get_ulp_diff_ignore_zero_sign(in0, out0);
                    if ulp_diff > 0 {
                        return Err(format!(
                            "Expected [{comp_ndx}] = {:#x} with ULP threshold 0, got ULP diff {ulp_diff:#x}",
                            Float32::new(in0).bits()
                        ));
                    }
                }
            }
            Func::ClampConstArrayDynamicIndex => {
                let in0 = inputs[0] as i32;
                let out0_x = f32::from_bits(outputs[0]);
                let out0_y = f32::from_bits(outputs[1]);
                let (ref_x, ref_y) = match in0 {
                    0 => (-1.0f32, -1.0f32),
                    1 => (3.0, -1.0),
                    2 => (-1.0, 3.0),
                    3 => (3.0, 3.0),
                    _ => unreachable!("the inputs are ndx % 4"),
                };
                let (ref_x, ref_y) = (ref_x.clamp(0.0, 1.0), ref_y.clamp(0.0, 1.0));
                let close = |a: f32, b: f32| (a - b).abs() <= 0.0001;
                if !close(out0_x, ref_x) || !close(out0_y, ref_y) {
                    return Err(format!(
                        "Expected ({ref_x}, {ref_y}), got ({out0_x}, {out0_y}) for input index {in0}"
                    ));
                }
            }
        }

        Ok(())
    }
}

impl TestInstance for CommonFunctionInstance<'_> {
    /// `CommonFunctionTestInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let case = self.case;
        let num_values = case.num_values();
        let spec = &case.spec;
        let input_scalar = spec.inputs[0].size as usize * if case.params.double { 2 } else { 1 };
        let output_scalar = spec.outputs[0].size as usize;

        let input_data = self.get_input_values(num_values);
        let input_bytes = to_bytes(&input_data);
        let mut output_bytes = vec![0u8; num_values * output_scalar * 4];
        execute(
            self.context,
            ShaderType::Compute,
            spec,
            None,
            num_values,
            &[&input_bytes],
            &mut [&mut output_bytes[..]],
            None,
        )?;
        let output_data = from_bytes(&output_bytes);

        let mut num_failed = 0;
        for val_ndx in 0..num_values {
            let cur_input = &input_data[val_ndx * input_scalar..(val_ndx + 1) * input_scalar];
            let cur_output = &output_data[val_ndx * output_scalar..(val_ndx + 1) * output_scalar];
            if let Err(message) = self.compare(cur_input, cur_output) {
                log::error!(
                    "ERROR: comparison failed for value {val_ndx}:\n  {message}\n  inputs: {cur_input:x?}\n  outputs: {cur_output:x?}"
                );
                num_failed += 1;
            }
        }
        log::info!("{} / {} values passed", num_values - num_failed, num_values);

        if num_failed == 0 {
            Ok(TestStatus::pass("Pass"))
        } else {
            Ok(TestStatus::fail("Result comparison failed"))
        }
    }
}

/// `getCommonFuncCaseName`
fn case_name(kind: ScalarKind, size: u32, double: bool, precision: Precision) -> String {
    let base = match (kind, double, size) {
        (ScalarKind::Int, _, 1) => "int".to_string(),
        (ScalarKind::Int, _, n) => format!("ivec{n}"),
        (ScalarKind::Uint, _, 1) => "uint".to_string(),
        (ScalarKind::Uint, _, n) => format!("uvec{n}"),
        (_, true, 1) => "double".to_string(),
        (_, true, n) => format!("dvec{n}"),
        (_, false, 1) => "float".to_string(),
        (_, false, n) => format!("vec{n}"),
    };
    format!(
        "{base}{}_compute",
        if double {
            String::new()
        } else {
            format!("_{}", precision.name())
        }
    )
}

/// `addFunctionCases`: `types` are the scalar types, `(kind, double)`.
fn add_function_cases(parent: &mut TestCaseGroup, function_name: &str, func: Func, types: &[(ScalarKind, bool)]) {
    let mut group = TestCaseGroup::new(function_name);
    for &(kind, double) in types {
        let precisions: &[Precision] = if double {
            &[Precision::HighP]
        } else {
            &[Precision::MediumP, Precision::HighP]
        };
        for size in 1..=5u32 {
            for &precision in precisions {
                let name = case_name(kind, size, double, precision);
                group.add_child(Box::new(CommonFunctionCase::new(
                    name,
                    CaseParams {
                        func,
                        kind,
                        size,
                        precision,
                        double,
                    },
                )) as Box<dyn TestCase>);
            }
        }
    }
    parent.add_child(group);
}

/// `ShaderCommonFunctionTests::init`
pub fn create_common_function_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("common");

    add_function_cases(&mut group, "abs", Func::Abs, &[(ScalarKind::Int, false)]);
    add_function_cases(&mut group, "sign", Func::Sign, &[(ScalarKind::Int, false)]);
    add_function_cases(
        &mut group,
        "isnan",
        Func::Isnan,
        &[(ScalarKind::Float, false), (ScalarKind::Float, true)],
    );
    add_function_cases(
        &mut group,
        "isinf",
        Func::Isinf,
        &[(ScalarKind::Float, false), (ScalarKind::Float, true)],
    );
    add_function_cases(
        &mut group,
        "floatbitstoint",
        Func::FloatBitsToInt,
        &[(ScalarKind::Float, false)],
    );
    add_function_cases(
        &mut group,
        "floatbitstouint",
        Func::FloatBitsToUint,
        &[(ScalarKind::Float, false)],
    );

    // (u)intBitsToFloat()
    let mut int_group = TestCaseGroup::new("intbitstofloat");
    let mut uint_group = TestCaseGroup::new("uintbitstofloat");
    for size in 1..=5u32 {
        let int_name = case_name(ScalarKind::Int, size, false, Precision::HighP);
        int_group.add_child(Box::new(CommonFunctionCase::new(
            int_name,
            CaseParams {
                func: Func::IntBitsToFloat,
                kind: ScalarKind::Int,
                size,
                precision: Precision::HighP,
                double: false,
            },
        )) as Box<dyn TestCase>);
        let uint_name = case_name(ScalarKind::Uint, size, false, Precision::HighP);
        uint_group.add_child(Box::new(CommonFunctionCase::new(
            uint_name,
            CaseParams {
                func: Func::UintBitsToFloat,
                kind: ScalarKind::Uint,
                size,
                precision: Precision::HighP,
                double: false,
            },
        )) as Box<dyn TestCase>);
    }
    group.add_child(int_group);
    group.add_child(uint_group);

    let mut clamp_group = TestCaseGroup::new("clamp");
    clamp_group.add_child(Box::new(CommonFunctionCase::new(
        "clamp_const_array_dynamic_index".to_string(),
        CaseParams {
            func: Func::ClampConstArrayDynamicIndex,
            kind: ScalarKind::Int,
            size: 1,
            precision: Precision::HighP,
            double: false,
        },
    )) as Box<dyn TestCase>);
    group.add_child(clamp_group);

    group
}

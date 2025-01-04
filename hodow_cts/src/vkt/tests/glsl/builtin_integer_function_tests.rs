// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderexecutor/vktShaderIntegerFunctionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The shaders are written by `scripts/gen_shader_executor_programs.py` (`integer_function_specs`) and run
// through the ShaderExecutor in `vkt/tests/shaderexecutor`; the case classes of upstream are one `Func` variant each, with `get_input_values` and `compare`
// as methods. The vec5 cases (VK_EXT_shader_long_vector, compute only) use `vector<int, 5>` types and `GL_EXT_long_vector` in the generated shaders. Upstream runs the
// instance on every queue of the kind (`MultiQueueRunnerTestInstance`); this runs it on the universal queue.

use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};
use crate::vk::programs::BinaryCollection;
use crate::vkt::tests::shaderexecutor::{
    ScalarKind, ShaderSpec, ShaderType, Symbol, check_support_long_vector, check_support_shader, execute,
    executor_programs,
};
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

/// `glu::Precision`
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Precision {
    MediumP,
    HighP,
}

impl Precision {
    /// `getPrecisionPostfix`
    fn postfix(self) -> &'static str {
        match self {
            Self::MediumP => "_mediump",
            Self::HighP => "_highp",
        }
    }

    fn glsl(self) -> &'static str {
        &self.postfix()[1..]
    }

    /// `getShaderUintBitCount`
    fn uint_bit_count(self) -> u32 {
        match self {
            Self::MediumP => 16,
            Self::HighP => 32,
        }
    }
}

/// `getShaderTypePostfix`
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

/// `extendSignTo32`
fn extend_sign_to_32(integer: u32, integer_length: u32) -> u32 {
    assert!(integer_length > 0 && integer_length <= 32);
    0u32.wrapping_sub((integer & (1 << (integer_length - 1))).wrapping_shl(1)) | integer
}

/// `getLowBitMask`
fn get_low_bit_mask(integer_length: u32) -> u32 {
    assert!(integer_length <= 32);
    if integer_length == 0 {
        return 0;
    }
    ((1u32 << (integer_length - 1)) << 1).wrapping_sub(1)
}

/// `generateRandomInputData`
fn generate_random_input_data(
    rnd: &mut Random,
    signed: bool,
    scalar_size: usize,
    precision: Precision,
    dst: &mut [u32],
    num_values: usize,
) {
    let integer_length = precision.uint_bit_count();
    let integer_mask = get_low_bit_mask(integer_length);

    for value_ndx in 0..num_values {
        for comp_ndx in 0..scalar_size {
            let raw = rnd.get_uint32() & integer_mask;
            dst[value_ndx * scalar_size + comp_ndx] = if signed {
                extend_sign_to_32(raw, integer_length)
            } else {
                raw
            };
        }
    }
}

fn reverse_bits(v: u32) -> u32 {
    v.reverse_bits()
}

/// `toPrecision` (uint)
fn to_precision_u32(value: u32, num_integer_bits: u32) -> u32 {
    value & get_low_bit_mask(num_integer_bits)
}

/// `toPrecision` (int)
fn to_precision_i32(value: i32, num_integer_bits: u32) -> i32 {
    extend_sign_to_32(value as u32 & get_low_bit_mask(num_integer_bits), num_integer_bits) as i32
}

/// `de::findMSB(uint32_t)`
fn find_msb_u32(value: u32) -> i32 {
    31 - value.leading_zeros() as i32
}

/// `de::findMSB(int32_t)`
fn find_msb_i32(value: i32) -> i32 {
    find_msb_u32(if value < 0 { !(value as u32) } else { value as u32 })
}

/// `de::findLSB(uint32_t)`
fn find_lsb_u32(value: u32) -> i32 {
    if value == 0 { -1 } else { value.trailing_zeros() as i32 }
}

const NESTED_SHIFT_OUTPUTS: [(&str, i32); 18] = [
    ("signExtendEqualShift", -1),
    ("signExtendCompoundShift", -3),
    ("zeroExtendCompoundShift", 511),
    ("signExtendReducedShift", -4096),
    ("logicalShiftCast", 3),
    ("logicalShiftCompound", 1023),
    ("posIntLeftRightMask", 21504),
    ("posIntRightLeftMask", 114688),
    ("shiftLeftClearAll", 0),
    ("shiftRightClearAll", 0),
    ("negIntSignFlip", 6144),
    ("negIntSignExtend", -16384),
    ("maxArithmeticShiftRight", -1),
    ("maxShiftLeftOdd", 0x80000000u32 as i32),
    ("consecutiveRightShiftPos", 1883),
    ("consecutiveRightShiftNeg", -1),
    ("identityRightShift", -1024000),
    ("identityLeftShift", 0xF3454000u32 as i32),
];

/// One case class of upstream per variant.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Func {
    UaddCarry,
    UsubBorrow,
    UmulExtended,
    ImulExtended,
    BitfieldExtract,
    BitfieldInsert,
    BitfieldReverse,
    BitCount,
    FindLsb,
    FindMsb,
    BitwiseVectorModulo,
    BitwiseNestedLiteralShift,
}

impl Func {
    /// The `integer.<group>` name of the function; the spec keys of the generator are `integer_<key>_<base><size>_<precision>`.
    fn key(self) -> &'static str {
        match self {
            Self::UaddCarry => "uaddcarry",
            Self::UsubBorrow => "usubborrow",
            Self::UmulExtended => "umulextended",
            Self::ImulExtended => "imulextended",
            Self::BitfieldExtract => "bitfieldextract",
            Self::BitfieldInsert => "bitfieldinsert",
            Self::BitfieldReverse => "bitfieldreverse",
            Self::BitCount => "bitcount",
            Self::FindLsb => "findlsb",
            Self::FindMsb => "findMSB",
            Self::BitwiseVectorModulo => "bitwise_vector_modulo",
            Self::BitwiseNestedLiteralShift => "bitwise_nested_literal_shifts",
        }
    }
}

#[derive(Clone, Copy)]
struct CaseParams {
    func: Func,
    shader_type: ShaderType,
    signed: bool,
    size: u32,
    precision: Precision,
}

fn symbol(name: &'static str, signed: bool, size: u32) -> Symbol {
    Symbol::new(name, if signed { ScalarKind::Int } else { ScalarKind::Uint }, size)
}

/// The host half of the spec the generator wrote for the case.
fn build_spec(params: &CaseParams) -> ShaderSpec {
    let (signed, size) = (params.signed, params.size);
    let int = |name| Symbol::new(name, ScalarKind::Int, 1);
    let (inputs, outputs): (Vec<Symbol>, Vec<Symbol>) = match params.func {
        Func::UaddCarry => (
            vec![symbol("x", signed, size), symbol("y", signed, size)],
            vec![symbol("sum", signed, size), symbol("carry", signed, size)],
        ),
        Func::UsubBorrow => (
            vec![symbol("x", signed, size), symbol("y", signed, size)],
            vec![symbol("diff", signed, size), symbol("carry", signed, size)],
        ),
        Func::UmulExtended | Func::ImulExtended => (
            vec![symbol("x", signed, size), symbol("y", signed, size)],
            vec![symbol("msb", signed, size), symbol("lsb", signed, size)],
        ),
        Func::BitfieldExtract => (
            vec![symbol("value", signed, size), int("offset"), int("bits")],
            vec![symbol("extracted", signed, size)],
        ),
        Func::BitfieldInsert => (
            vec![
                symbol("base", signed, size),
                symbol("insert", signed, size),
                int("offset"),
                int("bits"),
            ],
            vec![symbol("result", signed, size)],
        ),
        Func::BitfieldReverse => (
            vec![symbol("value", signed, size)],
            vec![symbol("result", signed, size)],
        ),
        Func::BitCount => (
            vec![symbol("value", signed, size)],
            vec![Symbol::new("count", ScalarKind::Int, size)],
        ),
        Func::FindLsb => (
            vec![symbol("value", signed, size)],
            vec![Symbol::new("lsb", ScalarKind::Int, size)],
        ),
        Func::FindMsb => (
            vec![symbol("value", signed, size)],
            vec![Symbol::new("msb", ScalarKind::Int, size)],
        ),
        Func::BitwiseVectorModulo => (vec![int("input1")], vec![Symbol::new("outVal", ScalarKind::Uint, 1)]),
        Func::BitwiseNestedLiteralShift => (
            vec![
                Symbol::new("highBitMaskPattern", ScalarKind::Uint, 1),
                int("lowBitsPattern"),
                int("mixedBitsPattern"),
                int("negativeValue"),
            ],
            NESTED_SHIFT_OUTPUTS.iter().map(|(name, _)| int(*name)).collect(),
        ),
    };
    ShaderSpec {
        inputs: inputs.leak(),
        outputs: outputs.leak(),
    }
}

/// The key of the generator's spec of the case.
fn spec_key(params: &CaseParams) -> String {
    match params.func {
        Func::BitwiseVectorModulo | Func::BitwiseNestedLiteralShift => format!("integer_{}", params.func.key()),
        func => format!(
            "integer_{}_{}{}_{}",
            func.key(),
            if params.signed { "int" } else { "uint" },
            params.size,
            params.precision.glsl()
        ),
    }
}

struct IntegerFunctionCase {
    name: String,
    params: CaseParams,
    spec: ShaderSpec,
    spec_key: String,
}

impl IntegerFunctionCase {
    fn new(name: String, params: CaseParams) -> Self {
        Self {
            name,
            params,
            spec: build_spec(&params),
            spec_key: spec_key(&params),
        }
    }

    fn num_values(&self) -> usize {
        match self.params.func {
            Func::BitwiseVectorModulo | Func::BitwiseNestedLiteralShift => 1,
            _ => 100,
        }
    }
}

impl TestCase for IntegerFunctionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        check_support_shader(context, self.params.shader_type)?;
        if self.params.size == 5 {
            check_support_long_vector(context)?;
        }
        Ok(())
    }

    fn programs(&self) -> BinaryCollection {
        executor_programs(&self.spec_key, self.params.shader_type)
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(IntegerFunctionInstance { context, case: self })
    }
}

struct IntegerFunctionInstance<'a> {
    context: &'a Context<'a>,
    case: &'a IntegerFunctionCase,
}

impl IntegerFunctionInstance<'_> {
    /// `getInputValues` of the case class. `values[i]` holds the `num_values` elements of input `i`, planar.
    fn get_input_values(&self, num_values: usize, values: &mut [Vec<u32>]) {
        let params = &self.case.params;
        let name = self.case.name.as_str();
        let scalar_size = params.size as usize;
        let precision = params.precision;
        let integer_length = precision.uint_bit_count();
        let integer_mask = get_low_bit_mask(integer_length);
        let signed = params.signed;

        match params.func {
            Func::UaddCarry | Func::UsubBorrow => {
                let mut rnd = Random::new(de_string_hash(name) ^ 0x235fac);
                let easy_cases: &[(u32, u32)] = if params.func == Func::UaddCarry {
                    &[
                        (0x00000000, 0x00000000),
                        (0xfffffffe, 0x00000001),
                        (0x00000001, 0xfffffffe),
                        (0xffffffff, 0x00000001),
                        (0x00000001, 0xffffffff),
                        (0xfffffffe, 0x00000002),
                        (0x00000002, 0xfffffffe),
                        (0xffffffff, 0xffffffff),
                    ]
                } else {
                    &[
                        (0x00000000, 0x00000000),
                        (0x00000001, 0x00000001),
                        (0x00000001, 0x00000002),
                        (0x00000001, 0xffffffff),
                        (0xfffffffe, 0xffffffff),
                        (0xffffffff, 0xffffffff),
                    ]
                };

                for (easy_ndx, (x, y)) in easy_cases.iter().enumerate() {
                    for comp_ndx in 0..scalar_size {
                        values[0][easy_ndx * scalar_size + comp_ndx] = x & integer_mask;
                        values[1][easy_ndx * scalar_size + comp_ndx] = y & integer_mask;
                    }
                }
                if signed {
                    for easy_ndx in 0..easy_cases.len() {
                        for comp_ndx in 0..scalar_size {
                            for input in values.iter_mut().take(2) {
                                let index = easy_ndx * scalar_size + comp_ndx;
                                input[index] = extend_sign_to_32(input[index], integer_length);
                            }
                        }
                    }
                }

                // Upstream passes the start of the arrays, so the random values overwrite the easy cases.
                let random_count = num_values - easy_cases.len();
                let (first, second) = values.split_at_mut(1);
                generate_random_input_data(&mut rnd, signed, scalar_size, precision, &mut first[0], random_count);
                generate_random_input_data(&mut rnd, signed, scalar_size, precision, &mut second[0], random_count);
            }
            Func::UmulExtended => {
                let mut rnd = Random::new(de_string_hash(name) ^ 0x235fac);
                let easy_cases = [
                    (0x00000000u32, 0x00000000u32),
                    (0xffffffff, 0x00000001),
                    (0xffffffff, 0x00000002),
                    (0x00000001, 0xffffffff),
                    (0x00000002, 0xffffffff),
                    (0xffffffff, 0xffffffff),
                ];
                let mut value_ndx = 0;
                for (x, y) in easy_cases {
                    for comp_ndx in 0..scalar_size {
                        values[0][value_ndx * scalar_size + comp_ndx] = x;
                        values[1][value_ndx * scalar_size + comp_ndx] = y;
                    }
                    value_ndx += 1;
                }
                while value_ndx < num_values {
                    for comp_ndx in 0..scalar_size {
                        let base0 = rnd.get_uint32();
                        let base1 = rnd.get_uint32();
                        let adj0 = rnd.get_int(0, 20);
                        let adj1 = rnd.get_int(0, 20);
                        values[0][value_ndx * scalar_size + comp_ndx] = base0 >> adj0;
                        values[1][value_ndx * scalar_size + comp_ndx] = base1 >> adj1;
                    }
                    value_ndx += 1;
                }
            }
            Func::ImulExtended => {
                let mut rnd = Random::new(de_string_hash(name) ^ 0x224fa1);
                let easy_cases = [
                    (0x00000000u32, 0x00000000u32),
                    (0xffffffff, 0x00000002),
                    (0x7fffffff, 0x00000001),
                    (0x7fffffff, 0x00000002),
                    (0x7fffffff, 0x7fffffff),
                    (0xffffffff, 0xffffffff),
                    (0x7fffffff, 0xfffffffe),
                ];
                let mut value_ndx = 0;
                for (x, y) in easy_cases {
                    for comp_ndx in 0..scalar_size {
                        values[0][value_ndx * scalar_size + comp_ndx] = x;
                        values[1][value_ndx * scalar_size + comp_ndx] = y;
                    }
                    value_ndx += 1;
                }
                while value_ndx < num_values {
                    for comp_ndx in 0..scalar_size {
                        let base0 = rnd.get_uint32() as i32;
                        let base1 = rnd.get_uint32() as i32;
                        let adj0 = rnd.get_int(0, 20);
                        let adj1 = rnd.get_int(0, 20);
                        values[0][value_ndx * scalar_size + comp_ndx] = (base0 >> adj0) as u32;
                        values[1][value_ndx * scalar_size + comp_ndx] = (base1 >> adj1) as u32;
                    }
                    value_ndx += 1;
                }
            }
            Func::BitfieldExtract => {
                let mut rnd = Random::new(de_string_hash(name) ^ 0xa113fca2);
                let ignore_sign = precision != Precision::HighP && signed;
                let num_bits = integer_length as i32 - i32::from(ignore_sign);
                for value_ndx in 0..num_values {
                    let bits = rnd.get_int(0, num_bits);
                    let offset = rnd.get_int(0, num_bits - bits);
                    values[1][value_ndx] = offset as u32;
                    values[2][value_ndx] = bits as u32;
                }
                generate_random_input_data(&mut rnd, signed, scalar_size, precision, &mut values[0], num_values);
            }
            Func::BitfieldInsert => {
                let mut rnd = Random::new(de_string_hash(name) ^ 0x12c2acff);
                let num_bits = integer_length as i32;
                for value_ndx in 0..num_values {
                    let bits = rnd.get_int(0, num_bits);
                    let offset = rnd.get_int(0, num_bits - bits);
                    values[2][value_ndx] = offset as u32;
                    values[3][value_ndx] = bits as u32;
                }
                generate_random_input_data(&mut rnd, signed, scalar_size, precision, &mut values[0], num_values);
                generate_random_input_data(&mut rnd, signed, scalar_size, precision, &mut values[1], num_values);
            }
            Func::BitfieldReverse | Func::BitCount | Func::FindLsb | Func::FindMsb => {
                let seed = match params.func {
                    Func::BitfieldReverse => 0xff23a4,
                    Func::BitCount => 0xab2cca4,
                    Func::FindLsb => 0x9923c2af,
                    _ => 0x742ac4e,
                };
                let mut rnd = Random::new(de_string_hash(name) ^ seed);
                generate_random_input_data(&mut rnd, signed, scalar_size, precision, &mut values[0], num_values);
            }
            Func::BitwiseVectorModulo => {
                for (ndx, value) in values[0].iter_mut().enumerate().take(num_values) {
                    *value = ndx as u32;
                }
            }
            Func::BitwiseNestedLiteralShift => {
                values[0][0] = 0xDFFFF7FF;
                values[1][0] = 700;
                values[2][0] = 123456789;
                values[3][0] = (-1000i32) as u32;
            }
        }
    }

    /// `compare` of the case class for one element: `inputs[i]` and `outputs[i]` are the components of that element.
    fn compare(&self, inputs: &[&[u32]], outputs: &[&[u32]]) -> Result<(), String> {
        let params = &self.case.params;
        let scalar_size = params.size as usize;
        let precision = params.precision;
        let integer_length = precision.uint_bit_count();
        let signed = params.signed;

        match params.func {
            Func::UaddCarry => {
                let mask0 = get_low_bit_mask(integer_length);
                for comp_ndx in 0..scalar_size {
                    let (in0, in1, out0, out1) = (
                        inputs[0][comp_ndx],
                        inputs[1][comp_ndx],
                        outputs[0][comp_ndx],
                        outputs[1][comp_ndx],
                    );
                    let ref0 = in0.wrapping_add(in1);
                    let ref1 = u32::from(u64::from(in0) + u64::from(in1) > 0xffffffff);
                    if (out0 & mask0) != (ref0 & mask0) || out1 != ref1 {
                        return Err(format!("Expected [{comp_ndx}] = {ref0:#x}, {ref1:#x}"));
                    }
                }
            }
            Func::UsubBorrow => {
                let mask0 = get_low_bit_mask(integer_length);
                for comp_ndx in 0..scalar_size {
                    let (in0, in1, out0, out1) = (
                        inputs[0][comp_ndx],
                        inputs[1][comp_ndx],
                        outputs[0][comp_ndx],
                        outputs[1][comp_ndx],
                    );
                    let ref0 = in0.wrapping_sub(in1);
                    let ref1 = if in0 >= in1 { 0 } else { 1 };
                    if (out0 & mask0) != (ref0 & mask0) || out1 != ref1 {
                        return Err(format!("Expected [{comp_ndx}] = {ref0:#x}, {ref1:#x}"));
                    }
                }
            }
            Func::UmulExtended => {
                for comp_ndx in 0..scalar_size {
                    let (in0, in1, out0, out1) = (
                        inputs[0][comp_ndx],
                        inputs[1][comp_ndx],
                        outputs[0][comp_ndx],
                        outputs[1][comp_ndx],
                    );
                    let mul64 = u64::from(in0) * u64::from(in1);
                    let (ref0, ref1) = ((mul64 >> 32) as u32, (mul64 & 0xffffffff) as u32);
                    if out0 != ref0 || out1 != ref1 {
                        return Err(format!("Expected [{comp_ndx}] = {ref0:#x}, {ref1:#x}"));
                    }
                }
            }
            Func::ImulExtended => {
                for comp_ndx in 0..scalar_size {
                    let (in0, in1, out0, out1) = (
                        inputs[0][comp_ndx] as i32,
                        inputs[1][comp_ndx] as i32,
                        outputs[0][comp_ndx] as i32,
                        outputs[1][comp_ndx] as i32,
                    );
                    let mul64 = i64::from(in0) * i64::from(in1);
                    let (ref0, ref1) = ((mul64 >> 32) as i32, (mul64 & 0xffffffff) as i32);
                    if out0 != ref0 || out1 != ref1 {
                        return Err(format!("Expected [{comp_ndx}] = {ref0:#x}, {ref1:#x}"));
                    }
                }
            }
            Func::BitfieldExtract => {
                let offset = inputs[1][0] as i32;
                let bits = inputs[2][0] as i32;
                for comp_ndx in 0..scalar_size {
                    let value = inputs[0][comp_ndx];
                    let out = outputs[0][comp_ndx];
                    let val_mask = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
                    let base_val = if offset == 32 { 0 } else { (value >> offset) & val_mask };
                    let sign_bit_set = bits > 0 && base_val & (1u32 << (bits - 1)) != 0;
                    let reference = base_val | if signed && sign_bit_set { !val_mask } else { 0 };
                    if out != reference {
                        return Err(format!("Expected [{comp_ndx}] = {reference:#x}"));
                    }
                }
            }
            Func::BitfieldInsert => {
                let cmp_mask = get_low_bit_mask(integer_length);
                let offset = inputs[2][0] as i32;
                let bits = inputs[3][0] as i32;
                for comp_ndx in 0..scalar_size {
                    let base = inputs[0][comp_ndx];
                    let insert = inputs[1][comp_ndx];
                    let out = outputs[0][comp_ndx];
                    let mask = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
                    let reference =
                        (base & !mask.wrapping_shl(offset as u32)) | (insert & mask).wrapping_shl(offset as u32);
                    if (out & cmp_mask) != (reference & cmp_mask) {
                        return Err(format!("Expected [{comp_ndx}] = {reference:#x}"));
                    }
                }
            }
            Func::BitfieldReverse => {
                let cmp_mask = reverse_bits(get_low_bit_mask(integer_length));
                for comp_ndx in 0..scalar_size {
                    let value = inputs[0][comp_ndx];
                    let out = outputs[0][comp_ndx];
                    let reference = reverse_bits(value);
                    if (out & cmp_mask) != (reference & cmp_mask) {
                        return Err(format!("Expected [{comp_ndx}] = {reference:#x}"));
                    }
                }
            }
            Func::BitCount => {
                let count_mask = get_low_bit_mask(integer_length);
                for comp_ndx in 0..scalar_size {
                    let value = inputs[0][comp_ndx];
                    let out = outputs[0][comp_ndx] as i32;
                    let min_ref = (value & count_mask).count_ones() as i32;
                    let max_ref = value.count_ones() as i32;
                    if !(min_ref..=max_ref).contains(&out) {
                        return Err(format!("Expected [{comp_ndx}] in range [{min_ref}, {max_ref}]"));
                    }
                }
            }
            Func::FindLsb => {
                let mask = get_low_bit_mask(integer_length);
                for comp_ndx in 0..scalar_size {
                    let value = inputs[0][comp_ndx];
                    let out = outputs[0][comp_ndx] as i32;
                    let min_ref = find_lsb_u32(value & mask);
                    let max_ref = find_lsb_u32(value);
                    if !(min_ref..=max_ref).contains(&out) {
                        return Err(format!("Expected [{comp_ndx}] in range [{min_ref}, {max_ref}]"));
                    }
                }
            }
            Func::FindMsb => {
                for comp_ndx in 0..scalar_size {
                    let value = inputs[0][comp_ndx];
                    let out = outputs[0][comp_ndx] as i32;
                    let (min_ref, max_ref) = if signed {
                        (
                            find_msb_i32(to_precision_i32(value as i32, integer_length)),
                            find_msb_i32(value as i32),
                        )
                    } else {
                        (
                            find_msb_u32(to_precision_u32(value, integer_length)),
                            find_msb_u32(value),
                        )
                    };
                    if !(min_ref..=max_ref).contains(&out) {
                        return Err(format!("Expected [{comp_ndx}] in range [{min_ref}, {max_ref}]"));
                    }
                }
            }
            Func::BitwiseVectorModulo => {
                let out_val = outputs[0][0];
                if out_val != 0 {
                    return Err(format!("Expected 0, got {out_val}"));
                }
            }
            Func::BitwiseNestedLiteralShift => {
                for (ndx, (name, expected)) in NESTED_SHIFT_OUTPUTS.iter().enumerate() {
                    let out_val = outputs[ndx][0] as i32;
                    if out_val != *expected {
                        return Err(format!("Output {name} mismatch: expected {expected}, got {out_val}"));
                    }
                }
            }
        }

        Ok(())
    }
}

fn to_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

impl TestInstance for IntegerFunctionInstance<'_> {
    /// `IntegerFunctionTestInstance::queuePass`
    fn iterate(&mut self) -> TestOutcome {
        let case = self.case;
        let num_values = case.num_values();
        let spec = &case.spec;
        let mut input_data: Vec<Vec<u32>> = spec
            .inputs
            .iter()
            .map(|symbol| vec![0u32; symbol.size as usize * num_values])
            .collect();
        let mut output_data: Vec<Vec<u32>> = spec
            .outputs
            .iter()
            .map(|symbol| vec![0u32; symbol.size as usize * num_values])
            .collect();

        self.get_input_values(num_values, &mut input_data);

        {
            let input_bytes: Vec<Vec<u8>> = input_data.iter().map(|values| to_bytes(values)).collect();
            let input_refs: Vec<&[u8]> = input_bytes.iter().map(|bytes| bytes.as_slice()).collect();
            let mut output_bytes: Vec<Vec<u8>> = output_data.iter().map(|values| vec![0u8; values.len() * 4]).collect();
            let mut output_refs: Vec<&mut [u8]> = output_bytes.iter_mut().map(|bytes| bytes.as_mut_slice()).collect();
            execute(
                self.context,
                case.params.shader_type,
                spec,
                None,
                num_values,
                &input_refs,
                &mut output_refs,
                None,
            )?;
            for (values, bytes) in output_data.iter_mut().zip(&output_bytes) {
                for (value, chunk) in values.iter_mut().zip(bytes.chunks_exact(4)) {
                    *value = u32::from_ne_bytes([chunk[0], chunk[1], chunk[2], chunk[3]]);
                }
            }
        }

        let mut num_failed = 0;
        for val_ndx in 0..num_values {
            let cur_inputs: Vec<&[u32]> = spec
                .inputs
                .iter()
                .zip(&input_data)
                .map(|(symbol, values)| &values[symbol.size as usize * val_ndx..symbol.size as usize * (val_ndx + 1)])
                .collect();
            let cur_outputs: Vec<&[u32]> = spec
                .outputs
                .iter()
                .zip(&output_data)
                .map(|(symbol, values)| &values[symbol.size as usize * val_ndx..symbol.size as usize * (val_ndx + 1)])
                .collect();

            if let Err(message) = self.compare(&cur_inputs, &cur_outputs) {
                log::error!("ERROR: comparison failed for value {val_ndx}:\n  {message}");
                for (symbol, values) in spec.inputs.iter().zip(&cur_inputs) {
                    log::error!("    {} = {values:x?}", symbol.name);
                }
                for (symbol, values) in spec.outputs.iter().zip(&cur_outputs) {
                    log::error!("    {} = {values:x?}", symbol.name);
                }
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

/// `addFunctionCases`
fn add_function_cases(
    parent: &mut TestCaseGroup,
    function_name: &str,
    func: Func,
    int_types: bool,
    uint_types: bool,
    all_prec: bool,
) {
    let mut group = TestCaseGroup::new(function_name);
    let shader_types = [
        ShaderType::Vertex,
        ShaderType::Fragment,
        ShaderType::Geometry,
        ShaderType::TessellationControl,
        ShaderType::TessellationEvaluation,
        ShaderType::Compute,
    ];

    for signed in [true, false] {
        if (!int_types && signed) || (!uint_types && !signed) {
            continue;
        }

        for vec_size in 1..=5u32 {
            for precision in [Precision::MediumP, Precision::HighP] {
                if precision != Precision::HighP && !all_prec {
                    continue;
                }

                for shader_type in shader_types {
                    if vec_size == 5 && shader_type != ShaderType::Compute {
                        continue;
                    }
                    let base_name = match (signed, vec_size) {
                        (true, 1) => "int".to_string(),
                        (false, 1) => "uint".to_string(),
                        (true, n) => format!("ivec{n}"),
                        (false, n) => format!("uvec{n}"),
                    };
                    let name = format!("{base_name}{}{}", precision.postfix(), shader_type_postfix(shader_type));
                    group.add_child(Box::new(IntegerFunctionCase::new(
                        name,
                        CaseParams {
                            func,
                            shader_type,
                            signed,
                            size: vec_size,
                            precision,
                        },
                    )) as Box<dyn TestCase>);
                }
            }
        }
    }

    parent.add_child(group);
}

/// `ShaderIntegerFunctionTests::init`
pub fn create_integer_function_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("integer");

    //                                           Int?   Uint?  AllPrec?
    add_function_cases(&mut group, "uaddcarry", Func::UaddCarry, false, true, true);
    add_function_cases(&mut group, "usubborrow", Func::UsubBorrow, false, true, true);
    add_function_cases(&mut group, "umulextended", Func::UmulExtended, false, true, false);
    add_function_cases(&mut group, "imulextended", Func::ImulExtended, true, false, false);
    add_function_cases(&mut group, "bitfieldextract", Func::BitfieldExtract, true, true, true);
    add_function_cases(&mut group, "bitfieldinsert", Func::BitfieldInsert, true, true, true);
    add_function_cases(&mut group, "bitfieldreverse", Func::BitfieldReverse, true, true, true);
    add_function_cases(&mut group, "bitcount", Func::BitCount, true, true, true);
    add_function_cases(&mut group, "findlsb", Func::FindLsb, true, true, true);
    add_function_cases(&mut group, "findMSB", Func::FindMsb, true, true, true);

    let mut modulo_group = TestCaseGroup::new("bitwise_vector_modulo");
    modulo_group.add_child(Box::new(IntegerFunctionCase::new(
        "uvec2_compute".to_string(),
        CaseParams {
            func: Func::BitwiseVectorModulo,
            shader_type: ShaderType::Compute,
            signed: true,
            size: 1,
            precision: Precision::HighP,
        },
    )) as Box<dyn TestCase>);
    group.add_child(modulo_group);

    let mut shift_group = TestCaseGroup::new("bitwise_nested_literal_shifts");
    shift_group.add_child(Box::new(IntegerFunctionCase::new(
        "compute".to_string(),
        CaseParams {
            func: Func::BitwiseNestedLiteralShift,
            shader_type: ShaderType::Compute,
            signed: true,
            size: 1,
            precision: Precision::HighP,
        },
    )) as Box<dyn TestCase>);
    group.add_child(shift_group);

    group
}

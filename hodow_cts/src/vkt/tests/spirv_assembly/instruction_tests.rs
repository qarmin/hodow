// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmInstructionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Copyright (c) 2015 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The groups of `compute` that run one shader over a buffer of floats (opnop, opline,
// opnoline, opmoduleprocessed, opsource, opsourceextension, opconstantnull, opconstantcomposite, opconstantnullcomposite, opundef,
// opunreachable, block_order, multiple_shaders, opname, opmembername, loop_control (with dependency_length and dependency_infinite), selection_control, function_control, memory_access,
// opcopymemory, opcopyobject, opfrem, opnmin, opnmax, opnclamp, nocontraction, conditional_branch, opspecconstantop, opspecconstantop_opquantize, bool.mixed_bitsize, opcompositeinsert, opinboundsaccesschain, shader_default_output, 64bit_compare, float_controls_extensionless, indexing.input (struct, non16basealignment), relaxed_with_forward_reference, workgroup_memory, spirv_version, variable_init, ubo_padding, empty_struct, composite_insert, decoration_group, opquantize, opquantize_vec4, localsize, localsize_id, opatomic, opatomic_storage_buffer, opatomic_return_values, opatomic_storage_buffer_volatile, expression_rearrangement, opphi (block, induction, swap, wide, nested, vartype_*), opfunord, opfunord_nan, opsrem, opsmod, opsrem64, opsmod64 and
// the android and maintenance8 copies of opsrem and opsmod). The assembly of each case is in
// `shaders/manifest/spirv_assembly_compute.toml` (written by `scripts/gen_spirv_assembly_manifest.py`), with what is needed to build
// the input and the expected output as the parameters of `SpvAsmCase`; a case name is its path below `compute` joined by `/`.
//
// opcopyobject.descriptor_array binds four buffers as one descriptor array. The integer dot product groups are in dot_product_tests.rs. The conversion groups (sconvert, uconvert, fconvert, convertstof, convertftos, convertutof, convertftou) are in amber_tests.rs too, as one-element buffer cases.
// The Amber scripts of signed_op, mul_extended and undef are in amber_tests.rs, and the one of graphics.switch_block_order.
//
// Not ported: the abuse cases whose names are invalid UTF-8 (a manifest is UTF-8 text), `opline.module_scope_image` (needs a storage
// image input), the Amber cases that need a second shader or a graphics pipeline, and every group not listed above.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, VerifyIo};
use super::utils;
use crate::generated::shaders::spirv_assembly_compute::ALL_SPV_ASM_CASE;
use crate::tcu::random::Random;
use crate::tcu::{TestResult, de_string_hash};
use crate::vk::programs::{BinaryCollection, ProgramBinary};
use crate::vkt::{TestCase, TestCaseGroup};

/// The `rust_type` of the manifest entries: one test case of `compute`.
#[derive(Clone, Copy)]
pub struct SpvAsmCase {
    pub name: &'static str,
    pub seed: &'static str,
    pub min: i32,
    pub max: i32,
    pub elements: u32,
    pub kind: &'static str,
    pub entry: &'static str,
    pub extensions: &'static str,
    pub spirv13: bool,
    /// Floats an earlier case of the group has already drawn from the group's generator.
    pub skip: u32,
    pub workgroups: u32,
    /// Hex of each specialization constant's data, separated by `;`, constant 0 first.
    pub spec_constants: &'static str,
    pub programs: BinaryCollection,
}

fn to_bytes(values: &[f32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

/// `veryfiBinaryShader` - the three `OpModuleProcessed` strings are in the binary, in this order.
fn verify_binary_shader(binary: &ProgramBinary) -> bool {
    let bytes: Vec<u8> = binary.spirv.iter().flat_map(|word| word.to_le_bytes()).collect();
    let patterns: [&[u8]; 3] = [b"VULKAN CTS", b"Negative values", b"Date: 2017/09/21"];
    let mut pattern_ndx = 0;

    for ndx in 0..bytes.len() {
        if bytes[ndx..].starts_with(patterns[pattern_ndx]) {
            pattern_ndx += 1;
            if pattern_ndx == patterns.len() {
                return true;
            }
        }
    }

    false
}

fn to_floats(bytes: &[u8]) -> Vec<f32> {
    bytes
        .chunks_exact(4)
        .map(|chunk| f32::from_ne_bytes(chunk.try_into().expect("four bytes")))
        .collect()
}

/// `compareFRem` - the relative error is fairly high because FRem may be implemented as (roughly) frac(a/b)*b.
fn compare_frem(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    to_floats(&expected[0])
        .iter()
        .zip(to_floats(&outputs[0]))
        .all(|(&f0, f1)| ((f1 - f0) / f0).abs() <= 0.02)
}

/// `compareNMin` - NaN is accepted as the output only if both inputs were NaN.
fn compare_nmin(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    to_floats(&expected[0])
        .iter()
        .zip(to_floats(&outputs[0]))
        .all(|(&f0, f1)| (f1.is_nan() && f0.is_nan()) || (f1 - f0).abs() <= 0.00001)
}

/// `compareNMax` - NaN is an acceptable result, since on architectures that do not handle NaNs those are huge values.
fn compare_nmax(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    to_floats(&expected[0])
        .iter()
        .zip(to_floats(&outputs[0]))
        .all(|(&f0, f1)| f1.is_nan() || (f1 - f0).abs() <= 0.00001)
}

/// `compareNClamp` - two legal outcomes per element, depending on whether NaNs are handled.
fn compare_nclamp(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    let expected = to_floats(&expected[0]);
    let result = to_floats(&outputs[0]);
    (0..expected.len() / 2).all(|idx| {
        let (e0, e1, res) = (expected[idx * 2], expected[idx * 2 + 1], result[idx]);
        (e0.is_nan() && res.is_nan()) || (e0 - res).abs() < 0.00001 || (e1 - res).abs() < 0.00001
    })
}

/// `compareNoContractCase` - the two answers the rounding mode allows: 0 and -2^-24.
fn compare_no_contract(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    to_floats(&outputs[0])
        .iter()
        .take(expected[0].len() / 4)
        .all(|&value| value == 0.0 || value == -(2.0f32.powi(-24)))
}

/// `std::min` and `std::max` with their NaN behaviour: the first argument wins unless the comparison says otherwise.
fn std_min(a: f32, b: f32) -> f32 {
    if b < a { b } else { a }
}

fn std_max(a: f32, b: f32) -> f32 {
    if a < b { b } else { a }
}

fn to_int_bytes(values: &[i32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn to_int64_bytes(values: &[i64]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

/// `compareExpressionRearrangementCase` - the first expected value says whether one or two results are accepted.
fn compare_expression_rearrangement(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    let expected = to_floats(&expected[0]);
    let accepted_values = 1 + (expected[0] > 1.9) as u32;
    to_floats(&outputs[0])
        .iter()
        .all(|&out| out == expected[1] || (accepted_values >= 2 && out == expected[2]))
}

fn build_expression_rearrangement_io(case: &SpvAsmCase, leaf: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut output = vec![0.0f32; n];
    let (input_a, input_b) = if case.kind == "rearrangement_add" {
        // 4 + denorm - 4 is either the denorm or 0 when DenormPreserve is used
        output[1] = 0.0;
        output[2] = f32::from_bits(1);
        (4.0f32, f32::from_bits(1))
    } else {
        // 1.0e-20 * 1.0e-20 is denormal and is flushed to 0 with FTZ, but a fused multiply-add may keep it
        output[1] = f32::MIN_POSITIVE;
        output[2] = 1.185_494_3e-38;
        (1.0e-20f32, f32::MIN_POSITIVE)
    };
    output[0] = if leaf.ends_with("no_contraction") { 1.0 } else { 2.0 };
    (
        vec![to_bytes(&vec![input_a; n]), to_bytes(&vec![input_b; n])],
        vec![to_bytes(&output)],
    )
}

/// `compareFUnord` - a NaN operand is only checked when the shader was asked to preserve NaNs.
fn compare_funord<const NAN_SUPPORTED: bool>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    let input1 = to_floats(&inputs[0]);
    let input2 = to_floats(&inputs[1]);
    expected[0]
        .chunks_exact(4)
        .zip(outputs[0].chunks_exact(4))
        .enumerate()
        .all(|(idx, (expected, output))| {
            (!NAN_SUPPORTED && (input1[idx].is_nan() || input2[idx].is_nan())) || expected == output
        })
}

fn funord_compare(op: &str, x: f32, y: f32) -> bool {
    match op {
        "equal" => x == y,
        "less" => x < y,
        "lessequal" => x <= y,
        "greater" => x > y,
        "greaterequal" => x >= y,
        "notequal" => x != y,
        _ => unreachable!("not an OpFUnord case"),
    }
}

fn build_funord_io(case: &SpvAsmCase, op: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    for _ in 0..case.skip {
        rnd.get_float_range(case.min as f32, case.max as f32);
    }
    let mut input1: Vec<f32> = (0..n)
        .map(|_| rnd.get_float_range(case.min as f32, case.max as f32))
        .collect();
    let mut input2 = vec![0.0f32; n];
    let mut expected = vec![0i32; n];

    for ndx in 0..n {
        match ndx % 6 {
            0 => input2[ndx] = input1[ndx] + 1.0,
            1 => input2[ndx] = input1[ndx] - 1.0,
            2 => input2[ndx] = input1[ndx],
            3 => input2[ndx] = f32::NAN,
            4 => {
                input2[ndx] = input1[ndx];
                input1[ndx] = f32::NAN;
            }
            _ => {
                input2[ndx] = f32::NAN;
                input1[ndx] = f32::NAN;
            }
        }
        expected[ndx] =
            (input1[ndx].is_nan() || input2[ndx].is_nan() || funord_compare(op, input1[ndx], input2[ndx])) as i32;
    }

    (
        vec![to_bytes(&input1), to_bytes(&input2)],
        vec![to_int_bytes(&expected)],
    )
}

/// `OpSMod`: the remainder takes the sign of the second operand, where `%` takes the sign of the first.
fn smod<T>(a: T, b: T) -> T
where
    T: Copy + PartialOrd + Default + std::ops::Rem<Output = T> + std::ops::Add<Output = T>,
{
    let zero = T::default();
    let rem = a % b;
    if rem == zero {
        zero
    } else if (a >= zero) == (b >= zero) {
        rem
    } else {
        rem + b
    }
}

/// The operand ranges of `createOpSRemComputeGroup` and `createOpSModComputeGroup`: positive operands, then all of them.
const INT32_REMAINDER_RANGES: [(i32, i32, i32, i32); 2] = [(0, 65536, 0, 100), (-65536, 65536, -100, 100)];

fn build_int32_remainder_io(case: &SpvAsmCase, modulo: bool) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let mut inputs = (Vec::new(), Vec::new());

    for &(op1_min, op1_max, op2_min, op2_max) in &INT32_REMAINDER_RANGES[..=case.skip as usize] {
        let input1: Vec<i32> = (0..n).map(|_| rnd.get_int(op1_min, op1_max)).collect();
        let input2: Vec<i32> = (0..n)
            .map(|_| {
                loop {
                    let value = rnd.get_int(op2_min, op2_max);
                    if value != 0 {
                        break value;
                    }
                }
            })
            .collect();
        inputs = (input1, input2);
    }

    let output: Vec<i32> = inputs
        .0
        .iter()
        .zip(&inputs.1)
        .map(|(&a, &b)| if modulo { smod(a, b) } else { a % b })
        .collect();
    (
        vec![to_int_bytes(&inputs.0), to_int_bytes(&inputs.1)],
        vec![to_int_bytes(&output)],
    )
}

/// `randomInt64LogDistributed`
fn random_int64_log_distributed(rnd: &mut Random) -> i64 {
    let mut value = rnd.get_uint64() as i64;
    let bits = rnd.get_int(1, 63);
    value &= ((1u64 << bits) - 1) as i64;
    if rnd.get_bool() {
        value = -value;
    }
    value
}

fn fill_int64s_log_distributed(rnd: &mut Random, count: usize, filter: fn(i64) -> bool) -> Vec<i64> {
    (0..count)
        .map(|_| {
            loop {
                let value = random_int64_log_distributed(rnd);
                if filter(value) {
                    break value;
                }
            }
        })
        .collect()
}

fn build_int64_remainder_io(case: &SpvAsmCase, modulo: bool) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let mut inputs = (Vec::new(), Vec::new());

    for positive in [true, false].into_iter().take(case.skip as usize + 1) {
        inputs = if positive {
            (
                fill_int64s_log_distributed(&mut rnd, n, |value| value >= 0),
                fill_int64s_log_distributed(&mut rnd, n, |value| value > 0),
            )
        } else {
            (
                fill_int64s_log_distributed(&mut rnd, n, |_| true),
                fill_int64s_log_distributed(&mut rnd, n, |value| value != 0),
            )
        };
    }

    let output: Vec<i64> = inputs
        .0
        .iter()
        .zip(&inputs.1)
        .map(|(&a, &b)| if modulo { smod(a, b) } else { a % b })
        .collect();
    (
        vec![to_int64_bytes(&inputs.0), to_int64_bytes(&inputs.1)],
        vec![to_int64_bytes(&output)],
    )
}

const OPPHI_WIDTH: i32 = 512;

/// `expandOpPhiCase5` - injects "ABC" between the characters, skipping some injections to make the result less uniform.
fn expand_op_phi_case5(text: &str, acc: &mut i32, add: i32, threshold: i32) -> String {
    let mut result = String::new();
    for ch in text.chars() {
        result.push(ch);
        *acc += add;
        if *acc > threshold {
            *acc -= threshold;
            result.push_str("ABC");
        }
    }
    result
}

/// `calcOpPhiCase5`
fn calc_op_phi_case5(val: f32, code: &str) -> f32 {
    const TV: [f32; 8] = [0.5, 1.5, 3.5, 7.5, 15.5, 31.5, 63.5, 127.5];
    let v = val.abs();
    let mut x = [0.0f32; 8];
    let mut b = [false; 8];
    let mut res = 0.0f32;
    let mut depth: i32 = -1;
    let mut skip = 0;

    for i in (0..8).rev() {
        x[i] = v % (2i32 << i) as f32;
    }
    for i in (0..8).rev() {
        b[i] = x[i] > TV[i];
    }

    for ch in code.chars() {
        if ch == 'A' {
            depth += 1;
            if skip == 0 && b[depth as usize] {
                res += 1.0;
            } else {
                skip += 1;
            }
        }
        if ch == 'B' {
            if skip > 0 {
                skip -= 1;
            }
            if b[depth as usize] || skip > 0 {
                skip += 1;
            }
        }
        if ch == 'C' {
            depth -= 1;
            if skip > 0 {
                skip -= 1;
            }
        }
    }
    res
}

fn build_op_phi_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    // The CPU might not round like the GPU: whole numbers avoid the difference.
    let input: Vec<f32> = (0..n)
        .map(|_| rnd.get_float_range(case.min as f32, case.max as f32).floor())
        .collect();

    let mut code = "ABC".to_string();
    let mut acc = 0;
    if case.kind == "opphi_nested" {
        for _ in 0..9 {
            code = expand_op_phi_case5(&code, &mut acc, 7, 24);
        }
    }

    let output: Vec<f32> = input
        .iter()
        .enumerate()
        .map(|(ndx, &value)| match case.kind {
            "opphi_block" => value + [5.5, 20.5, 1.75][ndx % 3],
            "opphi_induction" => value + 6.5 * 3.0,
            "opphi_swap" => 8.5 - value,
            "opphi_wide" => {
                let index = (ndx as f32 * value).abs().floor() as i32;
                (index % OPPHI_WIDTH) as f32 * 10.0 + 5.0
            }
            _ => calc_op_phi_case5(value, &code),
        })
        .collect();

    (vec![to_bytes(&input)], vec![to_bytes(&output)])
}

const ATOMIC_OPS: [&str; 7] = ["iadd", "isub", "iinc", "idec", "load", "store", "compex"];

/// `OpAtomicBuffer::compareRetVals` - the order of execution is undefined, so each return value undoes one operation, one at a time.
fn compare_atomic_ret_vals(op: &str, input_values: &[u32], result_value: u32, return_values: &[u32]) -> bool {
    let mut operations_undone = vec![false; input_values.len()];
    let mut current_result = result_value;

    for _ in 0..input_values.len() {
        let found = (0..input_values.len()).find(|&ndx| {
            if operations_undone[ndx] {
                return false;
            }
            let previous_result = match op {
                "iadd" => current_result.wrapping_sub(input_values[ndx]),
                "isub" => current_result.wrapping_add(input_values[ndx]),
                "iinc" => current_result.wrapping_sub(1),
                "idec" => current_result.wrapping_add(1),
                _ => unreachable!("no return value comparison for this OpAtomic"),
            };
            previous_result == return_values[ndx]
        });
        match found {
            Some(ndx) => {
                current_result = return_values[ndx];
                operations_undone[ndx] = true;
            }
            None => return false,
        }
    }
    true
}

/// `OpAtomicBuffer::compareWithRetvals`
fn compare_atomic_with_retvals<const OP: usize>(inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 2 || inputs.len() != 1 {
        return false;
    }
    if outputs[0] != expected[0] {
        return false;
    }
    if ATOMIC_OPS[OP] == "compex" {
        return outputs[1] == expected[1];
    }
    let words = |bytes: &[u8]| -> Vec<u32> {
        bytes
            .chunks_exact(4)
            .map(|chunk| u32::from_ne_bytes(chunk.try_into().expect("four bytes")))
            .collect()
    };
    let result_value = words(&outputs[0])[0];
    compare_atomic_ret_vals(ATOMIC_OPS[OP], &words(&inputs[0]), result_value, &words(&outputs[1]))
}

/// `OpAtomicBuffer` in its input, expected and return value roles.
fn build_atomic_io(case: &SpvAsmCase, op: &str, with_return_values: bool) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let op_index = ATOMIC_OPS
        .iter()
        .position(|candidate| *candidate == op)
        .expect("a known OpAtomic");
    let mut rnd = Random::new(op_index as u32);
    let input: Vec<i32> = (0..n).map(|_| rnd.get_int(1, 100)).collect();

    let single_output = matches!(op, "iadd" | "isub" | "iinc" | "idec");
    let mut expected = vec![-1i32; if single_output { 1 } else { n }];
    for ndx in 0..n {
        match op {
            "iadd" => expected[0] = expected[0].wrapping_add(input[ndx]),
            "isub" => expected[0] = expected[0].wrapping_sub(input[ndx]),
            "iinc" => expected[0] = expected[0].wrapping_add(1),
            "idec" => expected[0] = expected[0].wrapping_sub(1),
            "load" | "store" => expected[ndx] = input[ndx],
            _ => expected[ndx] = if input[ndx] % 2 == 0 { -1 } else { 1 },
        }
    }

    let mut outputs = vec![to_int_bytes(&expected)];
    if with_return_values {
        let ret: Vec<i32> = if op == "compex" {
            input.iter().map(|value| value % 2).collect()
        } else {
            vec![-1; n]
        };
        outputs.push(to_int_bytes(&ret));
    }
    (vec![to_int_bytes(&input)], outputs)
}

/// `constructNormalizedFloat` - a normalized float from an exponent and the top bits of a significand.
fn construct_normalized_float(exponent: i32, mut significand: u32) -> f32 {
    let mut f = 1.0f32;
    for idx in 0..23 {
        if significand & 0x800000 != 0 {
            f += 2.0f32.powi(-(idx + 1));
        }
        significand <<= 1;
    }
    f * 2.0f32.powi(exponent)
}

/// `compareOpQuantizeF16ComputeExactCase`
fn compare_op_quantize_f16_exact(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 || expected[0].len() != 4 * 4 {
        return false;
    }
    let out = to_floats(&outputs[0]);
    let accepted = [
        (
            construct_normalized_float(8, 0x304000),
            construct_normalized_float(8, 0x300000),
        ),
        (
            -construct_normalized_float(-7, 0x600000),
            -construct_normalized_float(-7, 0x604000),
        ),
        (
            construct_normalized_float(2, 0x01C000),
            construct_normalized_float(2, 0x020000),
        ),
        (
            construct_normalized_float(1, 0xFFC000),
            construct_normalized_float(2, 0x000000),
        ),
    ];
    out.iter()
        .zip(accepted)
        .all(|(&value, (first, second))| value == first || value == second)
}

/// `compareNan` - every output is a NaN.
fn compare_nan(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    to_floats(&outputs[0])
        .iter()
        .take(expected[0].len() / 4)
        .all(|value| value.is_nan())
}

/// `compareZeros` - every output is +0 or -0.
fn compare_zeros(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    to_floats(&outputs[0])
        .iter()
        .take(expected[0].len() / 4)
        .all(|&value| value == 0.0)
}

fn build_quantize_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    let n = case.elements as usize;
    let infinity = f32::INFINITY;
    match case.kind {
        "quantize_infinities" => {
            let (input, results): (Vec<f32>, Vec<f32>) = (0..n)
                .map(|idx| match idx % 4 {
                    0 => (infinity, infinity),
                    1 => (-infinity, -infinity),
                    2 => (2.0f32.powi(16), infinity),
                    _ => (-(2.0f32.powi(32)), -infinity),
                })
                .unzip();
            (vec![to_bytes(&input)], vec![to_bytes(&results)], None)
        }
        "quantize_nans" => {
            let nans: Vec<f32> = (0..n)
                .map(|idx| if idx % 2 == 0 { f32::NAN } else { -f32::NAN })
                .collect();
            (vec![to_bytes(&nans)], vec![to_bytes(&nans)], Some(compare_nan))
        }
        "quantize_ftz" => {
            let small: Vec<f32> = (0..n)
                .map(|idx| match idx % 6 {
                    0 => 0.0,
                    1 => -0.0,
                    2 => 2.0f32.powi(-16),
                    3 => -(2.0f32.powi(-32)),
                    4 => f32::from_bits(0x0040_0000),
                    _ => -f32::from_bits(0x0020_0000),
                })
                .collect();
            (vec![to_bytes(&small)], vec![to_bytes(&small)], Some(compare_zeros))
        }
        "quantize_exact" => {
            let exact: Vec<f32> = (0..n).map(|idx| (idx as i32 - 100) as f32).collect();
            (vec![to_bytes(&exact)], vec![to_bytes(&exact)], None)
        }
        _ => {
            let inputs = vec![
                construct_normalized_float(8, 0x300300),
                -construct_normalized_float(-7, 0x600800),
                construct_normalized_float(2, 0x01E000),
                construct_normalized_float(1, 0xFFE000),
            ];
            (
                vec![to_bytes(&inputs)],
                vec![to_bytes(&inputs)],
                Some(compare_op_quantize_f16_exact),
            )
        }
    }
}

/// `createSpecConstantOpQuantizeToF16Group` - the inputs are unused zeros, the values under test arrive as the specialization constants of the case.
fn build_spec_quantize_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    let n = case.elements as usize;
    let inputs = vec![to_bytes(&vec![0.0f32; n])];
    let infinity = f32::INFINITY;
    match case.kind {
        "specquant_infinities" => (
            inputs,
            vec![to_bytes(&[infinity, -infinity, infinity, -infinity])],
            None,
        ),
        "specquant_nans" => (inputs, vec![to_bytes(&[f32::NAN, -f32::NAN])], Some(compare_nan)),
        "specquant_ftz" => (inputs.clone(), inputs, Some(compare_zeros)),
        "specquant_exact" => {
            let exact: Vec<f32> = (0..n).map(|idx| (idx as i32 * 10 - 30) as f32 / 4.0).collect();
            (inputs, vec![to_bytes(&exact)], None)
        }
        _ => {
            let rounded = [
                construct_normalized_float(8, 0x300300),
                -construct_normalized_float(-7, 0x600800),
                construct_normalized_float(2, 0x01E000),
                construct_normalized_float(1, 0xFFE000),
            ];
            (inputs, vec![to_bytes(&rounded)], Some(compare_op_quantize_f16_exact))
        }
    }
}

/// `verifyOutput` - an absolute epsilon of 0.001 because of the float to string conversion.
fn verify_output(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    outputs.iter().zip(expected).all(|(output, expected)| {
        to_floats(expected)
            .iter()
            .zip(to_floats(output))
            .all(|(&expected, actual)| (expected - actual).abs() <= 0.001)
    })
}

/// `getComputeShaderSpec` of vktSpvAsmLoopDepInfTests.cpp and vktSpvAsmLoopDepLenTests.cpp, which seed with the literal 0xABC.
fn build_loop_dependency_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const N: usize = 12;
    let mut rnd = Random::new(0xABC);
    let infinite = case.kind == "loop_dependency_infinite";
    let input: Vec<f32> = (0..case.elements)
        .map(|_| {
            let value = rnd.get_float_range(1.0, 100.0);
            if infinite { value.floor() } else { value }
        })
        .collect();

    let output: Vec<f32> = input
        .iter()
        .map(|&value| {
            let mut c = [0.0f32; N];
            if infinite {
                for (i, slot) in c.iter_mut().enumerate() {
                    *slot = i as f32 * value;
                }
                let mut result = 0.0f32;
                for slot in c {
                    result += slot;
                }
                result
            } else {
                for i in 0..6 {
                    c[i] = i as f32 * value;
                }
                for i in 6..N {
                    c[i] = c[i - 4] + c[i - 5] + c[i - 6];
                }
                c[N - 1]
            }
        })
        .collect();

    (vec![to_bytes(&input)], vec![to_bytes(&output)])
}

/// `verifyMatrixOutput` - an expected -1 is the padding of a three row matrix and matches anything.
fn verify_matrix_output(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    if outputs.len() != 1 {
        return false;
    }
    to_floats(&expected[0])
        .iter()
        .zip(to_floats(&outputs[0]))
        .all(|(&expected, actual)| actual == expected || expected == -1.0)
}

fn build_composite_insert_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    let output: Vec<f32> = match case.kind {
        "composite_insert_vec" => (0..case.elements).map(|e| e as f32).collect(),
        "composite_insert_nested" => (0..case.elements)
            .flat_map(|_| (0..4).flat_map(|c| (0..4).map(move |r| if c == r { 1.0 } else { 0.0 })))
            .collect(),
        kind => {
            let (cols, rows) = kind
                .strip_prefix("composite_insert_mat_")
                .and_then(|dims| dims.split_once('x'))
                .expect("a matrix size");
            let (cols, rows): (usize, usize) = (cols.parse().expect("columns"), rows.parse().expect("rows"));
            let mut identity = Vec::new();
            for c in 0..cols {
                identity.extend((0..rows).map(|r| if c == r { 1.0 } else { 0.0 }));
                if rows == 3 {
                    identity.push(-1.0);
                }
            }
            return (Vec::new(), vec![to_bytes(&identity)], Some(verify_matrix_output));
        }
    };
    (Vec::new(), vec![to_bytes(&output)], None)
}

/// `verifyResult` of vktSpvAsmEmptyStructTests.cpp - an expected word of 0 marks an empty structure and is skipped.
fn verify_empty_struct_result(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    let words = |bytes: &[u8]| -> Vec<u32> {
        bytes
            .chunks_exact(4)
            .map(|chunk| u32::from_ne_bytes(chunk.try_into().expect("four bytes")))
            .collect()
    };
    outputs.iter().zip(expected).all(|(output, expected)| {
        words(expected)
            .iter()
            .zip(words(output))
            .all(|(&expected, returned)| expected == 0 || expected == returned)
    })
}

fn words_to_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().flat_map(|value| value.to_ne_bytes()).collect()
}

fn build_empty_struct_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    match case.kind {
        "empty_struct_copy_ubo" => (
            vec![words_to_bytes(&[2, 0, 0, 0, 3, 0, 0, 0, 5, 0, 0, 0, 7, 0, 0, 0])],
            vec![words_to_bytes(&[2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0])],
        ),
        "empty_struct_copy_ssbo" => (vec![words_to_bytes(&[2, 3, 5, 7])], vec![words_to_bytes(&[2, 0, 0, 7])]),
        "empty_struct_pointer_comparison" => (vec![words_to_bytes(&[2, 3, 5, 7])], vec![words_to_bytes(&[1])]),
        _ => (
            vec![words_to_bytes(&[2])],
            vec![words_to_bytes(&[1, 0xffff_ffff, 1]); 2],
        ),
    }
}

const WORKGROUP_MEMORY_TYPES: [&str; 11] = [
    "float64", "float32", "float16", "int64", "int32", "int16", "int8", "uint64", "uint32", "uint16", "uint8",
];

/// `checkResultsFloat16`, `checkResultsFloat32` and `checkResultsFloat64` - identical bits, or NaN on both sides.
fn compare_workgroup_floats<const WIDTH: usize>(
    _inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    expected: &[Vec<u8>],
) -> bool {
    let bits = |chunk: &[u8]| -> u64 { chunk.iter().rev().fold(0u64, |acc, byte| (acc << 8) | *byte as u64) };
    let is_nan = |value: u64| -> bool {
        let (exponent_mask, mantissa_mask) = match WIDTH {
            2 => (0x7c00u64, 0x03ffu64),
            4 => (0x7f80_0000, 0x007f_ffff),
            _ => (0x7ff0_0000_0000_0000, 0x000f_ffff_ffff_ffff),
        };
        (value & exponent_mask) == exponent_mask && (value & mantissa_mask) != 0
    };
    expected[0]
        .chunks_exact(WIDTH)
        .zip(outputs[0].chunks_exact(WIDTH))
        .all(|(expected, result)| {
            let (expected, result) = (bits(expected), bits(result));
            expected == result || (is_nan(expected) && is_nan(result))
        })
}

/// `addComputeWorkgroupMemoryTests` - one generator is shared by every type, so the data of a type depends on how many were drawn before it.
fn build_workgroup_memory_io(case: &SpvAsmCase, leaf: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let mut data = Vec::new();
    for ty in &WORKGROUP_MEMORY_TYPES[..=case.skip as usize] {
        data = match *ty {
            "float64" => utils::get_float64s(&mut rnd, n),
            "float32" => utils::get_float32s(&mut rnd, n),
            "float16" => utils::get_float16s(&mut rnd, n),
            "int64" => utils::get_int64s(&mut rnd, n),
            "int32" => utils::get_int32s(&mut rnd, n),
            "int16" => utils::get_int16s(&mut rnd, n),
            "int8" => utils::get_int8s(&mut rnd, n),
            "uint64" => utils::get_uint64s(&mut rnd, n),
            "uint32" => utils::get_uint32s(&mut rnd, n),
            "uint16" => utils::get_uint16s(&mut rnd, n),
            _ => utils::get_uint8s(&mut rnd, n),
        };
    }
    let input: Vec<u8> = data.iter().flatten().copied().collect();
    let output: Vec<u8> = data.iter().rev().flatten().copied().collect();
    let verify: Option<VerifyIo> = match leaf {
        "float16" => Some(compare_workgroup_floats::<2>),
        "float32" => Some(compare_workgroup_floats::<4>),
        "float64" => Some(compare_workgroup_floats::<8>),
        _ => None,
    };
    (vec![input], vec![output], verify)
}

fn workgroup_memory_features(leaf: &str) -> Vec<RequiredFeature> {
    match leaf {
        "float64" => vec![RequiredFeature::ShaderFloat64],
        "float16" => vec![
            RequiredFeature::StorageBuffer16BitAccess,
            RequiredFeature::ShaderFloat16,
        ],
        "int16" | "uint16" => vec![RequiredFeature::ShaderInt16, RequiredFeature::StorageBuffer16BitAccess],
        "int8" | "uint8" => vec![
            RequiredFeature::UniformAndStorageBuffer8BitAccess,
            RequiredFeature::ShaderInt8,
        ],
        _ => Vec::new(),
    }
}

/// `addComputeIndexingStructTests` - four selectors per invocation index a 32x32x4x4 float array of one of two structs.
fn build_indexing_struct_io(case: &SpvAsmCase, leaf: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    // opptraccesschain starts from the second struct
    let element = usize::from(leaf.starts_with("opptraccesschain"));
    indexing_struct_io(case.seed, case.elements as usize, element)
}

/// The inputs (two structs of 32x32 matrices, the index selectors) and the output of `addComputeIndexingStructTests` and its graphics twin, drawn from the stream seeded with the hash of `seed`; `element` is the struct the chain reads.
pub(super) fn indexing_struct_io(seed: &str, elements: usize, element: usize) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const FLOATS_PER_STRUCT: usize = 32 * 32 * 4 * 4;
    let n = elements;
    let mut rnd = Random::new(de_string_hash(seed));
    let input: Vec<f32> = (0..FLOATS_PER_STRUCT * 2).map(|_| rnd.get_float()).collect();
    let selectors: Vec<[u32; 4]> = (0..n)
        .map(|_| {
            [
                rnd.get_uint32() % 32,
                rnd.get_uint32() % 32,
                rnd.get_uint32() % 4,
                rnd.get_uint32() % 4,
            ]
        })
        .collect();

    let output: Vec<f32> = selectors
        .iter()
        .map(|&[x, y, z, w]| {
            input[element * FLOATS_PER_STRUCT + x as usize * 512 + y as usize * 16 + z as usize * 4 + w as usize]
        })
        .collect();
    let selector_bytes: Vec<u8> = selectors
        .iter()
        .flatten()
        .flat_map(|value| value.to_ne_bytes())
        .collect();

    (vec![to_bytes(&input), selector_bytes], vec![to_bytes(&output)])
}

/// `addComputeIndexingNon16BaseAlignmentTests` - whole numbers only, which for the generator's range of [0, 1) means zeros.
fn build_indexing_non16_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    const FLOAT_ARRAY_SIZE: usize = 18;
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let input: Vec<f32> = (0..FLOAT_ARRAY_SIZE * n).map(|_| rnd.get_float().floor()).collect();
    let output: Vec<f32> = (0..n)
        .map(|output_idx| {
            let mut sum = 0.0f32;
            for arr_idx in 0..FLOAT_ARRAY_SIZE {
                sum += input[output_idx * FLOAT_ARRAY_SIZE + arr_idx];
            }
            sum
        })
        .collect();
    (vec![to_bytes(&input)], vec![to_bytes(&output)])
}

/// `getComputeShaderSpec` of vktSpvAsmFloatControlsExtensionlessTests.cpp: the seed is the hash of the test's own name.
fn build_float_controls_extensionless_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let input: Vec<f32> = (0..n).map(|_| rnd.get_float_range(1.0, 100.0)).collect();
    let output: Vec<f32> = input.iter().map(|value| -value).collect();
    (vec![to_bytes(&input)], vec![to_bytes(&output)])
}

/// The width and execution mode that a float controls case names in its kind, `<width>_<mode>_<spirv14|vulkan12>`.
fn float_controls_extensionless_property(kind: &str) -> Option<(u32, &'static str)> {
    let rest = kind.strip_prefix("float_controls_extensionless_")?;
    let (width, rest) = rest.split_once('_')?;
    let mode = [
        "DenormPreserve",
        "DenormFlushToZero",
        "SignedZeroInfNanPreserve",
        "RoundingModeRTE",
        "RoundingModeRTZ",
    ]
    .into_iter()
    .find(|mode| rest.starts_with(mode))?;
    Some((width.parse().ok()?, mode))
}

const COMPARE64_DOUBLE_OPERANDS: [(f64, f64); 20] = [
    (-8.0, -5.0),
    (-5.0, -8.0),
    (-5.0, -5.0),
    (-5.0, 0.0),
    (0.0, -5.0),
    (5.0, 0.0),
    (0.0, 5.0),
    (0.0, 0.0),
    (-5.0, 5.0),
    (5.0, -5.0),
    (5.0, 8.0),
    (8.0, 5.0),
    (5.0, 5.0),
    (-6.0, -5.0),
    (6.0, 5.0),
    (0.0, 1.0),
    (1.0, 0.0),
    (0.0, f64::NAN),
    (f64::NAN, 0.0),
    (f64::NAN, f64::NAN),
];

const COMPARE64_INT64_OPERANDS: [(i64, i64); 16] = [
    (-8, -5),
    (-5, -8),
    (-5, -5),
    (-5, 0),
    (0, -5),
    (5, 0),
    (0, 5),
    (0, 0),
    (-5, 5),
    (5, -5),
    (5, 8),
    (8, 5),
    (5, 5),
    (-6, -5),
    (6, 5),
    (0, 1),
];

const COMPARE64_UINT64_OPERANDS: [(u64, u64); 12] = [
    (0, 0),
    (1, 0),
    (0, 1),
    (1, 1),
    (5, 8),
    (8, 5),
    (5, 5),
    (0, u64::MAX),
    (u64::MAX, 0),
    (u64::MAX - 1, u64::MAX),
    (u64::MAX, u64::MAX - 1),
    (u64::MAX, u64::MAX),
];

/// The comparison named by the lower-cased SPIR-V opcode of a 64bit_compare case, `opfordlessthan` and `opsgreaterthanequal` among them.
fn compare64_run<T: PartialOrd>(op: &str, left: T, right: T) -> bool {
    if op.ends_with("lessthanequal") {
        left <= right
    } else if op.ends_with("greaterthanequal") {
        left >= right
    } else if op.ends_with("notequal") {
        left != right
    } else if op.ends_with("lessthan") {
        left < right
    } else if op.ends_with("greaterthan") {
        left > right
    } else {
        left == right
    }
}

/// The result `T64bitCompareTestInstance` expects: a NaN makes an ordered comparison false and an unordered one true.
fn compare64_double_run(op: &str, left: f64, right: f64) -> bool {
    if left.is_nan() || right.is_nan() {
        return op.starts_with("opfunord");
    }
    compare64_run(op, left, right)
}

/// Results differing on a NaN operand only count when the shader asked to preserve NaNs.
fn verify_compare64_double<const NAN_PRESERVE: bool>(
    inputs: &[Vec<u8>],
    outputs: &[Vec<u8>],
    expected: &[Vec<u8>],
) -> bool {
    let doubles = |bytes: &[u8]| -> Vec<f64> {
        bytes
            .chunks_exact(8)
            .map(|chunk| f64::from_ne_bytes(chunk.try_into().expect("eight bytes")))
            .collect()
    };
    let (left, right) = (doubles(&inputs[0]), doubles(&inputs[1]));
    expected[0]
        .chunks_exact(4)
        .zip(outputs[0].chunks_exact(4))
        .enumerate()
        .all(|(idx, (expected, result))| {
            expected == result || (!NAN_PRESERVE && (left[idx].is_nan() || right[idx].is_nan()))
        })
}

fn build_compare64_io(case: &SpvAsmCase, leaf: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    compare64_io(case.kind, leaf)
}

/// The inputs, expected results and the result check of a `64bit_compare` case, from its kind (`compare64_double`, `compare64_int64`, `compare64_uint64`) and its leaf name.
pub(super) fn compare64_io(kind: &str, leaf: &str) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    let op = leaf.split('_').nth(1).expect("an opcode in the case name");
    let nan_preserve = leaf.contains("_withnan_");
    let bool_ints = |results: Vec<bool>| -> Vec<u8> {
        results
            .into_iter()
            .flat_map(|result| (result as i32).to_ne_bytes())
            .collect()
    };
    match kind {
        "compare64_double" => {
            let left: Vec<u8> = COMPARE64_DOUBLE_OPERANDS
                .iter()
                .flat_map(|(left, _)| left.to_ne_bytes())
                .collect();
            let right: Vec<u8> = COMPARE64_DOUBLE_OPERANDS
                .iter()
                .flat_map(|(_, right)| right.to_ne_bytes())
                .collect();
            let results = bool_ints(
                COMPARE64_DOUBLE_OPERANDS
                    .iter()
                    .map(|&(left, right)| compare64_double_run(op, left, right))
                    .collect(),
            );
            let verify: VerifyIo = if nan_preserve {
                verify_compare64_double::<true>
            } else {
                verify_compare64_double::<false>
            };
            (vec![left, right], vec![results], Some(verify))
        }
        "compare64_int64" => {
            let left: Vec<u8> = COMPARE64_INT64_OPERANDS
                .iter()
                .flat_map(|(left, _)| left.to_ne_bytes())
                .collect();
            let right: Vec<u8> = COMPARE64_INT64_OPERANDS
                .iter()
                .flat_map(|(_, right)| right.to_ne_bytes())
                .collect();
            (
                vec![left, right],
                vec![bool_ints(
                    COMPARE64_INT64_OPERANDS
                        .iter()
                        .map(|&(left, right)| compare64_run(op, left, right))
                        .collect(),
                )],
                None,
            )
        }
        _ => {
            let left: Vec<u8> = COMPARE64_UINT64_OPERANDS
                .iter()
                .flat_map(|(left, _)| left.to_ne_bytes())
                .collect();
            let right: Vec<u8> = COMPARE64_UINT64_OPERANDS
                .iter()
                .flat_map(|(_, right)| right.to_ne_bytes())
                .collect();
            (
                vec![left, right],
                vec![bool_ints(
                    COMPARE64_UINT64_OPERANDS
                        .iter()
                        .map(|&(left, right)| compare64_run(op, left, right))
                        .collect(),
                )],
                None,
            )
        }
    }
}

/// The drawn number of a composite or default output case, carried in `seed` as decimal or as the hex bits of a float.
fn number_bytes(case: &SpvAsmCase, number_type: &str) -> Vec<u8> {
    match number_type {
        "int" => case
            .seed
            .parse::<i32>()
            .expect("a signed number")
            .to_ne_bytes()
            .to_vec(),
        "uint" => case
            .seed
            .parse::<u32>()
            .expect("an unsigned number")
            .to_ne_bytes()
            .to_vec(),
        _ => u32::from_str_radix(case.seed.trim_start_matches("0x"), 16)
            .expect("float bits")
            .to_ne_bytes()
            .to_vec(),
    }
}

/// `compareFloats` - an epsilon of 0.00001 because of the float to string conversion of the constant.
fn compare_floats(_inputs: &[Vec<u8>], outputs: &[Vec<u8>], expected: &[Vec<u8>]) -> bool {
    to_floats(&expected[0])
        .iter()
        .zip(to_floats(&outputs[0]))
        .all(|(&expected, actual)| (expected - actual).abs() <= 0.00001)
}

/// `passthruVerify` - only checks that the driver survives an uninitialized variable.
fn passthru_verify(_inputs: &[Vec<u8>], _outputs: &[Vec<u8>], _expected: &[Vec<u8>]) -> bool {
    true
}

fn build_number_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) {
    let number_type = case.kind.rsplit('_').next().expect("a number type suffix");
    let number = number_bytes(case, number_type);
    let verify: Option<VerifyIo> = if case.kind.starts_with("default_output_uninitialized_") {
        Some(passthru_verify)
    } else if case.kind.starts_with("default_output_float") {
        Some(compare_floats)
    } else {
        None
    };
    (vec![number.clone()], vec![number], verify)
}

/// `tcu::Float16(value).bits()` for the whole numbers (up to 2048 in magnitude) the vartype cases convert, which a half holds exactly.
fn whole_number_to_half_bits(value: f32) -> u16 {
    let sign = if value.is_sign_negative() { 0x8000u16 } else { 0 };
    let magnitude = value.abs();
    if magnitude == 0.0 {
        return sign;
    }
    let exponent = magnitude.log2().floor() as i32;
    let mantissa = ((magnitude / 2.0f32.powi(exponent) - 1.0) * 1024.0) as u16;
    sign | (((exponent + 15) as u16) << 10) | mantissa
}

/// `createOpPhiVartypeTests` - the sign of each floored input, as a float or as the half packed into the low bits of a uint.
fn build_op_phi_vartype_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let input: Vec<f32> = (0..n)
        .map(|_| rnd.get_float_range(case.min as f32, case.max as f32).floor())
        .collect();
    let output: Vec<f32> = input
        .iter()
        .map(|&value| if value > 0.0 { 1.0 } else { -1.0 })
        .collect();

    if case.kind == "opphi_vartype_f16" {
        let words = |values: &[f32]| -> Vec<u8> {
            values
                .iter()
                .flat_map(|&value| u32::from(whole_number_to_half_bits(value)).to_ne_bytes())
                .collect()
        };
        return (vec![words(&input)], vec![words(&output)]);
    }
    (vec![to_bytes(&input)], vec![to_bytes(&output)])
}

/// `createSpecConstantGroup` - the output is the input shifted by the amount that `kind` names (`spec_constant_<n>`), n as upstream's `outputInts<n>`.
fn build_spec_constant_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let input: Vec<i32> = (0..n).map(|_| rnd.get_int(-65536, 65536)).collect();
    let delta = match case.kind {
        "spec_constant_1" => 42,
        "spec_constant_2" => 0,
        "spec_constant_3" => -11200,
        "spec_constant_4" => 1,
        _ => -42,
    };
    let output: Vec<i32> = input.iter().map(|value| value.wrapping_add(delta)).collect();
    (vec![to_int_bytes(&input)], vec![to_int_bytes(&output)])
}

/// The device features behind the type flags of a spec constant case, by the suffix of its name.
fn spec_constant_features(leaf: &str) -> Vec<RequiredFeature> {
    match leaf {
        "sconvert" => vec![RequiredFeature::ShaderInt16],
        "fconvert" => vec![RequiredFeature::ShaderFloat64],
        "fconvert16" => vec![RequiredFeature::ShaderFloat16],
        name if name.ends_with("_i64") || name.ends_with("_s_i64") => vec![RequiredFeature::ShaderInt64],
        name if name.ends_with("_i16") => vec![RequiredFeature::ShaderInt16],
        name if name.ends_with("_i8") => vec![RequiredFeature::ShaderInt8],
        _ => Vec::new(),
    }
}

/// The inputs and the expected outputs of the cases with several inputs and a custom comparison.
fn build_multi_io(case: &SpvAsmCase) -> (Vec<Vec<u8>>, Vec<Vec<u8>>) {
    let n = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    let mut draw = |lo: f32, hi: f32| -> Vec<f32> { (0..n).map(|_| rnd.get_float_range(lo, hi)).collect() };

    match case.kind {
        "frem" => {
            let in1 = draw(-10000.0, 10000.0);
            let mut in2 = draw(-100.0, 100.0);
            let out: Vec<f32> = (0..n)
                .map(|ndx| {
                    // Guard against divisors near zero.
                    if in2[ndx].abs() < 1e-3 {
                        in2[ndx] = 8.0;
                    }
                    // The sign of the result is the one of the first operand, which is how OpFRem is specified.
                    in1[ndx] % in2[ndx]
                })
                .collect();
            (vec![to_bytes(&in1), to_bytes(&in2)], vec![to_bytes(&out)])
        }
        "nmin" | "nmax" => {
            let mut in1 = draw(-10000.0, 10000.0);
            let mut in2 = draw(-10000.0, 10000.0);
            let mut out = vec![0.0f32; n];

            // The first case is a full NaN case.
            in1[0] = f32::NAN;
            in2[0] = f32::NAN;

            for ndx in 0..n {
                out[ndx] = if case.kind == "nmin" {
                    std_min(in1[ndx], in2[ndx])
                } else {
                    std_max(in1[ndx], in2[ndx])
                };

                // Half of the cases are NaN cases, alternating the NaN operand.
                if ndx & 1 == 0 {
                    if ndx & 2 == 0 {
                        out[ndx] = in2[ndx];
                        in1[ndx] = f32::NAN;
                    } else {
                        out[ndx] = in1[ndx];
                        in2[ndx] = f32::NAN;
                    }
                }
            }
            (vec![to_bytes(&in1), to_bytes(&in2)], vec![to_bytes(&out)])
        }
        "nclamp" => {
            let mut in1 = draw(-10000.0, 10000.0);
            let mut in2 = draw(-10000.0, 10000.0);
            let mut in3 = draw(-10000.0, 10000.0);
            let mut out = vec![0.0f32; n * 2];

            for ndx in 0..n {
                // The results are only defined if the maximum is bigger than the minimum.
                if in2[ndx] > in3[ndx] {
                    std::mem::swap(&mut in2[ndx], &mut in3[ndx]);
                }

                let default_res = std_min(std_max(in1[ndx], in2[ndx]), in3[ndx]);
                let (res_a, res_b) = if ndx & 1 != 0 {
                    in1[ndx] = f32::NAN;
                    // With NaNs handled the result is the minimum, without them it clamps to the maximum.
                    (in2[ndx], in3[ndx])
                } else {
                    (default_res, default_res)
                };
                out[ndx * 2] = res_a;
                out[ndx * 2 + 1] = res_b;
            }

            // The first case is a full NaN case.
            in1[0] = f32::NAN;
            in2[0] = f32::NAN;
            in3[0] = f32::NAN;
            out[0] = f32::NAN;
            out[1] = f32::NAN;
            (
                vec![to_bytes(&in1), to_bytes(&in2), to_bytes(&in3)],
                vec![to_bytes(&out)],
            )
        }
        _ => unreachable!("not a multi input kind"),
    }
}

/// The input and the expected output of a case, built the way the group function of upstream builds them.
fn build_io(case: &SpvAsmCase) -> (Vec<u8>, Vec<u8>) {
    let elements = case.elements as usize;
    let mut rnd = Random::new(de_string_hash(case.seed));
    for _ in 0..case.skip {
        rnd.get_float_range(case.min as f32, case.max as f32);
    }
    let mut input: Vec<f32> = (0..elements)
        .map(|_| rnd.get_float_range(case.min as f32, case.max as f32))
        .collect();

    // The CPU might not round like the GPU: whole numbers avoid the difference.
    if matches!(case.kind, "selection" | "add_10" | "copy_vector" | "add_7_5") {
        for value in &mut input {
            *value = value.floor();
        }
    }

    let output: Vec<f32> = match case.kind {
        "add_4" => input.iter().map(|value| value + 4.0).collect(),
        "add_10" => input.iter().map(|value| value + 10.0).collect(),
        "add_7_5" => input.iter().map(|value| value + 7.5).collect(),
        "selection" => input
            .iter()
            .map(|value| value + if *value > 10.0 { 1.0 } else { -1.0 })
            .collect(),
        "identity" => input.clone(),
        "copy_vector" => input
            .iter()
            .enumerate()
            .map(|(ndx, value)| value + [0.0, 0.5, 1.5, 2.5][ndx % 4])
            .collect(),
        "block_order" => {
            for value in &mut input {
                *value = value.floor();
            }
            (0..elements)
                .map(|ndx| {
                    if ndx <= 50 {
                        -input[ndx]
                    } else {
                        match ndx % 3 {
                            0 => input[ndx] + 1.5,
                            1 => input[ndx] + 42.0,
                            _ => input[ndx] - 27.0,
                        }
                    }
                })
                .collect()
        }
        "double" => input.iter().map(|value| value + value).collect(),
        _ => input.iter().map(|value| -value).collect(),
    };

    (to_bytes(&input), to_bytes(&output))
}

fn make_case(case: &SpvAsmCase, leaf: &str) -> Box<dyn TestCase> {
    let is_remainder = matches!(case.kind, "srem" | "smod" | "srem64" | "smod64");
    let (inputs, outputs, verify_io): (Vec<Vec<u8>>, Vec<Vec<u8>>, Option<VerifyIo>) = match case.kind {
        "frem" => {
            let (inputs, outputs) = build_multi_io(case);
            (inputs, outputs, Some(compare_frem))
        }
        "nmin" => {
            let (inputs, outputs) = build_multi_io(case);
            (inputs, outputs, Some(compare_nmin))
        }
        "nmax" => {
            let (inputs, outputs) = build_multi_io(case);
            (inputs, outputs, Some(compare_nmax))
        }
        "nclamp" => {
            let (inputs, outputs) = build_multi_io(case);
            (inputs, outputs, Some(compare_nclamp))
        }
        "funord" | "funord_nan" => {
            let (inputs, outputs) = build_funord_io(case, leaf);
            let verify: VerifyIo = if case.kind == "funord_nan" {
                compare_funord::<true>
            } else {
                compare_funord::<false>
            };
            (inputs, outputs, Some(verify))
        }
        "srem" | "smod" => {
            let (inputs, outputs) = build_int32_remainder_io(case, case.kind == "smod");
            (inputs, outputs, None)
        }
        "srem64" | "smod64" => {
            let (inputs, outputs) = build_int64_remainder_io(case, case.kind == "smod64");
            (inputs, outputs, None)
        }
        "rearrangement_add" | "rearrangement_mul_add" => {
            let (inputs, outputs) = build_expression_rearrangement_io(case, leaf);
            (inputs, outputs, Some(compare_expression_rearrangement))
        }
        "opphi_vartype" | "opphi_vartype_f16" => {
            let (inputs, outputs) = build_op_phi_vartype_io(case);
            (inputs, outputs, None)
        }
        "opphi_block" | "opphi_induction" | "opphi_swap" | "opphi_wide" | "opphi_nested" => {
            let (inputs, outputs) = build_op_phi_io(case);
            (inputs, outputs, None)
        }
        kind if kind.starts_with("quantize_") => build_quantize_io(case),
        kind if kind.starts_with("specquant_") => build_spec_quantize_io(case),
        "loop_dependency_length" | "loop_dependency_infinite" => {
            let (inputs, outputs) = build_loop_dependency_io(case);
            (inputs, outputs, Some(verify_output))
        }
        kind if kind.starts_with("composite_insert_") => build_composite_insert_io(case),
        kind if kind.starts_with("empty_struct_") => {
            let (inputs, outputs) = build_empty_struct_io(case);
            (inputs, outputs, Some(verify_empty_struct_result))
        }
        kind if kind.starts_with("spirv_version_") => {
            let version: u32 = kind["spirv_version_".len()..].parse().expect("a SPIR-V minor version");
            let n = case.elements as usize;
            let mut rnd = Random::new(version);
            let input: Vec<f32> = (0..n).map(|_| rnd.get_float_range(1.0, 100.0)).collect();
            let output: Vec<f32> = input.iter().map(|value| -value).collect();
            (vec![to_bytes(&input)], vec![to_bytes(&output)], None)
        }
        "relaxed_forward_reference" => (vec![to_bytes(&[0.0f32; 10])], vec![to_bytes(&[0.0f32; 10])], None),
        "indexing_struct" => {
            let (inputs, outputs) = build_indexing_struct_io(case, leaf);
            (inputs, outputs, None)
        }
        "indexing_non16" => {
            let (inputs, outputs) = build_indexing_non16_io(case);
            (inputs, outputs, None)
        }
        kind if kind.starts_with("float_controls_extensionless_") => {
            let (inputs, outputs) = build_float_controls_extensionless_io(case);
            (inputs, outputs, Some(verify_output))
        }
        kind if kind.starts_with("compare64_") => build_compare64_io(case, leaf),
        kind if kind.starts_with("composite_number_") || kind.starts_with("default_output_") => build_number_io(case),
        "bool_mixed_bitsize" => {
            let n = case.elements as usize;
            let mut rnd = Random::new(de_string_hash(case.seed));
            let input: Vec<f32> = (0..n).map(|_| rnd.get_float_range(0.0, 100.0)).collect();
            let output: Vec<f32> = input
                .iter()
                .map(|&value| {
                    if (25.0..50.0).contains(&value) || (value < 10.0 || value >= 90.0) {
                        0.0
                    } else {
                        1.0
                    }
                })
                .collect();
            (vec![to_bytes(&input)], vec![to_bytes(&output)], None)
        }
        kind if kind.starts_with("spec_constant_") => {
            let (inputs, outputs) = build_spec_constant_io(case);
            (inputs, outputs, None)
        }
        "workgroup_memory" => build_workgroup_memory_io(case, leaf),
        "variable_init" => (Vec::new(), vec![to_bytes(&[1.0f32; 128])], None),
        "ubo_padding" => {
            let mut rnd = Random::new(de_string_hash(case.seed));
            let mut input = Vec::new();
            let mut output = Vec::new();
            for _ in 0..case.elements {
                let v: [f32; 4] = std::array::from_fn(|_| rnd.get_float_range(0.0, 1.0));
                output.extend_from_slice(&v);
                input.extend_from_slice(&[v[0], v[1], 0.0, 0.0, v[2], v[3], 0.0, 0.0]);
            }
            (vec![to_bytes(&input)], vec![to_bytes(&output)], None)
        }
        "conditional_branch" => {
            let output: Vec<u32> = (0..case.elements).collect();
            (
                Vec::new(),
                vec![output.iter().flat_map(|value| value.to_ne_bytes()).collect()],
                None,
            )
        }
        "decoration_group" => {
            let n = case.elements as usize;
            let mut rnd = Random::new(de_string_hash(case.seed));
            let inputs: Vec<Vec<f32>> = (0..5)
                .map(|_| {
                    (0..n)
                        .map(|_| rnd.get_float_range(case.min as f32, case.max as f32).floor())
                        .collect()
                })
                .collect();
            let output: Vec<f32> = (0..n)
                .map(|ndx| inputs[0][ndx] + inputs[1][ndx] + inputs[2][ndx] + inputs[3][ndx] + inputs[4][ndx])
                .collect();
            (
                inputs.iter().map(|input| to_bytes(input)).collect(),
                vec![to_bytes(&output)],
                None,
            )
        }
        kind if kind.starts_with("atomic_") => {
            let with_return_values = kind.starts_with("atomic_ret_");
            let op = kind.rsplit('_').next().expect("an operation suffix");
            let (inputs, outputs) = build_atomic_io(case, op, with_return_values);
            let verify: Option<VerifyIo> = match (with_return_values, op) {
                (false, _) => None,
                (true, "iadd") => Some(compare_atomic_with_retvals::<0>),
                (true, "isub") => Some(compare_atomic_with_retvals::<1>),
                (true, "iinc") => Some(compare_atomic_with_retvals::<2>),
                (true, "idec") => Some(compare_atomic_with_retvals::<3>),
                (true, _) => Some(compare_atomic_with_retvals::<6>),
            };
            (inputs, outputs, verify)
        }
        "descriptor_array" => (
            (0..4i32).map(|ndx| ndx.to_ne_bytes().to_vec()).collect(),
            vec![(-1i32).to_ne_bytes().to_vec()],
            None,
        ),
        "nocontraction" => {
            let n = case.elements as usize;
            // (1 + 2^-23) * (1 - 2^-23) - 1: multiplied on its own the result is rounded to 1, so the final value is 0 or -2^-24;
            // as a fused multiply-add it would be -2^-46.
            let in1 = vec![1.0f32 + 2.0f32.powi(-23); n];
            let in2 = vec![1.0f32 - 2.0f32.powi(-23); n];
            (
                vec![to_bytes(&in1), to_bytes(&in2)],
                vec![to_bytes(&vec![0.0f32; n])],
                Some(compare_no_contract),
            )
        }
        _ => {
            let (input, output) = build_io(case);
            (vec![input], vec![output], None)
        }
    };
    let spec = ComputeShaderSpec {
        inputs,
        outputs,
        verify_io,
        num_work_groups: [case.workgroups, 1, 1],
        entry_point: case.entry.to_string(),
        extensions: case
            .extensions
            .split(',')
            .filter(|extension| !extension.is_empty())
            .map(str::to_string)
            .collect(),
        spirv_1_3: case.spirv13
            || case.kind.ends_with("_spirv14")
            || matches!(case.kind, "empty_struct_pointer_comparison" | "empty_struct_function")
            || leaf.starts_with("struct_from_")
            || leaf.starts_with("floatarray_from_"),
        spirv_version_minor: case
            .kind
            .strip_prefix("spirv_version_")
            .and_then(|minor| minor.parse().ok())
            .or(if case.kind == "relaxed_forward_reference" {
                Some(6)
            } else {
                None
            }),
        spirv_1_5: case.kind == "negate_spirv15" || case.kind.ends_with("_vulkan12"),
        vulkan_memory_model: case.kind.starts_with("atomic_vol_"),
        float_controls_property: float_controls_extensionless_property(case.kind).or(if leaf.contains("_withnan_") {
            Some((64, "SignedZeroInfNanPreserve"))
        } else {
            None
        }),
        maintenance8: case.name.starts_with("maintenance8/"),
        spec_constants: case
            .spec_constants
            .split(';')
            .filter(|hex| !hex.is_empty())
            .map(|hex| {
                (0..hex.len() / 2)
                    .map(|ndx| u8::from_str_radix(&hex[ndx * 2..ndx * 2 + 2], 16).expect("hex digits"))
                    .collect()
            })
            .collect(),
        uniform_inputs: matches!(case.kind, "ubo_padding" | "empty_struct_copy_ubo"),
        variable_pointers: case.kind == "variable_init" && leaf.ends_with("_from_workgroup"),
        variable_pointers_storage_buffer: matches!(
            case.kind,
            "empty_struct_pointer_comparison" | "empty_struct_function" | "indexing_non16"
        ) || (case.kind == "indexing_struct" && leaf.starts_with("opptraccesschain")),
        uses_64bit_indexing: case.kind == "indexing_struct" && leaf.ends_with("_64bit_indexing"),
        shader_int64: matches!(case.kind, "srem64" | "smod64")
            || (case.kind == "workgroup_memory" && leaf.ends_with("int64"))
            || (case.kind == "indexing_struct" && leaf.trim_end_matches("_64bit_indexing").ends_with("64"))
            || matches!(case.kind, "compare64_int64" | "compare64_uint64"),
        features: match case.kind {
            "workgroup_memory" => workgroup_memory_features(leaf),
            "indexing_struct" if leaf.contains("16") => vec![RequiredFeature::ShaderInt16],
            "compare64_double" => vec![RequiredFeature::ShaderFloat64],
            "float16_negate" | "opphi_vartype_f16" => vec![RequiredFeature::ShaderFloat16],
            "bool_mixed_bitsize" => {
                let mut features = Vec::new();
                if leaf.contains("b16") {
                    features.push(RequiredFeature::ShaderFloat16);
                }
                if leaf.contains("b8") {
                    features.push(RequiredFeature::ShaderInt8);
                }
                features
            }
            kind if kind.starts_with("spec_constant_") => spec_constant_features(leaf),
            kind if kind.starts_with("float_controls_extensionless_16_") => vec![RequiredFeature::ShaderFloat16],
            kind if kind.starts_with("float_controls_extensionless_64_") => vec![RequiredFeature::ShaderFloat64],
            _ => Vec::new(),
        },
        signed_zero_inf_nan_preserve_float32: case.kind == "funord_nan",
        denorm_preserve_float32: case.kind == "rearrangement_add",
        denorm_flush_to_zero_float32: case.kind == "rearrangement_mul_add",
        fail_result: match (is_remainder, leaf) {
            (true, "all") if case.name.starts_with("android/") => TestResult::QualityWarning,
            (true, "all") if case.name.starts_with("maintenance8/") => TestResult::Fail,
            (true, "all") => TestResult::Pass,
            _ => TestResult::Fail,
        },
        fail_message: match (is_remainder, leaf) {
            (true, "all") => "Inconsistent results, but within specification",
            (true, _) => "Output doesn't match with expected",
            _ => "Output does not match with expected results",
        },
        verify_binary: if case.kind == "negate_verify_binary" {
            Some(verify_binary_shader)
        } else {
            None
        },
        array_count: if case.kind == "descriptor_array" { 4 } else { 0 },
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

pub(super) enum Node {
    Group(String, Vec<Node>),
    Case(Box<dyn TestCase>),
}

pub(super) fn insert(children: &mut Vec<Node>, path: &[&str], case: Box<dyn TestCase>) {
    let Some((first, rest)) = path.split_first() else {
        children.push(Node::Case(case));
        return;
    };

    let existing = children
        .iter()
        .position(|node| matches!(node, Node::Group(name, _) if name == first));
    let index = existing.unwrap_or_else(|| {
        children.push(Node::Group(first.to_string(), Vec::new()));
        children.len() - 1
    });

    if let Node::Group(_, grandchildren) = &mut children[index] {
        insert(grandchildren, rest, case);
    }
}

pub(super) fn build_group(name: &str, nodes: Vec<Node>) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for node in nodes {
        match node {
            Node::Group(child_name, children) => {
                group.add_child(build_group(&child_name, children));
            }
            Node::Case(case) => {
                group.add_child(case);
            }
        }
    }
    group
}

/// `createInstructionTests`, as far as it is ported: `instruction.compute`.
pub fn create_instruction_tests() -> TestCaseGroup {
    let mut compute = Vec::new();

    for case in ALL_SPV_ASM_CASE.iter() {
        let segments: Vec<&str> = case.name.split('/').collect();
        let (leaf, groups) = segments.split_last().expect("a case name has a leaf");
        insert(&mut compute, groups, make_case(case, leaf));
    }

    for (groups, case) in super::amber_tests::create_amber_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::dot_product_tests::create_dot_product_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::compute_shader_derivatives_tests::create_compute_shader_derivatives_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::float_controls2_tests::create_float_controls2_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::fma_tests::create_fma_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::untyped_pointers_tests::create_untyped_pointers_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::opundef_buffer_tests::create_opundef_buffer_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::raw_access_chain_tests::create_raw_access_chain_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::pointers_tests::create_pointers_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::physical_storage_buffer_tests::create_physical_storage_buffer_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::hlsl_tests::create_hlsl_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::opselect_different_strides_tests::create_opselect_different_strides_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::image_input_tests::create_image_input_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::storage16_tests::create_storage16_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::storage8_tests::create_storage8_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::struct16_tests::create_struct16_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::graphics_fragments_tests::create_compute_fragments_cases() {
        insert(&mut compute, &groups, case);
    }

    for (groups, case) in super::multiple_shaders_extended_tests::create_multiple_shaders_extended_cases() {
        insert(&mut compute, &groups, case);
    }

    let mut instruction = TestCaseGroup::new("instruction");
    instruction.add_child(build_group("compute", compute));

    let mut maint9 = Vec::new();
    for (groups, case) in super::maint9_vectorization_tests::create_maint9_vectorization_cases() {
        insert(&mut maint9, &groups, case);
    }
    for (groups, case) in super::trinary_minmax_tests::create_trinary_minmax_cases() {
        insert(&mut maint9, &groups, case);
    }
    for node in maint9 {
        if let Node::Group(name, children) = node {
            instruction.add_child(build_group(&name, children));
        }
    }
    let mut graphics = super::amber_tests::create_graphics_amber_group();
    let mut graphics_nodes = Vec::new();
    for (groups, case) in super::float_controls2_tests::create_float_controls2_graphics_cases() {
        insert(&mut graphics_nodes, &groups, case);
    }
    for (groups, case) in super::convert_graphics_tests::create_convert_graphics_cases() {
        insert(&mut graphics_nodes, &groups, case);
    }
    for (groups, case) in super::graphics_fragments_tests::create_graphics_fragments_cases() {
        insert(&mut graphics_nodes, &groups, case);
    }
    for (groups, case) in super::compare64_graphics_tests::create_compare64_graphics_cases() {
        insert(&mut graphics_nodes, &groups, case);
    }
    for node in graphics_nodes {
        if let Node::Group(name, children) = node {
            graphics.add_child(build_group(&name, children));
        }
    }
    instruction.add_child(graphics);
    instruction.add_child(super::amber_tests::create_spirv1p4_group());
    instruction.add_child(super::function_params_tests::create_function_params_group());
    instruction.add_child(super::image_query_tests::create_query_group());
    instruction
}

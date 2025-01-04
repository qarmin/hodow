// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmIntegerDotProductTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2021 The Khronos Group Inc.
// Copyright (c) 2021 Google Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The assembly of each case is in `shaders/manifest/spirv_assembly_dot_product.toml` (written by
// `scripts/gen_spirv_assembly_dot_product_manifest.py`). Upstream draws the operands of every case of a group from one `de::Random` in the order
// the group function creates its cases; each draw is one `getUint32`, so a case's `spec` records the number of draws before its operands (`skip`)
// and, for the saturating groups, before its addends (`askip`), and the draws are replayed from there. The expected output is computed here the way
// `fillDotProductOutputs` does, and `compareDotProductAccSat` becomes a mask over the output: where the exact product overflows the addend type
// the result is not defined, so no byte of it is compared.

use super::compute_shader_case::{ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase};
use crate::generated::shaders::spirv_assembly_dot_product::ALL_DOT_PRODUCT_CASE;
use crate::tcu::de_string_hash;
use crate::tcu::random::Random;
use crate::vk::programs::BinaryCollection;
use crate::vkt::TestCase;

const NUM_ELEMENTS: usize = 200;

/// The `rust_type` of the manifest entries: one test case of an integer dot product group.
#[derive(Clone, Copy)]
pub struct DotProductCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

struct Params<'a> {
    seed: &'a str,
    accumulate: bool,
    bits: u32,
    lhs_signed: bool,
    rhs_signed: bool,
    length: usize,
    out_bits: u32,
    lhs_range: (i64, i64),
    rhs_range: (i64, i64),
    skip: usize,
    addend_skip: usize,
    max_addend: bool,
    packed: bool,
}

fn field<'a>(spec: &'a str, key: &str) -> &'a str {
    spec.split(';')
        .find_map(|entry| entry.strip_prefix(key).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("dot product spec without {key}"))
}

fn number(spec: &str, key: &str) -> i64 {
    field(spec, key)
        .parse()
        .unwrap_or_else(|_| panic!("dot product spec with a bad {key}"))
}

fn parse(spec: &str) -> Params<'_> {
    Params {
        seed: field(spec, "seed"),
        accumulate: field(spec, "op").ends_with("acc"),
        bits: number(spec, "bits") as u32,
        lhs_signed: number(spec, "ls") != 0,
        rhs_signed: number(spec, "rs") != 0,
        length: number(spec, "len") as usize,
        out_bits: number(spec, "out") as u32,
        lhs_range: (number(spec, "lmin"), number(spec, "lmax")),
        rhs_range: (number(spec, "rmin"), number(spec, "rmax")),
        skip: number(spec, "skip") as usize,
        addend_skip: number(spec, "askip").max(0) as usize,
        max_addend: number(spec, "maxadd") != 0,
        packed: number(spec, "packed") != 0,
    }
}

/// `de::randomScalar<T>` for the integer types of these tests, one draw each.
fn random_scalar(rnd: &mut Random, bits: u32, signed: bool, min: i64, max: i64) -> i64 {
    if signed {
        i64::from(rnd.get_int(min as i32, max as i32))
    } else {
        let span = max - min + 1;
        match bits {
            8 => min + i64::from(rnd.get_uint8()) % span,
            16 => min + i64::from(rnd.get_uint16()) % span,
            _ if min == 0 && max == 0xffff_ffff => i64::from(rnd.get_uint32()),
            _ => min + i64::from(rnd.get_uint32()) % span,
        }
    }
}

fn type_range(bits: u32, signed: bool) -> (i64, i64) {
    if signed {
        (-(1i64 << (bits - 1)), (1i64 << (bits - 1)) - 1)
    } else {
        (0, (1i64 << bits) - 1)
    }
}

/// `static_cast<T>` of an int64 to an integer of `bits` bits.
fn wrap(value: i64, bits: u32, signed: bool) -> i64 {
    let masked = (value as u64) & ((1u64 << bits) - 1);
    if signed && masked >> (bits - 1) != 0 {
        (masked | (u64::MAX << bits)) as i64
    } else {
        masked as i64
    }
}

fn to_bytes(values: &[i64], bits: u32) -> Vec<u8> {
    values
        .iter()
        .flat_map(|&value| (value as u64).to_le_bytes()[..(bits / 8) as usize].to_vec())
        .collect()
}

/// `dotProduct<T>` - the sum of the products, which wraps like the 64-bit accumulation of upstream.
fn dot_product(lhs: &[i64], rhs: &[i64]) -> i64 {
    let sum: i128 = lhs.iter().zip(rhs).map(|(&a, &b)| i128::from(a) * i128::from(b)).sum();
    sum as u64 as i64
}

/// The operands, the expected output and the mask of what is compared of it.
fn build_io(params: &Params<'_>) -> (Vec<Vec<u8>>, Vec<u8>, Vec<u8>) {
    let aligned = if params.length == 3 { 4 } else { params.length };
    let count = NUM_ELEMENTS * aligned;

    let mut rnd = Random::new(de_string_hash(params.seed));
    for _ in 0..params.skip {
        rnd.get_uint32();
    }
    let mut lhs: Vec<i64> = (0..count)
        .map(|_| {
            random_scalar(
                &mut rnd,
                params.bits,
                params.lhs_signed,
                params.lhs_range.0,
                params.lhs_range.1,
            )
        })
        .collect();
    let mut rhs: Vec<i64> = (0..count)
        .map(|_| {
            random_scalar(
                &mut rnd,
                params.bits,
                params.rhs_signed,
                params.rhs_range.0,
                params.rhs_range.1,
            )
        })
        .collect();
    if params.length == 3 {
        for ndx in 0..NUM_ELEMENTS {
            lhs[ndx * 4 + 3] = 0;
            rhs[ndx * 4 + 3] = 0;
        }
    }

    let out_bits = params.out_bits;
    let mut inputs = vec![to_bytes(&lhs, params.bits), to_bytes(&rhs, params.bits)];

    if !params.accumulate {
        let output: Vec<i64> = (0..NUM_ELEMENTS)
            .map(|ndx| {
                dot_product(
                    &lhs[ndx * aligned..(ndx + 1) * aligned],
                    &rhs[ndx * aligned..(ndx + 1) * aligned],
                )
            })
            .collect();
        let expected = to_bytes(&output, out_bits);
        let mask = vec![0xffu8; expected.len()];
        return (inputs, expected, mask);
    }

    let addend_signed = params.lhs_signed;
    let (min, max) = type_range(out_bits, addend_signed);
    let (addend_min, addend_max) = if params.max_addend {
        (max - 20, max)
    } else {
        (min, min + 20)
    };
    let mut addend_rnd = Random::new(de_string_hash(params.seed));
    for _ in 0..params.addend_skip {
        addend_rnd.get_uint32();
    }
    let addends: Vec<i64> = (0..NUM_ELEMENTS)
        .map(|_| random_scalar(&mut addend_rnd, out_bits, addend_signed, addend_min, addend_max))
        .collect();
    inputs.push(to_bytes(&addends, out_bits));

    // `compareDotProductAccSat`: products of operands of the same sign and of opposite signs are summed apart, and a result that
    // cannot be represented in the addend type is not checked.
    let mut expected = Vec::new();
    let mut mask = Vec::new();
    let width = (out_bits / 8) as usize;
    for (idx, &addend) in addends.iter().enumerate() {
        let (mut pos_lhs, mut pos_rhs, mut neg_lhs, mut neg_rhs) = (Vec::new(), Vec::new(), Vec::new(), Vec::new());
        for elem in 0..aligned {
            let a = lhs[idx * aligned + elem];
            let b = rhs[idx * aligned + elem];
            if (a < 0) == (b < 0) {
                pos_lhs.push(a);
                pos_rhs.push(b);
            } else {
                neg_lhs.push(a);
                neg_rhs.push(b);
            }
        }
        let pos = dot_product(&pos_lhs, &pos_rhs);
        let neg = dot_product(&neg_lhs, &neg_rhs);
        let within = |value: i64| min <= value && value <= max;

        if within(pos) && within(neg) {
            let mut result = wrap(pos + neg, out_bits, addend_signed);
            if addend < 0 {
                result = if result < min - addend {
                    min
                } else {
                    wrap(result + addend, out_bits, addend_signed)
                };
            } else {
                result = if result > max - addend {
                    max
                } else {
                    wrap(result + addend, out_bits, addend_signed)
                };
            }
            expected.extend(to_bytes(&[result], out_bits));
            mask.extend(std::iter::repeat_n(0xffu8, width));
        } else {
            expected.extend(std::iter::repeat_n(0u8, width));
            mask.extend(std::iter::repeat_n(0u8, width));
        }
    }
    (inputs, expected, mask)
}

/// `addDotProductExtensionAndFeatures`
fn extensions_and_features(params: &Params<'_>) -> (Vec<String>, Vec<RequiredFeature>) {
    let mut extensions = vec!["VK_KHR_shader_integer_dot_product".to_string()];
    let mut features = vec![RequiredFeature::IntegerDotProduct];

    if (!params.packed && params.bits == 8) || params.out_bits == 8 {
        features.extend([RequiredFeature::ShaderInt8, RequiredFeature::StorageBuffer8BitAccess]);
        extensions.push("VK_KHR_8bit_storage".to_string());
    }

    if params.bits == 16 || params.out_bits == 16 {
        features.extend([
            RequiredFeature::ShaderInt16,
            RequiredFeature::StorageBuffer16BitAccess,
            RequiredFeature::UniformAndStorageBuffer16BitAccess,
        ]);
        extensions.push("VK_KHR_16bit_storage".to_string());
    }

    (extensions, features)
}

fn make_case(case: &DotProductCase, leaf: &str) -> Box<dyn TestCase> {
    let params = parse(case.spec);
    let (inputs, expected, mask) = build_io(&params);
    let (extensions, features) = extensions_and_features(&params);

    let spec = ComputeShaderSpec {
        inputs,
        outputs: vec![expected],
        output_masks: vec![mask],
        num_work_groups: [NUM_ELEMENTS as u32, 1, 1],
        extensions,
        features,
        fail_message: "Output doesn't match with expected",
        ..Default::default()
    };
    Box::new(SpvAsmComputeShaderCase {
        name: leaf.to_string(),
        spec,
        programs: case.programs,
    })
}

/// The six integer dot product groups of `spirv_assembly.instruction.compute` as the groups of their path below `compute` and the test case.
pub fn create_dot_product_cases() -> Vec<(Vec<&'static str>, Box<dyn TestCase>)> {
    ALL_DOT_PRODUCT_CASE
        .iter()
        .map(|case| {
            let mut segments: Vec<&'static str> = case.name.split('/').collect();
            let leaf = segments.pop().expect("a case name has a leaf");
            (segments, make_case(case, leaf))
        })
        .collect()
}

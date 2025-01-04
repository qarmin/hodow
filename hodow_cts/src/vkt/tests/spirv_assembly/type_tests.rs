// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmTypeTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2017 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The case tree of the `type` group is the mustpass list; the compute (`_comp`) cases run: their assembly is in
// `shaders/manifest/spirv_assembly_type.toml` (written by `scripts/gen_spirv_assembly_type_manifest.py`, which replays `createStageTests`) and the `spec` of a
// case says what is redone here: the data of `getDataset`, `combine` and the expected values (`TestMath`). The `de::Random` stream of a type group depends on the order of the
// `createTests` calls, so a spec carries the number of draws that precede its case. The `_vert` and `_frag` cases (`spirv_assembly_type_graphics.toml`) run through `graphics_shader_case.rs`; `_geom`, `_tessc` and `_tesse` (`spirv_assembly_type_{geom,tessc,tesse}.toml`) run through the same runner with the extra stages.

use std::collections::HashMap;

use super::compute_shader_case::{
    ComputeShaderSpec, RequiredFeature, SpvAsmComputeShaderCase, SpvAsmComputeShaderInstance, VerifyIo,
};
use super::graphics_shader_case::{SpvAsmGraphicsShaderCase, SpvAsmGraphicsShaderInstance};
use crate::generated::shaders::spirv_assembly_type::ALL_TYPE_COMP_CASE;
use crate::generated::shaders::spirv_assembly_type_geom::ALL_TYPE_GRAPHICS_CASE as ALL_TYPE_GEOM_CASE;
use crate::generated::shaders::spirv_assembly_type_graphics::ALL_TYPE_GRAPHICS_CASE;
use crate::generated::shaders::spirv_assembly_type_tessc::ALL_TYPE_GRAPHICS_CASE as ALL_TYPE_TESSC_CASE;
use crate::generated::shaders::spirv_assembly_type_tesse::ALL_TYPE_GRAPHICS_CASE as ALL_TYPE_TESSE_CASE;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome};
use crate::vk::programs::BinaryCollection;
use crate::vkt::gated::build_gated_groups_with;
use crate::vkt::{Context, TestCase, TestCaseGroup, TestInstance};

const CASE_NAMES: &str = include_str!("type_cases/cases.txt");

/// The `rust_type` of the manifest entries: one `_comp` case of the `type` group.
#[derive(Clone, Copy)]
pub struct TypeCompCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

/// The `rust_type` of the graphics manifest entries: one `_vert` or `_frag` case of the `type` group.
#[derive(Clone, Copy)]
pub struct TypeGraphicsCase {
    pub name: &'static str,
    pub spec: &'static str,
    pub programs: BinaryCollection,
}

#[derive(Clone, Copy)]
struct IntType {
    bits: u32,
    signed: bool,
}

impl IntType {
    fn mask(self) -> i128 {
        (1i128 << self.bits) - 1
    }

    fn wrap(self, value: i128) -> i128 {
        let mut result = value & self.mask();
        if self.signed && (result >> (self.bits - 1)) & 1 == 1 {
            result -= 1i128 << self.bits;
        }
        result
    }

    fn unsigned(self, value: i128) -> i128 {
        value & self.mask()
    }

    fn as_signed(self, value: i128) -> i128 {
        IntType {
            bits: self.bits,
            signed: true,
        }
        .wrap(value)
    }

    fn to_bytes(self, value: i128, out: &mut Vec<u8>) {
        let raw = self.unsigned(value) as u64;
        out.extend_from_slice(&raw.to_le_bytes()[..(self.bits / 8) as usize]);
    }
}

fn field_str<'a>(spec: &'a str, name: &str) -> &'a str {
    spec.split(';')
        .find_map(|part| part.strip_prefix(name).and_then(|rest| rest.strip_prefix('=')))
        .unwrap_or_else(|| panic!("the spec `{spec}` has no field `{name}`"))
}

fn field(spec: &str, name: &str) -> u64 {
    field_str(spec, name)
        .parse()
        .unwrap_or_else(|_| panic!("the field `{name}` of `{spec}` is not a number"))
}

fn type_of(name: &str) -> IntType {
    let bits = name[1..].parse().expect("a type name ends in its width");
    IntType {
        bits,
        signed: name.starts_with('i'),
    }
}

/// The switch cases `m_cases` of the type group.
fn switch_cases(name: &str) -> [i128; 3] {
    match name {
        "i8" => [-42, 73, 121],
        "i16" => [-3221, 3210, 19597],
        "i32" => [-3221, 3210, 268438669],
        "i64" => [3210, -268438669, 26843866939192872],
        "u8" => [0, 73, 193],
        "u16" => [0, 3210, 19597],
        "u32" => [0, 3210, 268438669],
        _ => [3210, 268438669, 26843866939192872],
    }
}

fn draw(rnd: &mut Random, ty: IntType) -> i128 {
    let raw = if ty.bits == 64 {
        i128::from(rnd.get_uint64())
    } else {
        i128::from(rnd.get_uint32()) & ty.mask()
    };
    ty.wrap(raw)
}

/// `getDataset`
fn get_dataset(name: &str, ty: IntType, rnd: &mut Random, num_elements: usize) -> Vec<i128> {
    let mut input = vec![0];
    if ty.signed {
        match ty.bits {
            32 => input.extend([-(1i128 << 31) + 1, (1i128 << 31) - 1]),
            64 => input.extend([ty.wrap(0xFFFF859A3BF78592), 0x7FFF859A3BF78592]),
            bits => input.extend([-(1i128 << (bits - 1)), (1i128 << (bits - 1)) - 1]),
        }
    } else {
        input.push(ty.mask());
    }
    input.extend(switch_cases(name));
    let random_count = num_elements - input.len();
    for _ in 0..random_count {
        let value = draw(rnd, ty);
        input.push(value);
    }
    input
}

/// `getConstituentIndex`
fn constituent_index(ndx: usize, vector_size: usize) -> usize {
    (ndx / vector_size) / (1 + (ndx % vector_size))
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum Filter {
    None,
    Zero,
    NegativesAndZero,
    SignedDiv,
    MinGtMax,
}

impl Filter {
    fn parse(name: &str) -> Self {
        match name {
            "zero" => Self::Zero,
            "negz" => Self::NegativesAndZero,
            "signed_div" => Self::SignedDiv,
            "min_gt_max" => Self::MinGtMax,
            _ => Self::None,
        }
    }

    fn accepts(self, ty: IntType, a: i128, b: i128) -> bool {
        match self {
            Self::None => true,
            Self::Zero => b != 0,
            Self::NegativesAndZero => !(a < 0 || b <= 0),
            Self::SignedDiv => !(b == 0 || (b == -1 && a == -(1i128 << (ty.bits - 1)))),
            Self::MinGtMax => a <= b,
        }
    }
}

fn arity(key: &str) -> usize {
    match key {
        "negate" | "abs" | "sign" | "not" | "lsb" | "msb" | "bitrev" | "bitcnt" | "const" => 1,
        "clamp" | "bfse" | "bfue" => 3,
        "bfi" => 4,
        _ => 2,
    }
}

fn bool_value(condition: bool) -> i128 {
    i128::from(condition)
}

/// The `TestMath` functions and their variants per type, on values held as the integers they stand for.
fn apply(key: &str, ty: IntType, a: &[i128]) -> i128 {
    let w = |value: i128| ty.wrap(value);
    let x = a[0];
    let y = a.get(1).copied().unwrap_or(0);
    match key {
        "negate" => w(-x),
        "add" => w(x + y),
        "sub" => w(x - y),
        "mul" => w(x.wrapping_mul(y)),
        "sdiv" | "udiv" => {
            if y == 0 {
                0
            } else {
                w(x / y)
            }
        }
        "srem" | "smod" | "umod" => {
            if y == 0 {
                0
            } else {
                w(x % y)
            }
        }
        "abs" => {
            if x >= 0 {
                x
            } else {
                w(-x)
            }
        }
        "sign" => x.signum(),
        "min" => {
            if y < x {
                y
            } else {
                x
            }
        }
        "max" => {
            if x < y {
                y
            } else {
                x
            }
        }
        "clamp" => {
            let lower_bounded = if x < y { y } else { x };
            let z = a[2];
            if z < lower_bounded { z } else { lower_bounded }
        }
        "lsb" => {
            let bits = ty.unsigned(x);
            (0..ty.bits).find(|i| (bits >> i) & 1 == 1).map_or(w(-1), i128::from)
        }
        "msb" => {
            let magnitude = if ty.signed && x < 0 { -x - 1 } else { x };
            if magnitude > 0 {
                i128::from(127 - magnitude.leading_zeros())
            } else if ty.signed {
                -1
            } else {
                w(-1)
            }
        }
        "mul_div" => {
            if y == 0 {
                0
            } else {
                w(w(x * y) / y)
            }
        }
        "lsr" => w(ty.unsigned(x) >> y),
        "asr" => w(ty.as_signed(x) >> y),
        "lsl" => w(x << y),
        "or" => w(x | y),
        "xor" => w(x ^ y),
        "and" => w(x & y),
        "not" => w(!x),
        "iequal" => bool_value(x == y),
        "inotequal" => bool_value(x != y),
        "ugreaterthan" => bool_value(ty.unsigned(x) > ty.unsigned(y)),
        "ulessthan" => bool_value(ty.unsigned(x) < ty.unsigned(y)),
        "ugreaterthanequal" => bool_value(ty.unsigned(x) >= ty.unsigned(y)),
        "ulessthanequal" => bool_value(ty.unsigned(x) <= ty.unsigned(y)),
        "sgreaterthan" => bool_value(ty.as_signed(x) > ty.as_signed(y)),
        "slessthan" => bool_value(ty.as_signed(x) < ty.as_signed(y)),
        "sgreaterthanequal" => bool_value(ty.as_signed(x) >= ty.as_signed(y)),
        "slessthanequal" => bool_value(ty.as_signed(x) <= ty.as_signed(y)),
        "bfi" => {
            let (insert, offset, count) = (y, a[2], a[3]);
            let mask = (1i128 << count) - 1;
            let base = ty.unsigned(x);
            w((base & !(mask << offset)) | ((ty.unsigned(insert) & mask) << offset))
        }
        "bfse" | "bfue" => {
            let (offset, count) = (y, a[2]);
            if count == 0 {
                return 0;
            }
            let mask = (1i128 << count) - 1;
            let field = (ty.unsigned(x) >> offset) & mask;
            if key == "bfse" && (field >> (count - 1)) & 1 == 1 {
                w(field | !mask)
            } else {
                w(field)
            }
        }
        "bitrev" => {
            let bits = ty.unsigned(x);
            let mut result = 0i128;
            for i in 0..ty.bits {
                result |= ((bits >> i) & 1) << (ty.bits - 1 - i);
            }
            w(result)
        }
        "bitcnt" => ty.unsigned(x).count_ones().into(),
        "const" => x,
        _ => panic!("unknown operation key `{key}`"),
    }
}

struct Combined {
    inputs: Vec<Vec<i128>>,
    outputs: Vec<i128>,
    num_elements: usize,
}

struct CaseParams {
    name: String,
    ty: IntType,
    vec: usize,
    key: String,
    filter: Filter,
    range: String,
    high: bool,
}

/// `combine`
fn combine(params: &CaseParams, data: &[i128], rnd: &mut Random) -> Combined {
    let ty = params.ty;
    let vec = params.vec;
    let n_in = arity(&params.key);
    let size_with_padding = if vec == 3 { 4 } else { vec };
    let datasize = data.len();
    let mut inputs: Vec<Vec<i128>> = vec![Vec::new(); n_in];
    let mut outputs: Vec<i128> = Vec::new();
    let mut pad_count = vec;

    let mut emit = |row: &[i128], inputs: &mut Vec<Vec<i128>>, outputs: &mut Vec<i128>| {
        for (input, value) in inputs.iter_mut().zip(row) {
            input.push(*value);
        }
        outputs.push(if params.high { 0 } else { apply(&params.key, ty, row) });
        if vec == 3 {
            pad_count -= 1;
            if pad_count == 0 {
                for input in inputs.iter_mut() {
                    input.push(0);
                }
                outputs.push(0);
                pad_count = vec;
            }
        }
    };

    let draw_offset_and_count = |rnd: &mut Random| {
        let offset = ty.wrap(i128::from(rnd.get_uint32() & (ty.bits - 1)));
        let mut count = ty.wrap(i128::from(rnd.get_uint32() & (ty.bits - 1)));
        if offset + count > i128::from(ty.bits) {
            count = i128::from(ty.bits) - offset;
        }
        (offset, count)
    };

    match n_in {
        1 => {
            for &x in data {
                emit(&[x], &mut inputs, &mut outputs);
            }
        }
        2 => {
            for &a in data {
                for &b in data {
                    if !params.filter.accepts(ty, a, b) {
                        continue;
                    }
                    let b = if params.range == "bit_width" {
                        b & i128::from(ty.bits - 1)
                    } else {
                        b
                    };
                    emit(&[a, b], &mut inputs, &mut outputs);
                }
            }
        }
        3 => {
            let sum_range = params.range == "bit_width_sum";
            let datasize2 = if sum_range { 4 * vec } else { datasize };
            let (mut bit_offset, mut bit_count) = (0i128, 0i128);
            for &a in data {
                for e2 in 0..datasize2 {
                    for e3 in 0..datasize2 {
                        if sum_range {
                            if e3 % vec == 0 {
                                (bit_offset, bit_count) = draw_offset_and_count(rnd);
                            }
                            if bit_offset + bit_count > i128::from(ty.bits) {
                                bit_count = i128::from(ty.bits) - bit_offset;
                            }
                            emit(&[a, bit_offset, bit_count], &mut inputs, &mut outputs);
                        } else if params.filter.accepts(ty, data[e2], data[e3]) {
                            emit(&[a, data[e2], data[e3]], &mut inputs, &mut outputs);
                        }
                    }
                }
            }
        }
        _ => {
            let datasize2 = 2 * vec;
            let (mut bit_offset, mut bit_count) = (0i128, 0i128);
            for &a in data {
                for e2 in 0..datasize2 {
                    for _ in 0..datasize2 {
                        for e4 in 0..datasize2 {
                            if e4 % vec == 0 {
                                (bit_offset, bit_count) = draw_offset_and_count(rnd);
                            }
                            if bit_offset + bit_count > i128::from(ty.bits) {
                                bit_count = i128::from(ty.bits) - bit_offset;
                            }
                            emit(&[a, data[e2], bit_offset, bit_count], &mut inputs, &mut outputs);
                        }
                    }
                }
            }
        }
    }

    while outputs.len() % size_with_padding != 0 {
        for input in inputs.iter_mut() {
            input.pop();
        }
        outputs.pop();
    }
    let num_elements = outputs.len() / size_with_padding;
    Combined {
        inputs,
        outputs,
        num_elements,
    }
}

fn encode(ty: IntType, values: &[i128]) -> Vec<u8> {
    let mut bytes = Vec::with_capacity(values.len() * (ty.bits / 8) as usize);
    for &value in values {
        ty.to_bytes(value, &mut bytes);
    }
    bytes
}

fn parse_params(case_name: &str, spec: &str) -> CaseParams {
    CaseParams {
        name: case_name.to_string(),
        ty: type_of(field_str(spec, "ty")),
        vec: field(spec, "vec") as usize,
        key: field_str(spec, "op").to_string(),
        filter: Filter::parse(field_str(spec, "filt")),
        range: field_str(spec, "rng").to_string(),
        high: field(spec, "hp") != 0,
    }
}

fn seeded(spec: &str) -> Random {
    let mut rnd = Random::new(field(spec, "seed") as u32);
    for _ in 0..field(spec, "skip") {
        rnd.get_uint32();
    }
    rnd
}

/// What `verifyResult` compares: every element but the padding of the three component vectors.
fn verify_elements(element_size: usize, pad_vec3: bool, outputs: &[Vec<u8>], expected_outputs: &[Vec<u8>]) -> bool {
    let (Some(obtained), Some(expected)) = (outputs.first(), expected_outputs.first()) else {
        return false;
    };
    if obtained.len() < expected.len() {
        return false;
    }
    expected
        .chunks_exact(element_size)
        .zip(obtained.chunks_exact(element_size))
        .enumerate()
        .all(|(index, (want, got))| (pad_vec3 && (index + 1) % 4 == 0) || want == got)
}

fn verify_default<const SIZE: usize>(_: &[Vec<u8>], outputs: &[Vec<u8>], expected_outputs: &[Vec<u8>]) -> bool {
    verify_elements(SIZE, false, outputs, expected_outputs)
}

fn verify_vec3<const SIZE: usize>(_: &[Vec<u8>], outputs: &[Vec<u8>], expected_outputs: &[Vec<u8>]) -> bool {
    verify_elements(SIZE, true, outputs, expected_outputs)
}

/// `verifyComputeSwitchResult`
fn verify_switch(_: &[Vec<u8>], outputs: &[Vec<u8>], expected_outputs: &[Vec<u8>]) -> bool {
    match (outputs.first(), expected_outputs.first()) {
        (Some(obtained), Some(expected)) => {
            obtained.len() >= 4 && expected.len() >= 4 && obtained[..4] == expected[..4]
        }
        _ => false,
    }
}

fn verifier(ty: IntType, vec: usize) -> VerifyIo {
    match (ty.bits, vec == 3) {
        (8, false) => verify_default::<1>,
        (16, false) => verify_default::<2>,
        (32, false) => verify_default::<4>,
        (64, false) => verify_default::<8>,
        (8, true) => verify_vec3::<1>,
        (16, true) => verify_vec3::<2>,
        (32, true) => verify_vec3::<4>,
        _ => verify_vec3::<8>,
    }
}

fn has_width(spec: &str, width: u64) -> bool {
    field(spec, "w1") == width || field(spec, "w2") == width
}

/// The requirements of a case (`createStageTests`/`createSwitchTests`), without the data.
fn make_requirements(spec: &str) -> ComputeShaderSpec {
    let ty = type_of(field_str(spec, "ty"));
    let is_switch = spec.starts_with("switch=");
    let vec = field(spec, "vec");
    let op = if is_switch { "" } else { field_str(spec, "op") };
    let mut features = Vec::new();
    let mut extensions = Vec::new();

    let (has8, has16, has64) = if is_switch {
        (false, false, false)
    } else {
        (has_width(spec, 8), has_width(spec, 16), has_width(spec, 64))
    };
    if ty.bits == 16 || has16 {
        features.push(RequiredFeature::ShaderInt16);
    }
    if ty.bits == 64 || has64 {
        features.push(RequiredFeature::ShaderInt64);
    }
    if ty.bits == 8 || has8 {
        features.push(RequiredFeature::ShaderInt8);
    }
    if ty.bits == 8 {
        features.push(RequiredFeature::UniformAndStorageBuffer8BitAccess);
    }
    if ty.bits == 16 {
        features.push(RequiredFeature::UniformAndStorageBuffer16BitAccess);
    }
    let long_vector = !is_switch && field(spec, "vg") == 1 && (vec == 1 || vec > 4);
    if long_vector {
        features.push(RequiredFeature::LongVector);
        extensions.push("VK_EXT_shader_long_vector".to_string());
    }
    if matches!(op, "bitrev" | "bitcnt" | "bfi" | "bfse" | "bfue") && ty.bits != 32 {
        extensions.push("VK_KHR_maintenance9".to_string());
    }

    ComputeShaderSpec {
        features,
        extensions,
        ..Default::default()
    }
}

/// Everything the runner needs that depends on the data.
fn make_spec(case_name: &str, spec: &str, graphics: bool) -> ComputeShaderSpec {
    let mut result = make_requirements(spec);
    let ty = type_of(field_str(spec, "ty"));
    let mut rnd = seeded(spec);

    if spec.starts_with("switch=") {
        let name = field_str(spec, "ty");
        let cases = switch_cases(name);
        let data = get_dataset(name, ty, &mut rnd, 10);
        let outputs: Vec<i128> = data
            .iter()
            .map(|&value| {
                if value == cases[0] {
                    100
                } else if value == cases[1] {
                    110
                } else if value == cases[2] {
                    120
                } else {
                    10
                }
            })
            .collect();
        result.inputs = vec![encode(ty, &data), encode(ty, &outputs)];
        if !graphics {
            result.outputs = vec![1i32.to_le_bytes().to_vec()];
            result.verify_io = Some(verify_switch);
        }
        return result;
    }

    let params = parse_params(case_name, spec);
    let vec = params.vec;
    let data = if params.key == "const" {
        let input = get_dataset(field_str(spec, "ty"), ty, &mut rnd, 10);
        if matches!(field_str(spec, "spv"), "OpConstant" | "OpSpecConstant") {
            input
        } else {
            (0..input.len() * vec)
                .map(|ndx| input[constituent_index(ndx, vec)])
                .collect()
        }
    } else {
        let size = if vec <= 4 { 10 * vec } else { 60 };
        get_dataset(field_str(spec, "ty"), ty, &mut rnd, size)
    };
    let combined = combine(&params, &data, &mut rnd);
    debug_assert_eq!(
        combined.num_elements as u64,
        field(spec, "n"),
        "{}: the element count differs from the generator's",
        params.name
    );
    result.inputs = combined.inputs.iter().map(|input| encode(ty, input)).collect();
    result.outputs = vec![encode(ty, &combined.outputs)];
    result.verify_io = Some(verifier(ty, vec));
    result
}

/// A case of the group: the data is made when the case runs, not when it is registered.
struct TypeCompTestCase {
    name: String,
    spec: &'static str,
    inner: SpvAsmComputeShaderCase,
}

impl TestCase for TypeCompTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TypeCompInstance {
            context,
            spec: make_spec(&self.name, self.spec, false),
        })
    }
}

struct TypeCompInstance<'a> {
    context: &'a Context<'a>,
    spec: ComputeShaderSpec,
}

impl TestInstance for TypeCompInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        SpvAsmComputeShaderInstance {
            context: self.context,
            spec: &self.spec,
        }
        .iterate()
    }
}

fn make_case(case: &TypeCompCase) -> Box<dyn TestCase> {
    let leaf = case.name.rsplit('/').next().expect("a case name has a leaf");
    Box::new(TypeCompTestCase {
        name: leaf.to_string(),
        spec: case.spec,
        inner: SpvAsmComputeShaderCase {
            name: leaf.to_string(),
            spec: make_requirements(case.spec),
            programs: case.programs,
        },
    })
}

/// A `_vert` or `_frag` case: `createTestForStage` with the default vertex plus fragment pipeline.
struct TypeGraphicsTestCase {
    name: String,
    spec: &'static str,
    inner: SpvAsmGraphicsShaderCase,
}

impl TestCase for TypeGraphicsTestCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn check_support(&self, context: &Context<'_>) -> Result<(), TestError> {
        self.inner.check_support(context)
    }

    fn programs(&self) -> BinaryCollection {
        self.inner.programs
    }

    fn create_instance<'a>(&'a self, context: &'a Context<'a>) -> Box<dyn TestInstance + 'a> {
        Box::new(TypeGraphicsInstance {
            context,
            spec: make_spec(&self.name, self.spec, true),
        })
    }
}

struct TypeGraphicsInstance<'a> {
    context: &'a Context<'a>,
    spec: ComputeShaderSpec,
}

impl TestInstance for TypeGraphicsInstance<'_> {
    fn iterate(&mut self) -> TestOutcome {
        SpvAsmGraphicsShaderInstance {
            context: self.context,
            spec: &self.spec,
        }
        .iterate()
    }
}

fn make_graphics_case(case: &TypeGraphicsCase) -> Box<dyn TestCase> {
    let leaf = case.name.rsplit('/').next().expect("a case name has a leaf");
    Box::new(TypeGraphicsTestCase {
        name: leaf.to_string(),
        spec: case.spec,
        inner: SpvAsmGraphicsShaderCase {
            name: leaf.to_string(),
            spec: make_requirements(case.spec),
            programs: case.programs,
        },
    })
}

/// The `type` group of `spirv_assembly`: every stage of every case runs.
pub fn create_type_tests() -> TestCaseGroup {
    let mut ported: HashMap<String, Box<dyn TestCase>> = ALL_TYPE_COMP_CASE
        .iter()
        .map(|case| (case.name.replace('/', "."), make_case(case)))
        .chain(
            ALL_TYPE_GRAPHICS_CASE
                .iter()
                .chain(ALL_TYPE_GEOM_CASE.iter())
                .chain(ALL_TYPE_TESSC_CASE.iter())
                .chain(ALL_TYPE_TESSE_CASE.iter())
                .map(|case| (case.name.replace('/', "."), make_graphics_case(case))),
        )
        .collect();
    let mut group = TestCaseGroup::new("type");
    for child in build_gated_groups_with(
        CASE_NAMES,
        &[],
        "the SPIR-V assembly type tests of this stage",
        &mut |path| ported.remove(path),
    ) {
        group.add_child(child);
    }
    group
}

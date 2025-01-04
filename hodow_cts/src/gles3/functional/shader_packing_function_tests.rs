// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderPackingFunctionTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A fourth `shaders.builtin_functions` subgroup (`pack_unpack`, 20 gles3 cases; gles31's
// own separate copy of this file adds the ES-3.1-only `*4x8` family and re-registers the
// same six functions here over its own new shader stages - see that module's own header
// for exactly how). Unlike `precision`/`common`/`integer`, `ShaderPackingFunctionTests::init`
// registers every case *directly* on the `pack_unpack` group itself, with no per-function
// sub-group at all - confirmed against the real mustpass, whose names are flat
// (`pack_unpack.packsnorm2x16_highp_vertex`, not `pack_unpack.packsnorm2x16.highp_vertex`).
//
// Six functions, three shapes:
// - `packSnorm2x16`/`packUnorm2x16` (`PackCase` below): a precision-qualified `vec2` in,
//   a `highp uint` out, quantised into two 16-bit fields. Reference/compare are shared
//   (`pack_reference_lane`/`compare_pack`, parameterised by `PackKind`/lane width/count),
//   but *input generation* is not - each function's own special-case values and random
//   ranges are hand-copied from its own C++ literals rather than derived, since they
//   genuinely differ (`packUnorm2x16`'s own "mostly in range" random draw is `rnd.getFloat()
//   * 1.25`, no offset, while `packSnorm2x16`'s is `* 2.5 - 1.25`).
// - `unpackSnorm2x16`/`unpackUnorm2x16` (`UnpackCase` below): the reverse direction. Both
//   this file's `unpack*` functions share *exactly* the same input generation (the same 5
//   special `uint32` words plus 95 random ones) - confirmed by reading all of them; only
//   the per-lane reference (sign-extend-and-scale for snorm, plain-scale for unorm) differs.
// - `packHalf2x16`/`unpackHalf2x16` (`PackHalf2x16Case`/`UnpackHalf2x16Case`): fp16 bit
//   manipulation, no quantisation - `tcu::Float16` (already ported, see
//   `gles3::functional::shader_common_function_tests`'s own de-risking note) is exactly
//   what upstream itself uses here.

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::tcu::float::{Float16, Float32};
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};

fn stage_name_postfix(stage: ShaderType) -> &'static str {
    match stage {
        ShaderType::Vertex => "vertex",
        ShaderType::Fragment => "fragment",
        ShaderType::Geometry => "geometry",
        ShaderType::TessControl => "tess_control",
        ShaderType::TessEvaluation => "tess_eval",
        ShaderType::Compute => "compute",
    }
}

const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

fn u32s_to_bytes(values: &[u32]) -> Vec<u8> {
    let mut out = Vec::with_capacity(values.len() * 4);
    for v in values {
        out.extend_from_slice(&v.to_ne_bytes());
    }
    out
}

fn f32s_to_bytes(values: &[f32]) -> Vec<u8> {
    let mut out = Vec::with_capacity(values.len() * 4);
    for v in values {
        out.extend_from_slice(&v.to_ne_bytes());
    }
    out
}

fn u32s_from_bytes(bytes: &[u8]) -> Vec<u32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| u32::from_ne_bytes(*c)).collect()
}

fn floats_from_bytes(bytes: &[u8]) -> Vec<f32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| f32::from_ne_bytes(*c)).collect()
}

/// `getUlpDiff`
fn ulp_diff(a: f32, b: f32) -> u32 {
    a.to_bits().abs_diff(b.to_bits())
}

/// `deRoundFloatToInt32`
fn de_round_float_to_i32(x: f32) -> i32 {
    if x >= 0.0 { (x + 0.5) as i32 } else { (x - 0.5) as i32 }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum PackKind {
    Snorm,
    Unorm,
}

/// `PackSnorm2x16Case`/`PackUnorm2x16Case`'s own per-lane quantisation, shared: clamp to
/// the kind's own range, scale by `2^(width-1)-1` (snorm, symmetric) or `2^width-1`
/// (unorm), round half-away-from-zero, clamp to the integer range, keep the low `width`
/// bits.
fn pack_reference_lane(kind: PackKind, width: u32, value: f32) -> u32 {
    let rounded = match kind {
        PackKind::Snorm => {
            let scale = ((1i64 << (width - 1)) - 1) as f32;
            let rmin = -(1i32 << (width - 1));
            let rmax = (1i32 << (width - 1)) - 1;
            de_round_float_to_i32(value.clamp(-1.0, 1.0) * scale).clamp(rmin, rmax)
        }
        PackKind::Unorm => {
            let scale = ((1i64 << width) - 1) as f32;
            let rmax = (1i32 << width) - 1;
            de_round_float_to_i32(value.clamp(0.0, 1.0) * scale).clamp(0, rmax)
        }
    };
    (rounded as u32) & ((1u32 << width) - 1)
}

fn compare_pack(kind: PackKind, width: u32, max_diff: u32, values: &[f32], res: u32) -> bool {
    let lane_mask = (1u32 << width) - 1;
    values.iter().enumerate().all(|(i, &v)| {
        let reference = pack_reference_lane(kind, width, v);
        let out = (res >> (i as u32 * width)) & lane_mask;
        reference.abs_diff(out) <= max_diff
    })
}

fn pack_max_diff(kind: PackKind, width: u32, precision: Precision) -> u32 {
    match (kind, width, precision) {
        (PackKind::Snorm, 16, Precision::HighP) => 1,
        (PackKind::Snorm, 16, Precision::MediumP) => 33,
        (PackKind::Snorm, 16, Precision::LowP) => 129,
        (PackKind::Unorm, 16, Precision::HighP) => 1,
        (PackKind::Unorm, 16, Precision::MediumP) => 65,
        (PackKind::Unorm, 16, Precision::LowP) => 257,
        _ => unreachable!("gles3 pack_unpack only has the 2x16 family"),
    }
}

fn pack_glsl_name(kind: PackKind, width: u32) -> String {
    format!(
        "pack{}2x{}",
        if kind == PackKind::Snorm { "Snorm" } else { "Unorm" },
        width
    )
}

fn pack_case_name_prefix(kind: PackKind, width: u32) -> String {
    format!(
        "pack{}2x{}",
        if kind == PackKind::Snorm { "snorm" } else { "unorm" },
        width
    )
}

/// `PackSnorm2x16Case::getInputValues`/`PackUnorm2x16Case::getInputValues` - each
/// function's own special values and "mostly in range"/"large random" literal ranges,
/// hand-copied rather than derived (see this file's own header for why).
fn generate_pack2x16_inputs(kind: PackKind, seed: u32) -> Vec<f32> {
    let mut rnd = Random::new(seed);
    let specials: &[[f32; 2]] = match kind {
        PackKind::Snorm => &[[0.0, 0.0], [-1.0, 1.0], [0.5, -0.5], [-1.5, 1.5], [0.25, -0.75]],
        PackKind::Unorm => &[[0.0, 0.0], [0.5, 1.0], [1.0, 0.5], [-0.5, 1.5], [0.25, 0.75]],
    };
    let mut values: Vec<[f32; 2]> = specials.to_vec();
    match kind {
        PackKind::Snorm => {
            for _ in 0..15 {
                values.push([rnd.get_float() * 2.5 - 1.25, rnd.get_float() * 2.5 - 1.25]);
            }
            for _ in 0..80 {
                values.push([rnd.get_float() * 1e6 - 0.5e6, rnd.get_float() * 1e6 - 0.5e6]);
            }
        }
        PackKind::Unorm => {
            for _ in 0..15 {
                values.push([rnd.get_float() * 1.25, rnd.get_float() * 1.25]);
            }
            for _ in 0..80 {
                values.push([rnd.get_float() * 1e6 - 1e5, rnd.get_float() * 1e6 - 1e5]);
            }
        }
    }
    values.into_iter().flatten().collect()
}

struct PackCase {
    name: String,
    kind: PackKind,
    width: u32,
    lanes: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for PackCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.lanes as usize;
        let vec_ty = glu::get_data_type_float_vec(self.lanes);
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(vec_ty, Some(self.precision))));
        spec.outputs.push(Symbol::new(
            "out0",
            VarType::basic(DataType::Uint, Some(Precision::HighP)),
        ));
        spec.source = format!("out0 = {}(in0);", pack_glsl_name(self.kind, self.width));
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x0077_6002;
        let values = generate_pack2x16_inputs(self.kind, seed);
        let num_values = values.len() / lanes;
        let in0 = f32s_to_bytes(&values);
        let mut out0 = vec![0u8; num_values * 4];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }

        let out0_u = u32s_from_bytes(&out0);
        let max_diff = pack_max_diff(self.kind, self.width, self.precision);
        let num_failed = (0..num_values)
            .filter(|&i| {
                !compare_pack(
                    self.kind,
                    self.width,
                    max_diff,
                    &values[i * lanes..(i + 1) * lanes],
                    out0_u[i],
                )
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {num_values} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `UnpackSnorm2x16Case`/`UnpackUnorm2x16Case`'s own per-lane reference: for `Snorm`,
/// sign-extend the `width`-bit field before scaling (and clamp, matching upstream's own
/// clamp on the division result); for `Unorm`, a plain unsigned scale.
fn unpack_reference_lane(kind: PackKind, width: u32, bits: u32) -> f32 {
    match kind {
        PackKind::Snorm => {
            let shift = 32 - width;
            let signed = ((bits << shift) as i32) >> shift;
            let scale = ((1i64 << (width - 1)) - 1) as f32;
            (signed as f32 / scale).clamp(-1.0, 1.0)
        }
        PackKind::Unorm => {
            let scale = ((1i64 << width) - 1) as f32;
            bits as f32 / scale
        }
    }
}

fn compare_unpack(kind: PackKind, width: u32, max_diff: u32, input: u32, outputs: &[f32]) -> bool {
    let lane_mask = (1u32 << width) - 1;
    outputs.iter().enumerate().all(|(i, &out)| {
        let bits = (input >> (i as u32 * width)) & lane_mask;
        let reference = unpack_reference_lane(kind, width, bits);
        ulp_diff(reference, out) <= max_diff
    })
}

fn unpack_glsl_name(kind: PackKind, width: u32) -> String {
    format!(
        "unpack{}2x{}",
        if kind == PackKind::Snorm { "Snorm" } else { "Unorm" },
        width
    )
}

fn unpack_case_name_prefix(kind: PackKind, width: u32) -> String {
    format!(
        "unpack{}2x{}",
        if kind == PackKind::Snorm { "snorm" } else { "unorm" },
        width
    )
}

/// `UnpackSnorm2x16Case`/`UnpackUnorm2x16Case::getInputValues` - identical between the
/// two (and, per this file's own header, the same shape gles31's `*4x8` unpack functions
/// use too): 5 fixed special words, 95 random ones.
fn generate_unpack_inputs(seed: u32) -> Vec<u32> {
    let mut rnd = Random::new(seed);
    let mut inputs = vec![0x0000_0000u32, 0x7fff_8000, 0x8000_7fff, 0xffff_ffff, 0x0001_fffe];
    for _ in 0..95 {
        inputs.push(rnd.get_uint32());
    }
    inputs
}

struct UnpackCase {
    name: String,
    kind: PackKind,
    width: u32,
    lanes: i32,
    stage: ShaderType,
}

impl TestCase for UnpackCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.lanes as usize;
        let vec_ty = glu::get_data_type_float_vec(self.lanes);
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
        spec.inputs.push(Symbol::new(
            "in0",
            VarType::basic(DataType::Uint, Some(Precision::HighP)),
        ));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(vec_ty, Some(Precision::HighP))));
        spec.source = format!("out0 = {}(in0);", unpack_glsl_name(self.kind, self.width));
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        // Every one of this file's `unpack*` cases hashes the same constant into its own
        // name-derived seed (`0x776002`, matching upstream's own literal in every case).
        let seed = de_string_hash(&self.name) ^ 0x0077_6002;
        let inputs = generate_unpack_inputs(seed);
        let num_values = inputs.len();
        let in0 = u32s_to_bytes(&inputs);
        let mut out0 = vec![0u8; num_values * lanes * 4];
        {
            let ins: [&[u8]; 1] = [&in0];
            let mut outs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(num_values as i32, &ins, &mut outs)?;
        }

        let out0_f = floats_from_bytes(&out0);
        let max_diff = 1u32;
        let num_failed = (0..num_values)
            .filter(|&i| {
                !compare_unpack(
                    self.kind,
                    self.width,
                    max_diff,
                    inputs[i],
                    &out0_f[i * lanes..(i + 1) * lanes],
                )
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {num_values} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `PackHalf2x16Case`
struct PackHalf2x16Case {
    name: String,
    stage: ShaderType,
}

fn generate_pack_half_inputs(seed: u32) -> Vec<[f32; 2]> {
    let mut rnd = Random::new(seed);
    let mut values: Vec<[f32; 2]> = vec![[0.0, 0.0], [0.5, 1.0], [1.0, 0.5], [-0.5, 1.5], [0.25, 0.75]];
    let (min_exp, max_exp) = (-14, 15);
    for _ in 0..95 {
        let mut v = [0.0f32; 2];
        for c in v.iter_mut() {
            let s = if rnd.get_bool() { 1 } else { -1 };
            let exp = rnd.get_int(min_exp, max_exp);
            let mantissa = rnd.get_uint32() & ((1 << 23) - 1);
            *c = Float32::construct(s, if exp != 0 { exp } else { 1 }, (1u32 << 23) | mantissa).as_float();
        }
        values.push(v);
    }
    // Round-trip through fp16 so the reference (computed at full f32 precision) cannot
    // disagree with what the shader's own mediump storage actually received.
    for v in &mut values {
        v[0] = Float16::new(v[0]).as_float();
        v[1] = Float16::new(v[1]).as_float();
    }
    values
}

fn compare_pack_half(values: [f32; 2], res: u32) -> bool {
    let ref0 = u32::from(Float16::new(values[0]).bits());
    let ref1 = u32::from(Float16::new(values[1]).bits());
    let res0 = res & 0xffff;
    let res1 = res >> 16;
    ref0.abs_diff(res0) == 0 && ref1.abs_diff(res1) == 0
}

impl TestCase for PackHalf2x16Case {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
        spec.inputs.push(Symbol::new(
            "in0",
            VarType::basic(DataType::FloatVec2, Some(Precision::HighP)),
        ));
        spec.outputs.push(Symbol::new(
            "out0",
            VarType::basic(DataType::Uint, Some(Precision::HighP)),
        ));
        spec.source = "out0 = packHalf2x16(in0);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x0077_6002;
        let values = generate_pack_half_inputs(seed);
        let num_values = values.len();
        let flat: Vec<f32> = values.iter().flatten().copied().collect();
        let in0 = f32s_to_bytes(&flat);
        let mut out0 = vec![0u8; num_values * 4];
        {
            let ins: [&[u8]; 1] = [&in0];
            let mut outs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(num_values as i32, &ins, &mut outs)?;
        }

        let out0_u = u32s_from_bytes(&out0);
        let num_failed = (0..num_values)
            .filter(|&i| !compare_pack_half(values[i], out0_u[i]))
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {num_values} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `UnpackHalf2x16Case`
struct UnpackHalf2x16Case {
    name: String,
    stage: ShaderType,
}

fn generate_unpack_half_inputs(seed: u32) -> Vec<u32> {
    let mut rnd = Random::new(seed);
    let mut inputs = vec![
        (u32::from(Float16::new(0.0).bits()) << 16) | u32::from(Float16::new(1.0).bits()),
        (u32::from(Float16::new(1.0).bits()) << 16) | u32::from(Float16::new(0.0).bits()),
        (u32::from(Float16::new(-1.0).bits()) << 16) | u32::from(Float16::new(0.5).bits()),
        (u32::from(Float16::new(0.5).bits()) << 16) | u32::from(Float16::new(-0.5).bits()),
    ];
    let (min_exp, max_exp, mant_bits) = (-14, 15, 10u32);
    for _ in 0..96 {
        let mut in_val = 0u32;
        for c in 0..2 {
            let s = if rnd.get_bool() { 1 } else { -1 };
            let exp = rnd.get_int(min_exp, max_exp);
            let mantissa = rnd.get_uint32() & ((1u32 << mant_bits) - 1);
            let value = u32::from(
                Float16::construct(
                    s,
                    if exp != 0 { exp } else { 1 },
                    ((1u32 << mant_bits) | mantissa) as u16,
                )
                .bits(),
            );
            in_val |= value << (16 * c);
        }
        inputs.push(in_val);
    }
    inputs
}

fn compare_unpack_half(input: u32, outputs: [f32; 2]) -> bool {
    let in0 = (input & 0xffff) as u16;
    let in1 = (input >> 16) as u16;
    let ref0 = Float16::from_bits(in0).as_float();
    let ref1 = Float16::from_bits(in1).as_float();
    ref0.to_bits() == outputs[0].to_bits() && ref1.to_bits() == outputs[1].to_bits()
}

impl TestCase for UnpackHalf2x16Case {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
        spec.inputs.push(Symbol::new(
            "in0",
            VarType::basic(DataType::Uint, Some(Precision::HighP)),
        ));
        spec.outputs.push(Symbol::new(
            "out0",
            VarType::basic(DataType::FloatVec2, Some(Precision::MediumP)),
        ));
        spec.source = "out0 = unpackHalf2x16(in0);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x0077_6002;
        let inputs = generate_unpack_half_inputs(seed);
        let num_values = inputs.len();
        let in0 = u32s_to_bytes(&inputs);
        let mut out0 = vec![0u8; num_values * 2 * 4];
        {
            let ins: [&[u8]; 1] = [&in0];
            let mut outs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(num_values as i32, &ins, &mut outs)?;
        }

        let out0_f = floats_from_bytes(&out0);
        let num_failed = (0..num_values)
            .filter(|&i| !compare_unpack_half(inputs[i], [out0_f[i * 2], out0_f[i * 2 + 1]]))
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {num_values} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn case_name(prefix: &str, precision: Option<Precision>, stage: ShaderType) -> String {
    match precision {
        Some(p) => format!("{prefix}_{}_{}", p.name(), stage_name_postfix(stage)),
        None => format!("{prefix}_{}", stage_name_postfix(stage)),
    }
}

/// `ShaderPackingFunctionTests::init` - every case is added directly to the group, no
/// per-function sub-group (see this file's own header).
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("pack_unpack");
    let stages = [ShaderType::Vertex, ShaderType::Fragment];

    for &(kind, width, lanes) in &[(PackKind::Snorm, 16u32, 2i32), (PackKind::Unorm, 16u32, 2i32)] {
        let prefix = pack_case_name_prefix(kind, width);
        for &precision in &PRECISIONS {
            for &stage in &stages {
                group.add_child(Box::new(PackCase {
                    name: case_name(&prefix, Some(precision), stage),
                    kind,
                    width,
                    lanes,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
        let unprefix = unpack_case_name_prefix(kind, width);
        for &stage in &stages {
            group.add_child(Box::new(UnpackCase {
                name: case_name(&unprefix, None, stage),
                kind,
                width,
                lanes,
                stage,
            }) as Box<dyn TestCase>);
        }
    }

    for &stage in &stages {
        group.add_child(Box::new(PackHalf2x16Case {
            name: case_name("packhalf2x16", None, stage),
            stage,
        }) as Box<dyn TestCase>);
    }
    for &stage in &stages {
        group.add_child(Box::new(UnpackHalf2x16Case {
            name: case_name("unpackhalf2x16", None, stage),
            stage,
        }) as Box<dyn TestCase>);
    }

    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn registers_every_expected_case_name() {
        let group = create_tests();
        let flat = crate::tcu::flatten(group);
        let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
        names.sort();
        // packsnorm2x16/packunorm2x16: 3 precisions x 2 stages, each. unpacksnorm2x16/
        // unpackunorm2x16/packhalf2x16/unpackhalf2x16: 2 stages, each, no precision axis.
        let expected = 2 * (3 * 2) + 4 * 2;
        assert_eq!(expected, 20);
        assert_eq!(names.len(), expected);
        assert!(names.contains(&"pack_unpack.packsnorm2x16_highp_vertex".to_string()));
        assert!(names.contains(&"pack_unpack.packunorm2x16_lowp_fragment".to_string()));
        assert!(names.contains(&"pack_unpack.unpacksnorm2x16_vertex".to_string()));
        assert!(names.contains(&"pack_unpack.unpackunorm2x16_fragment".to_string()));
        assert!(names.contains(&"pack_unpack.packhalf2x16_vertex".to_string()));
        assert!(names.contains(&"pack_unpack.unpackhalf2x16_fragment".to_string()));
    }

    #[test]
    fn pack_reference_matches_known_values() {
        // packSnorm2x16(-1, 1): both lanes saturate to the extreme 16-bit snorm values.
        assert_eq!(pack_reference_lane(PackKind::Snorm, 16, -1.0), 0x8001);
        assert_eq!(pack_reference_lane(PackKind::Snorm, 16, 1.0), 0x7fff);
        assert_eq!(pack_reference_lane(PackKind::Snorm, 16, 0.0), 0x0000);
        // packUnorm2x16(1.0) saturates to the maximum 16-bit unorm value.
        assert_eq!(pack_reference_lane(PackKind::Unorm, 16, 1.0), 0xffff);
        assert_eq!(pack_reference_lane(PackKind::Unorm, 16, 0.0), 0x0000);
    }

    #[test]
    fn unpack_reference_matches_known_values() {
        assert_eq!(unpack_reference_lane(PackKind::Snorm, 16, 0x7fff), 1.0);
        assert_eq!(unpack_reference_lane(PackKind::Snorm, 16, 0x8001), -1.0);
        assert_eq!(unpack_reference_lane(PackKind::Unorm, 16, 0xffff), 1.0);
        assert_eq!(unpack_reference_lane(PackKind::Unorm, 16, 0x0000), 0.0);
    }
}

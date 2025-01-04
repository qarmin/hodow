// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderCommonFunctionTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `es31fShaderCommonFunctionTests.cpp` is genuinely its own file upstream - unlike
// `glsBuiltinPrecisionTests.cpp` (shared between `gles3`/`gles31` via a thin per-API
// wrapper), it duplicates almost all of `es3fShaderCommonFunctionTests.cpp`'s own
// helpers/case classes verbatim (confirmed by diffing the two upstream files directly:
// `Floor`/`Trunc`/`Round`/`Ceil`/`Fract`/`Modf`/`FloatBitsToInt`/`FloatBitsToUint`/
// `BitsToFloat`/`Abs`/`Sign`/`RoundEven` are byte-identical between the two), so this
// module is a *duplicate* of `gles3::functional::shader_common_function_tests`'s own
// logic for those, not a shared-framework wrapper - matching upstream's own choice not
// to factor it out either.
//
// Two real differences from the `gles3` file:
// - **Six shader stages, not two, and a different subset per function.** `addFunctionCases`
//   here takes an explicit `shaderBits` mask; every function bar `Frexp`/`Ldexp`/`Fma` uses
//   `NEW_SHADERS` (`TessControl`/`TessEvaluation`/`Geometry`/`Compute` - deliberately
//   *not* `Vertex`/`Fragment`, since those six stages minus the four ES-3.1-only ones are
//   already covered by the `gles3` root's own `Vertex`/`Fragment` cases). `Frexp`/`Ldexp`/
//   `Fma` use `ALL_SHADERS` (all six, since they have no ES3 equivalent at all).
// - **`Isnan`/`Isinf`'s own `compare` is not the `gles3` file's "either 0 or 1" shape.**
//   `Isnan` at mediump/lowp checks a *reference* (`Float32(in0).isNaN()`) but only
//   one-sided ("NaN support is optional, check that inputs that are not NaN don't result
//   in true"); `Isinf` at mediump does the same but against `Float16(in0).isInf()`
//   (mediump storage can genuinely overflow to infinity even when the host `f32` is
//   finite) and at *lowp* performs **no check at all** ("no verification can be
//   performed") - `compare_isinf`'s lowp arm is a bare `true`, not the `gles3` file's
//   "either 0 or 1" assertion, because upstream's own `else` branch here is empty.
//
// `Float16`/`Float32` (`crate::tcu::float`) and the round-to-even `roundEven`/`frac`
// helpers were already de-risked with their own unit tests when the `gles3` module was
// written; nothing new to de-risk here.
//
// `Frexp`/`Ldexp`/`Fma` (`ALL_SHADERS`) each need their own new piece:
// - `Frexp`/`Ldexp` are exact bit manipulation (this file's own local `frexp`/`ldexp` static
//   functions, ~1726-1755 of the upstream `.cpp`), built from `tcu::Float32::construct`/
//   `constructBits`/`exponent`/`mantissa`/`mantissaBits` - a *different*, exact/ULP-threshold
//   pair from `gls::builtin_precision_tests`'s own interval-valued `FrExp`/`LdExp` (which
//   share only the name, not the formula).
// - `Fma` needs the interval-arithmetic framework (`tcu::Interval`/`tcu::FloatFormat`,
//   already ported for `gls::builtin_precision_tests`) - its own local `fma()` static
//   function builds its `FloatFormat` table from the exact same four numeric triples as
//   `gls::builtin_precision_tests::precision_format`, reused here rather than re-typed.
//   Also needs the GLSL-3.20-vs-`GL_EXT_gpu_shader5` extension gate `gls::
//   builtin_precision_tests::TernaryOp::Fma` already solved once (ported the
//   version-conditional shape directly from this file's own `FmaCase` constructor/`init`,
//   since - unlike that reused solution - upstream's `FmaCase` only adds the pragma/gate
//   when the context does *not* already support ES 3.2).

use crate::gls::builtin_precision_tests::precision_format;
use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::tcu::float::{Float16, Float32};
use crate::tcu::float_format::FloatFormat;
use crate::tcu::interval::Interval;
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `CommonFunctionCase::m_numValues`
const NUM_VALUES: usize = 100;

/// `getShaderTypeName` - upstream's own snake_case postfix table (`"tess_control"`, not
/// `ShaderType::as_str()`'s human-readable `"tessellation control"`, which is used
/// elsewhere in this port only for logging).
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

/// `NEW_SHADERS` - the four ES-3.1-only stages; every function in this file bar
/// `Frexp`/`Ldexp`/`Fma` (not yet ported) is registered over exactly these, in upstream's
/// own enum order (`Geometry`, `TessControl`, `TessEvaluation`, `Compute`).
const NEW_STAGES: [ShaderType; 4] = [
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

/// `ALL_SHADERS` - `Frexp`/`Ldexp`/`Fma`'s own six-stage registration, upstream's own
/// `glu::ShaderType` enum order (`SHADERTYPE_VERTEX`=0 .. `SHADERTYPE_COMPUTE`=5).
const ALL_STAGES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

fn glsl_version(context: &Context) -> glu::GlslVersion {
    if context.context_type().supports(3, 2) {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum ScalarKind {
    Float,
    Int,
}

fn base_data_type(kind: ScalarKind, vec_size: i32) -> DataType {
    match kind {
        ScalarKind::Float => glu::get_data_type_float_vec(vec_size),
        ScalarKind::Int => glu::get_data_type_int_vec(vec_size),
    }
}

/// `getMinMantissaBits`
fn min_mantissa_bits(precision: Precision) -> i32 {
    match precision {
        Precision::LowP => 7,
        Precision::MediumP => 10,
        Precision::HighP => 23,
    }
}

/// `getMaxUlpDiffFromBits`
fn max_ulp_diff_from_bits(num_accurate_bits: i32) -> u32 {
    let num_garbage_bits = 23 - num_accurate_bits;
    (1u32 << num_garbage_bits) - 1
}

/// `getUlpDiff`
fn ulp_diff(a: f32, b: f32) -> u32 {
    a.to_bits().abs_diff(b.to_bits())
}

/// `getUlpDiffIgnoreZeroSign`
fn get_ulp_diff_ignore_zero_sign(a: f32, b: f32) -> u32 {
    if Float32::new(a).is_zero() {
        ulp_diff(Float32::construct(Float32::new(b).sign(), 0, 0).as_float(), b)
    } else if Float32::new(b).is_zero() {
        ulp_diff(a, Float32::construct(Float32::new(a).sign(), 0, 0).as_float())
    } else {
        ulp_diff(a, b)
    }
}

/// `numBitsLostInOp`
fn num_bits_lost_in_op(input: f32, output: f32) -> i32 {
    let in_exp = Float32::new(input).exponent();
    let out_exp = Float32::new(output).exponent();
    (in_exp - out_exp).max(0)
}

/// `getEpsFromMaxUlpDiff`
fn get_eps_from_max_ulp_diff(value: f32, ulp_diff: u32) -> f32 {
    let exp = Float32::new(value).exponent();
    Float32::construct(1, exp, (1u32 << 23) | ulp_diff).as_float() - Float32::construct(1, exp, 1u32 << 23).as_float()
}

/// `getEpsFromBits`
fn get_eps_from_bits(value: f32, num_accurate_bits: i32) -> f32 {
    get_eps_from_max_ulp_diff(value, max_ulp_diff_from_bits(num_accurate_bits))
}

/// `supportsSignedZero`
fn supports_signed_zero(precision: Precision) -> bool {
    precision == Precision::HighP
}

/// `deFloatFrac(a) = a - deFloatFloor(a)`
fn frac(v: f32) -> f32 {
    v - v.floor()
}

/// The file's own local `roundEven` static function.
fn round_even(v: f32) -> f32 {
    let q = frac(v);
    let truncated = (v - q) as i32;
    let rounded = if q > 0.5 || (q == 0.5 && truncated % 2 != 0) {
        truncated + 1
    } else {
        truncated
    };
    rounded as f32
}

fn round_input_range(precision: Precision) -> (f32, f32) {
    match precision {
        Precision::LowP => (-2.0, 2.0),
        Precision::MediumP => (-1e3, 1e3),
        Precision::HighP => (-1e7, 1e7),
    }
}

/// `count` values of `ndx - offset`, clamped into this precision's own range.
fn special_half_integers(count: usize, offset: f32, precision: Precision) -> Vec<f32> {
    let (lo, hi) = round_input_range(precision);
    (0..count).map(|ndx| (ndx as f32 - offset).clamp(lo, hi)).collect()
}

fn f32s_to_bytes(values: &[f32]) -> Vec<u8> {
    let mut out = Vec::with_capacity(values.len() * 4);
    for v in values {
        out.extend_from_slice(&v.to_ne_bytes());
    }
    out
}

fn i32s_to_bytes(values: &[i32]) -> Vec<u8> {
    let mut out = Vec::with_capacity(values.len() * 4);
    for v in values {
        out.extend_from_slice(&v.to_ne_bytes());
    }
    out
}

fn u32s_to_bytes(values: &[u32]) -> Vec<u8> {
    let mut out = Vec::with_capacity(values.len() * 4);
    for v in values {
        out.extend_from_slice(&v.to_ne_bytes());
    }
    out
}

fn floats_from_bytes(bytes: &[u8]) -> Vec<f32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| f32::from_ne_bytes(*c)).collect()
}

fn ints_from_bytes(bytes: &[u8]) -> Vec<i32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| i32::from_ne_bytes(*c)).collect()
}

fn u32s_from_bytes(bytes: &[u8]) -> Vec<u32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| u32::from_ne_bytes(*c)).collect()
}

/// Shared `getInputValues` shape: fixed leading special values, random fill, then a
/// fp16 round trip at mediump.
fn generate_common_float_inputs(special_values: &[f32], precision: Precision, vec_size: usize, seed: u32) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let (lo, hi) = round_input_range(precision);
    let mut values = vec![0.0f32; NUM_VALUES * vec_size];

    for (ndx, &v) in special_values.iter().enumerate() {
        values[ndx * vec_size..(ndx + 1) * vec_size].fill(v);
    }
    for v in &mut values[special_values.len() * vec_size..] {
        *v = rnd.get_float_range(lo, hi);
    }
    if precision == Precision::MediumP {
        for v in &mut values {
            *v = Float16::new(*v).as_float();
        }
    }
    f32s_to_bytes(&values)
}

/// Reproduces the same upstream bug the `gles3` module's own
/// `generate_buggy_special_float_inputs` documents in full: `RoundCase`/
/// `RoundEvenCase`/`FractCase`'s special-case loop always writes to the first
/// `scalarSize` slots regardless of the loop index, so only the *last* special value
/// survives there and every other special slot stays at its zero-initialised default.
fn generate_buggy_special_float_inputs(
    special_values: &[f32],
    precision: Precision,
    vec_size: usize,
    seed: u32,
) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let (lo, hi) = round_input_range(precision);
    let mut values = vec![0.0f32; NUM_VALUES * vec_size];

    if let Some(&last) = special_values.last() {
        values[..vec_size].fill(last);
    }
    for v in &mut values[special_values.len() * vec_size..] {
        *v = rnd.get_float_range(lo, hi);
    }
    if precision == Precision::MediumP {
        for v in &mut values {
            *v = Float16::new(*v).as_float();
        }
    }
    f32s_to_bytes(&values)
}

// `Abs`/`Sign` - identical to the `gles3` module's own `CommonFunc`/`CommonFunctionCase`.

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum CommonFunc {
    Abs,
    Sign,
}

impl CommonFunc {
    fn glsl_name(self) -> &'static str {
        match self {
            Self::Abs => "abs",
            Self::Sign => "sign",
        }
    }
}

fn build_common_spec(
    version: glu::GlslVersion,
    func: CommonFunc,
    kind: ScalarKind,
    precision: Precision,
    vec_size: i32,
) -> ShaderSpec {
    let ty = base_data_type(kind, vec_size);
    let mut spec = ShaderSpec::new(version);
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = format!("out0 = {}(in0);", func.glsl_name());
    spec
}

fn generate_common_inputs(
    func: CommonFunc,
    kind: ScalarKind,
    precision: Precision,
    vec_size: usize,
    seed: u32,
) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let total_lanes = NUM_VALUES * vec_size;

    match kind {
        ScalarKind::Float => {
            let (lo, hi): (f32, f32) = match (func, precision) {
                (CommonFunc::Abs, Precision::LowP) => (-2.0, 2.0),
                (CommonFunc::Abs, Precision::MediumP) => (-1e3, 1e3),
                (CommonFunc::Abs, Precision::HighP) => (-1e7, 1e7),
                (CommonFunc::Sign, Precision::LowP) => (-2.0, 2.0),
                (CommonFunc::Sign, Precision::MediumP) => (-1e4, 1e4),
                (CommonFunc::Sign, Precision::HighP) => (-1e8, 1e8),
            };
            let mut values = vec![0.0f32; total_lanes];
            if func == CommonFunc::Sign {
                values[..vec_size].fill(1.0);
                values[vec_size..vec_size * 2].fill(-1.0);
                values[vec_size * 2..vec_size * 3].fill(0.0);
                for v in &mut values[vec_size * 3..] {
                    *v = rnd.get_float_range(lo, hi);
                }
            } else {
                for v in &mut values {
                    *v = rnd.get_float_range(lo, hi);
                }
            }
            f32s_to_bytes(&values)
        }
        ScalarKind::Int => {
            let (lo, hi): (i32, i32) = match (func, precision) {
                (CommonFunc::Abs, Precision::LowP) => (-127, 127),
                (CommonFunc::Abs, Precision::MediumP) => (-32767, 32767),
                (CommonFunc::Abs, Precision::HighP) => (-2_147_483_647, 2_147_483_647),
                (CommonFunc::Sign, Precision::LowP) => (-128, 127),
                (CommonFunc::Sign, Precision::MediumP) => (-32768, 32767),
                (CommonFunc::Sign, Precision::HighP) => (i32::MIN, i32::MAX),
            };
            let mut values = vec![0i32; total_lanes];
            if func == CommonFunc::Sign {
                values[..vec_size].fill(1);
                values[vec_size..vec_size * 2].fill(-1);
                values[vec_size * 2..vec_size * 3].fill(0);
                for v in &mut values[vec_size * 3..] {
                    *v = rnd.get_int(lo, hi);
                }
            } else {
                for v in &mut values {
                    *v = rnd.get_int(lo, hi);
                }
            }
            i32s_to_bytes(&values)
        }
    }
}

fn compare_common(
    func: CommonFunc,
    kind: ScalarKind,
    precision: Precision,
    in0: &[u8],
    out0: &[u8],
    vec_size: usize,
) -> bool {
    match kind {
        ScalarKind::Float => {
            let in0 = floats_from_bytes(in0);
            let out0 = floats_from_bytes(out0);
            let max_ulp = match func {
                CommonFunc::Abs => max_ulp_diff_from_bits(min_mantissa_bits(precision)),
                CommonFunc::Sign => {
                    if precision == Precision::LowP {
                        max_ulp_diff_from_bits(min_mantissa_bits(precision))
                    } else {
                        0
                    }
                }
            };
            (0..vec_size).all(|lane| {
                let reference = match func {
                    CommonFunc::Abs => in0[lane].abs(),
                    CommonFunc::Sign => {
                        if in0[lane] < 0.0 {
                            -1.0
                        } else if in0[lane] > 0.0 {
                            1.0
                        } else {
                            0.0
                        }
                    }
                };
                ulp_diff(out0[lane], reference) <= max_ulp
            })
        }
        ScalarKind::Int => {
            let in0 = ints_from_bytes(in0);
            let out0 = ints_from_bytes(out0);
            (0..vec_size).all(|lane| {
                let reference = match func {
                    CommonFunc::Abs => in0[lane].abs(),
                    CommonFunc::Sign => in0[lane].signum(),
                };
                out0[lane] == reference
            })
        }
    }
}

struct CommonFunctionCase {
    name: String,
    func: CommonFunc,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for CommonFunctionCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let spec = build_common_spec(
            glsl_version(context),
            self.func,
            self.kind,
            self.precision,
            self.vec_size,
        );
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ (u32::from(self.func == CommonFunc::Sign) << 16)
            ^ (u32::from(self.kind == ScalarKind::Int) << 8)
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let in0 = generate_common_inputs(self.func, self.kind, self.precision, vec_size, seed);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let elem_bytes = vec_size * 4;
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                let in_slice = &in0[value_ndx * elem_bytes..(value_ndx + 1) * elem_bytes];
                let out_slice = &out0[value_ndx * elem_bytes..(value_ndx + 1) * elem_bytes];
                !compare_common(self.func, self.kind, self.precision, in_slice, out_slice, vec_size)
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn common_function_group(func: CommonFunc, name: &str, kinds: &[ScalarKind]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &kind in kinds {
        for vec_size in 1..=4i32 {
            for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
                for &stage in &NEW_STAGES {
                    let case_name = format!(
                        "{}_{}_{}",
                        base_data_type(kind, vec_size).name(),
                        precision.name(),
                        stage_name_postfix(stage)
                    );
                    group.add_child(Box::new(CommonFunctionCase {
                        name: case_name,
                        func,
                        kind,
                        vec_size,
                        precision,
                        stage,
                    }) as Box<dyn TestCase>);
                }
            }
        }
    }
    group
}

// `Floor`/`Trunc`/`Round`/`RoundEven`/`Ceil` - see the `gles3` module's own doc comments
// on `compare_floor`/`compare_trunc`/`compare_round`/`compare_round_even`/`compare_ceil`
// for why these five do not share one comparison shape; the logic here is byte-identical
// to that module's, only duplicated rather than imported (see this file's own header).

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum RoundFunc {
    Floor,
    Trunc,
    Round,
    RoundEven,
    Ceil,
}

impl RoundFunc {
    fn glsl_name(self) -> &'static str {
        match self {
            Self::Floor => "floor",
            Self::Trunc => "trunc",
            Self::Round => "round",
            Self::RoundEven => "roundEven",
            Self::Ceil => "ceil",
        }
    }

    fn case_group_name(self) -> &'static str {
        match self {
            Self::Floor => "floor",
            Self::Trunc => "trunc",
            Self::Round => "round",
            Self::RoundEven => "roundeven",
            Self::Ceil => "ceil",
        }
    }
}

fn generate_round_inputs(func: RoundFunc, precision: Precision, vec_size: usize, seed: u32) -> Vec<u8> {
    match func {
        RoundFunc::Trunc => generate_common_float_inputs(&[0.0, -0.0, -0.9, 0.9, 1.0, -1.0], precision, vec_size, seed),
        RoundFunc::Round if precision != Precision::LowP => {
            generate_buggy_special_float_inputs(&special_half_integers(10, 5.5, precision), precision, vec_size, seed)
        }
        RoundFunc::RoundEven if precision != Precision::LowP => {
            generate_buggy_special_float_inputs(&special_half_integers(20, 10.5, precision), precision, vec_size, seed)
        }
        _ => generate_common_float_inputs(&[], precision, vec_size, seed),
    }
}

fn compare_floor(precision: Precision, in0: f32, out0: f32) -> bool {
    if precision == Precision::HighP || precision == Precision::MediumP {
        ulp_diff(out0, in0.floor()) == 0
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        let min_res = (in0 - eps).floor() as i32;
        let max_res = (in0 + eps).floor() as i32;
        (min_res..=max_res).any(|r| ulp_diff(out0, r as f32) <= max_ulp)
    }
}

fn compare_trunc(precision: Precision, in0: f32, out0: f32) -> bool {
    if precision == Precision::HighP || precision == Precision::MediumP {
        get_ulp_diff_ignore_zero_sign(out0, in0.trunc()) == 0
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        let min_res = (in0 - eps) as i32;
        let max_res = (in0 + eps) as i32;
        (min_res..=max_res).any(|r| get_ulp_diff_ignore_zero_sign(out0, r as f32) <= max_ulp)
    }
}

fn compare_round(precision: Precision, in0: f32, out0: f32) -> bool {
    let has_zero_sign = supports_signed_zero(precision);
    let ulp = |a: f32, b: f32| {
        if has_zero_sign {
            ulp_diff(a, b)
        } else {
            get_ulp_diff_ignore_zero_sign(a, b)
        }
    };

    if precision == Precision::HighP || precision == Precision::MediumP {
        if frac(in0) == 0.5 {
            ulp(out0, in0.floor()) == 0 || ulp(out0, in0.ceil()) == 0
        } else {
            ulp(out0, round_even(in0)) == 0
        }
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        let min_res = round_even(in0 - eps) as i32;
        let max_res = round_even(in0 + eps) as i32;
        (min_res..=max_res).any(|r| get_ulp_diff_ignore_zero_sign(out0, r as f32) <= max_ulp)
    }
}

fn compare_round_even(precision: Precision, in0: f32, out0: f32) -> bool {
    let has_zero_sign = supports_signed_zero(precision);
    if precision == Precision::HighP || precision == Precision::MediumP {
        let ref0 = round_even(in0);
        let ulp = if has_zero_sign {
            ulp_diff(out0, ref0)
        } else {
            get_ulp_diff_ignore_zero_sign(out0, ref0)
        };
        ulp == 0
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        let min_res = round_even(in0 - eps) as i32;
        let max_res = round_even(in0 + eps) as i32;
        (min_res..=max_res).any(|r| get_ulp_diff_ignore_zero_sign(out0, r as f32) <= max_ulp)
    }
}

fn compare_ceil(precision: Precision, in0: f32, out0: f32) -> bool {
    let has_zero_sign = supports_signed_zero(precision);
    if precision == Precision::HighP || precision == Precision::MediumP {
        let ref0 = in0.ceil();
        let ulp = if has_zero_sign {
            ulp_diff(out0, ref0)
        } else {
            get_ulp_diff_ignore_zero_sign(out0, ref0)
        };
        ulp == 0
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        let min_res = (in0 - eps).ceil() as i32;
        let max_res = (in0 + eps).ceil() as i32;
        let any_ok = (min_res..=max_res).any(|r| get_ulp_diff_ignore_zero_sign(out0, r as f32) <= max_ulp);
        if any_ok {
            true
        } else if min_res <= 0 && 0 <= max_res {
            ulp_diff(out0, -0.0) <= max_ulp
        } else {
            false
        }
    }
}

fn compare_round_func(func: RoundFunc, precision: Precision, in0: f32, out0: f32) -> bool {
    match func {
        RoundFunc::Floor => compare_floor(precision, in0, out0),
        RoundFunc::Trunc => compare_trunc(precision, in0, out0),
        RoundFunc::Round => compare_round(precision, in0, out0),
        RoundFunc::RoundEven => compare_round_even(precision, in0, out0),
        RoundFunc::Ceil => compare_ceil(precision, in0, out0),
    }
}

struct RoundCase {
    name: String,
    func: RoundFunc,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for RoundCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = glu::get_data_type_float_vec(self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(ty, Some(self.precision))));
        spec.source = format!("out0 = {}(in0);", self.func.glsl_name());
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0xac23f
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let in0 = generate_round_inputs(self.func, self.precision, vec_size, seed);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_f = floats_from_bytes(&in0);
        let out0_f = floats_from_bytes(&out0);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_round_func(self.func, self.precision, in0_f[i], out0_f[i])
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn round_function_group(func: RoundFunc) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(func.case_group_name());
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &NEW_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(RoundCase {
                    name: case_name,
                    func,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

// `Fract`

struct FractCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

fn compare_fract(precision: Precision, in0: f32, out0: f32) -> bool {
    let has_zero_sign = supports_signed_zero(precision);
    if precision == Precision::HighP || precision == Precision::MediumP {
        let ref0 = frac(in0);
        let ulp = if has_zero_sign {
            ulp_diff(out0, ref0)
        } else {
            get_ulp_diff_ignore_zero_sign(out0, ref0)
        };
        ulp == 0
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        if (in0 - eps).floor() as i32 == (in0 + eps).floor() as i32 {
            let ref0 = frac(in0);
            let bits_lost = num_bits_lost_in_op(in0, ref0);
            let max_ulp = max_ulp_diff_from_bits((mantissa_bits - bits_lost).max(0));
            get_ulp_diff_ignore_zero_sign(out0, ref0) <= max_ulp
        } else {
            out0 < 1.0
        }
    }
}

impl TestCase for FractCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = glu::get_data_type_float_vec(self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(ty, Some(self.precision))));
        spec.source = "out0 = fract(in0);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0xac23f
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let specials: Vec<f32> = if self.precision != Precision::LowP {
            special_half_integers(10, 5.5, self.precision)
        } else {
            Vec::new()
        };
        let in0 = generate_buggy_special_float_inputs(&specials, self.precision, vec_size, seed);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_f = floats_from_bytes(&in0);
        let out0_f = floats_from_bytes(&out0);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_fract(self.precision, in0_f[i], out0_f[i])
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn fract_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fract");
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &NEW_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(FractCase {
                    name: case_name,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

// `Modf`

struct ModfCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

fn compare_modf(precision: Precision, in0: f32, out0: f32, out1: f32) -> bool {
    let has_zero_sign = supports_signed_zero(precision);
    let mantissa_bits = min_mantissa_bits(precision);

    let ref_out1 = (in0 as i32) as f32;
    let ref_out0 = in0 - ref_out1;

    let bits_lost = if precision != Precision::HighP {
        num_bits_lost_in_op(in0, ref_out0)
    } else {
        0
    };
    let max_ulp = max_ulp_diff_from_bits((mantissa_bits - bits_lost).max(0));

    let res_sum = out0 + out1;
    let ulp = if has_zero_sign {
        ulp_diff(res_sum, in0)
    } else {
        get_ulp_diff_ignore_zero_sign(res_sum, in0)
    };
    ulp <= max_ulp
}

impl TestCase for ModfCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = glu::get_data_type_float_vec(self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("out1", VarType::basic(ty, Some(self.precision))));
        spec.source = "out0 = modf(in0, out1);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0xac23f
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let (lo, hi) = round_input_range(self.precision);
        let mut rnd = Random::new(seed);
        let mut values = vec![0.0f32; NUM_VALUES * vec_size];
        for v in &mut values {
            *v = rnd.get_float_range(lo, hi);
        }
        let in0 = f32s_to_bytes(&values);
        let mut out0 = vec![0u8; in0.len()];
        let mut out1 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 2] = [&mut out0, &mut out1];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let out0_f = floats_from_bytes(&out0);
        let out1_f = floats_from_bytes(&out1);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_modf(self.precision, values[i], out0_f[i], out1_f[i])
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn modf_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("modf");
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &NEW_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(ModfCase {
                    name: case_name,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

// `Isnan`/`Isinf` - genuinely different `compare` shape from the `gles3` module (see this
// file's own header for exactly how).

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum NanInfFunc {
    Isnan,
    Isinf,
}

impl NanInfFunc {
    fn glsl_name(self) -> &'static str {
        match self {
            Self::Isnan => "isnan",
            Self::Isinf => "isinf",
        }
    }
}

fn generate_nan_inf_inputs(func: NanInfFunc, precision: Precision, vec_size: usize, seed: u32) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let mantissa_bits = min_mantissa_bits(precision);
    let mantissa_mask = !max_ulp_diff_from_bits(mantissa_bits) & ((1u32 << 23) - 1);
    let mut values = vec![0u32; NUM_VALUES * vec_size];

    for v in &mut values {
        let (is_nan, is_inf) = match func {
            NanInfFunc::Isnan => {
                let is_nan = rnd.get_float() > 0.3;
                let is_inf = !is_nan && rnd.get_float() > 0.4;
                (is_nan, is_inf)
            }
            NanInfFunc::Isinf => {
                let is_inf = rnd.get_float() > 0.3;
                let is_nan = !is_inf && rnd.get_float() > 0.4;
                (is_nan, is_inf)
            }
        };
        let mantissa: u32 = if !is_inf {
            (1u32 << 22) | (rnd.get_uint32() & mantissa_mask)
        } else {
            0
        };
        let exp: u32 = if !is_nan && !is_inf {
            rnd.get_uint32() & 0x7f
        } else {
            0xff
        };
        let sign: u32 = rnd.get_uint32() & 0x1;
        *v = (sign << 31) | (exp << 23) | mantissa;
    }

    u32s_to_bytes(&values)
}

/// `IsnanCase::compare` - highp is exact; mediump/lowp are one-sided ("NaN support is
/// optional, check that inputs that are not NaN don't result in true").
fn compare_isnan(precision: Precision, in0_bits: u32, out0: i32) -> bool {
    let in0 = f32::from_bits(in0_bits);
    let ref0 = in0.is_nan();
    let out0 = out0 != 0;
    if precision == Precision::HighP {
        out0 == ref0
    } else {
        !(!ref0 && out0)
    }
}

/// `IsinfCase::compare` - highp is exact; mediump is one-sided against whether the value
/// would overflow to infinity *in fp16* (mediump storage can genuinely do that even when
/// the host `f32` is finite); lowp performs no check at all.
fn compare_isinf(precision: Precision, in0_bits: u32, out0: i32) -> bool {
    let in0 = f32::from_bits(in0_bits);
    let out0 = out0 != 0;
    match precision {
        Precision::HighP => out0 == in0.is_infinite(),
        Precision::MediumP => {
            let ref0 = Float16::new(in0).is_inf();
            !(!ref0 && out0)
        }
        Precision::LowP => true,
    }
}

struct NanInfCase {
    name: String,
    func: NanInfFunc,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for NanInfCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let float_ty = glu::get_data_type_float_vec(self.vec_size);
        let bool_ty = if self.vec_size > 1 {
            glu::get_data_type_bool_vec(self.vec_size)
        } else {
            DataType::Bool
        };
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(float_ty, Some(self.precision))));
        spec.outputs.push(Symbol::new("out0", VarType::basic(bool_ty, None)));
        spec.source = format!("out0 = {}(in0);", self.func.glsl_name());
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0xc2a39f
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let in0 = generate_nan_inf_inputs(self.func, self.precision, vec_size, seed);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_bits = u32s_from_bytes(&in0);
        let out0_i = ints_from_bytes(&out0);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    let ok = match self.func {
                        NanInfFunc::Isnan => compare_isnan(self.precision, in0_bits[i], out0_i[i]),
                        NanInfFunc::Isinf => compare_isinf(self.precision, in0_bits[i], out0_i[i]),
                    };
                    !ok
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn nan_inf_group(func: NanInfFunc, name: &str) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &NEW_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(NanInfCase {
                    name: case_name,
                    func,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

// `FloatBitsToInt`/`FloatBitsToUint`

struct FloatBitsToIntCase {
    name: String,
    out_is_signed: bool,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for FloatBitsToIntCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let in_ty = glu::get_data_type_float_vec(self.vec_size);
        let out_ty = if self.out_is_signed {
            glu::get_data_type_int_vec(self.vec_size)
        } else {
            glu::get_data_type_uint_vec(self.vec_size)
        };
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(in_ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(out_ty, Some(Precision::HighP))));
        spec.source = format!(
            "out0 = {}(in0);",
            if self.out_is_signed {
                "floatBitsToInt"
            } else {
                "floatBitsToUint"
            }
        );
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0x2790a
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let (lo, hi) = round_input_range(self.precision);
        let mut rnd = Random::new(seed);
        let mut values = vec![0.0f32; NUM_VALUES * vec_size];
        for v in &mut values {
            *v = rnd.get_float_range(lo, hi);
        }
        let in0 = f32s_to_bytes(&values);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let out0_u = u32s_from_bytes(&out0);
        let mantissa_bits = min_mantissa_bits(self.precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    let ref0 = values[i].to_bits();
                    let diff = (out0_u[i] as i32).wrapping_sub(ref0 as i32);
                    diff.unsigned_abs() > max_ulp
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn float_bits_to_int_group(out_is_signed: bool, name: &str) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &NEW_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(FloatBitsToIntCase {
                    name: case_name,
                    out_is_signed,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

// `(u)intBitsToFloat` - `NEW_SHADERS` only, and no `vec4` case (upstream's own loop bound
// is `vecSize < 4`), matching the `gles3` module's own `bits_to_float_group` shape.

struct BitsToFloatCase {
    name: String,
    in_is_signed: bool,
    vec_size: i32,
    stage: ShaderType,
}

impl TestCase for BitsToFloatCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let in_ty = if self.in_is_signed {
            glu::get_data_type_int_vec(self.vec_size)
        } else {
            glu::get_data_type_uint_vec(self.vec_size)
        };
        let out_ty = glu::get_data_type_float_vec(self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(in_ty, Some(Precision::HighP))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(out_ty, Some(Precision::HighP))));
        spec.source = format!(
            "out0 = {}(in0);",
            if self.in_is_signed {
                "intBitsToFloat"
            } else {
                "uintBitsToFloat"
            }
        );
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0xbbb225 ^ ((self.stage as i32 as u32) << 2) ^ self.vec_size as u32;
        let mut rnd = Random::new(seed);
        let mut values = vec![0.0f32; NUM_VALUES * vec_size];
        for v in &mut values {
            *v = rnd.get_float_range(-1e8, 1e8);
        }
        let in0 = f32s_to_bytes(&values);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let out0_f = floats_from_bytes(&out0);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size)
                    .any(|lane| ulp_diff(values[value_ndx * vec_size + lane], out0_f[value_ndx * vec_size + lane]) != 0)
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn bits_to_float_group(in_is_signed: bool, name: &str) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for vec_size in 1..4i32 {
        let in_ty = if in_is_signed {
            glu::get_data_type_int_vec(vec_size)
        } else {
            glu::get_data_type_uint_vec(vec_size)
        };
        for &stage in &NEW_STAGES {
            let case_name = format!(
                "{}_{}_{}",
                in_ty.name(),
                Precision::HighP.name(),
                stage_name_postfix(stage)
            );
            group.add_child(Box::new(BitsToFloatCase {
                name: case_name,
                in_is_signed,
                vec_size,
                stage,
            }) as Box<dyn TestCase>);
        }
    }
    group
}

// `Frexp`/`Ldexp`/`Fma` - `ALL_SHADERS`, not `NEW_SHADERS`. Shared input-snapping helper
// first (`makeFloatRepresentable`), then the three functions themselves.

/// `getMaxNormalizedValueExponent`
fn max_normalized_value_exponent(precision: Precision) -> i32 {
    match precision {
        Precision::LowP => 0,
        Precision::MediumP => 13,
        Precision::HighP => 127,
    }
}

/// `getMinNormalizedValueExponent`
fn min_normalized_value_exponent(precision: Precision) -> i32 {
    match precision {
        Precision::LowP => -7,
        Precision::MediumP => -13,
        Precision::HighP => -126,
    }
}

/// `makeFloatRepresentable` - snaps `f` onto the precision's own representable grid
/// (flushing too-small values to zero, or to the smallest positive non-subnormal at
/// lowp where zero itself is not required to be representable; clamping too-large
/// values to the largest representable value; masking off mantissa bits the format
/// cannot hold), so the reference computed at full `f32`/`f64` precision never
/// disagrees with the shader over a value that was never representable in the target
/// precision to begin with. Highp is the identity (`f` is assumed not extended-precision).
fn make_float_representable(f: f32, precision: Precision) -> f32 {
    if precision == Precision::HighP {
        return f;
    }
    let num_mantissa_bits = min_mantissa_bits(precision);
    let max_exp = max_normalized_value_exponent(precision);
    let min_exp = min_normalized_value_exponent(precision);
    let representable_mantissa_mask = ((1u32 << num_mantissa_bits) - 1) << (23 - num_mantissa_bits);
    let largest_representable_value = Float32::construct_bits(
        1,
        max_exp,
        ((1u32 << num_mantissa_bits) - 1) << (23 - num_mantissa_bits),
    )
    .as_float();
    let zero_not_representable = precision == Precision::LowP;
    let zero_value = if zero_not_representable {
        Float32::construct_bits(1, min_exp, 1).as_float()
    } else {
        0.0
    };

    let f32_representation = Float32::new(f);
    if f32_representation.exponent() < min_exp {
        zero_value
    } else if f32_representation.exponent() > max_exp {
        if f32_representation.sign() == 1 {
            largest_representable_value
        } else {
            -largest_representable_value
        }
    } else {
        let target_mantissa = f32_representation.mantissa_bits() & representable_mantissa_mask;
        Float32::construct_bits(
            f32_representation.sign(),
            f32_representation.exponent(),
            target_mantissa,
        )
        .as_float()
    }
}

/// This file's own local `frexp(in, significand, exponent)` static function - *not*
/// `gls::builtin_precision_tests`'s interval-valued `FrExp` (see this file's own header).
/// Exact bit manipulation: `significand` keeps `in`'s sign and mantissa with the
/// exponent forced to `-1` (i.e. in `[0.5, 1)` or its negation), `exponent` is shifted
/// by one to compensate.
fn common_frexp(in0: f32) -> (f32, i32) {
    let fp_value = Float32::new(in0);
    if !fp_value.is_zero() {
        (
            Float32::construct(fp_value.sign(), -1, fp_value.mantissa()).as_float(),
            fp_value.exponent() + 1,
        )
    } else {
        (if fp_value.sign() < 0 { -0.0 } else { 0.0 }, 0)
    }
}

/// This file's own local `ldexp(significand, exponent)` static function.
fn common_ldexp(significand: f32, exponent: i32) -> f32 {
    let mant = Float32::new(significand);
    if exponent == 0 && mant.is_zero() {
        if mant.sign() < 0 { -0.0 } else { 0.0 }
    } else {
        Float32::construct(mant.sign(), exponent + mant.exponent(), mant.mantissa()).as_float()
    }
}

struct FrexpCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

fn generate_frexp_inputs(precision: Precision, vec_size: usize, seed: u32) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let (lo, hi) = round_input_range(precision);
    let specials = [0.0f32, -0.0, 0.5, -0.5, 1.0, -1.0, 2.0, -2.0];
    let mut values = vec![0.0f32; NUM_VALUES * vec_size];

    for (ndx, &v) in specials.iter().enumerate() {
        values[ndx * vec_size..(ndx + 1) * vec_size].fill(v);
    }
    for v in &mut values[specials.len() * vec_size..] {
        *v = rnd.get_float_range(lo, hi);
    }
    for v in &mut values {
        *v = make_float_representable(*v, precision);
    }
    f32s_to_bytes(&values)
}

/// `FrexpCase::compare` - `signedZero` is hardcoded `false` upstream (not routed through
/// `supportsSignedZero`), unconditionally on every precision.
fn compare_frexp(precision: Precision, in0: f32, out0: f32, out1: i32) -> bool {
    let (ref_out0, ref_out1) = common_frexp(in0);
    let max_ulp = max_ulp_diff_from_bits(min_mantissa_bits(precision));
    get_ulp_diff_ignore_zero_sign(out0, ref_out0) <= max_ulp && out1 == ref_out1
}

impl TestCase for FrexpCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let base_ty = glu::get_data_type_float_vec(self.vec_size);
        let int_ty = glu::get_data_type_int_vec(self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(base_ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(base_ty, Some(Precision::HighP))));
        spec.outputs
            .push(Symbol::new("out1", VarType::basic(int_ty, Some(Precision::HighP))));
        spec.source = "out0 = frexp(in0, out1);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0x2790a
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let in0 = generate_frexp_inputs(self.precision, vec_size, seed);
        let mut out0 = vec![0u8; in0.len()];
        let mut out1 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 1] = [&in0];
            let mut outputs: [&mut [u8]; 2] = [&mut out0, &mut out1];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_f = floats_from_bytes(&in0);
        let out0_f = floats_from_bytes(&out0);
        let out1_i = ints_from_bytes(&out1);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_frexp(self.precision, in0_f[i], out0_f[i], out1_i[i])
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn frexp_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("frexp");
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &ALL_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(FrexpCase {
                    name: case_name,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

struct LdexpCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

/// `LdexpCase::getInputValues` - the most intricate sample generator in this file:
/// 8 "easy" specials run through `frexp` themselves (so `in0` is already a valid
/// significand), then up to 50 further "easy" random cases (highp only - lowp/mediump
/// skip straight to filling every remaining slot this way), then any slots still left
/// build a raw `Float32` directly from a random sign/exponent/mantissa and derive `in1`
/// from a bounded range specifically chosen so `ldexp(in0, in1)` cannot overflow to
/// infinity or underflow to a denormal (Khronos bug 11180).
fn generate_ldexp_inputs(precision: Precision, vec_size: usize, seed: u32) -> (Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(seed);
    let (lo, hi) = round_input_range(precision);
    let mut in0 = vec![0.0f32; NUM_VALUES * vec_size];
    let mut in1 = vec![0i32; NUM_VALUES * vec_size];
    let mut value_ndx = 0usize;

    let easy_specials = [0.0f32, -0.0, 0.5, -0.5, 1.0, -1.0, 2.0, -2.0];
    for &v in &easy_specials {
        let (s, e) = common_frexp(v);
        for lane in 0..vec_size {
            in0[value_ndx * vec_size + lane] = s;
            in1[value_ndx * vec_size + lane] = e;
        }
        value_ndx += 1;
    }

    let num_easy_random = if precision == Precision::HighP {
        50
    } else {
        NUM_VALUES - value_ndx
    };
    for _ in 0..num_easy_random {
        for lane in 0..vec_size {
            let (s, e) = common_frexp(rnd.get_float_range(lo, hi));
            in0[value_ndx * vec_size + lane] = s;
            in1[value_ndx * vec_size + lane] = e;
        }
        value_ndx += 1;
    }

    let num_hard_random = NUM_VALUES - value_ndx;
    for _ in 0..num_hard_random {
        for lane in 0..vec_size {
            let fp_exp = rnd.get_int(-126, 127);
            let sign: i32 = if rnd.get_bool() { -1 } else { 1 };
            let mantissa = (1u32 << 23) | (rnd.get_uint32() & ((1u32 << 23) - 1));
            let exp1 = rnd.get_int((-126i32).max(-126 - fp_exp), 127i32.min(127 - fp_exp));
            in0[value_ndx * vec_size + lane] = Float32::construct(sign, fp_exp, mantissa).as_float();
            in1[value_ndx * vec_size + lane] = exp1;
        }
        value_ndx += 1;
    }

    (f32s_to_bytes(&in0), i32s_to_bytes(&in1))
}

fn compare_ldexp(precision: Precision, in0: f32, in1: i32, out0: f32) -> bool {
    let ref0 = common_ldexp(in0, in1);
    let max_ulp = max_ulp_diff_from_bits(min_mantissa_bits(precision));
    get_ulp_diff_ignore_zero_sign(out0, ref0) <= max_ulp
}

impl TestCase for LdexpCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let base_ty = glu::get_data_type_float_vec(self.vec_size);
        let int_ty = glu::get_data_type_int_vec(self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("in0", VarType::basic(base_ty, Some(self.precision))));
        spec.inputs
            .push(Symbol::new("in1", VarType::basic(int_ty, Some(Precision::HighP))));
        spec.outputs
            .push(Symbol::new("out0", VarType::basic(base_ty, Some(Precision::HighP))));
        spec.source = "out0 = ldexp(in0, in1);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0x2790a
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let (in0, in1) = generate_ldexp_inputs(self.precision, vec_size, seed);
        let mut out0 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 2] = [&in0, &in1];
            let mut outputs: [&mut [u8]; 1] = [&mut out0];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_f = floats_from_bytes(&in0);
        let in1_i = ints_from_bytes(&in1);
        let out0_f = floats_from_bytes(&out0);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_ldexp(self.precision, in0_f[i], in1_i[i], out0_f[i])
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn ldexp_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ldexp");
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &ALL_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(LdexpCase {
                    name: case_name,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

struct FmaCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

/// `FmaCase::specialCases` (a/b/c triples) followed by a random fill, all snapped
/// through `makeFloatRepresentable` - matches `FrexpCase`'s own shape but with three
/// input buffers instead of one.
fn generate_fma_inputs(precision: Precision, vec_size: usize, seed: u32) -> (Vec<u8>, Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(seed);
    let (lo, hi): (f32, f32) = match precision {
        Precision::LowP => (-2.0, 2.0),
        Precision::MediumP => (-127.0, 127.0),
        Precision::HighP => (-1e7, 1e7),
    };
    #[rustfmt::skip]
    let special_cases: [[f32; 3]; 10] = [
        [0.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, -1.0], [1.0, 1.0, 0.0], [1.0, 1.0, 1.0],
        [-1.0, 1.0, 0.0], [1.0, -1.0, 0.0], [-1.0, -1.0, 0.0], [-0.0, 1.0, 0.0], [1.0, -0.0, 0.0],
    ];

    let mut a = vec![0.0f32; NUM_VALUES * vec_size];
    let mut b = vec![0.0f32; NUM_VALUES * vec_size];
    let mut c = vec![0.0f32; NUM_VALUES * vec_size];

    for (case_ndx, triple) in special_cases.iter().enumerate() {
        a[case_ndx * vec_size..(case_ndx + 1) * vec_size].fill(triple[0]);
        b[case_ndx * vec_size..(case_ndx + 1) * vec_size].fill(triple[1]);
        c[case_ndx * vec_size..(case_ndx + 1) * vec_size].fill(triple[2]);
    }

    let offs = special_cases.len() * vec_size;
    for buf in [&mut a, &mut b, &mut c] {
        for v in &mut buf[offs..] {
            *v = rnd.get_float_range(lo, hi);
        }
    }
    for buf in [&mut a, &mut b, &mut c] {
        for v in buf.iter_mut() {
            *v = make_float_representable(*v, precision);
        }
    }

    (f32s_to_bytes(&a), f32s_to_bytes(&b), f32s_to_bytes(&c))
}

/// `FmaCase::fma` - the interval-arithmetic reference. Genuinely different machinery
/// from every other function in this file (see this file's own header), but not a new
/// *framework* for this project: `tcu::Interval`/`tcu::FloatFormat` are already ported
/// for `gls::builtin_precision_tests`, and `precision_format` builds the identical
/// format table `FmaCase`'s own local table does. Ported line-by-line off the upstream
/// `TCU_SET_INTERVAL`/`TCU_SET_INTERVAL_BOUNDS` directed-rounding macros as plain `f64`
/// point intervals - the double-precision rounding error those macros guard against is
/// negligible next to the coarse mantissa widths (7/9/23 bits) `FloatFormat::convert`
/// rounds into afterwards (see `tcu::interval`'s own header for why this project treats
/// "one double ULP" as immaterial throughout).
fn fma_reference(fmt: FloatFormat, a: f32, b: f32, c: f32) -> Interval {
    let ia = fmt.convert(Interval::exact(a as f64));
    let ib = fmt.convert(Interval::exact(b as f64));
    let ic = fmt.convert(Interval::exact(c as f64));

    let prod0 = Interval::exact(ia.lo() * ib.lo());
    let prod1 = Interval::exact(ia.lo() * ib.hi());
    let prod2 = Interval::exact(ia.hi() * ib.lo());
    let prod3 = Interval::exact(ia.hi() * ib.hi());
    let ab_finite = ia.is_finite(fmt.max_value()) && ib.is_finite(fmt.max_value());
    let prod = fmt.convert(fmt.round_out_interval(prod0 | prod1 | prod2 | prod3, ab_finite));

    let res = Interval::new(prod.lo() + ic.lo(), prod.hi() + ic.hi());
    let res_finite = prod.is_finite(fmt.max_value()) && ic.is_finite(fmt.max_value());
    fmt.convert(fmt.round_out_interval(res, res_finite))
}

impl TestCase for FmaCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // `FmaCase::init`'s own gate (ES-only: the upstream `core 4.5` alternative never
        // applies here) - a real `NotSupported`, not a failure, when neither ES 3.2 nor
        // the extension the shader below conditionally declares is available.
        let supports_es32 = context.context_type().supports(3, 2);
        if !supports_es32 && !context.context_info.is_extension_supported("GL_EXT_gpu_shader5") {
            return Err(TestError::NotSupported(
                "OpenGL ES 3.2 and GL_EXT_gpu_shader5 not supported".to_string(),
            ));
        }

        let vec_size = self.vec_size as usize;
        let ty = glu::get_data_type_float_vec(self.vec_size);
        let mut spec = ShaderSpec::new(if supports_es32 {
            glu::GlslVersion::Es320
        } else {
            glu::GlslVersion::Es310
        });
        // `FmaCase`'s own constructor only adds the pragma when the context does not
        // already support ES 3.2 - unlike `gls::builtin_precision_tests::TernaryOp::Fma`,
        // which adds it unconditionally (see this file's own header for why they differ).
        if !supports_es32 {
            spec.global_declarations = "#extension GL_EXT_gpu_shader5 : require\n".to_string();
        }
        spec.inputs
            .push(Symbol::new("a", VarType::basic(ty, Some(self.precision))));
        spec.inputs
            .push(Symbol::new("b", VarType::basic(ty, Some(self.precision))));
        spec.inputs
            .push(Symbol::new("c", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("res", VarType::basic(ty, Some(self.precision))));
        spec.source = "res = fma(a, b, c);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name)
            ^ 0xac23f
            ^ ((self.precision as i32 as u32) << 4)
            ^ ((self.stage as i32 as u32) << 2)
            ^ self.vec_size as u32;
        let (a, b, c) = generate_fma_inputs(self.precision, vec_size, seed);
        let mut res = vec![0u8; a.len()];
        {
            let inputs: [&[u8]; 3] = [&a, &b, &c];
            let mut outputs: [&mut [u8]; 1] = [&mut res];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let a_f = floats_from_bytes(&a);
        let b_f = floats_from_bytes(&b);
        let c_f = floats_from_bytes(&c);
        let res_f = floats_from_bytes(&res);
        let fmt = precision_format(self.precision);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !fma_reference(fmt, a_f[i], b_f[i], c_f[i]).contains(res_f[i] as f64)
                })
            })
            .count();

        if num_failed > 0 {
            Ok(TestStatus::fail(format!("{num_failed} / {NUM_VALUES} values failed")))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

fn fma_group() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("fma");
    for vec_size in 1..=4i32 {
        for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
            for &stage in &ALL_STAGES {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage_name_postfix(stage)
                );
                group.add_child(Box::new(FmaCase {
                    name: case_name,
                    vec_size,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
        }
    }
    group
}

/// `ShaderCommonFunctionTests::init`.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("common");
    group.add_child(common_function_group(
        CommonFunc::Abs,
        "abs",
        &[ScalarKind::Float, ScalarKind::Int],
    ));
    group.add_child(common_function_group(
        CommonFunc::Sign,
        "sign",
        &[ScalarKind::Float, ScalarKind::Int],
    ));
    group.add_child(round_function_group(RoundFunc::Floor));
    group.add_child(round_function_group(RoundFunc::Trunc));
    group.add_child(round_function_group(RoundFunc::Round));
    group.add_child(round_function_group(RoundFunc::RoundEven));
    group.add_child(round_function_group(RoundFunc::Ceil));
    group.add_child(fract_group());
    group.add_child(modf_group());
    group.add_child(nan_inf_group(NanInfFunc::Isnan, "isnan"));
    group.add_child(nan_inf_group(NanInfFunc::Isinf, "isinf"));
    group.add_child(float_bits_to_int_group(true, "floatbitstoint"));
    group.add_child(float_bits_to_int_group(false, "floatbitstouint"));
    group.add_child(bits_to_float_group(true, "intbitstofloat"));
    group.add_child(bits_to_float_group(false, "uintbitstofloat"));
    group.add_child(frexp_group());
    group.add_child(ldexp_group());
    group.add_child(fma_group());
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
        // abs/sign: 2 kinds x 4 vec_sizes x 3 precisions x 4 stages, each.
        // floor/trunc/round/roundeven/ceil/fract/modf/isnan/isinf/floatbitstoint/
        // floatbitstouint: 4 vec_sizes x 3 precisions x 4 stages, each (11 functions).
        // intbitstofloat/uintbitstofloat: 3 vec_sizes (no vec4) x 4 stages, each.
        // frexp/ldexp/fma: 4 vec_sizes x 3 precisions x 6 stages, each (`ALL_SHADERS`).
        // Matches the real gles31-main mustpass exactly (960 cases total - confirmed via
        // `grep -c 'shaders\.builtin_functions\.common\.<fn>\.' gles31-main.txt` per
        // function before writing this; frexp/ldexp/fma are 72 each, no omissions).
        let expected = 2 * (2 * 4 * 3 * 4) + 11 * (4 * 3 * 4) + 2 * (3 * 4) + 3 * (4 * 3 * 6);
        assert_eq!(expected, 960);
        assert_eq!(names.len(), expected);
        assert!(names.contains(&"common.abs.float_highp_compute".to_string()));
        assert!(names.contains(&"common.sign.ivec3_lowp_geometry".to_string()));
        assert!(names.contains(&"common.floor.vec2_mediump_tess_control".to_string()));
        assert!(names.contains(&"common.roundeven.vec4_highp_tess_eval".to_string()));
        assert!(names.contains(&"common.modf.float_lowp_compute".to_string()));
        assert!(names.contains(&"common.isnan.vec3_highp_geometry".to_string()));
        assert!(names.contains(&"common.isinf.vec4_mediump_tess_control".to_string()));
        assert!(names.contains(&"common.floatbitstoint.float_lowp_tess_eval".to_string()));
        assert!(names.contains(&"common.intbitstofloat.ivec2_highp_compute".to_string()));
        assert!(names.contains(&"common.uintbitstofloat.uvec3_highp_geometry".to_string()));
        assert!(
            !names.contains(&"common.intbitstofloat.ivec4_highp_compute".to_string()),
            "no vec4 case for (u)intBitsToFloat"
        );
        assert!(
            names.contains(&"common.frexp.float_highp_vertex".to_string()),
            "frexp/ldexp/fma use ALL_SHADERS, including vertex/fragment"
        );
        assert!(names.contains(&"common.ldexp.vec4_lowp_fragment".to_string()));
        assert!(names.contains(&"common.fma.vec3_mediump_tess_control".to_string()));
        assert!(
            !names.iter().any(|n| !n.starts_with("common.frexp.")
                && !n.starts_with("common.ldexp.")
                && !n.starts_with("common.fma.")
                && (n.ends_with("_vertex") || n.ends_with("_fragment"))),
            "NEW_SHADERS (every function except frexp/ldexp/fma) excludes vertex/fragment"
        );
    }

    #[test]
    fn round_even_matches_upstream_on_known_ties() {
        assert_eq!(round_even(-0.5), 0.0);
        assert_eq!(round_even(0.5), 0.0);
        assert_eq!(round_even(1.5), 2.0);
        assert_eq!(round_even(2.5), 2.0);
    }
}

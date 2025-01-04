// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderCommonFunctionTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `shaders.builtin_functions.common` - genuinely different from `gls::
// builtin_precision_tests` (`shaders.builtin_functions.precision`): no `tcu::Interval`/
// `FloatFormat` at all, just a per-function `compare()` against an exact reference
// (integer types) or an ULP-threshold-bounded one (float types). `getUlpDiff` is a *raw*
// unsigned bit-pattern difference (`a.to_bits().abs_diff(b.to_bits())`), not a
// sign-aware ULP distance - ported exactly rather than "improved", since neither
// function this file ports so far ever compares two differently-signed floats this way
// (a value and its own `abs`/`sign` share a sign or are both zero) so the difference
// would never be observed anyway. `getMinMantissaBits` (7/10/23 for lowp/mediump/highp)
// and `getMaxUlpDiffFromBits` are ported the same way.
//
// Every case reuses `gls::shader_exec_util::create_executor`/`execute` unchanged - no
// new plumbing was needed, unlike the matrix/`int`-typed additions `gls::
// builtin_precision_tests` needed for its own last functions (`FragmentOutExecutor`'s
// int-typed input/output paths were already generic, just never exercised by any case
// before this file).
//
// **Every function in `es3fShaderCommonFunctionTests.cpp` is now ported** - all 372 real
// mustpass cases of this group: `Abs`/`Sign` (`addFunctionCases<AbsCase>`/`<SignCase>`,
// `floatTypes=true, intTypes=true, uintTypes=false`), `Floor`/`Trunc`/`Round`/`RoundEven`/
// `Ceil` (one `RoundFunc` enum, five distinct `compare_*` functions - the five do *not*
// share one comparison shape, see each one's own doc comment), `Fract` (its own case -
// checks whether `in0 +- eps` straddles an integer boundary rather than looping a
// candidate range), `Modf` (two outputs, no fp16 snap - unlike every other function here),
// `Isnan`/`Isinf` (bool output, built from crafted bit patterns rather than a value range,
// so the domain includes NaN/Inf at all), `FloatBitsToInt`/`FloatBitsToUint` (int/uint
// output fixed at highp), `(u)intBitsToFloat` (the one function upstream registers
// directly under `common` rather than through `addFunctionCases`, and the one with no
// `vec4` case - see `bits_to_float_group`'s own comment).
//
// `Float16` (`crate::tcu::float`) exists specifically for the "make sure values can be
// represented in fp16 exactly" mediump snap every float-returning function here except
// `Modf` performs - covered by its own unit tests (cross-checked against
// Python's `struct` module).
//
// This is `gles3`-only, matching upstream's own `es3fShaderCommonFunctionTests.cpp`
// (`{Vertex, Fragment}` only, GLSL ES 3.00) - `gles31` has its own, larger
// `es31fShaderCommonFunctionTests.cpp` (all six shader stages, not yet read for
// differences) and is not shared with this module.

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::tcu::float::{Float16, Float32};
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `CommonFunctionCase::m_numValues`
const NUM_VALUES: usize = 100;

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

/// `getUlpDiff` - see the module header on why this stays a raw bit-pattern difference.
fn ulp_diff(a: f32, b: f32) -> u32 {
    a.to_bits().abs_diff(b.to_bits())
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

fn u32s_to_bytes(values: &[u32]) -> Vec<u8> {
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

/// `getUlpDiffIgnoreZeroSign` - treats +0/-0 as equal first, by re-signing whichever side
/// is zero to match the other's sign before taking the ordinary bit-pattern difference.
/// `Trunc`'s own comment: "trunc() function definition is a bit broad on negative zeros.
/// Ignore result sign if zero" - `Ceil`/`Round`/`RoundEven`/`Fract`/`Modf` all need it too,
/// in both their exact-result and lowp-fuzzy branches (`Floor` alone never does - see each
/// function's own `compare` below for exactly where upstream does and does not call this
/// instead of the plain `ulp_diff`).
fn get_ulp_diff_ignore_zero_sign(a: f32, b: f32) -> u32 {
    if Float32::new(a).is_zero() {
        ulp_diff(Float32::construct(Float32::new(b).sign(), 0, 0).as_float(), b)
    } else if Float32::new(b).is_zero() {
        ulp_diff(a, Float32::construct(Float32::new(a).sign(), 0, 0).as_float())
    } else {
        ulp_diff(a, b)
    }
}

/// `numBitsLostInOp` - how many mantissa bits a computation threw away, from the drop in
/// exponent between an input and its output (a larger exponent gap means more of the
/// input's precision landed below the output's own ULP). `Modf`/`Fract` both use this to
/// loosen their own ULP threshold by exactly as many bits as the subtraction itself lost.
fn num_bits_lost_in_op(input: f32, output: f32) -> i32 {
    let in_exp = Float32::new(input).exponent();
    let out_exp = Float32::new(output).exponent();
    (in_exp - out_exp).max(0)
}

/// `getEpsFromMaxUlpDiff` - the absolute value of one representable step at `value`'s own
/// exponent, scaled by `ulp_diff` steps - the epsilon the lowp "fuzzy" branches widen a
/// candidate integer range by.
fn get_eps_from_max_ulp_diff(value: f32, ulp_diff: u32) -> f32 {
    let exp = Float32::new(value).exponent();
    Float32::construct(1, exp, (1u32 << 23) | ulp_diff).as_float() - Float32::construct(1, exp, 1u32 << 23).as_float()
}

/// `getEpsFromBits`
fn get_eps_from_bits(value: f32, num_accurate_bits: i32) -> f32 {
    get_eps_from_max_ulp_diff(value, max_ulp_diff_from_bits(num_accurate_bits))
}

/// `supportsSignedZero` - GLSL ES 3.0 does not strictly require -0 support, but upstream
/// requires it at highp anyway "as it is very widely supported".
fn supports_signed_zero(precision: Precision) -> bool {
    precision == Precision::HighP
}

/// `deFloatFrac(a) = a - deFloatFloor(a)`. Rust's own `f32::floor()` already matches C's
/// `floor()` (and therefore `deFloatFloor`) bit-for-bit on every input including
/// infinities/NaN, so no separate port of `deFloatFloor` itself is needed anywhere in this
/// file - only this one composition.
fn frac(v: f32) -> f32 {
    v - v.floor()
}

/// The file's own local `roundEven` static function (distinct from, and always used ahead
/// of, GLSL's `roundEven` builtin under test) - round to the nearest integer, ties to even.
fn round_even(v: f32) -> f32 {
    let q = frac(v);
    let truncated = (v - q) as i32;
    // Same three-way condition as upstream's ternary chain (`q > 0.5`, else `q == 0.5`
    // with an odd truncated part, else plain truncation) - the first two arms share their
    // result, so they are merged with `||` here rather than kept as separate `if`/`else
    // if` branches clippy flags as identical.
    let rounded = if q > 0.5 || (q == 0.5 && truncated % 2 != 0) {
        truncated + 1
    } else {
        truncated
    };
    rounded as f32
}

/// The `Vec2` range table shared by `Floor`/`Trunc`/`Round`/`RoundEven`/`Ceil`/`Fract`/
/// `Modf`/`FloatBitsToInt`/`FloatBitsToUint` (`AbsCase`'s own float range, above, happens
/// to be the same values but is kept separate - upstream declares its own copy of this
/// same table in every one of those classes rather than sharing it, so there is no single
/// upstream name to point this at).
fn round_input_range(precision: Precision) -> (f32, f32) {
    match precision {
        Precision::LowP => (-2.0, 2.0),
        Precision::MediumP => (-1e3, 1e3),
        Precision::HighP => (-1e7, 1e7),
    }
}

/// `count` values of `ndx - offset` (`ndx` in `0..count`), clamped into this precision's own
/// range - `Round`/`Fract`'s shared `10` around `5.5`, `RoundEven`'s own `20` around `10.5`.
fn special_half_integers(count: usize, offset: f32, precision: Precision) -> Vec<f32> {
    let (lo, hi) = round_input_range(precision);
    (0..count).map(|ndx| (ndx as f32 - offset).clamp(lo, hi)).collect()
}

/// Shared `getInputValues` shape for every single-float-in/single-float-out function in
/// this file: some fixed leading special-case values (function-specific, empty for
/// `Floor`/`Ceil`), then random fill over this precision's own range, then - "If precision
/// is mediump, make sure values can be represented in fp16 exactly" - a round trip through
/// `Float16` so the reference computation never sees a value the shader's own mediump
/// storage could not represent. `Modf` alone does not use this (see its own comment on why).
fn generate_common_float_inputs(special_values: &[f32], precision: Precision, vec_size: usize, seed: u32) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let (lo, hi) = round_input_range(precision);
    let total_lanes = NUM_VALUES * vec_size;
    let mut values = vec![0.0f32; total_lanes];

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

/// Reproduces a real bug in upstream's own `RoundCase`/`RoundEvenCase`/
/// `FractCase::getInputValues`: their special-case loop is `std::fill((float
/// *)values[0], (float *)values[0] + scalarSize, v)` on *every* iteration - always the
/// first `scalarSize` slots, never offset by the loop index - so only the loop's last
/// value actually survives there, and every other "special" slot is left at the
/// buffer's zero-initialised default rather than holding its own intended value.
/// `numSpecialCases` is still incremented once per intended special regardless, so the
/// random fill afterward still starts past the whole special region, leaving the
/// zero-filled slots as literal zeros forever - not a case the port invented, and not
/// safe to "fix": a first draft of this file placed each special value at its own
/// offset (the obviously-intended behaviour), and disagreed with the real
/// `deqp-gles3` binary on every `roundeven.*_highp_*` case, because that correction
/// actually exercises `roundEven(-0.5)`, a genuine tie whose driver answer (`-0.0`)
/// legitimately differs from this file's own `+0.0` reference under highp's strict,
/// sign-sensitive comparison - a real disagreement upstream's own bug happens to hide
/// by never actually asking the question. Confirmed by reverting to this shape and
/// rerunning `diff_vs_deqp.py`: agrees again, 0 differ.
fn generate_buggy_special_float_inputs(
    special_values: &[f32],
    precision: Precision,
    vec_size: usize,
    seed: u32,
) -> Vec<u8> {
    let mut rnd = Random::new(seed);
    let (lo, hi) = round_input_range(precision);
    let total_lanes = NUM_VALUES * vec_size;
    let mut values = vec![0.0f32; total_lanes];

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

fn build_common_spec(func: CommonFunc, kind: ScalarKind, precision: Precision, vec_size: i32) -> ShaderSpec {
    let ty = base_data_type(kind, vec_size);
    let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = format!("out0 = {}(in0);", func.glsl_name());
    spec
}

/// `AbsCase`/`SignCase::getInputValues` - the fixed float/int ranges per function and
/// precision, read directly off the C++ rather than guessed (`Sign`'s own int range
/// reaches down to the true minimum, unlike `Abs`'s, which stops one short so the
/// reference `abs()` itself never overflows). `Sign` additionally forces its first
/// three *values* (every lane of each) to `+1`/`-1`/`0` before filling the rest
/// randomly - the one case in this pair with a domain edge cheap enough to always hit
/// rather than leave to chance.
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

/// `AbsCase`/`SignCase::compare` - returns whether every lane of this one value passed.
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
                // "Both highp and mediump should be able to represent -1, 0, and +1
                // exactly" - only lowp gets a nonzero tolerance.
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
        let spec = build_common_spec(self.func, self.kind, self.precision, self.vec_size);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x235f_ac00u32
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

/// `addFunctionCases<TestClass>(parent, functionName, floatTypes, intTypes, uintTypes)`,
/// restricted to `Abs`/`Sign`'s own `(true, true, false)` - every `DataType` from
/// `vec_size in 1..=4` for each requested `kind`, every precision, both shader stages.
fn common_function_group(func: CommonFunc, name: &str, kinds: &[ScalarKind]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(name);
    for &kind in kinds {
        for vec_size in 1..=4i32 {
            for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
                for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
                    let case_name = format!(
                        "{}_{}_{}",
                        base_data_type(kind, vec_size).name(),
                        precision.name(),
                        stage.as_str()
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

// `Floor`/`Trunc`/`Round`/`RoundEven`/`Ceil` - one float in, one float out, each with its
// own reference formula and its own exact-vs-lowp-fuzzy comparison shape (see each
// `compare_*` function below for exactly which upstream branch it ports - they are *not*
// uniform across the five, and are kept as separate functions rather than one parameterised
// one for that reason).

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

    /// `roundeven`, not `roundEven` - upstream's own case-group name for it.
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

/// `FloorCase`/`TruncCase`/`RoundCase`/`RoundEvenCase`/`CeilCase::getInputValues`.
fn generate_round_inputs(func: RoundFunc, precision: Precision, vec_size: usize, seed: u32) -> Vec<u8> {
    match func {
        // `TruncCase`'s own special-case loop indexes correctly - no bug to reproduce.
        RoundFunc::Trunc => generate_common_float_inputs(&[0.0, -0.0, -0.9, 0.9, 1.0, -1.0], precision, vec_size, seed),
        // `RoundCase`/`RoundEvenCase` both need `generate_buggy_special_float_inputs` -
        // see its own doc comment.
        RoundFunc::Round if precision != Precision::LowP => {
            generate_buggy_special_float_inputs(&special_half_integers(10, 5.5, precision), precision, vec_size, seed)
        }
        RoundFunc::RoundEven if precision != Precision::LowP => {
            generate_buggy_special_float_inputs(&special_half_integers(20, 10.5, precision), precision, vec_size, seed)
        }
        _ => generate_common_float_inputs(&[], precision, vec_size, seed),
    }
}

/// `FloorCase::compare` - the simplest of the five: no zero-sign handling at all, in
/// either branch (upstream declares no `hasZeroSign`/ignore-zero-sign anywhere in this
/// one, unlike every other function in this group).
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

/// `TruncCase::compare` - unconditionally ignores the result's zero sign in both branches
/// ("trunc() function definition is a bit broad on negative zeros"), regardless of whether
/// this precision otherwise requires signed-zero support.
fn compare_trunc(precision: Precision, in0: f32, out0: f32) -> bool {
    if precision == Precision::HighP || precision == Precision::MediumP {
        get_ulp_diff_ignore_zero_sign(out0, in0.trunc()) == 0
    } else {
        let mantissa_bits = min_mantissa_bits(precision);
        let max_ulp = max_ulp_diff_from_bits(mantissa_bits);
        let eps = get_eps_from_bits(1.0, mantissa_bits);
        // Upstream's own lowp branch truncates `in0 +- eps` directly (a plain cast), not
        // via `trunc()` again - kept as written rather than "simplified" to match.
        let min_res = (in0 - eps) as i32;
        let max_res = (in0 + eps) as i32;
        (min_res..=max_res).any(|r| get_ulp_diff_ignore_zero_sign(out0, r as f32) <= max_ulp)
    }
}

/// `RoundCase::compare` - at an exact half-integer input, either neighbouring integer is
/// accepted (GLSL leaves round-half-to-even vs away-from-zero implementation-defined);
/// everywhere else the exact `roundEven` result is required. Both branches are gated by
/// this precision's own zero-sign support (`hasZeroSign`), unlike `Trunc`.
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

/// `RoundEvenCase::compare` - always the exact `roundEven` result, no half-integer
/// exception (that is `Round`'s own allowance, not this function's).
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

/// `CeilCase::compare` - like `RoundEven`/`Round`, gated on `hasZeroSign`; its lowp branch
/// additionally accepts `-0` even when the candidate-integer loop alone would not, since
/// `ceil` of a small negative value can legitimately be `-0` (`de::inRange(0, minRes,
/// maxRes)` - "Allow -0 as well").
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
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
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
            for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage.as_str()
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

// `Fract` - its own case, not folded into the `RoundFunc` group above: its lowp branch
// checks whether `in0 +- eps` crosses an integer boundary at all (rather than looping over
// a candidate range), and widens its own ULP threshold by `numBitsLostInOp` rather than
// using a fixed one.

struct FractCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

/// `FractCase::compare`.
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
            // Straddles an integer boundary - upstream only requires the result stay
            // below 1.0 here, not that it match any particular fractional value.
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
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
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
        // `FractCase` has the same special-case-placement bug `Round`/`RoundEven` do -
        // see `generate_buggy_special_float_inputs`'s own doc comment.
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
            for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage.as_str()
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

// `Modf` - two outputs (fractional part returned, integer part written through `out1`),
// and - unlike every other function in this file - no fp16 snap on its mediump inputs at
// all (upstream's own `ModfCase::getInputValues` simply omits that step; not an oversight
// this port introduces).

struct ModfCase {
    name: String,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

/// `ModfCase::compare` - checks that `out0 + out1` reconstructs `in0`, at a threshold
/// widened by however many mantissa bits the subtraction (`in0 - refOut1`) itself lost.
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
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
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
            for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage.as_str()
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

// `Isnan`/`Isinf` - float input built directly from crafted sign/exponent/mantissa bit
// fields (rather than from a value range) so the domain includes NaN/Inf at all, bool
// output. Only `highp` is required to actually distinguish them; below that the shader is
// merely required to answer `0` or `1`, never anything else.

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

/// `IsnanCase`/`IsinfCase::getInputValues` - which of `isNan`/`isInf` is drawn first (and
/// therefore gets the wider `0.3` share) differs between the two, matching upstream's own
/// two near-identical bodies exactly rather than sharing one draw order for both.
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

/// `IsnanCase`/`IsinfCase::compare`.
fn compare_nan_inf(func: NanInfFunc, precision: Precision, in0_bits: u32, out0: i32) -> bool {
    if precision == Precision::HighP {
        let in0 = f32::from_bits(in0_bits);
        let ref0 = match func {
            NanInfFunc::Isnan => i32::from(in0.is_nan()),
            NanInfFunc::Isinf => i32::from(in0.is_infinite()),
        };
        out0 == ref0
    } else {
        out0 == 0 || out0 == 1
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
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
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
                    !compare_nan_inf(self.func, self.precision, in0_bits[i], out0_i[i])
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
            for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage.as_str()
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

// `FloatBitsToInt`/`FloatBitsToUint` - float input at a variable precision, int/uint
// output fixed at highp; the comparison tolerates a ULP difference proportional to the
// *input's* precision, since a lowp/mediump-stored `in0` may not carry the same bits the
// host generated it with.

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
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
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
            for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
                let case_name = format!(
                    "{}_{}_{}",
                    glu::get_data_type_float_vec(vec_size).name(),
                    precision.name(),
                    stage.as_str()
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

// `(u)intBitsToFloat` - the one function in this file registered directly under `common`
// rather than through `addFunctionCases`'s per-function wrapper group (same resulting
// depth either way: `common.<name>.<case>`), fixed at `highp`, and - upstream's own loop
// bound is `vecSize < 4`, not `<= 4` - the only function here with no `vec4` case at all.

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
        let mut spec = ShaderSpec::new(glu::GlslVersion::Es300);
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
        // Filled as floats but fed through an int/uint-typed input symbol - same
        // underlying bit pattern either way ("\note Filled as floats.").
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
    // Upstream's own loop bound: `vecSize < 4`, i.e. scalar/vec2/vec3 only - no vec4.
    for vec_size in 1..4i32 {
        let in_ty = if in_is_signed {
            glu::get_data_type_int_vec(vec_size)
        } else {
            glu::get_data_type_uint_vec(vec_size)
        };
        for &stage in &[ShaderType::Vertex, ShaderType::Fragment] {
            let case_name = format!("{}_{}_{}", in_ty.name(), Precision::HighP.name(), stage.as_str());
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

/// `ShaderCommonFunctionTests::init` - every function in
/// `es3fShaderCommonFunctionTests.cpp` is now ported.
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
        // abs/sign: 2 kinds x 4 vec_sizes x 3 precisions x 2 stages, each.
        // floor/trunc/round/roundeven/ceil/fract/modf/isnan/isinf/floatbitstoint/
        // floatbitstouint: 4 vec_sizes x 3 precisions x 2 stages, each (11 functions).
        // intbitstofloat/uintbitstofloat: 3 vec_sizes (no vec4) x 2 stages, each.
        // Matches the real gles3-main mustpass exactly (372 cases total, confirmed via
        // `grep -c 'shaders\.builtin_functions\.common\.<fn>\.' gles3-main.txt` per
        // function before writing this).
        let expected = 2 * (2 * 4 * 3 * 2) + 11 * (4 * 3 * 2) + 2 * (3 * 2);
        assert_eq!(expected, 372);
        assert_eq!(names.len(), expected);
        assert!(names.contains(&"common.abs.float_highp_vertex".to_string()));
        assert!(names.contains(&"common.abs.ivec4_lowp_fragment".to_string()));
        assert!(names.contains(&"common.sign.vec2_mediump_vertex".to_string()));
        assert!(names.contains(&"common.sign.ivec3_highp_fragment".to_string()));
        assert!(names.contains(&"common.floor.float_highp_vertex".to_string()));
        assert!(names.contains(&"common.trunc.vec4_lowp_fragment".to_string()));
        assert!(names.contains(&"common.round.vec2_mediump_vertex".to_string()));
        assert!(names.contains(&"common.roundeven.vec3_highp_fragment".to_string()));
        assert!(names.contains(&"common.ceil.float_lowp_vertex".to_string()));
        assert!(names.contains(&"common.fract.vec4_highp_fragment".to_string()));
        assert!(names.contains(&"common.modf.vec2_lowp_vertex".to_string()));
        assert!(names.contains(&"common.isnan.float_highp_fragment".to_string()));
        assert!(names.contains(&"common.isinf.vec3_mediump_vertex".to_string()));
        assert!(names.contains(&"common.floatbitstoint.vec4_highp_fragment".to_string()));
        assert!(names.contains(&"common.floatbitstouint.float_lowp_vertex".to_string()));
        assert!(names.contains(&"common.intbitstofloat.ivec3_highp_fragment".to_string()));
        assert!(names.contains(&"common.uintbitstofloat.uint_highp_vertex".to_string()));
        assert!(
            !names.contains(&"common.intbitstofloat.ivec4_highp_vertex".to_string()),
            "no vec4 case for (u)intBitsToFloat"
        );
    }

    #[test]
    fn ulp_diff_is_a_raw_unsigned_bit_pattern_difference() {
        assert_eq!(ulp_diff(1.0, 1.0), 0);
        assert_eq!(ulp_diff(0.0, -0.0), 0.0f32.to_bits().abs_diff((-0.0f32).to_bits()));
        assert!(ulp_diff(1.0, f32::from_bits(1.0f32.to_bits() + 1)) == 1);
    }

    #[test]
    fn max_ulp_diff_matches_upstream_get_max_ulp_diff_from_bits() {
        assert_eq!(max_ulp_diff_from_bits(23), 0);
        assert_eq!(max_ulp_diff_from_bits(10), (1u32 << 13) - 1);
        assert_eq!(max_ulp_diff_from_bits(7), (1u32 << 16) - 1);
    }
}

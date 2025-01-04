// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles31/functional/es31fShaderIntegerFunctionTests.cpp / .hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// A third, genuinely separate `shaders.builtin_functions` subgroup (`integer`, 1056
// gles31 cases, 0 gles3 - GLSL ES's integer builtins are 3.1+ only) alongside
// `precision` (`gls::builtin_precision_tests`) and `common`
// (`shader_common_function_tests`). Unlike those two, every case here is an exact- or
// range-threshold comparison over raw 32-bit patterns - no interval arithmetic, no
// `Float16`/`Float32` snapping.
//
// This file's own local `addFunctionCases` template (`integer_function_group` here) is
// a *different* shape from `shader_common_function_tests.rs`'s: it has no float axis at
// all (`scalarTypes = {INT, UINT}` only) and gates the *whole precision axis* on
// `allPrec` (`false` means highp-only), not a per-function shader-stage subset - every
// function here registers over all six stages (`ALL_SHADERS`), never `NEW_SHADERS`.
//
// **`UaddCarryCase`/`UsubBorrowCase` reproduce a real upstream bug, faithfully**: their
// own `getInputValues` fills 8/6 "easy" special cases into the buffer's first slots,
// then calls the shared `generateRandomInputData(rnd, ..., in0, numValues -
// easyCases.len())` - which (unlike `UmulExtendedCase`/`ImulExtendedCase`'s own
// hand-written fill loops, which track and advance a `valueNdx`) always writes
// starting at `dst[0]`, never offset past the easy cases just written. With a reduced
// count of `numValues - easyCases.len()`, this overwrites nearly all of the "easy"
// cases with fresh random data and leaves the last `easyCases.len()` slots at their
// zero-initialised default, so none of the intended special values ever reach the
// shader. Confirmed by reading `generateRandomInputData` character-by-character (it has
// no offset parameter). This does not create a genuine correctness *mismatch* the way
// the `RoundCase`/`RoundEvenCase` bug elsewhere in this campaign did - the reference is
// always computed from whatever data actually reached the shader, so both the buggy and
// the "obviously intended" version would still agree with a conformant driver - but
// "ported code keeps the upstream C++ shape" applies regardless of whether a given quirk
// is externally observable, so it is reproduced rather than silently corrected.
// `generate_carry_inputs` below is the equivalent of `generate_buggy_special_float_inputs`
// in the `common` module for this same class of bug.
//
// **`BitfieldInsertCase`'s own `compare` shifts by `offset`, which can legally reach 32**
// (`bits == 0` makes `numBits - bits == numBits`, and `offset = rnd.getInt(0, numBits -
// bits)` is inclusive) - upstream's C++ never guards this (`mask << offset` with no
// `offset == 32` special case, unlike `BitfieldExtractCase`'s own compare, which does
// guard it). Shifting a 32-bit value by 32 is undefined behaviour in C++, but on the
// x86_64 this project (and the real `deqp-gles31` binary compared against) both run on,
// the compiled `shl`/`shr` instruction masks its shift count to 5 bits in hardware, so in
// practice the shift is a no-op - and since `bits == 0` also forces `mask == 0`, the
// shifted value is `0` either way and the *result* is unaffected by which behaviour occurs.
// `u32::wrapping_shl` reproduces that same "shift count taken modulo the width" hardware
// behaviour without Rust's own shift-amount overflow panic, which is what matters here:
// getting a real x86 answer rather than aborting the test process.

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType};
use crate::tcu::random::{Random, de_string_hash};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// `IntegerFunctionCase::m_numValues`
const NUM_VALUES: usize = 100;

/// `ALL_SHADERS` - every function in this file registers over all six stages, upstream's
/// own `glu::ShaderType` enum order.
const ALL_STAGES: [ShaderType; 6] = [
    ShaderType::Vertex,
    ShaderType::Fragment,
    ShaderType::Geometry,
    ShaderType::TessControl,
    ShaderType::TessEvaluation,
    ShaderType::Compute,
];

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

fn glsl_version(context: &Context) -> glu::GlslVersion {
    if context.context_type().supports(3, 2) {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum ScalarKind {
    Int,
    Uint,
}

fn base_data_type(kind: ScalarKind, vec_size: i32) -> DataType {
    match kind {
        ScalarKind::Int => glu::get_data_type_int_vec(vec_size),
        ScalarKind::Uint => glu::get_data_type_uint_vec(vec_size),
    }
}

fn u32s_to_bytes(values: &[u32]) -> Vec<u8> {
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

fn u32s_from_bytes(bytes: &[u8]) -> Vec<u32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| u32::from_ne_bytes(*c)).collect()
}

fn i32s_from_bytes(bytes: &[u8]) -> Vec<i32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| i32::from_ne_bytes(*c)).collect()
}

/// `getShaderUintBitCount` - ignores `shaderType` entirely (upstream's own `\todo`:
/// "Query from GL for vertex and fragment shaders").
fn shader_uint_bit_count(precision: Precision) -> i32 {
    match precision {
        Precision::LowP => 9,
        Precision::MediumP => 16,
        Precision::HighP => 32,
    }
}

/// `getLowBitMask` - `((1u << (n-1)) << 1) - 1u` in two steps so the shift amount is
/// always `< 32` (the direct `(1u << n) - 1` upstream's own comment calls out as
/// undefined for `n == 32`); the intermediate `<< 1` and final `- 1` both wrap by
/// construction (`n == 32` wraps the top bit out to `0`, then wraps back to
/// `0xffffffff` - the correct all-ones answer), so both use the explicit `wrapping_*`
/// forms rather than Rust's panic-on-overflow-in-debug plain operators.
fn low_bit_mask(integer_length: i32) -> u32 {
    if integer_length == 0 {
        0
    } else {
        ((1u32 << (integer_length - 1)) << 1).wrapping_sub(1)
    }
}

/// `extendSignTo32` - `0 - int32_t(sign_bit_shifted)` reproduced via `wrapping_sub`,
/// which is the same two's-complement bit pattern regardless of signedness.
fn extend_sign_to32(integer: u32, integer_length: u32) -> u32 {
    let sign_shifted = (integer & (1u32 << (integer_length - 1))) << 1;
    0u32.wrapping_sub(sign_shifted) | integer
}

fn to_precision_u32(value: u32, num_integer_bits: i32) -> u32 {
    value & low_bit_mask(num_integer_bits)
}

fn to_precision_i32(value: i32, num_integer_bits: i32) -> i32 {
    extend_sign_to32((value as u32) & low_bit_mask(num_integer_bits), num_integer_bits as u32) as i32
}

/// `generateRandomInputData` - flat, linear fill of `dst[..count * vec_size]` starting
/// at index 0 (never offset), matching upstream's own signature exactly; callers that
/// need an offset (`UmulExtendedCase`/`ImulExtendedCase`'s own hand-written loops) do
/// not go through this helper at all, precisely because they need one.
fn generate_random_input_data(
    rnd: &mut Random,
    kind: ScalarKind,
    precision: Precision,
    vec_size: usize,
    count: usize,
    dst: &mut [u32],
) {
    let integer_length = shader_uint_bit_count(precision) as u32;
    let integer_mask = low_bit_mask(integer_length as i32);
    match kind {
        ScalarKind::Uint => {
            for v in &mut dst[..count * vec_size] {
                *v = rnd.get_uint32() & integer_mask;
            }
        }
        ScalarKind::Int => {
            for v in &mut dst[..count * vec_size] {
                *v = extend_sign_to32(rnd.get_uint32() & integer_mask, integer_length);
            }
        }
    }
}

fn in_range(x: i32, a: i32, b: i32) -> bool {
    a <= x && x <= b
}

fn integer_function_group<F>(
    name: &str,
    int_types: bool,
    uint_types: bool,
    all_prec: bool,
    mut make_case: F,
) -> TestCaseGroup
where
    F: FnMut(ScalarKind, i32, Precision, ShaderType) -> Box<dyn TestCase>,
{
    let mut group = TestCaseGroup::new(name);
    let kinds: &[ScalarKind] = match (int_types, uint_types) {
        (true, true) => &[ScalarKind::Int, ScalarKind::Uint],
        (true, false) => &[ScalarKind::Int],
        (false, true) => &[ScalarKind::Uint],
        (false, false) => &[],
    };
    for &kind in kinds {
        for vec_size in 1..=4i32 {
            for &precision in &[Precision::LowP, Precision::MediumP, Precision::HighP] {
                if precision != Precision::HighP && !all_prec {
                    continue;
                }
                for &stage in &ALL_STAGES {
                    group.add_child(make_case(kind, vec_size, precision, stage));
                }
            }
        }
    }
    group
}

fn case_name(kind: ScalarKind, vec_size: i32, precision: Precision, stage: ShaderType) -> String {
    format!(
        "{}_{}_{}",
        base_data_type(kind, vec_size).name(),
        precision.name(),
        stage_name_postfix(stage)
    )
}

// `UaddCarry`/`UsubBorrow` - see this file's own header for the special-case bug both
// reproduce faithfully.

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum CarryOp {
    UaddCarry,
    UsubBorrow,
}

impl CarryOp {
    fn glsl_name(self) -> &'static str {
        match self {
            Self::UaddCarry => "uaddCarry",
            Self::UsubBorrow => "usubBorrow",
        }
    }

    fn out0_name(self) -> &'static str {
        match self {
            Self::UaddCarry => "sum",
            Self::UsubBorrow => "diff",
        }
    }

    fn easy_cases(self) -> &'static [(u32, u32)] {
        match self {
            Self::UaddCarry => &[
                (0x0000_0000, 0x0000_0000),
                (0xffff_fffe, 0x0000_0001),
                (0x0000_0001, 0xffff_fffe),
                (0xffff_ffff, 0x0000_0001),
                (0x0000_0001, 0xffff_ffff),
                (0xffff_fffe, 0x0000_0002),
                (0x0000_0002, 0xffff_fffe),
                (0xffff_ffff, 0xffff_ffff),
            ],
            Self::UsubBorrow => &[
                (0x0000_0000, 0x0000_0000),
                (0x0000_0001, 0x0000_0001),
                (0x0000_0001, 0x0000_0002),
                (0x0000_0001, 0xffff_ffff),
                (0xffff_fffe, 0xffff_ffff),
                (0xffff_ffff, 0xffff_ffff),
            ],
        }
    }
}

fn generate_carry_inputs(
    op: CarryOp,
    kind: ScalarKind,
    precision: Precision,
    seed: u32,
    vec_size: usize,
) -> (Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(seed);
    let integer_length = shader_uint_bit_count(precision);
    let integer_mask = low_bit_mask(integer_length);
    let is_signed = kind == ScalarKind::Int;
    let easy = op.easy_cases();

    let mut in0 = vec![0u32; NUM_VALUES * vec_size];
    let mut in1 = vec![0u32; NUM_VALUES * vec_size];

    for (ndx, &(x, y)) in easy.iter().enumerate() {
        for lane in 0..vec_size {
            in0[ndx * vec_size + lane] = x & integer_mask;
            in1[ndx * vec_size + lane] = y & integer_mask;
        }
    }
    if is_signed {
        for ndx in 0..easy.len() {
            for lane in 0..vec_size {
                in0[ndx * vec_size + lane] = extend_sign_to32(in0[ndx * vec_size + lane], integer_length as u32);
                in1[ndx * vec_size + lane] = extend_sign_to32(in1[ndx * vec_size + lane], integer_length as u32);
            }
        }
    }

    // See this file's own header: `generateRandomInputData` always starts at `dst[0]`,
    // so this overwrites nearly all of the easy cases just written above rather than
    // filling the slots after them.
    let random_count = NUM_VALUES - easy.len();
    generate_random_input_data(&mut rnd, kind, precision, vec_size, random_count, &mut in0);
    generate_random_input_data(&mut rnd, kind, precision, vec_size, random_count, &mut in1);

    (u32s_to_bytes(&in0), u32s_to_bytes(&in1))
}

fn compare_carry(op: CarryOp, mask0: u32, in0: u32, in1: u32, out0: u32, out1: u32) -> bool {
    let (ref0, ref1) = match op {
        CarryOp::UaddCarry => (
            in0.wrapping_add(in1),
            u32::from(u64::from(in0) + u64::from(in1) > 0xffff_ffff),
        ),
        CarryOp::UsubBorrow => (in0.wrapping_sub(in1), u32::from(in0 < in1)),
    };
    (out0 & mask0) == (ref0 & mask0) && out1 == ref1
}

struct CarryCase {
    name: String,
    op: CarryOp,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for CarryCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("x", VarType::basic(ty, Some(self.precision))));
        spec.inputs
            .push(Symbol::new("y", VarType::basic(ty, Some(self.precision))));
        spec.outputs.push(Symbol::new(
            self.op.out0_name(),
            VarType::basic(ty, Some(self.precision)),
        ));
        spec.outputs
            .push(Symbol::new("carry", VarType::basic(ty, Some(Precision::LowP))));
        spec.source = format!("{} = {}(x, y, carry);", self.op.out0_name(), self.op.glsl_name());
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x235fac;
        let (in0, in1) = generate_carry_inputs(self.op, self.kind, self.precision, seed, vec_size);
        let mut out0 = vec![0u8; in0.len()];
        let mut out1 = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 2] = [&in0, &in1];
            let mut outputs: [&mut [u8]; 2] = [&mut out0, &mut out1];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_u = u32s_from_bytes(&in0);
        let in1_u = u32s_from_bytes(&in1);
        let out0_u = u32s_from_bytes(&out0);
        let out1_u = u32s_from_bytes(&out1);
        let mask0 = low_bit_mask(shader_uint_bit_count(self.precision));
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_carry(self.op, mask0, in0_u[i], in1_u[i], out0_u[i], out1_u[i])
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

fn carry_group(op: CarryOp, name: &str) -> TestCaseGroup {
    integer_function_group(name, false, true, true, move |kind, vec_size, precision, stage| {
        Box::new(CarryCase {
            name: case_name(kind, vec_size, precision, stage),
            op,
            kind,
            vec_size,
            precision,
            stage,
        }) as Box<dyn TestCase>
    })
}

// `UmulExtended`/`ImulExtended` - unlike `UaddCarry`/`UsubBorrow` above, these hand-write
// their own fill loop with a correctly-tracked `valueNdx`, so no special-case bug here.

fn generate_mul_extended_inputs(signed: bool, seed: u32, vec_size: usize) -> (Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(seed);
    let easy: &[(u32, u32)] = if signed {
        &[
            (0x0000_0000, 0x0000_0000),
            (0xffff_ffff, 0x0000_0002),
            (0x7fff_ffff, 0x0000_0001),
            (0x7fff_ffff, 0x0000_0002),
            (0x7fff_ffff, 0x7fff_ffff),
            (0xffff_ffff, 0xffff_ffff),
            (0x7fff_ffff, 0xffff_fffe),
        ]
    } else {
        &[
            (0x0000_0000, 0x0000_0000),
            (0xffff_ffff, 0x0000_0001),
            (0xffff_ffff, 0x0000_0002),
            (0x0000_0001, 0xffff_ffff),
            (0x0000_0002, 0xffff_ffff),
            (0xffff_ffff, 0xffff_ffff),
        ]
    };

    let mut in0 = vec![0u32; NUM_VALUES * vec_size];
    let mut in1 = vec![0u32; NUM_VALUES * vec_size];
    let mut value_ndx = 0usize;

    for &(x, y) in easy {
        for lane in 0..vec_size {
            in0[value_ndx * vec_size + lane] = x;
            in1[value_ndx * vec_size + lane] = y;
        }
        value_ndx += 1;
    }

    while value_ndx < NUM_VALUES {
        for lane in 0..vec_size {
            let base0 = rnd.get_uint32();
            let base1 = rnd.get_uint32();
            let adj0 = rnd.get_int(0, 20) as u32;
            let adj1 = rnd.get_int(0, 20) as u32;
            let (v0, v1) = if signed {
                (((base0 as i32) >> adj0) as u32, ((base1 as i32) >> adj1) as u32)
            } else {
                (base0 >> adj0, base1 >> adj1)
            };
            in0[value_ndx * vec_size + lane] = v0;
            in1[value_ndx * vec_size + lane] = v1;
        }
        value_ndx += 1;
    }

    (u32s_to_bytes(&in0), u32s_to_bytes(&in1))
}

fn compare_mul_extended(signed: bool, in0: u32, in1: u32, out0: u32, out1: u32) -> bool {
    if signed {
        let mul = i64::from(in0 as i32) * i64::from(in1 as i32);
        let ref0 = (mul >> 32) as i32 as u32;
        let ref1 = (mul & 0xffff_ffff) as u32;
        out0 == ref0 && out1 == ref1
    } else {
        let mul = u64::from(in0) * u64::from(in1);
        let ref0 = (mul >> 32) as u32;
        let ref1 = (mul & 0xffff_ffff) as u32;
        out0 == ref0 && out1 == ref1
    }
}

struct MulExtendedCase {
    name: String,
    signed: bool,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for MulExtendedCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("x", VarType::basic(ty, Some(self.precision))));
        spec.inputs
            .push(Symbol::new("y", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("msb", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("lsb", VarType::basic(ty, Some(self.precision))));
        spec.source = format!(
            "{}(x, y, msb, lsb);",
            if self.signed { "imulExtended" } else { "umulExtended" }
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

        let seed = de_string_hash(&self.name) ^ if self.signed { 0x224fa1 } else { 0x235fac };
        let (in0, in1) = generate_mul_extended_inputs(self.signed, seed, vec_size);
        let mut msb = vec![0u8; in0.len()];
        let mut lsb = vec![0u8; in0.len()];
        {
            let inputs: [&[u8]; 2] = [&in0, &in1];
            let mut outputs: [&mut [u8]; 2] = [&mut msb, &mut lsb];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let in0_u = u32s_from_bytes(&in0);
        let in1_u = u32s_from_bytes(&in1);
        let msb_u = u32s_from_bytes(&msb);
        let lsb_u = u32s_from_bytes(&lsb);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_mul_extended(self.signed, in0_u[i], in1_u[i], msb_u[i], lsb_u[i])
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

fn mul_extended_group(signed: bool, name: &str) -> TestCaseGroup {
    integer_function_group(name, signed, !signed, false, move |kind, vec_size, precision, stage| {
        Box::new(MulExtendedCase {
            name: case_name(kind, vec_size, precision, stage),
            signed,
            kind,
            vec_size,
            precision,
            stage,
        }) as Box<dyn TestCase>
    })
}

// `BitfieldExtract`

fn generate_bitfield_extract_inputs(
    kind: ScalarKind,
    precision: Precision,
    seed: u32,
    vec_size: usize,
) -> (Vec<u8>, Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(seed);
    let ignore_sign = precision != Precision::HighP && kind == ScalarKind::Int;
    let num_bits = shader_uint_bit_count(precision) - i32::from(ignore_sign);

    let mut offset = vec![0i32; NUM_VALUES];
    let mut bits = vec![0i32; NUM_VALUES];
    for i in 0..NUM_VALUES {
        let b = rnd.get_int(0, num_bits);
        let o = rnd.get_int(0, num_bits - b);
        bits[i] = b;
        offset[i] = o;
    }

    let mut value = vec![0u32; NUM_VALUES * vec_size];
    generate_random_input_data(&mut rnd, kind, precision, vec_size, NUM_VALUES, &mut value);

    (u32s_to_bytes(&value), i32s_to_bytes(&offset), i32s_to_bytes(&bits))
}

fn compare_bitfield_extract(is_signed: bool, value: u32, offset: i32, bits: i32, out: u32) -> bool {
    let reference = if bits == 0 {
        0u32
    } else {
        let val_mask: u32 = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
        let base_val: u32 = if offset == 32 { 0 } else { (value >> offset) & val_mask };
        let sign_extend = is_signed && (base_val & (1u32 << (bits - 1))) != 0;
        base_val | if sign_extend { !val_mask } else { 0 }
    };
    out == reference
}

struct BitfieldExtractCase {
    name: String,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for BitfieldExtractCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("value", VarType::basic(ty, Some(self.precision))));
        spec.inputs.push(Symbol::new(
            "offset",
            VarType::basic(DataType::Int, Some(self.precision)),
        ));
        spec.inputs
            .push(Symbol::new("bits", VarType::basic(DataType::Int, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("extracted", VarType::basic(ty, Some(self.precision))));
        spec.source = "extracted = bitfieldExtract(value, offset, bits);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0xa113_fca2;
        let (value, offset, bits) = generate_bitfield_extract_inputs(self.kind, self.precision, seed, vec_size);
        let mut extracted = vec![0u8; value.len()];
        {
            let inputs: [&[u8]; 3] = [&value, &offset, &bits];
            let mut outputs: [&mut [u8]; 1] = [&mut extracted];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let value_u = u32s_from_bytes(&value);
        let offset_i = i32s_from_bytes(&offset);
        let bits_i = i32s_from_bytes(&bits);
        let extracted_u = u32s_from_bytes(&extracted);
        let is_signed = self.kind == ScalarKind::Int;
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_bitfield_extract(
                        is_signed,
                        value_u[i],
                        offset_i[value_ndx],
                        bits_i[value_ndx],
                        extracted_u[i],
                    )
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

fn bitfield_extract_group() -> TestCaseGroup {
    integer_function_group(
        "bitfieldextract",
        true,
        true,
        true,
        |kind, vec_size, precision, stage| {
            Box::new(BitfieldExtractCase {
                name: case_name(kind, vec_size, precision, stage),
                kind,
                vec_size,
                precision,
                stage,
            }) as Box<dyn TestCase>
        },
    )
}

// `BitfieldInsert` - see this file's own header for why `offset` reaching `32` needs
// `wrapping_shl` rather than a guard.

fn generate_bitfield_insert_inputs(
    kind: ScalarKind,
    precision: Precision,
    seed: u32,
    vec_size: usize,
) -> (Vec<u8>, Vec<u8>, Vec<u8>, Vec<u8>) {
    let mut rnd = Random::new(seed);
    let num_bits = shader_uint_bit_count(precision);

    let mut offset = vec![0i32; NUM_VALUES];
    let mut bits = vec![0i32; NUM_VALUES];
    for i in 0..NUM_VALUES {
        let b = rnd.get_int(0, num_bits);
        let o = rnd.get_int(0, num_bits - b);
        bits[i] = b;
        offset[i] = o;
    }

    let mut base = vec![0u32; NUM_VALUES * vec_size];
    let mut insert = vec![0u32; NUM_VALUES * vec_size];
    generate_random_input_data(&mut rnd, kind, precision, vec_size, NUM_VALUES, &mut base);
    generate_random_input_data(&mut rnd, kind, precision, vec_size, NUM_VALUES, &mut insert);

    (
        u32s_to_bytes(&base),
        u32s_to_bytes(&insert),
        i32s_to_bytes(&offset),
        i32s_to_bytes(&bits),
    )
}

fn compare_bitfield_insert(cmp_mask: u32, base: u32, insert: u32, offset: i32, bits: i32, out: u32) -> bool {
    let mask: u32 = if bits == 32 { !0u32 } else { (1u32 << bits) - 1 };
    let offset = offset as u32;
    let reference = (base & !mask.wrapping_shl(offset)) | (insert & mask).wrapping_shl(offset);
    (out & cmp_mask) == (reference & cmp_mask)
}

struct BitfieldInsertCase {
    name: String,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for BitfieldInsertCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("base", VarType::basic(ty, Some(self.precision))));
        spec.inputs
            .push(Symbol::new("insert", VarType::basic(ty, Some(self.precision))));
        spec.inputs.push(Symbol::new(
            "offset",
            VarType::basic(DataType::Int, Some(self.precision)),
        ));
        spec.inputs
            .push(Symbol::new("bits", VarType::basic(DataType::Int, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("result", VarType::basic(ty, Some(self.precision))));
        spec.source = "result = bitfieldInsert(base, insert, offset, bits);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x12c2_acff;
        let (base, insert, offset, bits) = generate_bitfield_insert_inputs(self.kind, self.precision, seed, vec_size);
        let mut result = vec![0u8; base.len()];
        {
            let inputs: [&[u8]; 4] = [&base, &insert, &offset, &bits];
            let mut outputs: [&mut [u8]; 1] = [&mut result];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let base_u = u32s_from_bytes(&base);
        let insert_u = u32s_from_bytes(&insert);
        let offset_i = i32s_from_bytes(&offset);
        let bits_i = i32s_from_bytes(&bits);
        let result_u = u32s_from_bytes(&result);
        let cmp_mask = low_bit_mask(shader_uint_bit_count(self.precision));
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    !compare_bitfield_insert(
                        cmp_mask,
                        base_u[i],
                        insert_u[i],
                        offset_i[value_ndx],
                        bits_i[value_ndx],
                        result_u[i],
                    )
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

fn bitfield_insert_group() -> TestCaseGroup {
    integer_function_group(
        "bitfieldinsert",
        true,
        true,
        true,
        |kind, vec_size, precision, stage| {
            Box::new(BitfieldInsertCase {
                name: case_name(kind, vec_size, precision, stage),
                kind,
                vec_size,
                precision,
                stage,
            }) as Box<dyn TestCase>
        },
    )
}

// `BitfieldReverse`

fn reverse_bits(v: u32) -> u32 {
    let v = ((v & 0xaaaa_aaaa) >> 1) | ((v & 0x5555_5555) << 1);
    let v = ((v & 0xcccc_cccc) >> 2) | ((v & 0x3333_3333) << 2);
    let v = ((v & 0xf0f0_f0f0) >> 4) | ((v & 0x0f0f_0f0f) << 4);
    let v = ((v & 0xff00_ff00) >> 8) | ((v & 0x00ff_00ff) << 8);
    v.rotate_left(16)
}

struct BitfieldReverseCase {
    name: String,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for BitfieldReverseCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("value", VarType::basic(ty, Some(self.precision))));
        spec.outputs
            .push(Symbol::new("result", VarType::basic(ty, Some(Precision::HighP))));
        spec.source = "result = bitfieldReverse(value);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x00ff_23a4;
        let mut rnd = Random::new(seed);
        let mut value = vec![0u32; NUM_VALUES * vec_size];
        generate_random_input_data(&mut rnd, self.kind, self.precision, vec_size, NUM_VALUES, &mut value);
        let value_bytes = u32s_to_bytes(&value);
        let mut result = vec![0u8; value_bytes.len()];
        {
            let inputs: [&[u8]; 1] = [&value_bytes];
            let mut outputs: [&mut [u8]; 1] = [&mut result];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let result_u = u32s_from_bytes(&result);
        let cmp_mask = reverse_bits(low_bit_mask(shader_uint_bit_count(self.precision)));
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    let reference = reverse_bits(value[i]);
                    (result_u[i] & cmp_mask) != (reference & cmp_mask)
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

fn bitfield_reverse_group() -> TestCaseGroup {
    integer_function_group(
        "bitfieldreverse",
        true,
        true,
        true,
        |kind, vec_size, precision, stage| {
            Box::new(BitfieldReverseCase {
                name: case_name(kind, vec_size, precision, stage),
                kind,
                vec_size,
                precision,
                stage,
            }) as Box<dyn TestCase>
        },
    )
}

// `BitCount`/`FindLSB`/`FindMSB` - all three return a (vec of) plain `int`/`ivec`, always
// `lowp`, regardless of the input's own kind/precision.

fn int_result_type(vec_size: i32) -> DataType {
    glu::get_data_type_int_vec(vec_size)
}

fn find_lsb(value: u32) -> i32 {
    if value == 0 { -1 } else { value.trailing_zeros() as i32 }
}

fn find_msb_u32(value: u32) -> i32 {
    31 - value.leading_zeros() as i32
}

fn find_msb_i32(value: i32) -> i32 {
    if value < 0 {
        find_msb_u32(!(value as u32))
    } else {
        find_msb_u32(value as u32)
    }
}

struct BitCountCase {
    name: String,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for BitCountCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("value", VarType::basic(ty, Some(self.precision))));
        spec.outputs.push(Symbol::new(
            "count",
            VarType::basic(int_result_type(self.vec_size), Some(Precision::LowP)),
        ));
        spec.source = "count = bitCount(value);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x0ab2_cca4;
        let mut rnd = Random::new(seed);
        let mut value = vec![0u32; NUM_VALUES * vec_size];
        generate_random_input_data(&mut rnd, self.kind, self.precision, vec_size, NUM_VALUES, &mut value);
        let value_bytes = u32s_to_bytes(&value);
        let mut count = vec![0u8; value_bytes.len()];
        {
            let inputs: [&[u8]; 1] = [&value_bytes];
            let mut outputs: [&mut [u8]; 1] = [&mut count];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let count_i = i32s_from_bytes(&count);
        let count_mask = low_bit_mask(shader_uint_bit_count(self.precision));
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    let min_ref = (value[i] & count_mask).count_ones() as i32;
                    let max_ref = value[i].count_ones() as i32;
                    !in_range(count_i[i], min_ref, max_ref)
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

fn bit_count_group() -> TestCaseGroup {
    integer_function_group("bitcount", true, true, true, |kind, vec_size, precision, stage| {
        Box::new(BitCountCase {
            name: case_name(kind, vec_size, precision, stage),
            kind,
            vec_size,
            precision,
            stage,
        }) as Box<dyn TestCase>
    })
}

struct FindLSBCase {
    name: String,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for FindLSBCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("value", VarType::basic(ty, Some(self.precision))));
        spec.outputs.push(Symbol::new(
            "lsb",
            VarType::basic(int_result_type(self.vec_size), Some(Precision::LowP)),
        ));
        spec.source = "lsb = findLSB(value);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x9923_c2af;
        let mut rnd = Random::new(seed);
        let mut value = vec![0u32; NUM_VALUES * vec_size];
        generate_random_input_data(&mut rnd, self.kind, self.precision, vec_size, NUM_VALUES, &mut value);
        let value_bytes = u32s_to_bytes(&value);
        let mut lsb = vec![0u8; value_bytes.len()];
        {
            let inputs: [&[u8]; 1] = [&value_bytes];
            let mut outputs: [&mut [u8]; 1] = [&mut lsb];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let lsb_i = i32s_from_bytes(&lsb);
        let mask = low_bit_mask(shader_uint_bit_count(self.precision));
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    let min_ref = find_lsb(value[i] & mask);
                    let max_ref = find_lsb(value[i]);
                    !in_range(lsb_i[i], min_ref, max_ref)
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

fn find_lsb_group() -> TestCaseGroup {
    integer_function_group("findlsb", true, true, true, |kind, vec_size, precision, stage| {
        Box::new(FindLSBCase {
            name: case_name(kind, vec_size, precision, stage),
            kind,
            vec_size,
            precision,
            stage,
        }) as Box<dyn TestCase>
    })
}

struct FindMSBCase {
    name: String,
    kind: ScalarKind,
    vec_size: i32,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for FindMSBCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let vec_size = self.vec_size as usize;
        let ty = base_data_type(self.kind, self.vec_size);
        let mut spec = ShaderSpec::new(glsl_version(context));
        spec.inputs
            .push(Symbol::new("value", VarType::basic(ty, Some(self.precision))));
        spec.outputs.push(Symbol::new(
            "msb",
            VarType::basic(int_result_type(self.vec_size), Some(Precision::LowP)),
        ));
        spec.source = "msb = findMSB(value);".to_string();
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = de_string_hash(&self.name) ^ 0x0742_ac4e;
        let mut rnd = Random::new(seed);
        let mut value = vec![0u32; NUM_VALUES * vec_size];
        generate_random_input_data(&mut rnd, self.kind, self.precision, vec_size, NUM_VALUES, &mut value);
        let value_bytes = u32s_to_bytes(&value);
        let mut msb = vec![0u8; value_bytes.len()];
        {
            let inputs: [&[u8]; 1] = [&value_bytes];
            let mut outputs: [&mut [u8]; 1] = [&mut msb];
            executor.execute(NUM_VALUES as i32, &inputs, &mut outputs)?;
        }

        let msb_i = i32s_from_bytes(&msb);
        let is_signed = self.kind == ScalarKind::Int;
        let integer_length = shader_uint_bit_count(self.precision);
        let num_failed = (0..NUM_VALUES)
            .filter(|&value_ndx| {
                (0..vec_size).any(|lane| {
                    let i = value_ndx * vec_size + lane;
                    let v = value[i];
                    let (min_ref, max_ref) = if is_signed {
                        (
                            find_msb_i32(to_precision_i32(v as i32, integer_length)),
                            find_msb_i32(v as i32),
                        )
                    } else {
                        (find_msb_u32(to_precision_u32(v, integer_length)), find_msb_u32(v))
                    };
                    !in_range(msb_i[i], min_ref, max_ref)
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

fn find_msb_group() -> TestCaseGroup {
    integer_function_group("findmsb", true, true, true, |kind, vec_size, precision, stage| {
        Box::new(FindMSBCase {
            name: case_name(kind, vec_size, precision, stage),
            kind,
            vec_size,
            precision,
            stage,
        }) as Box<dyn TestCase>
    })
}

/// `ShaderIntegerFunctionTests::init`.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("integer");
    group.add_child(carry_group(CarryOp::UaddCarry, "uaddcarry"));
    group.add_child(carry_group(CarryOp::UsubBorrow, "usubborrow"));
    group.add_child(mul_extended_group(false, "umulextended"));
    group.add_child(mul_extended_group(true, "imulextended"));
    group.add_child(bitfield_extract_group());
    group.add_child(bitfield_insert_group());
    group.add_child(bitfield_reverse_group());
    group.add_child(bit_count_group());
    group.add_child(find_lsb_group());
    group.add_child(find_msb_group());
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
        // uaddcarry/usubborrow: uint only x 4 vec_sizes x 3 precisions x 6 stages, each.
        // umulextended/imulextended: one kind only x 4 vec_sizes x 1 precision (highp) x
        // 6 stages, each.
        // bitfieldextract/bitfieldinsert/bitfieldreverse/bitcount/findlsb/findmsb: 2
        // kinds x 4 vec_sizes x 3 precisions x 6 stages, each.
        // Matches the real gles31-main mustpass exactly (confirmed via `grep -c
        // 'shaders\.builtin_functions\.integer\.<fn>\.'` per function before writing
        // this: 72/72/24/24/144/144/144/144/144/144 = 1056 total).
        let expected = 2 * (4 * 3 * 6) + 2 * (4 * 6) + 6 * (2 * 4 * 3 * 6);
        assert_eq!(expected, 1056);
        assert_eq!(names.len(), expected);
        assert!(names.contains(&"integer.uaddcarry.uint_highp_vertex".to_string()));
        assert!(names.contains(&"integer.usubborrow.uvec4_lowp_compute".to_string()));
        assert!(
            !names
                .iter()
                .any(|n| n.starts_with("integer.uaddcarry.int_") || n.starts_with("integer.usubborrow.int_")),
            "uaddcarry/usubborrow are uint-only"
        );
        assert!(names.contains(&"integer.umulextended.uvec3_highp_geometry".to_string()));
        assert!(names.contains(&"integer.imulextended.ivec2_highp_tess_control".to_string()));
        assert!(
            !names
                .iter()
                .any(|n| n.starts_with("integer.umulextended.") && !n.contains("_highp_")),
            "umulextended is highp-only"
        );
        assert!(names.contains(&"integer.bitfieldextract.int_mediump_fragment".to_string()));
        assert!(names.contains(&"integer.bitfieldinsert.uvec4_lowp_tess_eval".to_string()));
        assert!(names.contains(&"integer.bitfieldreverse.ivec3_highp_compute".to_string()));
        assert!(names.contains(&"integer.bitcount.uint_lowp_vertex".to_string()));
        assert!(names.contains(&"integer.findlsb.ivec4_mediump_geometry".to_string()));
        assert!(names.contains(&"integer.findmsb.uvec2_highp_fragment".to_string()));
    }

    #[test]
    fn low_bit_mask_matches_known_values() {
        assert_eq!(low_bit_mask(0), 0);
        assert_eq!(low_bit_mask(1), 0x1);
        assert_eq!(low_bit_mask(9), 0x1ff);
        assert_eq!(low_bit_mask(32), 0xffff_ffff);
    }

    #[test]
    fn extend_sign_to32_matches_known_values() {
        // 9-bit -1 (0x1ff) sign-extends to the full-width -1.
        assert_eq!(extend_sign_to32(0x1ff, 9), 0xffff_ffff);
        // 9-bit 0 stays 0.
        assert_eq!(extend_sign_to32(0x000, 9), 0x0000_0000);
        // A positive 9-bit value (sign bit clear) is unaffected.
        assert_eq!(extend_sign_to32(0x0ff, 9), 0x0000_00ff);
        // Full 32-bit width is always a no-op, whatever the top bit is.
        assert_eq!(extend_sign_to32(0x8000_0000, 32), 0x8000_0000);
    }

    #[test]
    fn find_msb_matches_known_values() {
        assert_eq!(find_msb_u32(0), -1);
        assert_eq!(find_msb_u32(1), 0);
        assert_eq!(find_msb_u32(0xffff_ffff), 31);
        assert_eq!(find_msb_i32(0), -1);
        assert_eq!(find_msb_i32(-1), -1);
        assert_eq!(find_msb_i32(1), 0);
        assert_eq!(find_msb_i32(-2), 0);
        assert_eq!(find_msb_i32(i32::MIN), 30);
    }

    #[test]
    fn reverse_bits_matches_known_values() {
        assert_eq!(reverse_bits(0x0000_0001), 0x8000_0000);
        assert_eq!(reverse_bits(0x0000_0000), 0);
        assert_eq!(reverse_bits(0xffff_ffff), 0xffff_ffff);
    }
}

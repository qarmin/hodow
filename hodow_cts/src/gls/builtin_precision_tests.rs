// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsBuiltinPrecisionTests.cpp        (deqp::gls::BuiltinPrecisionTests::)
//   modules/gles3/functional/es3fBuiltinPrecisionTests.cpp
//   modules/gles31/functional/es31fBuiltinPrecisionTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `shaders.builtin_functions.precision` - a genuinely different testing style from
// every other GLES port here: instead of comparing a shader's result against one
// captured value, it computes a *reference interval* (`tcu::Interval`, via
// `tcu::FloatFormat`) bounding every answer a conformant driver is allowed to produce
// at the case's own precision (highp/mediump/lowp), and only fails if the shader's
// answer falls outside it. Upstream's own framework for this
// (`glsBuiltinPrecisionTests.cpp`, 5776 lines) is a C++ expression-template AST -
// `Expr<T>`/`ExprP<T>`/`Func<Sig>`, generic over scalar/vector/matrix element types -
// where a function like `Sin` or `Dot` is defined as a *formula* over other functions,
// and the interval bound falls out of evaluating that formula with interval semantics
// instead of point semantics.
//
// **`Add`/`Sub`/`Mul`/`Div`/`Min`/`Max`/`Clamp`/`Sin`/`Cos`/`ASin`/`ACos`/`ATan`/`ATan2`/
// `Exp`/`Log`/`Radians`/`Degrees`/`Tan`/`Sinh`/`Cosh`/`Tanh`/`ATanh`/`InverseSqrt`/`Sqrt`/
// `Exp2`/`Log2`/`Pow`/`ASinh`/`ACosh`/`Abs`/`Sign`/`Floor`/`Trunc`/`Round`/`RoundEven`/
// `Ceil`/`Fract`/`Step`/`Mod`/`Mix`/`SmoothStep`/`Fma`/`Modf`/`Dot`/`Length`/`Distance`/
// `Cross`/`Normalize`/`FaceForward`/`Reflect`/`Refract`/`MatrixCompMult`/`OuterProduct`/
// `Transpose`/`Determinant`/`Inverse` are ported so far - every function in
// `glsBuiltinPrecisionTests.cpp` that this port ever set out to hand-derive (the file's
// only remaining unported pieces, `GenVec`'s cross-lane AST core for anything beyond
// this hand-written set and the deliberately-disabled `mat3`/`mat4` `Determinant`/
// `Inverse` instantiations, are out of scope - see the matrix section's own module note
// below and the coverage campaign's progress log).**
// `Abs`/`Sign`/`Floor`/`Trunc`/
// `RoundEven`/`Ceil` are `PreciseFunc1`s (`FloatFunc1`, `precision()` unconditionally
// `0.0`) - the same primitive shape as `Exp`/`Log` below, just zero-tolerance. `Round`
// overrides `applyPoint` directly rather than going through `applyExact`/`precision`
// at all: at an exact halfway point either neighbouring integer is legal (GLSL leaves
// round-half behaviour implementation-defined), so `unary_point`'s own `Round` arm
// unions both rather than picking one - ported by reading `Round::applyPoint` in the
// C++ directly (`glsBuiltinPrecisionTests.cpp` ~3475-3502), not inferred from its name.
// `Fract = x - floor(x)`/`Mod = x - y * floor(x / y)` are `DerivedFunc`s composed the
// same way `Radians`/`Pow` are. `Step = step(edge, x) = x < edge ? 0.0 : 1.0` needed no
// special dispatch at all - it is `PreciseFunc2`-shaped (`precision()` unconditionally
// `0.0`), which is exactly `binary_reference`'s existing default arm (`apply_exact` +
// `fmt.round_out_point`, no separate epsilon term), the same path `Add`/`Sub`/`Mul`
// already use. A real llvmpipe run + `diff_vs_deqp` against real `deqp-gles3`/
// `deqp-gles31` caught a genuine bug in `Round` before this batch was committed: Rust's
// `f64::fract()` is `self - self.trunc()`, which for `x == +-inf` is `inf - inf ==
// NaN`, unlike C's `modf` (`deModf`), which special-cases infinity to a `0` fractional
// part - see `unary_point`'s own `Round` arm and its regression test for the fix and
// why `cargo test` alone did not catch it (the bug produced `QualityWarning`, not
// `Fail`, since the interval's warning range defaults to unbounded).
// `Exp`/`Log`/`InverseSqrt`/`Exp2`/`Log2` are `FloatFunc1` primitives, the same shape as
// `Sin`/`Cos`/`ASin`/`ACos`/`ATan` (see the "One-argument functions" section below;
// `Exp2`/`Log2` share `Exp`/`Log`'s own precision formula exactly, just a different base
// `DoubleFunc1`). `Tan`/`Sinh`/`Cosh`/`Tanh`/`ATanh`/`Sqrt`/`ASinh`/`ACosh` are
// `DerivedFunc` compositions, the same shape as `Radians`/`Degrees` but each nesting a
// non-arithmetic sub-function (`sin`/`cos`/`exp`/`log`/`sqrt`) rather than a plain
// constant - `derived_unary_reference` and its per-function `*_reference` helpers below
// (`tan_reference`, `sinh_reference`, `cosh_reference`, `tanh_reference`,
// `atanh_reference`, `sqrt_reference`, `asinh_reference`, `acosh_reference`) compose
// already-ported primitives/other `DerivedFunc` results directly rather than through a
// generic `Expr`/`Apply` evaluator, each read from the C++ macro expansion itself
// (`glsBuiltinPrecisionTests.cpp` line ~2463-2464, ~2600, ~2724-2734, ~2730-2734) -
// confirmed safe by reading `Apply<Sig>::doEvaluate` (recurses into whatever `Expr<T>`
// each argument is, threading the *same* `EvalContext` throughout) and `DerivedFunc::
// doApply` (evaluates the composed tree once, `EvalContext` populated by binding the
// symbolic parameter to the actual argument interval via `Environment`, and returns
// exactly what the outermost call returned - no extra rounding of its own layered on
// top). `Sqrt`'s own ternary (`x == 0.0f ? constant(1.0f) : (constant(1.0f) /
// app<InverseSqrt>(x))`) was this campaign's standing blocked item - resolved by
// compiling a minimal standalone reproduction of the real `SharedPtr<T>`/`ExprP<T>`
// class shape directly (see `sqrt_reference`'s own doc comment for the full argument):
// `ExprP<T>` has an implicit `operator bool()` but no `operator==`, so the comparison
// resolves through that bool conversion and is unconditionally `false` for any real
// (non-null) `ExprP`, making the `0.0f` branch unreachable dead code in upstream itself.
// `Pow = exp2(y * log2(x))` (`DEFINE_DERIVED_FLOAT2`) is the one two-argument
// `DerivedFunc` ported so far - it joins the `BinaryOp` enum purely for
// `BinaryOpCase`'s two-input shape and is dispatched to its own `pow_reference` from
// `check_one`, exactly as the one-argument `DerivedFunc`s dispatch through
// `derived_unary_reference` from `check_one1` instead of `unary_reference`. Upstream's own
// class hierarchy splits cleanly: the arithmetic four (`InfixOperator`, a
// `PrimitiveFunc`) compute their interval bound directly, by hand, with no dependency
// on the AST evaluator at all - `Add`/`Sub`/`Mul` are monotone in both arguments, so
// their bound is the union of the four corner evaluations
// `(lo,lo)`/`(lo,hi)`/`(hi,lo)`/`(hi,hi)`, each rounded through the target
// `FloatFormat`. That is `apply_monotone2` below, and it is the entire framework those
// three need - no AST, no `Expr<T>`. `Min`/`Max` (`MinMaxFunc`) share `FloatFunc2` (so
// still go through `apply_monotone2` - min/max are monotone in each argument too) but
// have a wholly different `applyPoint`: a direct comparison-based selection between the
// two exact operands (`min_max_point`/`compare`), never a rounded arithmetic result.
// `Clamp` (`FloatFunc3`, three arguments) needed its own eight-corner analogue
// (`apply_monotone3`) and its own case shape (`ClampCase`/`generate_inputs3`/
// `check_one_clamp`/`build_clamp_spec` - a three-input `ShaderSpec`, a full
// fixed-sample cross-product across all three arguments) since the existing
// `BinaryOpCase`/`binary_reference` machinery is two-argument only; its `applyPoint`
// (`clamp_point`) is a `MinMaxFunc`-like comparison, but against *two* bounds instead
// of one, plus a `minVal > maxVal` degenerate case that is legally `NaN`. `BinaryOp` is
// the one enum covering the six two-argument functions; each variant differs in its
// GLSL expression (`shader_expr` - infix for the arithmetic four, a function call for
// `Min`/`Max`), `apply_exact`, and (`Mul`/`Div` only) an `inner_extrema` override.
// `Div` additionally has a genuinely nonzero `precision()` and its own
// point-evaluation function rather than the generic `fmt.round_out_point` the
// arithmetic three share - see `div_point`/`div_precision` below. Every other scalar
// builtin function upstream covers is *also* a hand-derived primitive or `DerivedFunc`
// composition in exactly this shape (`FloatFunc1`/`FloatFunc2`, each with its own
// `precision()` error bound, or a formula over already-ported functions with no nested
// sub-function this port cannot already evaluate) and has now been added the same way.
// **Every hand-derivable scalar function is now ported, including `Mix`/`SmoothStep`/
// `Fma`/`Modf`.** `Mix`/`SmoothStep` (`DEFINE_DERIVED_FLOAT3`, three-argument
// `DerivedFunc`s over `Clamp`'s own primitives) needed a three-argument `TernaryOp`
// generalisation of the original `Clamp`-only `ClampCase` (`TernaryOpCase`/
// `build_ternary_spec`/`check_one_ternary`/`ternary_op_group`), which `Fma`
// (`DerivedFunc<Signature<float, float, float, float>>`, plain `x*y+z`) then reused
// directly - `Fma` is the one variant needing a required-extension gate
// (`GL_EXT_gpu_shader5`, `TernaryOp::required_extension`) and a GLES31-only, three-stage
// registration (`es31Cases`, not the shared `es3Cases` every other function here comes
// from - see `Fma`'s own doc comment). `Modf` (`PrimitiveFunc<Signature<float, float,
// float>>`, two outputs) needed its own case shape (`ModfCase`/`build_modf_spec`/
// `check_one_modf`/`modf_group`, `SimpleFuncCaseFactory`'s shape rather than
// `GenFuncCaseFactory`'s) - it is not vectorized over `GenType` at all, unlike every
// other function above (see the dedicated module note just above `modf_point`).
// **`Dot`/`Length`/`Distance`/`Cross`/`Normalize` (`GenVec`-shaped, each genuinely
// reads/combines multiple vector lanes together) are also ported now** - hand-written
// per-vector-size code operating on `Vec<Interval>`/`[Interval; 3]` arrays of lane
// intervals, not the generic `Expr<T>`/`ExprP<T>`/`Environment` AST upstream itself
// uses, turned out to be enough: `Dot`'s own `doExpand` sums lane products over
// *every permutation* of summation order via `alternatives` (`permutations`/
// `dot_reference` below), to bound floating-point summation-order sensitivity, and
// `Length`/`Distance`/`Normalize` all reduce to `dot` plus already-ported primitives
// (`sqrt`, lanewise `Sub`/`Div`). `Cross` is `SimpleFuncCaseFactory`-shaped like
// `Modf` (flat, `Vec3`-only, no `GenType` nesting). **`FaceForward`/`Reflect`/
// `Refract` are ported too** - each branches on the *sign* of an interval-valued
// `dot`, needing both alternatives whenever that interval straddles zero
// (`less_than_zero_possible`, replicating `Cond<T>`/`LessThan<T>`'s own
// bounds-only reachability check rather than anything cleverer). `Reflect` needed
// its own `Size == 1` special case (`ApplyReflect<1, ...>`'s wider formula, a third
// algebraic rearrangement only available at scalar width - confirmed load-bearing by
// negative control, not merely structurally different). **The matrix-typed family
// (`matrixCompMult`/`outerProduct`/`transpose`/`determinant`/`inverse`) is ported too**,
// needing new matrix-typed I/O support in `gls::shader_exec_util` first (see that
// module's own header) - see this file's own dedicated matrix section, near the bottom,
// for the reference formulas and case shape. See the coverage campaign's progress log
// for the full breakdown and current sizing.
//
// **Lives under `gls::`, not one API's own `functional::`,** because upstream's own
// `glsBuiltinPrecisionTests.cpp` is itself `modules/glshared/` - all seven (via
// `createES3BuiltinCases`) are registered by *both* `es3fBuiltinPrecisionTests.cpp`
// (`shaderTypes = {Vertex, Fragment}`) and `es31fBuiltinPrecisionTests.cpp`
// (`shaderTypes = {Compute}` for `es3Cases`, `{Vertex, Fragment, Compute}` for
// `es31Cases` - `FrExp`/`LdExp`/`Fma`, not ported). `binary_op_group`/`unary_op_group`/
// `ternary_op_group` all take the shader-stage list as a parameter for exactly this
// reason; `gles3::
// functional::builtin_precision_tests` and `gles31::functional::
// builtin_precision_tests` are the two thin per-API wrappers that supply it and nest
// the result under each API's own `builtin_functions.precision` group. Confirmed
// against both real mustpasses for the arithmetic four:
// `dEQP-GLES31...precision.{add,sub,mul,div}.*` names only `*_compute` (12 each: 3
// precisions x 4 `GenType`s), `dEQP-GLES3...precision.{add,sub,mul,div}.*` only
// `*_vertex`/`*_fragment` (24 each: 3 x 2 x 4), never `*_compute` (GLES3 has no compute
// shaders at all). **`Min`/`Max`/`Clamp` are the one deliberate exception**: the AOSP
// `gles31-main` mustpass lists only 8 of the 12 `precision.{min,max}.*_compute` cases
// each and 8 of `clamp`'s own 12 (`lowp`/`mediump`, no `highp`), even though upstream's
// own case-registration code (`createFuncGroup` in this same file) builds all three
// precisions for every function uniformly, with no per-function exception anywhere -
// confirmed directly against the real `deqp-gles31` binary via `diff_vs_deqp.py`,
// which reports `agree: 12/12, missing: 0` for each of `precision.min.*`,
// `precision.max.*` and `precision.clamp.*` including the `highp_compute` cases the
// mustpass omits: the real binary registers and passes them, so the mustpass's own
// 8-case subset is curated (or stale), not authoritative over what upstream actually
// runs. This is exactly the `MUSTPASS_OMISSIONS` shape `coverage.py`'s own header
// describes ("cases upstream's own test binary registers but whose mustpass leaves
// them out") - see the entries added there for these three functions.
//
// Sample generation does not need to reproduce upstream's `de::Random` stream bit for
// bit - like every other port in this campaign, `diff_vs_deqp.py` only ever compares a
// verdict category, never a logged value, so the two sides never need to agree on
// which floats went into a test, only on whether the shader's answer is inside the
// interval each side computes for its own inputs. `gen_random_sample`'s exponent *is*
// ported verbatim, though (upstream's cubic distribution, peaked at zero rather than
// uniform) - not merely for fidelity's own sake, but because a function with a domain
// edge away from zero (`ASin`/`ACos`'s `[-1, 1]`) needs the same *density* of samples
// near that edge upstream gets, or a verdict that flips between `Pass` and
// `QualityWarning` right at the edge can disagree between the two sides purely because
// one side's simplified distribution samples that edge far less often - see
// `gen_random_sample`'s own comment for the real case this was caught on.

use crate::gls::shader_exec_util::{self, ShaderSpec, Symbol};
use crate::glu::{
    self, Context, DataType, Precision, ShaderType, TestCase, TestCaseGroup, VarType, get_data_type_int_vec,
};
use crate::tcu::float_format::{FloatFormat, YesNoMaybe, de_sign, fract_exp};
use crate::tcu::interval::Interval;
use crate::tcu::random::Random;
use crate::tcu::{TestError, TestOutcome, TestResult, TestStatus};

/// `glu::GenType`, restricted to what a `genType` overload set actually varies over -
/// upstream's `GenFuncCaseFactory::createCase` builds exactly these four children,
/// named exactly this way, for every scalar-arity function.
#[derive(Clone, Copy)]
enum GenType {
    Scalar,
    Vec2,
    Vec3,
    Vec4,
}

const ALL_GEN_TYPES: [GenType; 4] = [GenType::Scalar, GenType::Vec2, GenType::Vec3, GenType::Vec4];

impl GenType {
    fn lanes(self) -> usize {
        match self {
            Self::Scalar => 1,
            Self::Vec2 => 2,
            Self::Vec3 => 3,
            Self::Vec4 => 4,
        }
    }

    fn case_name(self) -> &'static str {
        match self {
            Self::Scalar => "scalar",
            Self::Vec2 => "vec2",
            Self::Vec3 => "vec3",
            Self::Vec4 => "vec4",
        }
    }

    fn data_type(self) -> DataType {
        match self {
            Self::Scalar => DataType::Float,
            Self::Vec2 => DataType::FloatVec2,
            Self::Vec3 => DataType::FloatVec3,
            Self::Vec4 => DataType::FloatVec4,
        }
    }
}

/// `PrecisionTestContext`'s three formats, built exactly the way
/// `addBuiltinPrecisionTests` builds them - the comment there ("check these once
/// Khronos bug 11840 is resolved") is upstream's own, kept because nothing here
/// resolved it either.
///
/// `pub(crate)` since `gles31::functional::shader_common_function_tests`'s own `Fma`
/// (a *different* upstream file, `es31fShaderCommonFunctionTests.cpp`) builds its
/// `tcu::FloatFormat` table from the identical four numeric triples
/// (`(0,0,7,false,YES,MAYBE,MAYBE)`/`(-13,13,9,false,MAYBE,MAYBE,MAYBE)`/`(-126,127,23,true,
/// MAYBE,YES,MAYBE)`) - reused rather than re-typed a second time.
pub(crate) fn precision_format(precision: Precision) -> FloatFormat {
    match precision {
        Precision::HighP => FloatFormat::with_support(
            -126,
            127,
            23,
            true,
            YesNoMaybe::Maybe,
            YesNoMaybe::Yes,
            YesNoMaybe::Maybe,
        ),
        Precision::MediumP => FloatFormat::new(-13, 13, 9, false),
        // "A fixed-point format is just a floating point format with a fixed exponent
        // and support for subnormals" - upstream's own comment on lowp.
        Precision::LowP => {
            FloatFormat::with_support(0, 0, 7, false, YesNoMaybe::Yes, YesNoMaybe::Maybe, YesNoMaybe::Maybe)
        }
    }
}

/// `DefaultSampling<float>::genFixeds` - the standard set of floats that should always
/// be tested, ported verbatim (as f64 arithmetic; the exponents involved are always
/// tiny enough that this is exact in f32 too).
fn gen_fixed_samples(fmt: FloatFormat) -> Vec<f32> {
    let min_exp = fmt.min_exp();
    let max_exp = fmt.max_exp();
    let fraction_bits = fmt.fraction_bits();
    let min_quantum = ldexp(1.0, min_exp - fraction_bits);
    let min_normalized = ldexp(1.0, min_exp);
    let max_quantum = ldexp(1.0, max_exp - fraction_bits);

    let mut dst = vec![f32::NAN, 0.0f32];
    for sign in [-1.0f64, 1.0] {
        dst.push((sign * min_quantum) as f32);
        dst.push((sign * (min_normalized - min_quantum)) as f32);
        dst.push((sign * min_normalized) as f32);
        dst.push((sign * (min_normalized + min_quantum)) as f32);
        dst.push((sign * 0.5) as f32);
        dst.push((sign * 1.0) as f32);
        dst.push((sign * 2.0) as f32);
        dst.push((sign * (ldexp(1.0, max_exp) + (ldexp(1.0, max_exp) - max_quantum))) as f32);
        dst.push((sign * f64::INFINITY) as f32);
    }
    dst
}

fn ldexp(x: f64, exp: i32) -> f64 {
    x * 2f64.powi(exp)
}

/// `DefaultSampling<float>::genRandom` - the exponent is drawn from a *cubic*
/// distribution (`deRoundEven(pow(rnd.getDouble(minRoot, maxRoot), 3.0))`, peaked at
/// zero) rather than a uniform one, ported verbatim rather than simplified: an earlier
/// version of this port used a uniform exponent instead, reasoning that the fixed
/// samples above already carry every interesting boundary and the random ones only
/// need to exercise the general case. That reasoning does not hold for a function with
/// a *domain edge away from zero* - `acos`/`asin`'s domain is `[-1, 1]`, and their
/// mediump/lowp precision bound tightens sharply as `|x|` approaches `1` (the
/// derivative there is unbounded) - so how often the edge actually gets sampled
/// matters, and it matters a lot more under a cubic distribution (which puts far more
/// weight on the `[0.5, 2)`-magnitude band around exponent zero, i.e. exactly where
/// `acos`'s domain edge lives) than under a uniform one (which spreads only
/// `1/(max_exp - min_exp)` of its draws into that one exponent bucket). Confirmed by
/// running `dEQP-GLES31...precision.acos.mediump_compute.*` against real upstream
/// `deqp-gles31`: the uniform version left `vec2` a coin flip (`Pass` here,
/// `QualityWarning` on the real driver, on inputs neither side needs to agree on
/// bit-for-bit - see the module header) while every other size warned identically on
/// both sides; the cubic version below closed it, and re-running the whole
/// `Add`/`Sub`/`Mul`/`Div`/`Min`/`Max`/`Clamp` batch confirmed the wider exponent
/// density elsewhere in the domain does not disturb any of them (none has a
/// domain-edge-dependent precision bound).
fn gen_random_sample(fmt: FloatFormat, rnd: &mut Random) -> f32 {
    match rnd.get_int(0, 64) {
        0 => return 0.0,
        1 => return f32::INFINITY,
        2 => return f32::NEG_INFINITY,
        3 => return f32::NAN,
        _ => {}
    }

    let have_subnormal = fmt.has_subnormal() != YesNoMaybe::No;
    let min_root = (fmt.min_exp() as f64 - 0.5 - if have_subnormal { 1.0 } else { 0.0 }).cbrt();
    let max_root = (fmt.max_exp() as f64 + 0.5).cbrt();
    let exp = rnd.get_double_range(min_root, max_root).powi(3).round_ties_even() as i32;
    let fraction_bits = fmt.fraction_bits();

    let (base, quantum) = if exp >= fmt.min_exp() {
        (ldexp(1.0, exp), ldexp(1.0, exp - fraction_bits))
    } else {
        (0.0, ldexp(1.0, fmt.min_exp() - fraction_bits))
    };

    let significand = match rnd.get_int(0, 16) {
        0 => base - quantum,
        1 => quantum,
        2 => 0.0,
        _ => {
            let int_fraction = (rnd.get_uint64() & ((1u64 << fraction_bits) - 1)) as f64;
            int_fraction * quantum
        }
    };

    let sign = if rnd.get_int(0, 3) == 0 { -1.0 } else { 1.0 };
    (sign * (base + significand)) as f32
}

/// Upstream's own default (`defRandoms` in `createBuiltinPrecisionTests`) is 16384;
/// this stays well below that for runtime's sake (full-root regression runs stay in
/// the tens of seconds, not minutes), but had to move up from an original 512 once the
/// cubic exponent distribution above was ported for real: 512 draws left a
/// domain-edge-sensitive function's `QualityWarning`-vs-`Pass` split a coin flip on
/// this specific driver (see `gen_random_sample`'s own comment) for roughly one
/// mediump/lowp `acos` case in twenty, confirmed by re-running the whole
/// `Sin`/`Cos`/`ASin`/`ACos`/`ATan` batch against real `deqp-gles31`/`deqp-gles3`
/// several times over at each sample count tried. 4096 closed every occurrence seen in
/// several repeated full runs of both APIs' `acos` groups; if a future function turns
/// out to need still more (a tighter domain edge, or a smaller passing sub-range),
/// raise this rather than special-casing one function's own sample count.
const NUM_RANDOM_SAMPLES: usize = 4096;

/// `generateInputs`, restricted to the two-scalar-argument case `Add` (and every other
/// `InfixOperator`) needs: the fixed set crossed with itself (every fixed sample is a
/// *broadcast* vector, all lanes equal - matching `DefaultSampling<Vector<T,
/// Size>>::genFixeds`, which wraps each scalar fixed value into a uniform vector
/// rather than cross-producting per lane), plus `NUM_RANDOM_SAMPLES` genuinely
/// per-lane-independent random ones (matching `DefaultSampling<Vector<T,
/// Size>>::genRandom`, which samples every lane independently).
fn generate_inputs(fmt: FloatFormat, lanes: usize, seed: u32) -> (Vec<f32>, Vec<f32>) {
    generate_inputs_asym(fmt, lanes, lanes, seed)
}

/// `generate_inputs`, generalised to two operands of possibly different lane counts -
/// needed by `OuterProduct<Rows, Cols>`, whose two vector arguments are `Rows` and
/// `Cols` lanes respectively (a matrix's row/column counts need not match). Every other
/// caller has `lanes0 == lanes1` and goes through `generate_inputs` above unchanged.
fn generate_inputs_asym(fmt: FloatFormat, lanes0: usize, lanes1: usize, seed: u32) -> (Vec<f32>, Vec<f32>) {
    let fixed = gen_fixed_samples(fmt);
    let mut in0 = Vec::with_capacity((fixed.len() * fixed.len() + NUM_RANDOM_SAMPLES) * lanes0);
    let mut in1 = Vec::with_capacity((fixed.len() * fixed.len() + NUM_RANDOM_SAMPLES) * lanes1);

    for &f0 in &fixed {
        for &f1 in &fixed {
            in0.extend(std::iter::repeat_n(f0, lanes0));
            in1.extend(std::iter::repeat_n(f1, lanes1));
        }
    }

    let mut rnd = Random::new(seed);
    for _ in 0..NUM_RANDOM_SAMPLES {
        for _ in 0..lanes0 {
            in0.push(gen_random_sample(fmt, &mut rnd));
        }
        for _ in 0..lanes1 {
            in1.push(gen_random_sample(fmt, &mut rnd));
        }
    }

    (in0, in1)
}

/// `TCU_INTERVAL_APPLY_MONOTONE2` + `FloatFunc2::applyMonotone`, specialised to a
/// two-argument point function with no extra codomain restriction or "inner extrema"
/// (`Add`/`Sub`/`Mul`/`Div` all have `getCodomain() == unbounded(true)` and empty
/// `innerExtrema`, both no-ops) - the general form both of those would need is not
/// written yet since nothing ported so far uses them.
///
/// Simplified relative to the macro's exact recursive expansion: the only way either
/// argument is ever an empty `Interval` in this port is a sampled NaN (`round`/
/// `convert` never otherwise produce one), and an empty argument is NaN-flagged
/// whenever it is empty here, so "propagate the NaN flag of whichever argument was
/// empty, ignore the other" and "propagate the NaN flag of both arguments
/// unconditionally" agree on every input this generates. `#[cfg(test)]` below checks
/// the NaN-propagation shape directly rather than trusting that argument.
fn apply_monotone2(a: Interval, b: Interval, point: impl Fn(f64, f64) -> Interval) -> Interval {
    let mut dst = if a.is_empty() || b.is_empty() {
        Interval::empty()
    } else {
        point(a.lo(), b.lo()) | point(a.lo(), b.hi()) | point(a.hi(), b.lo()) | point(a.hi(), b.hi())
    };
    if a.has_nan() || b.has_nan() {
        dst = dst | Interval::exact(f64::NAN);
    }
    dst
}

/// `Add`/`Sub`/`Mul`/`Div` (all four `InfixOperator`s) plus `Min`/`Max`
/// (`MinMaxFunc`) - the latter two share `FloatFunc2` with the arithmetic ones but
/// have a wholly different `applyPoint` (a comparison-based selection between the two
/// exact operands, never a rounded arithmetic result) - see `min_max_point` below.
/// `ATan2` (`CFloatFunc2`) joins the same enum for the same reason `Div`/`Min`/`Max`
/// already share it despite each having its own `applyPoint`: it is still a
/// two-argument, one-output function needing exactly `BinaryOpCase`'s existing shape
/// (`generate_inputs`/`build_spec`/`binary_op_group`), just its own point-evaluation
/// and `innerExtrema` - see `atan2_point`/`atan2_inner_extrema` below. Its case *group*
/// name ("atan2") and its GLSL *function* name ("atan", upstream's own
/// `CFloatFunc2("atan", deAtan2)`) genuinely differ - `name()` and `shader_expr()`
/// already return independent strings for every variant, so this needed no new split.
/// `Pow` (`DEFINE_DERIVED_FLOAT2(Pow, pow, x, y, exp2(y *log2(x)))`) is the one
/// two-argument `DerivedFunc` ported so far - it joins this enum purely for
/// `BinaryOpCase`'s two-input/one-output shape (`generate_inputs`/`build_spec`/
/// `binary_op_group`), exactly as `Radians`/`Degrees`/`Tan`/... join `UnaryOp` for the
/// one-argument shape without being `FloatFunc1` primitives. `check_one` dispatches it
/// to `pow_reference` instead of `binary_reference`, mirroring `check_one1`'s dispatch
/// of the one-argument `DerivedFunc`s to `derived_unary_reference` - so `Pow`'s own
/// `apply_exact`/`inner_extrema` arms below are unreachable, kept only so the `match`
/// stays exhaustive.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BinaryOp {
    Add,
    Sub,
    Mul,
    Div,
    Min,
    Max,
    ATan2,
    Pow,
    /// `Step` (`PreciseFunc2`, `precision()` unconditionally `0.0`) - `step(edge, x) =
    /// x < edge ? 0.0 : 1.0`. Goes through the same generic `apply_exact` +
    /// `fmt.round_out_point` path the arithmetic four use (never a separate epsilon
    /// term), which already matches `PreciseFunc2`'s own zero-precision shape exactly.
    Step,
    /// `DEFINE_DERIVED_FLOAT2(Mod, mod, x, y, x - y * app<Floor>(x / y))` - a
    /// `DerivedFunc`, not a `FloatFunc2`: dispatched to `mod_reference` from
    /// `check_one`, exactly as `Pow` dispatches to `pow_reference`.
    Mod,
}

impl BinaryOp {
    fn name(self) -> &'static str {
        match self {
            Self::Add => "add",
            Self::Sub => "sub",
            Self::Mul => "mul",
            Self::Div => "div",
            Self::Min => "min",
            Self::Max => "max",
            Self::ATan2 => "atan2",
            Self::Pow => "pow",
            Self::Step => "step",
            Self::Mod => "mod",
        }
    }

    /// The GLSL expression `build_spec` embeds verbatim - infix for the arithmetic
    /// four, a function call for `Min`/`Max` (upstream's `Min`/`Max` are registered as
    /// ordinary function calls, never operators) and for `ATan2` (whose *group* name is
    /// "atan2" but whose GLSL function, and upstream's own `CFloatFunc2` name, is
    /// plain two-argument `atan`).
    fn shader_expr(self) -> String {
        match self {
            Self::Add => "in0 + in1".to_string(),
            Self::Sub => "in0 - in1".to_string(),
            Self::Mul => "in0 * in1".to_string(),
            Self::Div => "in0 / in1".to_string(),
            Self::Min => "min(in0, in1)".to_string(),
            Self::Max => "max(in0, in1)".to_string(),
            Self::ATan2 => "atan(in0, in1)".to_string(),
            Self::Pow => "pow(in0, in1)".to_string(),
            // `step(edge, x)` - `in0` is `edge`, `in1` is `x`, matching `apply_exact`.
            Self::Step => "step(in0, in1)".to_string(),
            Self::Mod => "mod(in0, in1)".to_string(),
        }
    }

    /// Used only by the arithmetic four's generic point-evaluation path in
    /// `binary_reference` - `Div`/`ATan2` have their own (`div_point`/`atan2_point`)
    /// and `Min`/`Max` bypass this entirely (`min_max_point`), so their arms here are
    /// unreachable but still have to typecheck as an exhaustive `match`. `Pow` never
    /// reaches `binary_reference` at all (see its own doc comment above) - unreachable.
    fn apply_exact(self, x: f64, y: f64) -> f64 {
        match self {
            Self::Add => x + y,
            Self::Sub => x - y,
            Self::Mul => x * y,
            Self::Div => x / y,
            Self::Min => x.min(y),
            Self::Max => x.max(y),
            // `deAtan2(x, y) = atan2(x, y)` - Rust's `x.atan2(y)` is the same call.
            Self::ATan2 => x.atan2(y),
            Self::Pow => x.powf(y),
            // `step(edge, x) = x < edge ? 0.0 : 1.0` - `x` here is `edge` (`in0`), `y`
            // is the value (`in1`), matching `shader_expr`'s own argument order.
            Self::Step => {
                if y < x {
                    0.0
                } else {
                    1.0
                }
            }
            // `Mod` never reaches this - see its own doc comment. Unreachable.
            Self::Mod => x - y * (x / y).floor(),
        }
    }

    /// `Mul::innerExtrema`/`Div::innerExtrema`/`ATan2::innerExtrema` - `Add`/`Sub`/
    /// `Min`/`Max`/`Step` all leave this empty (none of their own upstream classes
    /// override it). `fmt` is only used by `ATan2` (its own `isFinite` check needs the
    /// format's largest representable value) - every other variant ignores it.
    /// `Pow`/`Mod`'s arms are unreachable, same reason as `apply_exact` above.
    fn inner_extrema(self, fmt: FloatFormat, a: Interval, b: Interval) -> Interval {
        match self {
            Self::Mul => mul_inner_extrema(a, b),
            Self::Div => div_inner_extrema(a, b),
            Self::ATan2 => atan2_inner_extrema(fmt, a, b),
            Self::Add | Self::Sub | Self::Min | Self::Max | Self::Pow | Self::Step | Self::Mod => Interval::empty(),
        }
    }
}

/// `compare` - upstream's own free function: an implementation without subnormal
/// support may be unable to distinguish `x` from `y` even when they differ in host
/// (`f64`) arithmetic, if both fall within the subnormal range the format itself
/// cannot represent - in which case they must be treated as equal.
fn compare(fmt: FloatFormat, x: f64, y: f64) -> i32 {
    if fmt.has_subnormal() != YesNoMaybe::Yes {
        let min_quantum = ldexp(1.0, fmt.min_exp() - fmt.fraction_bits());
        let min_normalized = ldexp(1.0, fmt.min_exp());
        let max_subnormal = min_normalized - min_quantum;
        let min_subnormal = -max_subnormal;
        if min_subnormal <= x && x <= max_subnormal && min_subnormal <= y && y <= max_subnormal {
            return 0;
        }
    }
    if x < y {
        -1
    } else if y < x {
        1
    } else {
        0
    }
}

/// `MinMaxFunc::applyPoint` - a direct comparison-based selection between the two
/// exact operands (`precision()` is unconditionally `0.0`), not a rounded arithmetic
/// result: `Min`'s sign is `-1`, `Max`'s is `+1`, matching upstream's own
/// `MinMaxFunc(name, sign)` constructor argument. When the two operands cannot be
/// told apart at this format's precision (both indistinguishable subnormals), either
/// is a legal answer.
fn min_max_point(op: BinaryOp, fmt: FloatFormat, x: f64, y: f64) -> Interval {
    let sign = if op == BinaryOp::Min { -1 } else { 1 };
    let cmp = compare(fmt, x, y) * sign;
    if cmp > 0 {
        Interval::exact(x)
    } else if cmp < 0 {
        Interval::exact(y)
    } else {
        Interval::new(x, y)
    }
}

/// `Mul::innerExtrema` - `infinity * 0` is `NaN` regardless of which operand was
/// which, on top of whatever the corner-point evaluation already produced.
fn mul_inner_extrema(a: Interval, b: Interval) -> Interval {
    let is_inf = |i: Interval| i.contains(f64::INFINITY) || i.contains(f64::NEG_INFINITY);
    if (is_inf(a) && b.contains(0.0)) || (is_inf(b) && a.contains(0.0)) {
        Interval::exact(f64::NAN)
    } else {
        Interval::empty()
    }
}

/// `Div::innerExtrema(nom, den)` - a denominator interval spanning zero can make the
/// result `NaN` (if the numerator interval spans zero too, `0/0`) and/or unbounded (if
/// the numerator interval extends either positive or negative away from zero,
/// `x/0 == +-inf`) - both can apply at once, unlike `Mul`'s single `NaN` case.
fn div_inner_extrema(nom: Interval, den: Interval) -> Interval {
    let mut ret = Interval::empty();
    if den.contains(0.0) {
        if nom.contains(0.0) {
            ret = ret | Interval::exact(f64::NAN);
        }
        if nom.lo() < 0.0 || nom.hi() > 0.0 {
            ret = ret | Interval::unbounded(false);
        }
    }
    ret
}

/// `ATan2::innerExtrema(ctx, yi, xi)` - upstream names its own first parameter `yi`
/// and second `xi` to match `atan2`'s own `(y, x)` argument order: `yi` is `in0`'s
/// interval (the numerator passed to `deAtan2`) and `xi` is `in1`'s (the denominator),
/// matching `apply_exact`'s own `x.atan2(y)` where `x = in0` plays the same numerator
/// role. Two independent conditions can each admit `NaN`/widen to `[-pi, pi]`: a
/// numerator interval spanning zero together with a denominator that can be zero
/// (`atan2(0, 0)`, undefined) or negative-or-zero (crossing the branch cut, so the
/// whole angle range becomes reachable); and either operand's interval reaching or
/// exceeding the format's own largest representable value, in which case an
/// unsupported infinity legally admits any answer including `NaN`.
fn atan2_inner_extrema(fmt: FloatFormat, yi: Interval, xi: Interval) -> Interval {
    let mut ret = Interval::empty();
    if yi.contains(0.0) {
        if xi.contains(0.0) {
            ret = ret | Interval::exact(f64::NAN);
        }
        if xi.intersects(Interval::new(f64::NEG_INFINITY, 0.0)) {
            ret = ret | Interval::new(-std::f64::consts::PI, std::f64::consts::PI);
        }
    }
    let max_value = fmt.max_value();
    if !yi.is_finite(max_value) || !xi.is_finite(max_value) {
        ret = ret | Interval::exact(f64::NAN);
    }
    ret
}

/// `ATan2::precision` - `4096` ULPs at highp, `2` ULPs otherwise (unlike `ArcTrigFunc`'s
/// shared formula, this never depends on `x`/`y` themselves - no domain check, since
/// `atan2` itself has no excluded domain the way `asin`/`acos` do).
fn atan2_precision(fmt: FloatFormat, precision: Precision, ret: f64) -> f64 {
    if precision == Precision::HighP {
        fmt.ulp(ret, 4096.0)
    } else {
        fmt.ulp(ret, 2.0)
    }
}

/// `FloatFunc2::applyPoint`'s own base-class default (`CFloatFunc2` never overrides
/// it, unlike `Div`/`MinMaxFunc`/`Clamp`) - `exact +/- prec`, the same shape
/// `symmetric_error_interval` already gives `Div` and `FloatFunc1` one arity down.
fn atan2_point(fmt: FloatFormat, precision: Precision, x: f64, y: f64) -> Interval {
    let exact = x.atan2(y);
    let prec = atan2_precision(fmt, precision, exact);
    symmetric_error_interval(exact, prec)
}

/// `exact + Interval(-prec, prec)` (`FloatFunc2::applyPoint`'s generic shape, which
/// `Div::applyPoint` calls directly rather than `InfixOperator::applyPoint`'s
/// `format.roundOut`) - mirroring upstream's `Interval(double)` promotion plus
/// `Interval::operator+`, not plain `f64` arithmetic on the endpoints:
/// - a NaN `exact` (e.g. `0/0`) promotes to an *empty* range with only the NaN flag
///   set, so the `+-prec` term never touches it (`operator+` skips its numeric-bounds
///   computation whenever either side is empty).
/// - otherwise each bound is `exact -/+ prec` individually; the one real subtlety this
///   still has to replicate is that a bound can itself land on NaN (only possible when
///   `exact` is an infinity and `prec` is `f64::INFINITY` too, i.e. an infinite sampled
///   operand together with a denominator whose magnitude falls outside the "normal"
///   division range) - upstream's own rounding-mode machinery flags exactly that side
///   as NaN via the same double-to-`Interval` promotion, rather than propagating it
///   arithmetically, so this does the same: a NaN bound contributes only the NaN flag,
///   never a numeric value, and the other (non-NaN) bound is kept.
fn symmetric_error_interval(exact: f64, prec: f64) -> Interval {
    if exact.is_nan() {
        return Interval::exact(f64::NAN);
    }
    let lo = exact - prec;
    let hi = exact + prec;
    if !lo.is_nan() && !hi.is_nan() {
        return Interval::new(lo, hi);
    }
    let mut ret = Interval::exact(f64::NAN);
    if !lo.is_nan() {
        ret = ret | Interval::exact(lo);
    }
    if !hi.is_nan() {
        ret = ret | Interval::exact(hi);
    }
    ret
}

/// `Div::precision` - `0.0` exactly at a zero denominator (`x/0` must be exactly
/// `+-inf`, no ULP slop), `fmt.ulp(ret, 2.5)` when `|den|` is within
/// `[2^minExp, 2^(maxExp-1)]`, "any number" (`f64::INFINITY`, unioned in as `+-inf` by
/// `symmetric_error_interval` above) outside that range. Upstream's own `\todo` notes
/// this 2.5-ULP bound is not confirmed against the GLSL spec; ported as written.
fn div_precision(fmt: FloatFormat, ret: f64, den: f64) -> f64 {
    if den == 0.0 {
        0.0
    } else if den.abs() >= ldexp(1.0, fmt.min_exp()) && den.abs() <= ldexp(1.0, fmt.max_exp() - 1) {
        fmt.ulp(ret, 2.5)
    } else {
        f64::INFINITY
    }
}

/// `Div::applyPoint` - the base `FloatFunc2::applyPoint` shape (`symmetric_error_interval`
/// above) plus its own overflow-reclassification: if neither operand was itself
/// infinite and the denominator wasn't zero, an overflow the format's own `convert`
/// would clamp to infinity is additionally unioned in as the format's largest
/// representable value, since neither input was actually infinite.
fn div_point(fmt: FloatFormat, x: f64, y: f64) -> Interval {
    let exact = x / y;
    let prec = div_precision(fmt, exact, y);
    let mut ret = symmetric_error_interval(exact, prec);

    if !x.is_infinite() && !y.is_infinite() && y != 0.0 {
        let dst = fmt.convert(ret);
        if dst.contains(f64::NEG_INFINITY) {
            ret = ret | Interval::exact(-fmt.max_value());
        }
        if dst.contains(f64::INFINITY) {
            ret = ret | Interval::exact(fmt.max_value());
        }
    }

    ret
}

/// `InfixOperator::doApply` - only the general (`applyMonotone`) path, never
/// upstream's `isOrdinary` fast path, which is a performance optimisation upstream
/// itself proves equal to this one for ordinary operands (see e.g. `Add`'s own
/// comment: "Fast-path for common case"). This port has no such performance
/// requirement, so there is only one path to get right rather than two that have to
/// agree. `precision` (the qualifier, `highp`/`mediump`/`lowp`) is only read by
/// `ATan2` - every other variant's error bound depends only on `fmt` itself.
fn binary_reference(op: BinaryOp, fmt: FloatFormat, precision: Precision, a: Interval, b: Interval) -> Interval {
    let point = |x: f64, y: f64| match op {
        BinaryOp::Div => div_point(fmt, x, y),
        BinaryOp::Min | BinaryOp::Max => min_max_point(op, fmt, x, y),
        BinaryOp::ATan2 => atan2_point(fmt, precision, x, y),
        _ => {
            let exact = op.apply_exact(x, y);
            // `InfixOperator::applyPoint`'s `roundUnderOverflow`.
            let round_under_overflow = !x.is_infinite() && !y.is_infinite();
            fmt.round_out_point(exact, round_under_overflow)
        }
    };
    let result = apply_monotone2(a, b, point) | op.inner_extrema(fmt, a, b);
    fmt.convert(result)
}

/// `PrecisionCase::testStatement`'s per-sample loop, restricted to one non-generic
/// `op(in0, in1)` statement: round+convert the raw input through the case's own
/// format (modelling the store into a `precision`-qualified shader variable), compute
/// the reference through the same format, then convert the reference through highp
/// (upstream's own safety clamp - the reference was already computed at the case's own
/// precision, so this never rounds further) before comparing against the shader's
/// answer.
fn check_one(
    op: BinaryOp,
    fmt: FloatFormat,
    precision: Precision,
    highp_fmt: FloatFormat,
    a: f32,
    b: f32,
    got: f32,
) -> Result<(), bool> {
    let ia = fmt.convert(fmt.round_out_point(a as f64, false));
    let ib = fmt.convert(fmt.round_out_point(b as f64, false));
    let reference = highp_fmt.convert(match op {
        // `Pow`/`Mod` are `DerivedFunc`s, not `FloatFunc2`s - see their own doc comments.
        BinaryOp::Pow => pow_reference(fmt, precision, ia, ib),
        BinaryOp::Mod => mod_reference(fmt, precision, ia, ib),
        _ => binary_reference(op, fmt, precision, ia, ib),
    });
    let got = got as f64;

    if reference.contains(got) {
        Ok(())
    } else {
        // `Err(true)` is a quality warning (within the wider warning range, not a hard
        // failure), `Err(false)` a real failure.
        Err(reference.contains_warning(got))
    }
}

fn f32_bytes(values: &[f32]) -> &[u8] {
    // SAFETY: reinterpreting a `[f32]`'s own storage as bytes, the convention every
    // `shader_exec_util` input in this port uses.
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

fn floats_from_bytes(bytes: &[u8]) -> Vec<f32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| f32::from_ne_bytes(*c)).collect()
}

/// `i32` counterparts of `f32_bytes`/`floats_from_bytes` - needed once an `int`-typed
/// symbol enters the picture (`LdExp`'s exponent input, `FrExp`'s exponent out-param),
/// the first functions in this file whose I/O is not entirely `float`/vector-of-`float`.
fn i32_bytes(values: &[i32]) -> &[u8] {
    // SAFETY: as `f32_bytes` above, for `i32`.
    unsafe { std::slice::from_raw_parts(values.as_ptr().cast::<u8>(), std::mem::size_of_val(values)) }
}

fn ints_from_bytes(bytes: &[u8]) -> Vec<i32> {
    let (chunks, remainder) = bytes.as_chunks::<4>();
    debug_assert!(remainder.is_empty());
    chunks.iter().map(|c| i32::from_ne_bytes(*c)).collect()
}

/// `PrecisionCase::testStatement`'s `ShaderSpec` setup, restricted to an
/// `InfixOperator`'s own shape: two inputs, one output, all three at the case's own
/// precision (matching `makeSymbol`, which builds every symbol at `m_ctx.precision`,
/// not highp) - which is what makes the shader's *arithmetic*, not just its storage,
/// run at that precision.
fn build_spec(context: &Context, op: BinaryOp, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = format!("out0 = {};", op.shader_expr());
    spec
}

struct BinaryOpCase {
    op: BinaryOp,
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for BinaryOpCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_spec(context, self.op, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        // The seed only has to differ per case so the ops/precisions/GenTypes/stages
        // don't all sample identical random inputs; it need not (and does not) match
        // anything upstream - see the module header.
        let seed = 0x6275_696c
            ^ ((self.op as i32 as u32) << 12)
            ^ ((self.precision as i32 as u32) << 8)
            ^ ((self.stage as i32 as u32) << 4)
            ^ lanes as u32;
        let (in0, in1) = generate_inputs(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 2] = [f32_bytes(&in0), f32_bytes(&in1)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            for lane in 0..lanes {
                let idx = value_ndx * lanes + lane;
                match check_one(self.op, fmt, self.precision, highp_fmt, in0[idx], in1[idx], out0[idx]) {
                    Ok(()) => {}
                    Err(is_warning) => {
                        if is_warning {
                            num_warnings += 1;
                        } else {
                            num_errors += 1;
                        }
                        if first_message.is_none() {
                            first_message = Some(format!(
                                "sample {value_ndx} lane {lane}: in0 = {}, in1 = {}, got {}",
                                in0[idx], in1[idx], out0[idx]
                            ));
                        }
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `createFuncGroup`, restricted to one `InfixOperator` (`createES3BuiltinCases`
/// registers each through `addScalarFactory`). `stages` is each API's own
/// `shaderTypes` list - see the module header for which stages each of the two callers
/// passes and why they differ.
pub fn binary_op_group(op: BinaryOp, stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(op.name());
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(BinaryOpCase {
                    op,
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

/// `TCU_INTERVAL_APPLY_MONOTONE3` + `FloatFunc3::applyMonotone` - the eight-corner
/// analogue of `apply_monotone2` for a three-argument point function. Unlike
/// `FloatFunc1`/`FloatFunc2`, `FloatFunc3` has no `innerExtrema`/`getCodomain` step at
/// all (upstream's own `applyMonotone` for it is just the monotone-corner union
/// followed by `ctx.format.convert`), so this is the whole of what `Clamp` needs.
fn apply_monotone3(a: Interval, b: Interval, c: Interval, point: impl Fn(f64, f64, f64) -> Interval) -> Interval {
    let mut dst = if a.is_empty() || b.is_empty() || c.is_empty() {
        Interval::empty()
    } else {
        let mut acc = Interval::empty();
        for &x in &[a.lo(), a.hi()] {
            for &y in &[b.lo(), b.hi()] {
                for &z in &[c.lo(), c.hi()] {
                    acc = acc | point(x, y, z);
                }
            }
        }
        acc
    };
    if a.has_nan() || b.has_nan() || c.has_nan() {
        dst = dst | Interval::exact(f64::NAN);
    }
    dst
}

/// The three-argument, one-output functions sharing `ClampCase`'s original shape
/// (`generate_inputs3`/`build_ternary_spec`/`TernaryOpCase` - a full fixed-sample
/// cross-product across all three arguments, same as `Clamp` alone used to need).
/// `Mix`/`SmoothStep` are both `DEFINE_DERIVED_FLOAT3` `DerivedFunc`s, not
/// `FloatFunc3`s like `Clamp` - dispatched to their own `mix_reference`/
/// `smoothstep_reference` from `check_one_ternary`, mirroring how `Pow`/`Mod` dispatch
/// away from the generic `BinaryOp` path.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum TernaryOp {
    Clamp,
    /// `DEFINE_DERIVED_FLOAT3(Mix, mix, x, y, a, alternatives((x * (constant(1.0f) -
    /// a)) + y * a, x + (y - x) * a))`.
    Mix,
    /// `SmoothStep` (`DerivedFunc<Signature<float, float, float, float>>`):
    /// `t = clamp((x - edge0) / (edge1 - edge0), 0, 1)` (`bindExpression` - computed
    /// once and reused, matching `smoothstep_reference` computing `t` into a local and
    /// reusing it), `smoothstep(edge0, edge1, x) = t * t * (3 - 2 * t)`.
    SmoothStep,
    /// `Fma` (`DerivedFunc<Signature<float, float, float, float>>`,
    /// `glsBuiltinPrecisionTests.cpp` ~4139-4157): `doExpand` is plain `x.a * x.b +
    /// x.c` - dispatched to `fma_reference` from `check_one_ternary`, the same shape
    /// `Mix`/`SmoothStep` already use. Registered via upstream's `es31Cases`
    /// (`addScalarFactory<Fma>`, `createES3BuiltinCases` is *not* where it comes
    /// from), unlike every other `TernaryOp`/`BinaryOp`/`UnaryOp` variant, which all
    /// come from the one `es3Cases` factory list shared by both APIs - confirmed via
    /// the real mustpass: `gles3-main.txt` has zero `precision.fma.*` cases,
    /// `gles31-main.txt` has 36 (3 precisions x 4 `GenType`s x
    /// `{vertex,fragment,compute}`, all three stages rather than compute-only). So
    /// `Fma` is registered *only* by the `gles31` wrapper, with all three stages, and
    /// never by the `gles3` one. Also unlike every other function here, `Fma::
    /// getRequiredExtension` conditionally requires `GL_EXT_gpu_shader5` (GLSL ES
    /// added `fma()` as a core builtin only at 3.20; upstream's own check is actually
    /// "unless the context is desktop GL core 4.5", which is never true for any ES
    /// context this port creates, so in practice this port always needs the
    /// extension declared/checked, matching upstream's own `FuncCaseBase::iterate`,
    /// which throws `NotSupportedError` when the extension string is not advertised -
    /// see `required_extension`/`TernaryOpCase::iterate`'s own gate below).
    Fma,
}

impl TernaryOp {
    fn name(self) -> &'static str {
        match self {
            Self::Clamp => "clamp",
            Self::Mix => "mix",
            Self::SmoothStep => "smoothstep",
            Self::Fma => "fma",
        }
    }

    fn shader_expr(self) -> String {
        format!("{}(in0, in1, in2)", self.name())
    }

    /// `Fma::getRequiredExtension` - see `Fma`'s own doc comment above. `None` for
    /// every other variant (no other function ported so far needs an extension at
    /// all).
    fn required_extension(self) -> Option<&'static str> {
        match self {
            Self::Fma => Some("GL_EXT_gpu_shader5"),
            Self::Clamp | Self::Mix | Self::SmoothStep => None,
        }
    }
}

/// `Clamp::applyPoint` - out of range (`minVal > maxVal`) is legally `NaN`; otherwise a
/// direct comparison-based selection exactly like `MinMaxFunc`, except a tie against
/// *either* bound (not just against `x` itself) makes that bound's own exact value a
/// legal answer too (`result |= minVal` / `result |= maxVal`) rather than requiring an
/// `Interval::new` degenerate range as `MinMaxFunc` does - matching upstream's own
/// `Clamp::applyPoint` line for line, `precision()` (unconditionally `0.0`, or `NaN`
/// when `minVal > maxVal` - dead code here since this port's `applyPoint` override
/// never reaches the generic `FloatFunc3::applyPoint` that would call it, exactly as
/// `Div`'s and `MinMaxFunc`'s own `precision()` overrides already are for this port)
/// folded directly into the `minVal > maxVal` check above instead.
fn clamp_point(fmt: FloatFormat, x: f64, min_val: f64, max_val: f64) -> Interval {
    if min_val > max_val {
        return Interval::exact(f64::NAN);
    }
    let cmp_min = compare(fmt, x, min_val);
    let cmp_max = compare(fmt, x, max_val);
    let cmp_min_max = compare(fmt, min_val, max_val);

    if cmp_min < 0 {
        return if cmp_min_max < 0 {
            Interval::exact(min_val)
        } else {
            Interval::new(min_val, max_val)
        };
    }
    if cmp_max > 0 {
        return if cmp_min_max < 0 {
            Interval::exact(max_val)
        } else {
            Interval::new(min_val, max_val)
        };
    }

    let mut result = Interval::exact(x);
    if cmp_min == 0 {
        result = result | Interval::exact(min_val);
    }
    if cmp_max == 0 {
        result = result | Interval::exact(max_val);
    }
    result
}

fn clamp_reference(fmt: FloatFormat, x: Interval, min_val: Interval, max_val: Interval) -> Interval {
    let result = apply_monotone3(x, min_val, max_val, |x, mn, mx| clamp_point(fmt, x, mn, mx));
    fmt.convert(result)
}

/// `Mix(x, y, a) = alternatives((x * (1 - a)) + y * a, x + (y - x) * a)` - `alternatives`
/// is the same plain interval union (`|`) used by `acosh_reference`/`refract` above.
fn mix_reference(fmt: FloatFormat, precision: Precision, x: Interval, y: Interval, a: Interval) -> Interval {
    let one_minus_a = binary_reference(BinaryOp::Sub, fmt, precision, Interval::exact(1.0), a);
    let x_term = binary_reference(BinaryOp::Mul, fmt, precision, x, one_minus_a);
    let y_term = binary_reference(BinaryOp::Mul, fmt, precision, y, a);
    let alt1 = binary_reference(BinaryOp::Add, fmt, precision, x_term, y_term);

    let y_minus_x = binary_reference(BinaryOp::Sub, fmt, precision, y, x);
    let alt2 = binary_reference(
        BinaryOp::Add,
        fmt,
        precision,
        x,
        binary_reference(BinaryOp::Mul, fmt, precision, y_minus_x, a),
    );

    alt1 | alt2
}

/// `SmoothStep(edge0, edge1, x) = t * t * (3 - 2 * t)`, `t = clamp((x - edge0) /
/// (edge1 - edge0), 0, 1)` - `t` is computed once and reused for both occurrences,
/// matching upstream's own `bindExpression("t", ctx, tExpr)` (a shared subexpression,
/// evaluated once rather than independently at each use site).
fn smoothstep_reference(
    fmt: FloatFormat,
    precision: Precision,
    edge0: Interval,
    edge1: Interval,
    x: Interval,
) -> Interval {
    let diff_x = binary_reference(BinaryOp::Sub, fmt, precision, x, edge0);
    let diff_edge = binary_reference(BinaryOp::Sub, fmt, precision, edge1, edge0);
    let ratio = binary_reference(BinaryOp::Div, fmt, precision, diff_x, diff_edge);
    let t = clamp_reference(fmt, ratio, Interval::exact(0.0), Interval::exact(1.0));

    let t_sq = binary_reference(BinaryOp::Mul, fmt, precision, t, t);
    let two_t = binary_reference(BinaryOp::Mul, fmt, precision, Interval::exact(2.0), t);
    let three_minus_2t = binary_reference(BinaryOp::Sub, fmt, precision, Interval::exact(3.0), two_t);
    binary_reference(BinaryOp::Mul, fmt, precision, t_sq, three_minus_2t)
}

/// `Fma(x, y, z) = x * y + z` (`doExpand: x.a * x.b + x.c`) - two nested `binary_reference`
/// calls, same composition shape `Pow`/`Mod` already use for a two-argument `DerivedFunc`.
fn fma_reference(fmt: FloatFormat, precision: Precision, x: Interval, y: Interval, z: Interval) -> Interval {
    let xy = binary_reference(BinaryOp::Mul, fmt, precision, x, y);
    binary_reference(BinaryOp::Add, fmt, precision, xy, z)
}

/// `PrecisionCase::testStatement`'s per-sample loop for a three-argument function -
/// otherwise identical to `check_one`. `Mix`/`SmoothStep`/`Fma` dispatch to their own
/// `DerivedFunc`-shaped reference (threading `precision` through exactly like every
/// other `DerivedFunc` composition in this file, even though none of `Add`/`Sub`/`Mul`/
/// `Div`/`Clamp` - the only `BinaryOp`s either formula nests - actually reads it; only
/// `ATan2` does, and neither formula nests it), `Clamp` keeps its original `FloatFunc3`
/// path (which never needed `precision` either - its own `applyPoint` is exact).
#[allow(clippy::too_many_arguments)]
fn check_one_ternary(
    op: TernaryOp,
    fmt: FloatFormat,
    precision: Precision,
    highp_fmt: FloatFormat,
    a: f32,
    b: f32,
    c: f32,
    got: f32,
) -> Result<(), bool> {
    let ia = fmt.convert(fmt.round_out_point(a as f64, false));
    let ib = fmt.convert(fmt.round_out_point(b as f64, false));
    let ic = fmt.convert(fmt.round_out_point(c as f64, false));
    let reference = highp_fmt.convert(match op {
        TernaryOp::Clamp => clamp_reference(fmt, ia, ib, ic),
        TernaryOp::Mix => mix_reference(fmt, precision, ia, ib, ic),
        TernaryOp::SmoothStep => smoothstep_reference(fmt, precision, ia, ib, ic),
        TernaryOp::Fma => fma_reference(fmt, precision, ia, ib, ic),
    });
    let got = got as f64;

    if reference.contains(got) {
        Ok(())
    } else {
        Err(reference.contains_warning(got))
    }
}

/// `generateInputs`'s three-argument shape (`Clamp`'s `In0`/`In1`/`In2` are all
/// `float`/`Vector<float, Size>`, `In3` is `Void`): the full cross product of the
/// fixed samples across all three arguments, plus `NUM_RANDOM_SAMPLES` independent
/// random triples. This deliberately does not port `generateInputs`'s `seenInputs`
/// dedup (a `set` keyed on the whole tuple, skipping anything already generated) -
/// the two-argument `generate_inputs` above already omits the same dedup and every
/// function ported against it (`Add`/`Sub`/`Mul`/`Div`/`Min`/`Max`) diffed clean
/// against upstream regardless, since a duplicate sample only wastes a redundant
/// check, never changes a verdict.
fn generate_inputs3(fmt: FloatFormat, lanes: usize, seed: u32) -> (Vec<f32>, Vec<f32>, Vec<f32>) {
    let fixed = gen_fixed_samples(fmt);
    let fixed_count = fixed.len() * fixed.len() * fixed.len();
    let mut in0 = Vec::with_capacity((fixed_count + NUM_RANDOM_SAMPLES) * lanes);
    let mut in1 = Vec::with_capacity(in0.capacity());
    let mut in2 = Vec::with_capacity(in0.capacity());

    for &f0 in &fixed {
        for &f1 in &fixed {
            for &f2 in &fixed {
                in0.extend(std::iter::repeat_n(f0, lanes));
                in1.extend(std::iter::repeat_n(f1, lanes));
                in2.extend(std::iter::repeat_n(f2, lanes));
            }
        }
    }

    let mut rnd = Random::new(seed);
    for _ in 0..NUM_RANDOM_SAMPLES {
        for _ in 0..lanes {
            in0.push(gen_random_sample(fmt, &mut rnd));
        }
        for _ in 0..lanes {
            in1.push(gen_random_sample(fmt, &mut rnd));
        }
        for _ in 0..lanes {
            in2.push(gen_random_sample(fmt, &mut rnd));
        }
    }

    (in0, in1, in2)
}

/// `PrecisionCase::testStatement`'s `ShaderSpec` setup for a three-argument function
/// (`clamp(x, minVal, maxVal)`/`mix(x, y, a)`/`smoothstep(edge0, edge1, x)`) - three
/// inputs, one output, all at the case's own precision, same shape as `build_spec`
/// above. Originally `build_clamp_spec`, generalised for `Mix`/`SmoothStep` by taking
/// `op` and using its own `shader_expr` rather than the literal `clamp(...)` string.
fn build_ternary_spec(op: TernaryOp, context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    // GLSL requires every `#extension` directive to appear before any non-preprocessor
    // declaration, so it has to come *before* the `precision` statement below, not
    // after - confirmed the hard way: appending it after produced "#extension
    // directive is not allowed in the middle of a shader" from Mesa on every `Fma`
    // case. Upstream's own `PrecisionCase::testStatement` sidesteps the ordering
    // question entirely by *overwriting* `globalDeclarations` with just the extension
    // pragma, dropping the precision statement outright - harmless there (and here)
    // because every symbol already carries its own explicit precision qualifier
    // (`makeSymbol`/`Symbol::new` above), so nothing in the generated shader actually
    // depends on the default. Keeping both, in the only order GLSL accepts, is simpler
    // and behaves identically for every input this port generates.
    spec.global_declarations = match op.required_extension() {
        Some(ext) => format!("#extension {ext} : require\nprecision {} float;\n", precision.name()),
        None => format!("precision {} float;\n", precision.name()),
    };

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in2", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = format!("out0 = {};", op.shader_expr());
    spec
}

/// Originally `ClampCase`, generalised to the whole three-argument family (`op` picks
/// which of `clamp`/`mix`/`smoothstep` this case exercises) - the seed constant below
/// is still `Clamp`'s own (`0x636c_616d`, "clam" in ASCII) with `op` folded in the same
/// way `BinaryOpCase`/`UnaryOpCase` already fold their own `op` into their seed, so
/// `Mix`/`SmoothStep` get their own distinct random streams rather than replaying
/// `Clamp`'s exactly.
struct TernaryOpCase {
    op: TernaryOp,
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for TernaryOpCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // `FuncCaseBase::iterate`'s own extension gate (see `TernaryOp::Fma`'s doc
        // comment) - a real `NotSupported`, not a failure, when the driver does not
        // advertise the extension the shader below is about to declare.
        if let Some(ext) = self.op.required_extension()
            && !context.context_info.is_extension_supported(ext)
        {
            return Err(TestError::NotSupported(format!("Unsupported extension: {ext}")));
        }

        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_ternary_spec(self.op, context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x636c_616d
            ^ ((self.op as i32 as u32) << 16)
            ^ ((self.precision as i32 as u32) << 8)
            ^ ((self.stage as i32 as u32) << 4)
            ^ lanes as u32;
        let (in0, in1, in2) = generate_inputs3(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 3] = [f32_bytes(&in0), f32_bytes(&in1), f32_bytes(&in2)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            for lane in 0..lanes {
                let idx = value_ndx * lanes + lane;
                match check_one_ternary(
                    self.op,
                    fmt,
                    self.precision,
                    highp_fmt,
                    in0[idx],
                    in1[idx],
                    in2[idx],
                    out0[idx],
                ) {
                    Ok(()) => {}
                    Err(is_warning) => {
                        if is_warning {
                            num_warnings += 1;
                        } else {
                            num_errors += 1;
                        }
                        if first_message.is_none() {
                            first_message = Some(format!(
                                "sample {value_ndx} lane {lane}: in0 = {}, in1 = {}, in2 = {}, got {}",
                                in0[idx], in1[idx], in2[idx], out0[idx]
                            ));
                        }
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `createFuncGroup`, restricted to one three-argument function - same shape as
/// `binary_op_group`/`unary_op_group`. Originally `clamp_group` (`Clamp`-only).
pub fn ternary_op_group(op: TernaryOp, stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(op.name());
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(TernaryOpCase {
                    op,
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

// ---------------------------------------------------------------------------------
// One-argument functions (`FloatFunc1`): `Sin`/`Cos` (`TrigFunc`), `ASin`/`ACos`/`ATan`
// (`CFloatFunc1`/`ArcTrigFunc`), `Exp`/`Log` (`ExpFunc`/`LogFunc`, also `CFloatFunc1`).
// This was the first genuinely new argument arity this port added since `Clamp`'s
// three-argument shape - the trig family's *other* members (`Tan`, `Sinh`/`Cosh`/
// `Tanh`/`ASinh`/`ACosh`/`ATanh`) are `DEFINE_DERIVED_FLOAT1` macros in upstream, i.e.
// genuine `DerivedFunc` compositions over other functions (`Tan = sin(x) *
// (1/cos(x))`, `Sinh = (exp(x) - exp(-x))/2`, ...) built through the `Expr<T>`/
// `ExprP<T>` AST this port does not have - they are *not* the same shape as `Sin`/
// `Cos`/`ASin`/`ACos`/`ATan`/`Exp`/`Log` despite all being "the trig family"/"the
// exponential family" in the mustpass. `Tan`/`Sinh`/`Cosh`/`Tanh`/`ATanh` are ported
// anyway, by hand-composing each one's own nested-function chain directly rather than
// building the generic AST (see `derived_unary_reference` and its per-function
// `*_reference` helpers, further down, past `unary_reference`) - `Sqrt`/`InverseSqrt`/
// `Pow`/`ASinh`/`ACosh` are not (see the module header and the coverage campaign's
// progress log for why). `ATan2` (`CFloatFunc2`, its own `innerExtrema`) is a
// two-argument function, ported separately (see `BinaryOp::ATan2` above).
//
// `FloatFunc1::applyPoint` genuinely differs from `FloatFunc2`/`InfixOperator`'s shape
// in one way that matters: it explicitly narrows the *warning* range to `[exact -
// wprec, exact + wprec]` (`ioutput.warning(...)`), not just the main range - unlike
// `Add`/`Sub`/`Mul`/`Div`, which never touch the warning range and leave it at its
// default unbounded (see `symmetric_error_interval`'s own doc comment and the `Add`
// negative-control note in the coverage log for why that default is correct for those).
// None of `Sin`/`Cos`/`ASin`/`ACos`/`ATan`/`Exp` override `warningPrecision` (which
// defaults to `precision` itself), so `wprec == prec` for all of them -
// `float_func1_point` below sets the warning bounds to the same raw values as the main
// range in that case, via `Interval::set_warning` (a direct field assignment, exactly
// matching upstream's own `void warning(double, double)` - no NaN handling at either
// end, which is deliberate: if `precision()` itself returned `TCU_NAN` (`ASin`/`ACos`'s
// out-of-domain case), the assigned bound is a raw NaN *double*, not the interval's NaN
// *flag*, and `containsWarning`'s bound comparisons are simply false against it -
// matching upstream bit for bit rather than trying to interpret it). `Log` is the one
// exception: `LogFunc::warningPrecision` genuinely differs from `precision` at highp
// (OpenGL API Issue #57 - 4 ULPs warn, 3 ULPs fail), so `float_func1_point` takes
// `wprec` as its own parameter rather than hardcoding `wprec = prec`.
/// `deIntSign` - `0`/`1`/`-1`; comparisons against NaN are false either way, so this
/// returns `0` for a NaN input without any special-casing, matching a plain
/// less-than/greater-than implementation.
fn int_sign(x: f64) -> i32 {
    if x > 0.0 {
        1
    } else if x < 0.0 {
        -1
    } else {
        0
    }
}

/// `TCU_INTERVAL_APPLY_MONOTONE1` + `FloatFunc1::applyMonotone`'s corner-union step
/// alone (the `innerExtrema`/codomain steps are applied by the caller, same split as
/// `apply_monotone2`/`apply_monotone3` already use).
fn apply_monotone1(a: Interval, point: impl Fn(f64) -> Interval) -> Interval {
    let mut dst = if a.is_empty() {
        Interval::empty()
    } else {
        point(a.lo()) | point(a.hi())
    };
    if a.has_nan() {
        dst = dst | Interval::exact(f64::NAN);
    }
    dst
}

/// `FloatFunc1::applyPoint`'s generic shape: the main range is `exact +/- prec`
/// (`symmetric_error_interval`, already shared with `Div`'s `FloatFunc2::applyPoint`
/// path), plus the warning-range narrowing described above. `wprec` is a separate
/// parameter (not always `prec`) because `Log`'s own `warningPrecision` override is
/// genuinely different from its `precision` at highp (OpenGL API Issue #57: 4 ULPs
/// warn, 3 ULPs fail) - every other function ported through this still passes the
/// same value for both, matching upstream's `FloatFunc1::warningPrecision` default.
fn float_func1_point(exact: f64, prec: f64, wprec: f64) -> Interval {
    let mut ret = symmetric_error_interval(exact, prec);
    ret.set_warning(exact - wprec, exact + wprec);
    ret
}

/// `Sin`/`Cos`/`ASin`/`ACos`/`ATan`/`Exp`/`Log` (`FloatFunc1` primitives, each with its
/// own `precision()`/`getCodomain()`), plus `InverseSqrt`/`Exp2`/`Log2` (the same
/// primitive shape - `Exp2`/`Log2` share `Exp`/`Log`'s own precision formula exactly,
/// `ExpFunc`/`LogFunc` upstream, just a different base `DoubleFunc1`), plus
/// `Radians`/`Degrees`/`Tan`/`Sinh`/`Cosh`/`Tanh`/`ATanh`/`Sqrt`/`ASinh`/`ACosh`
/// (`DerivedFunc` compositions over the primitives above - see
/// `derived_unary_reference` and its per-function `*_reference` helpers below).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum UnaryOp {
    Sin,
    Cos,
    ASin,
    ACos,
    ATan,
    Exp,
    Log,
    /// `InverseSqrt` (`FloatFunc1`, `applyExact(x) = 1.0 / sqrt(x)`) - its own
    /// `precision()` is `x <= 0 ? TCU_NAN : ctx.format.ulp(ret, 2.0)`, unconditionally
    /// 2 ULPs regardless of the case's precision qualifier (unlike every other
    /// `FloatFunc1` primitive here, none of which skip that branch). `Sqrt` below is
    /// built directly on top of it (`1.0 / InverseSqrt(x)`), matching upstream's own
    /// `DEFINE_DERIVED_FLOAT1(Sqrt, ...)`.
    InverseSqrt,
    /// `Exp2` (`ExpFunc`, base `deExp2`) - same `exp_precision` formula as `Exp`, just
    /// `applyExact(x) = 2.0.powf(x)` instead of `x.exp()`.
    Exp2,
    /// `Log2` (`LogFunc`, base `deLog2`) - same `log_precision`/`log_warning_precision`
    /// formulas as `Log`, just `applyExact(x) = x.log2()` instead of `x.ln()`.
    Log2,
    /// `DEFINE_DERIVED_FLOAT1(Radians, radians, d, (constant(DE_PI) / constant(180.0f)) * d)` -
    /// a `DerivedFunc`, not a `FloatFunc1`: its reference is `derived_unary_reference` below,
    /// never `unary_point`/`unary_reference` (see the dedicated note there).
    Radians,
    /// `DEFINE_DERIVED_FLOAT1(Degrees, degrees, r, (constant(180.0f) / constant(DE_PI)) * r)` -
    /// same `DerivedFunc` shape as `Radians`, reciprocal constant.
    Degrees,
    /// `DEFINE_DERIVED_FLOAT1(Tan, tan, x, sin(x) * (constant(1.0f) / cos(x)))`.
    Tan,
    /// `DEFINE_DERIVED_FLOAT1(Sinh, sinh, x, (exp(x) - exp(-x)) / constant(2.0f))`.
    Sinh,
    /// `DEFINE_DERIVED_FLOAT1(Cosh, cosh, x, (exp(x) + exp(-x)) / constant(2.0f))`.
    Cosh,
    /// `DEFINE_DERIVED_FLOAT1(Tanh, tanh, x, sinh(x) / cosh(x))` - nests the two
    /// `DerivedFunc`s above, not just primitives.
    Tanh,
    /// `DEFINE_DERIVED_FLOAT1(ATanh, atanh, x, constant(0.5f) * log((constant(1.0f) + x) / (constant(1.0f) - x)))`.
    ATanh,
    /// `DEFINE_DERIVED_FLOAT1(Sqrt, sqrt, x, (x == 0.0f ? constant(1.0f) : (constant(1.0f) / app<InverseSqrt>(x))))` -
    /// the ternary's `x == 0.0f` branch is unreachable dead code in upstream itself
    /// (see `sqrt_reference`'s own doc comment for the compiled proof), so this is
    /// always `1.0 / InverseSqrt(x)`.
    Sqrt,
    /// `DEFINE_DERIVED_FLOAT1(ASinh, asinh, x, log(x + sqrt(x * x + constant(1.0f))))`.
    ASinh,
    /// `DEFINE_DERIVED_FLOAT1(ACosh, acosh, x, log(x + sqrt(alternatives((x + 1) * (x - 1), x * x - 1))))`.
    ACosh,
    /// `Abs` (`PreciseFunc1`, `applyExact = deAbs`, `precision()` unconditionally
    /// `0.0`) - like every other `PreciseFunc1` below, no override of
    /// `innerExtrema`/`getCodomain` either (both stay at `FloatFunc1`'s own defaults).
    Abs,
    /// `Sign` (`PreciseFunc1`, `applyExact = deSign`).
    Sign,
    /// `Floor` (`PreciseFunc1`, `applyExact = deFloor`) - also used directly by
    /// `Fract`/`Mod` below (`unary_reference(UnaryOp::Floor, ...)`), matching how
    /// upstream's own `DEFINE_DERIVED_FLOAT1(Fract, ...)`/`DEFINE_DERIVED_FLOAT2(Mod,
    /// ...)` call `app<Floor>` directly.
    Floor,
    /// `Trunc` (`PreciseFunc1`, `applyExact = deTrunc`).
    Trunc,
    /// `Round` (`FloatFunc1`, its own `applyPoint` rather than the generic
    /// `applyExact`/`precision` shape - see `unary_point`'s own dedicated arm: at the
    /// halfway point either neighbouring integer is a legal answer, matching GLSL's
    /// "implementation-defined" rounding at `x.5`).
    Round,
    /// `RoundEven` (`PreciseFunc1`, `applyExact = deRoundEven`) - case *group* name is
    /// `roundeven` (`de::toLower` of the GLSL function name) but the GLSL call itself
    /// is `roundEven(in0)`; `shader_expr` special-cases this one function for exactly
    /// that reason.
    RoundEven,
    /// `Ceil` (`PreciseFunc1`, `applyExact = deCeil`).
    Ceil,
    /// `DEFINE_DERIVED_FLOAT1(Fract, fract, x, x - app<Floor>(x))` - a `DerivedFunc`,
    /// dispatched through `derived_unary_reference`.
    Fract,
}

impl UnaryOp {
    fn name(self) -> &'static str {
        match self {
            Self::Sin => "sin",
            Self::Cos => "cos",
            Self::ASin => "asin",
            Self::ACos => "acos",
            Self::ATan => "atan",
            Self::Exp => "exp",
            Self::Log => "log",
            Self::InverseSqrt => "inversesqrt",
            Self::Exp2 => "exp2",
            Self::Log2 => "log2",
            Self::Radians => "radians",
            Self::Degrees => "degrees",
            Self::Tan => "tan",
            Self::Sinh => "sinh",
            Self::Cosh => "cosh",
            Self::Tanh => "tanh",
            Self::ATanh => "atanh",
            Self::Sqrt => "sqrt",
            Self::ASinh => "asinh",
            Self::ACosh => "acosh",
            Self::Abs => "abs",
            Self::Sign => "sign",
            Self::Floor => "floor",
            Self::Trunc => "trunc",
            Self::Round => "round",
            // `de::toLower("roundEven")` - the case *group* name; `shader_expr` keeps
            // the GLSL spelling below.
            Self::RoundEven => "roundeven",
            Self::Ceil => "ceil",
            Self::Fract => "fract",
        }
    }

    fn shader_expr(self) -> String {
        match self {
            Self::RoundEven => "roundEven(in0)".to_string(),
            _ => format!("{}(in0)", self.name()),
        }
    }

    /// `TrigFunc::innerExtrema` (`Sin`/`Cos` only - every other `FloatFunc1` primitive
    /// here uses the base-class default, an empty interval, since none of
    /// `CFloatFunc1`/`ArcTrigFunc`/`ExpFunc`/`LogFunc`/`InverseSqrt` override it).
    fn inner_extrema(self, arg: Interval) -> Interval {
        match self {
            Self::Sin => trig_inner_extrema(
                f64::sin,
                |x| int_sign(x.cos()),
                Interval::exact(-1.0),
                Interval::exact(1.0),
                arg,
            ),
            Self::Cos => trig_inner_extrema(
                f64::cos,
                |x| -int_sign(x.sin()),
                Interval::exact(-1.0),
                Interval::exact(1.0),
                arg,
            ),
            Self::ASin
            | Self::ACos
            | Self::ATan
            | Self::Exp
            | Self::Log
            | Self::InverseSqrt
            | Self::Exp2
            | Self::Log2
            | Self::Abs
            | Self::Sign
            | Self::Floor
            | Self::Trunc
            | Self::Round
            | Self::RoundEven
            | Self::Ceil => Interval::empty(),
            // Unreachable: these all dispatch through `derived_unary_reference`, never
            // `unary_reference`; kept only for match exhaustiveness.
            Self::Radians
            | Self::Degrees
            | Self::Tan
            | Self::Sinh
            | Self::Cosh
            | Self::Tanh
            | Self::ATanh
            | Self::Sqrt
            | Self::ASinh
            | Self::ACosh
            | Self::Fract => Interval::empty(),
        }
    }

    /// `TrigFunc::getCodomain` (`Sin`/`Cos`, `[-1, 1]`), `ExpFunc::getCodomain`
    /// (`Exp`/`Exp2`, `[0, inf)`), `InverseSqrt::getCodomain` (`[0, inf)`, same shape) -
    /// `ASin`/`ACos`/`ATan`/`Log`/`Log2` all keep the `FloatFunc1` default (unbounded),
    /// which is a no-op once `unary_reference` ORs the NaN flag back in regardless
    /// (`getCodomain() | TCU_NAN`, applied unconditionally in upstream's own
    /// `applyMonotone`).
    fn codomain(self) -> Interval {
        match self {
            Self::Sin | Self::Cos => Interval::new(-1.0, 1.0),
            Self::Exp | Self::Exp2 | Self::InverseSqrt => Interval::new(0.0, f64::INFINITY),
            Self::ASin
            | Self::ACos
            | Self::ATan
            | Self::Log
            | Self::Log2
            | Self::Abs
            | Self::Sign
            | Self::Floor
            | Self::Trunc
            | Self::Round
            | Self::RoundEven
            | Self::Ceil => Interval::unbounded(false),
            // Unreachable, see `inner_extrema` above.
            Self::Radians
            | Self::Degrees
            | Self::Tan
            | Self::Sinh
            | Self::Cosh
            | Self::Tanh
            | Self::ATanh
            | Self::Sqrt
            | Self::ASinh
            | Self::ACosh
            | Self::Fract => Interval::unbounded(false),
        }
    }
}

/// `TrigFunc::innerExtrema`, shared by `Sin`/`Cos` (only their `applyExact`/
/// `doGetSlope`/extrema constants differ - both extrema are `+-1` either way, just
/// which one is "low" versus "high" flips between the two functions).
fn trig_inner_extrema(
    apply_exact: impl Fn(f64) -> f64,
    get_slope: impl Fn(f64) -> i32,
    lo_ex: Interval,
    hi_ex: Interval,
    angle: Interval,
) -> Interval {
    let lo = angle.lo();
    let hi = angle.hi();
    let lo_slope = get_slope(lo);
    let hi_slope = get_slope(hi);

    if angle.hi() - angle.lo() >= 2.0 * std::f64::consts::PI {
        hi_ex | lo_ex
    } else if lo_slope == 1 && hi_slope == -1 {
        hi_ex
    } else if lo_slope == -1 && hi_slope == 1 {
        lo_ex
    } else if lo_slope == hi_slope && int_sign(apply_exact(hi) - apply_exact(lo)) * lo_slope == -1 {
        hi_ex | lo_ex
    } else {
        Interval::empty()
    }
}

/// `TrigFunc::precision` - the OpenCL-derived absolute/ULP error bounds, ported
/// verbatim per precision qualifier and whether `arg` (the raw angle, not the result)
/// falls inside `[-pi, pi]`.
fn trig_precision(precision: Precision, fmt: FloatFormat, ret: f64, arg: f64) -> f64 {
    use std::f64::consts::PI;
    let in_range = (-PI..=PI).contains(&arg);
    match precision {
        Precision::HighP => {
            if in_range {
                ldexp(1.0, -11)
            } else {
                ldexp(arg.abs(), -12)
            }
        }
        Precision::MediumP => {
            if in_range {
                fmt.ulp(ret, 2.0)
            } else {
                ldexp(arg.abs(), -10)
            }
        }
        Precision::LowP => fmt.ulp(ret, 2.0),
    }
}

/// `ArcTrigFunc::precision`, shared by `ACos`/`ATan` (`ASin` has its own, simpler,
/// absolute-error-only shape ported directly in `unary_point` below - it is not built
/// from `ArcTrigFunc` upstream either).
fn arctrig_precision(
    fmt: FloatFormat,
    precision: Precision,
    domain: Interval,
    precision_ulps: f64,
    ret: f64,
    x: f64,
) -> f64 {
    if !domain.contains(x) {
        return f64::NAN;
    }
    if precision == Precision::HighP {
        fmt.ulp(ret, precision_ulps)
    } else {
        fmt.ulp(ret, 2.0)
    }
}

/// `ExpFunc::precision` - shared by `Exp`/`Exp2` upstream; only `Exp` is ported.
fn exp_precision(precision: Precision, fmt: FloatFormat, ret: f64, x: f64) -> f64 {
    match precision {
        Precision::HighP => fmt.ulp(ret, 3.0 + 2.0 * x.abs()),
        Precision::MediumP => fmt.ulp(ret, 2.0 + 2.0 * x.abs()),
        Precision::LowP => fmt.ulp(ret, 2.0),
    }
}

/// `LogFunc::precision` - shared by `Log`/`Log2` upstream; only `Log` is ported.
fn log_precision(precision: Precision, fmt: FloatFormat, ret: f64, x: f64) -> f64 {
    if x <= 0.0 {
        return f64::NAN;
    }
    let near_one = (0.5..=2.0).contains(&x);
    match precision {
        Precision::HighP => {
            if near_one {
                ldexp(1.0, -21)
            } else {
                fmt.ulp(ret, 3.0)
            }
        }
        Precision::MediumP => {
            if near_one {
                ldexp(1.0, -7)
            } else {
                fmt.ulp(ret, 2.0)
            }
        }
        Precision::LowP => fmt.ulp(ret, 2.0),
    }
}

/// `LogFunc::warningPrecision` - OpenGL API Issue #57: highp `log`/`log2` are allowed
/// 4 ULPs before CTS treats it as a hard failure, but still warns past 3.
fn log_warning_precision(precision: Precision, fmt: FloatFormat, ret: f64, x: f64) -> f64 {
    if precision == Precision::HighP && x > 0.0 {
        if (0.5..=2.0).contains(&x) {
            ldexp(1.0, -21)
        } else {
            fmt.ulp(ret, 4.0)
        }
    } else {
        log_precision(precision, fmt, ret, x)
    }
}

fn unary_point(op: UnaryOp, fmt: FloatFormat, precision: Precision, x: f64) -> Interval {
    match op {
        UnaryOp::Sin => {
            let exact = x.sin();
            let prec = trig_precision(precision, fmt, exact, x);
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::Cos => {
            let exact = x.cos();
            let prec = trig_precision(precision, fmt, exact, x);
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::ASin => {
            let exact = x.asin();
            // `ASin::precision` - a plain absolute error, not `ArcTrigFunc`-shaped.
            let prec = if !(-1.0..=1.0).contains(&x) {
                f64::NAN
            } else if precision == Precision::HighP {
                ldexp(1.0, -11)
            } else {
                ldexp(1.0, -8)
            };
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::ACos => {
            let exact = x.acos();
            let prec = arctrig_precision(fmt, precision, Interval::new(-1.0, 1.0), 4096.0, exact, x);
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::ATan => {
            let exact = x.atan();
            let prec = arctrig_precision(fmt, precision, Interval::unbounded(false), 4096.0, exact, x);
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::Exp => {
            let exact = x.exp();
            let prec = exp_precision(precision, fmt, exact, x);
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::Log => {
            let exact = x.ln();
            let prec = log_precision(precision, fmt, exact, x);
            let wprec = log_warning_precision(precision, fmt, exact, x);
            float_func1_point(exact, prec, wprec)
        }
        // `InverseSqrt::precision` - unconditionally 2 ULPs (no branch on the case's
        // precision qualifier at all, unlike every other primitive above), NaN outside
        // its domain (`x <= 0`).
        UnaryOp::InverseSqrt => {
            let exact = 1.0 / x.sqrt();
            let prec = if x <= 0.0 { f64::NAN } else { fmt.ulp(exact, 2.0) };
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::Exp2 => {
            let exact = x.exp2();
            let prec = exp_precision(precision, fmt, exact, x);
            float_func1_point(exact, prec, prec)
        }
        UnaryOp::Log2 => {
            let exact = x.log2();
            let prec = log_precision(precision, fmt, exact, x);
            let wprec = log_warning_precision(precision, fmt, exact, x);
            float_func1_point(exact, prec, wprec)
        }
        // `PreciseFunc1`s - `precision()` is unconditionally `0.0` for all six, no
        // branch on the case's precision qualifier at all (matching `InverseSqrt`'s own
        // shape, not the trig/exp/log family above).
        UnaryOp::Abs => float_func1_point(x.abs(), 0.0, 0.0),
        // `deSign` - GLSL's own definition ("1.0 if x > 0, 0.0 if x = 0, -1.0 if x < 0")
        // matches Rust's `f64::signum()` except at exactly zero, where `signum()`
        // returns `+-1.0` depending on the sign of zero rather than `0.0` - handled
        // explicitly rather than trusting `signum()` there.
        UnaryOp::Sign => {
            let exact = if x > 0.0 {
                1.0
            } else if x < 0.0 {
                -1.0
            } else {
                x // preserves `0.0`/`-0.0`/`NaN` unchanged, matching `deSign`'s own shape.
            };
            float_func1_point(exact, 0.0, 0.0)
        }
        UnaryOp::Floor => float_func1_point(x.floor(), 0.0, 0.0),
        UnaryOp::Trunc => float_func1_point(x.trunc(), 0.0, 0.0),
        // `Round::applyPoint` - not the generic `applyExact`/`precision` shape: at the
        // halfway point (`|fract| == 0.5`) *both* neighbouring integers are legal
        // (GLSL leaves round-half behaviour implementation-defined), so this unions
        // both rather than picking one. `fract`'s sign always matches `x`'s own (Rust's
        // `f64::fract()` is `x - x.trunc()`, the same definition `deModf` uses), and
        // `fract` is provably nonzero whenever `|fract| >= 0.5`, so `fract.signum()`
        // needs no zero special-case the way `Sign` above does.
        UnaryOp::Round => {
            // `deModf` (C99 `modf`) special-cases an infinite `value`: `*iptr = value`
            // and the fractional part is `0` (same sign), rather than computed via
            // subtraction - Rust's `f64::fract()` is a plain `self - self.trunc()`,
            // which for `x == +-inf` is `inf - inf == NaN`, not `0`. Found via a real
            // llvmpipe run (`round(-inf)` reported `QualityWarning` here - passable
            // only because the warning range defaults to unbounded - and `DIFFER`
            // against real `deqp-gles3`/`deqp-gles31`, both of which correctly
            // `Pass` it): without this, every fixed sample here that is `+-inf` fell
            // through both branches below to an empty interval.
            let truncated = x.trunc();
            let fract = if x.is_infinite() { 0.0 } else { x.fract() };
            let mut ret = Interval::empty();
            if fract.abs() <= 0.5 {
                ret = ret | Interval::exact(truncated);
            }
            if fract.abs() >= 0.5 {
                ret = ret | Interval::exact(truncated + fract.signum());
            }
            ret
        }
        UnaryOp::RoundEven => float_func1_point(x.round_ties_even(), 0.0, 0.0),
        UnaryOp::Ceil => float_func1_point(x.ceil(), 0.0, 0.0),
        // Unreachable: these all dispatch through `derived_unary_reference`, never
        // `unary_point`/`unary_reference`; kept only for match exhaustiveness.
        UnaryOp::Radians
        | UnaryOp::Degrees
        | UnaryOp::Tan
        | UnaryOp::Sinh
        | UnaryOp::Cosh
        | UnaryOp::Tanh
        | UnaryOp::ATanh
        | UnaryOp::Sqrt
        | UnaryOp::ASinh
        | UnaryOp::ACosh
        | UnaryOp::Fract => {
            unreachable!("dispatches through derived_unary_reference instead")
        }
    }
}

/// `FloatFunc1::applyMonotone` in full: the two-corner union, `| innerExtrema`, then
/// `& (getCodomain() | TCU_NAN)` - the codomain intersection is a genuine no-op for
/// `ASin`/`ACos`/`ATan` (whose codomain is unbounded) and a real restriction for
/// `Sin`/`Cos` (clamped to `[-1, 1]`, NaN always still legal).
fn unary_reference(op: UnaryOp, fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let point = |x: f64| unary_point(op, fmt, precision, x);
    let mut result = apply_monotone1(arg, point);
    result = result | op.inner_extrema(arg);
    let codomain = op.codomain() | Interval::exact(f64::NAN);
    result = result & codomain;
    fmt.convert(result)
}

/// `Radians`/`Degrees` (`DEFINE_DERIVED_FLOAT1`, `DerivedFunc<Signature<float, float>>`)
/// composed directly rather than through a generic `Expr`/`Apply` evaluator, read from
/// the C++ itself rather than guessed:
///
/// - `Constant<T>::doEvaluate` returns `makeIVal(m_value)` - an exact point interval of
///   the literal, no format rounding at all. `DE_PI` is declared `3.14159265358979324f`
///   (a `float` literal, i.e. already rounded once to the nearest `f32` at C++ compile
///   time), so `f32::consts::PI as f64` is bit-for-bit the same double this promotes to
///   - both round the same infinite-precision pi to the same nearest `f32`.
/// - `Apply<Sig>::doEvaluate` threads the *same* `EvalContext` (`ctx.format`,
///   `ctx.floatPrecision`) into every nested call, so the constant division below runs
///   at the exact same format/precision as the outer multiplication - no separate
///   "compute the constant at full precision" step.
/// - `DerivedFunc::doApply` evaluates the composed tree once and returns exactly what
///   the outermost `Apply` (here, `Mul`) returned - no extra codomain intersection or
///   `format.convert` of its own layered on top, unlike `FloatFunc1::applyMonotone`
///   (which `unary_reference` above replicates for `Sin`/`Cos`/`ASin`/`ACos`/`ATan`).
///
/// `Mul::doApply`/`Div::doApply` (both `InfixOperator`s) are already `binary_reference`
/// in this port, so the whole composition is two calls to it - `(DE_PI / 180) * d` for
/// `Radians`, `(180 / DE_PI) * r` for `Degrees` - rather than a new generic evaluator.
/// This works *because* neither function nests a non-arithmetic sub-function (no
/// `sin`/`cos`/`exp`/`log`/`sqrt` inside); `Tan`/the hyperbolic family/`Sqrt`/`Pow` all
/// do, so do not generalize this shape to them without reading their own composition
/// first, per the standing note in the progress file.
/// `Negate::doApply` (`FloatFunc1`, `_negate`, upstream's own `operator-(ExprP<float>)`) -
/// used only inside `Sinh`/`Cosh`'s own `exp(-x)` sub-expression, never registered as a
/// standalone builtin (there is no GLSL `negate()` function), so this stays a private
/// helper rather than a `UnaryOp` variant with its own case group. `precision()` is
/// unconditionally `0.0` (exact) and neither `innerExtrema` nor `getCodomain` is
/// overridden, so the base `FloatFunc1::applyMonotone` codomain/NaN step is a genuine
/// no-op here (intersecting with `unbounded(true)` changes nothing) and is skipped.
fn negate_reference(fmt: FloatFormat, arg: Interval) -> Interval {
    let result = apply_monotone1(arg, |x| float_func1_point(-x, 0.0, 0.0));
    fmt.convert(result)
}

/// `Tan = sin(x) * (1 / cos(x))` - both `sin`/`cos` sub-calls run through the same
/// `unary_reference` this port already gives `Sin`/`Cos`, threaded through the same
/// `(fmt, precision)` `EvalContext` `Apply<Sig>::doEvaluate` uses for every nested call.
fn tan_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let sin_i = unary_reference(UnaryOp::Sin, fmt, precision, arg);
    let cos_i = unary_reference(UnaryOp::Cos, fmt, precision, arg);
    let recip = binary_reference(BinaryOp::Div, fmt, precision, Interval::exact(1.0), cos_i);
    binary_reference(BinaryOp::Mul, fmt, precision, sin_i, recip)
}

/// `Sinh = (exp(x) - exp(-x)) / 2`.
fn sinh_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let exp_pos = unary_reference(UnaryOp::Exp, fmt, precision, arg);
    let neg_arg = negate_reference(fmt, arg);
    let exp_neg = unary_reference(UnaryOp::Exp, fmt, precision, neg_arg);
    let diff = binary_reference(BinaryOp::Sub, fmt, precision, exp_pos, exp_neg);
    binary_reference(BinaryOp::Div, fmt, precision, diff, Interval::exact(2.0))
}

/// `Cosh = (exp(x) + exp(-x)) / 2`.
fn cosh_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let exp_pos = unary_reference(UnaryOp::Exp, fmt, precision, arg);
    let neg_arg = negate_reference(fmt, arg);
    let exp_neg = unary_reference(UnaryOp::Exp, fmt, precision, neg_arg);
    let sum = binary_reference(BinaryOp::Add, fmt, precision, exp_pos, exp_neg);
    binary_reference(BinaryOp::Div, fmt, precision, sum, Interval::exact(2.0))
}

/// `Tanh = sinh(x) / cosh(x)` - nests the two `DerivedFunc`s above rather than
/// primitives, exactly as upstream's own expansion does (`Apply::doEvaluate` recurses
/// into whatever `Expr<T>` the sub-call is, `DerivedFunc` or not).
fn tanh_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let sh = sinh_reference(fmt, precision, arg);
    let ch = cosh_reference(fmt, precision, arg);
    binary_reference(BinaryOp::Div, fmt, precision, sh, ch)
}

/// `ATanh = 0.5 * log((1 + x) / (1 - x))`.
fn atanh_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let one_plus_x = binary_reference(BinaryOp::Add, fmt, precision, Interval::exact(1.0), arg);
    let one_minus_x = binary_reference(BinaryOp::Sub, fmt, precision, Interval::exact(1.0), arg);
    let ratio = binary_reference(BinaryOp::Div, fmt, precision, one_plus_x, one_minus_x);
    let l = unary_reference(UnaryOp::Log, fmt, precision, ratio);
    binary_reference(BinaryOp::Mul, fmt, precision, Interval::exact(0.5), l)
}

/// `Sqrt = 1.0f / InverseSqrt(x)`, always - resolving the ternary in upstream's own
/// `DEFINE_DERIVED_FLOAT1(Sqrt, sqrt, x, (x == 0.0f ? constant(1.0f) : (constant(1.0f) /
/// app<InverseSqrt>(x))))` was this coverage campaign's standing blocked item (see the
/// progress log). Resolved by compiling a minimal standalone reproduction of the real
/// `SharedPtr<T>`/`ExprP<T>` shape (`framework/delibs/decpp/deSharedPtr.hpp`): `x` here
/// is an `ExprP<float>` - a `SharedPtr`-derived smart pointer with an *implicit*
/// `operator bool()` (`return !!m_ptr;`, not marked `explicit`) but no `operator==` of
/// its own anywhere in the codebase, and no implicit constructor from `float` either.
/// `x == 0.0f` therefore compiles via that bool conversion under the usual arithmetic
/// conversions against the `float` literal - i.e. it becomes `(x ? 1.0 : 0.0) == 0.0f`.
/// Compiled directly (g++, the exact class shapes from the real headers): a
/// non-null `ExprP` (`bool(x) == true`) makes this `1.0 == 0.0f`, unconditionally
/// `false`; only a *default-constructed*, null `ExprP` would take the `constant(1.0f)`
/// branch, and `x` here is always the bound argument (never null) at the point
/// `doExpand`'s composed tree is evaluated. So the `0.0f` branch is unreachable dead
/// code in upstream itself, not a genuine special case to port - `Sqrt` is simply
/// `1.0 / InverseSqrt(x)` for every input, matching this port's own `sqrt_reference`.
fn sqrt_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let inv = unary_reference(UnaryOp::InverseSqrt, fmt, precision, arg);
    binary_reference(BinaryOp::Div, fmt, precision, Interval::exact(1.0), inv)
}

/// `ASinh = log(x + sqrt(x * x + 1))`.
fn asinh_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let xx = binary_reference(BinaryOp::Mul, fmt, precision, arg, arg);
    let xx_plus_1 = binary_reference(BinaryOp::Add, fmt, precision, xx, Interval::exact(1.0));
    let s = sqrt_reference(fmt, precision, xx_plus_1);
    let sum = binary_reference(BinaryOp::Add, fmt, precision, arg, s);
    unary_reference(UnaryOp::Log, fmt, precision, sum)
}

/// `ACosh = log(x + sqrt(alternatives((x + 1) * (x - 1), x * x - 1)))` - `alternatives`
/// is `Alternatives::doApply`'s plain interval union (`unionIVal`, confirmed by reading
/// its `doApply` directly: `return unionIVal<T>(args.a, args.b);`), matching this
/// port's own `Interval::bitor` (`|`), already used the same way by
/// `TrigFunc::innerExtrema` and the `Mul`/`Div`/`ATan2` `inner_extrema` helpers above.
fn acosh_reference(fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    let x_plus_1 = binary_reference(BinaryOp::Add, fmt, precision, arg, Interval::exact(1.0));
    let x_minus_1 = binary_reference(BinaryOp::Sub, fmt, precision, arg, Interval::exact(1.0));
    let alt1 = binary_reference(BinaryOp::Mul, fmt, precision, x_plus_1, x_minus_1);
    let xx = binary_reference(BinaryOp::Mul, fmt, precision, arg, arg);
    let alt2 = binary_reference(BinaryOp::Sub, fmt, precision, xx, Interval::exact(1.0));
    let alt = alt1 | alt2;
    let s = sqrt_reference(fmt, precision, alt);
    let sum = binary_reference(BinaryOp::Add, fmt, precision, arg, s);
    unary_reference(UnaryOp::Log, fmt, precision, sum)
}

/// `Pow = exp2(y * log2(x))` (`DEFINE_DERIVED_FLOAT2`) - the one two-argument
/// `DerivedFunc` ported so far. Dispatched directly from `check_one` (see `BinaryOp::Pow`'s
/// own doc comment) rather than through `binary_reference`, mirroring how the
/// one-argument `DerivedFunc`s dispatch through `derived_unary_reference` instead of
/// `unary_reference`.
fn pow_reference(fmt: FloatFormat, precision: Precision, x: Interval, y: Interval) -> Interval {
    let log2_x = unary_reference(UnaryOp::Log2, fmt, precision, x);
    let mul = binary_reference(BinaryOp::Mul, fmt, precision, y, log2_x);
    unary_reference(UnaryOp::Exp2, fmt, precision, mul)
}

/// `Radians`/`Degrees`/`Tan`/`Sinh`/`Cosh`/`Tanh`/`ATanh`/`Sqrt`/`ASinh`/`ACosh` (every
/// `DEFINE_DERIVED_FLOAT1` entry ported so far) - each composed directly out of
/// already-ported primitives and other `derived_unary_reference` results rather than
/// through a generic `Expr`/`Apply` evaluator, per-function reasoning read from the C++
/// itself (see each `*_reference` helper's own doc comment, and the `Radians`/`Degrees`
/// note this generalizes from). `DerivedFunc::doApply` evaluates the composed tree once
/// and returns exactly what the outermost call returned - no extra codomain
/// intersection or `format.convert` of its own layered on top - which is why every
/// helper above ends on its own outermost `binary_reference`/`unary_reference` call
/// with no further wrapping here.
fn derived_unary_reference(op: UnaryOp, fmt: FloatFormat, precision: Precision, arg: Interval) -> Interval {
    match op {
        UnaryOp::Radians | UnaryOp::Degrees => {
            let pi = std::f32::consts::PI as f64;
            let (num, den) = if op == UnaryOp::Radians {
                (pi, 180.0)
            } else {
                (180.0, pi)
            };
            let c = binary_reference(
                BinaryOp::Div,
                fmt,
                precision,
                Interval::exact(num),
                Interval::exact(den),
            );
            binary_reference(BinaryOp::Mul, fmt, precision, c, arg)
        }
        UnaryOp::Tan => tan_reference(fmt, precision, arg),
        UnaryOp::Sinh => sinh_reference(fmt, precision, arg),
        UnaryOp::Cosh => cosh_reference(fmt, precision, arg),
        UnaryOp::Tanh => tanh_reference(fmt, precision, arg),
        UnaryOp::ATanh => atanh_reference(fmt, precision, arg),
        UnaryOp::Sqrt => sqrt_reference(fmt, precision, arg),
        UnaryOp::ASinh => asinh_reference(fmt, precision, arg),
        UnaryOp::ACosh => acosh_reference(fmt, precision, arg),
        // `Fract = x - floor(x)`.
        UnaryOp::Fract => {
            let fl = unary_reference(UnaryOp::Floor, fmt, precision, arg);
            binary_reference(BinaryOp::Sub, fmt, precision, arg, fl)
        }
        _ => unreachable!("derived_unary_reference only handles DerivedFunc-shaped ops"),
    }
}

/// `Mod = x - y * floor(x / y)` (`DEFINE_DERIVED_FLOAT2`). Dispatched directly from
/// `check_one` (see `BinaryOp::Mod`'s own doc comment) rather than through
/// `binary_reference`, mirroring `pow_reference`.
fn mod_reference(fmt: FloatFormat, precision: Precision, x: Interval, y: Interval) -> Interval {
    let div = binary_reference(BinaryOp::Div, fmt, precision, x, y);
    let fl = unary_reference(UnaryOp::Floor, fmt, precision, div);
    let prod = binary_reference(BinaryOp::Mul, fmt, precision, y, fl);
    binary_reference(BinaryOp::Sub, fmt, precision, x, prod)
}

/// `PrecisionCase::testStatement`'s per-sample loop for a one-argument function -
/// otherwise identical to `check_one`/`check_one_clamp`. The `DerivedFunc`-shaped ops
/// dispatch to `derived_unary_reference` instead of `unary_reference` - see its own doc
/// comment.
fn check_one1(
    op: UnaryOp,
    fmt: FloatFormat,
    precision: Precision,
    highp_fmt: FloatFormat,
    x: f32,
    got: f32,
) -> Result<(), bool> {
    let ix = fmt.convert(fmt.round_out_point(x as f64, false));
    let reference = highp_fmt.convert(match op {
        UnaryOp::Radians
        | UnaryOp::Degrees
        | UnaryOp::Tan
        | UnaryOp::Sinh
        | UnaryOp::Cosh
        | UnaryOp::Tanh
        | UnaryOp::ATanh
        | UnaryOp::Sqrt
        | UnaryOp::ASinh
        | UnaryOp::ACosh
        | UnaryOp::Fract => derived_unary_reference(op, fmt, precision, ix),
        _ => unary_reference(op, fmt, precision, ix),
    });
    let got = got as f64;

    if reference.contains(got) {
        Ok(())
    } else {
        Err(reference.contains_warning(got))
    }
}

/// `generateInputs`'s one-argument shape: the fixed samples directly (no cross
/// product needed with only one operand), plus `NUM_RANDOM_SAMPLES` random ones.
fn generate_inputs1(fmt: FloatFormat, lanes: usize, seed: u32) -> Vec<f32> {
    let fixed = gen_fixed_samples(fmt);
    let mut in0 = Vec::with_capacity((fixed.len() + NUM_RANDOM_SAMPLES) * lanes);
    for &f0 in &fixed {
        in0.extend(std::iter::repeat_n(f0, lanes));
    }
    let mut rnd = Random::new(seed);
    for _ in 0..NUM_RANDOM_SAMPLES {
        for _ in 0..lanes {
            in0.push(gen_random_sample(fmt, &mut rnd));
        }
    }
    in0
}

fn build_unary_spec(context: &Context, op: UnaryOp, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = format!("out0 = {};", op.shader_expr());
    spec
}

struct UnaryOpCase {
    op: UnaryOp,
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for UnaryOpCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_unary_spec(context, self.op, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x756e_6172
            ^ ((self.op as i32 as u32) << 12)
            ^ ((self.precision as i32 as u32) << 8)
            ^ ((self.stage as i32 as u32) << 4)
            ^ lanes as u32;
        let in0 = generate_inputs1(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            for lane in 0..lanes {
                let idx = value_ndx * lanes + lane;
                match check_one1(self.op, fmt, self.precision, highp_fmt, in0[idx], out0[idx]) {
                    Ok(()) => {}
                    Err(is_warning) => {
                        if is_warning {
                            num_warnings += 1;
                        } else {
                            num_errors += 1;
                        }
                        if first_message.is_none() {
                            first_message = Some(format!(
                                "sample {value_ndx} lane {lane}: in0 = {}, got {}",
                                in0[idx], out0[idx]
                            ));
                        }
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `createFuncGroup`, restricted to one one-argument function - same shape as
/// `binary_op_group`/`clamp_group`.
pub fn unary_op_group(op: UnaryOp, stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(op.name());
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(UnaryOpCase {
                    op,
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

// ---------------------------------------------------------------------------------
// `Modf` (`PrimitiveFunc<Signature<float, float, float>>`, `glsBuiltinPrecisionTests.cpp`
// ~3538-3570): the one two-*output* function ported so far, and genuinely differently
// shaped from every `UnaryOp`/`BinaryOp`/`TernaryOp` case above in two ways, both read
// directly off the C++ rather than guessed from the GLSL signature:
//
// - It is registered via `funcs->addFactory(createSimpleFuncCaseFactory<Modf>())`, not
//   `addScalarFactory` - `SimpleFuncCaseFactory::createCase` builds exactly *one*
//   `PrecisionCase` per precision/stage combination directly (named after that
//   combination, e.g. "highp_vertex"), never `GenFuncCaseFactory`'s
//   `scalar`/`vec2`/`vec3`/`vec4` group-of-four. Confirmed against the real mustpass:
//   `gles3-main.txt`'s `precision.modf.*` names are `highp_fragment`/`highp_vertex`/
//   `lowp_fragment`/`lowp_vertex`/`mediump_fragment`/`mediump_vertex` directly (6, no
//   `GenType` suffix at all), `gles31-main.txt`'s are `highp_compute`/`lowp_compute`/
//   `mediump_compute` (3) - i.e. `modf` only ever runs at scalar width, never vec2/3/4.
// - `Modf::doApply` returns the fractional-part interval as its own `IRet`, but *also*
//   writes the integer-part interval into `iargs.b` in place
//   (`getOutParamIndex() == 1`) - `InOutFuncCase<Sig>::runTest` binds that second
//   argument to the shader's own `out1` variable rather than to a real input, so the
//   generated GLSL is `out0 = modf(in0, out1);` with `out1` an `out float` parameter,
//   not a third input. `modf_reference` below returns the `(frac, whole)` pair
//   directly instead of replicating the C++'s environment-binding side effect.

/// `deModf`'s two halves at one exact point: `frac = x - trunc(x)`, `whole = trunc(x)`,
/// except at `+-inf` (`deModf`'s own special case, avoiding `inf - inf == NaN`,
/// matching the same fix `unary_point`'s `Round` arm already needed) where
/// `frac = +-0.0` and `whole = x` itself, and at `NaN` where both halves are `NaN`.
fn modf_point(x: f64) -> (Interval, Interval) {
    if x.is_nan() {
        return (Interval::exact(f64::NAN), Interval::exact(f64::NAN));
    }
    if x.is_infinite() {
        return (Interval::exact(0.0f64.copysign(x)), Interval::exact(x));
    }
    let whole = x.trunc();
    (Interval::exact(x - whole), Interval::exact(whole))
}

/// `Modf::doApply` - `TCU_INTERVAL_APPLY_MONOTONE1` over each half independently (so
/// each already gets its own NaN-if-`iargs.a.hasNaN()` flag, matching `apply_monotone1`),
/// plus the fractional part's own extra allowance: "Behavior on `modf(Inf)` is not
/// well-defined... allow anything as a fractional part" (Khronos bug 13907) - applied
/// only to `frac`, never to `whole`, when the *interval* `x` is not finite at this
/// format's own largest representable value (not just when a sampled point happens to
/// be literally infinite - matching `iargs.a.isFinite(ctx.format.getMaxValue())`
/// exactly, the same check `atan2_inner_extrema` already uses).
fn modf_reference(fmt: FloatFormat, x: Interval) -> (Interval, Interval) {
    let mut frac = apply_monotone1(x, |v| modf_point(v).0);
    let whole = apply_monotone1(x, |v| modf_point(v).1);
    if !x.is_finite(fmt.max_value()) {
        frac = frac | Interval::exact(f64::NAN);
    }
    (fmt.convert(frac), fmt.convert(whole))
}

/// `PrecisionCase::testStatement`'s two-output comparison (`outCount == 2`'s `case 2`
/// falling through to `case 1`): both `out0` (fractional part) and `out1` (whole part)
/// are checked independently, and the worst of the two verdicts wins (`Fail` if either
/// one fails outright, `QualityWarning` if neither fails but either one only lands in
/// the wider warning range, `Pass` only if both are exact `contains` hits) - upstream's
/// own `result`/`failStr` bookkeeping reaches the same worst-of-two outcome, just
/// spread across two fallthrough `case` blocks that each may set `result = false`.
fn check_one_modf(fmt: FloatFormat, highp_fmt: FloatFormat, x: f32, got_frac: f32, got_whole: f32) -> Result<(), bool> {
    let ix = fmt.convert(fmt.round_out_point(x as f64, false));
    let (frac_iv, whole_iv) = modf_reference(fmt, ix);
    let frac_ref = highp_fmt.convert(frac_iv);
    let whole_ref = highp_fmt.convert(whole_iv);
    let got_frac = got_frac as f64;
    let got_whole = got_whole as f64;

    let mut warning = false;
    for (reference, got) in [(frac_ref, got_frac), (whole_ref, got_whole)] {
        if !reference.contains(got) {
            if reference.contains_warning(got) {
                warning = true;
            } else {
                return Err(false);
            }
        }
    }
    if warning { Err(true) } else { Ok(()) }
}

/// `PrecisionCase::testStatement`'s `ShaderSpec` setup for `Modf` - one input, two
/// outputs (`out0` the function's own return value, `out1` its `out` parameter),
/// scalar-only (see the module note above for why there is no `gen_type` here at
/// all). `out1` is declared as an ordinary output symbol; `shader_exec_util`'s own
/// codegen already declares every output as a local variable *before* `spec.source`
/// runs (see its `generate_*_shader` functions), so `out1` already exists as an
/// assignable local by the time `modf(in0, out1)` executes, exactly matching GLSL's
/// own out-parameter passing.
fn build_modf_spec(context: &Context, precision: Precision) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    spec.inputs
        .push(Symbol::new("in0", VarType::basic(DataType::Float, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(DataType::Float, Some(precision))));
    spec.outputs
        .push(Symbol::new("out1", VarType::basic(DataType::Float, Some(precision))));
    spec.source = "out0 = modf(in0, out1);".to_string();
    spec
}

/// Originally would have been `ModfCase` nested under `UnaryOpCase`'s `GenType` loop,
/// but `Modf` is scalar-only and two-output - see the module note above - so this is
/// its own case, named directly `"{precision}_{stage}"` (no `GenType` path segment)
/// and added straight to the `modf` group rather than through an intermediate
/// per-precision/stage `TestCaseGroup` the way every `*OpCase` above needs (since
/// there is no `GenType` axis left to nest under it).
struct ModfCase {
    name: String,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for ModfCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_modf_spec(context, self.precision);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x6d6f_6466 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4);
        let in0 = generate_inputs1(fmt, 1, seed);
        let num_values = in0.len();

        let mut frac_bytes = vec![0u8; in0.len() * 4];
        let mut whole_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
            let mut outputs: [&mut [u8]; 2] = [&mut frac_bytes, &mut whole_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let frac = floats_from_bytes(&frac_bytes);
        let whole = floats_from_bytes(&whole_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            match check_one_modf(fmt, highp_fmt, in0[value_ndx], frac[value_ndx], whole[value_ndx]) {
                Ok(()) => {}
                Err(is_warning) => {
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!(
                            "sample {value_ndx}: in0 = {}, got frac {}, whole {}",
                            in0[value_ndx], frac[value_ndx], whole[value_ndx]
                        ));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `createFuncGroup`, restricted to `Modf`'s own `SimpleFuncCaseFactory` shape - one
/// case per precision/stage, added directly (no `GenType` nesting, see the module note
/// above and `ModfCase` itself).
pub fn modf_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("modf");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let name = format!("{}_{}", precision.name(), stage.as_str());
            group.add_child(Box::new(ModfCase { name, precision, stage }) as Box<dyn TestCase>);
        }
    }
    group
}

// ---------------------------------------------------------------------------------
// Vector-typed functions (`GenVec`-shaped, `glsBuiltinPrecisionTests.cpp` ~3159-3301):
// `Dot`/`Length`/`Distance`/`Cross`/`Normalize`, each genuinely *combining* multiple
// vector lanes together rather than applying one scalar formula independently per
// lane - the one thing every scalar `UnaryOpCase`/`BinaryOpCase`/`TernaryOpCase`
// above never needed. `FaceForward`/`Reflect`/`Refract` (each branches on the *sign*
// of an interval-valued `dot`, needing both alternatives whenever that interval
// straddles zero - not yet ported) and the matrix-typed family
// (`matrixCompMult`/`outerProduct`/`transpose`/`determinant`/`inverse`) are deferred
// to a future batch - see the coverage campaign's own progress log for sizing.

/// Every permutation of `0..n`, via a plain recursive swap - `n` is always a
/// `GenType`'s own lane count (`<= 4`, so at most 24 permutations), so this needs no
/// crate dependency. `Dot::doExpand`'s own `std::next_permutation` loop
/// (`glsBuiltinPrecisionTests.cpp` ~3200-3206) visits every permutation of the
/// summation order exactly once, in addition to the identity order already computed
/// separately just above the loop - a duplicate of one permutation already unioned
/// in, harmless since `Interval::bitor` (`alternatives`) is idempotent on a repeated
/// operand.
fn permutations(n: usize) -> Vec<Vec<usize>> {
    fn go(current: &mut Vec<usize>, remaining: &mut Vec<usize>, out: &mut Vec<Vec<usize>>) {
        if remaining.is_empty() {
            out.push(current.clone());
            return;
        }
        for i in 0..remaining.len() {
            let x = remaining.remove(i);
            current.push(x);
            go(current, remaining, out);
            current.pop();
            remaining.insert(i, x);
        }
    }
    let mut out = Vec::new();
    go(&mut Vec::new(), &mut (0..n).collect(), &mut out);
    out
}

/// A sample's per-lane raw values, rounded and converted into this format's own
/// interval exactly the way every scalar `check_one*` already does per value
/// (`fmt.convert(fmt.round_out_point(x as f64, false))`) - one entry per lane,
/// matching `PrecisionCase::testStatement`'s `convert(fmt, round(fmt, ...))` applied
/// componentwise to a `Vector<float, Size>` input.
fn read_lanes(fmt: FloatFormat, values: &[f32]) -> Vec<Interval> {
    values
        .iter()
        .map(|&v| fmt.convert(fmt.round_out_point(v as f64, false)))
        .collect()
}

/// `Dot<Size>::doExpand` - `alternatives` over every permutation of summation order
/// of the lanewise products, bounding floating-point summation-order sensitivity
/// (see the module note above). `Dot<1>`'s own specialisation (`args.a * args.b`) is
/// this same formula at `Size == 1`: `permutations(1)` is `[[0]]`, so the loop below
/// reduces to the single product with no addition step at all, matching the
/// specialisation exactly without needing its own arm.
fn dot_reference(fmt: FloatFormat, precision: Precision, a: &[Interval], b: &[Interval]) -> Interval {
    let products: Vec<Interval> = a
        .iter()
        .zip(b)
        .map(|(&x, &y)| binary_reference(BinaryOp::Mul, fmt, precision, x, y))
        .collect();
    let mut result = Interval::empty();
    for perm in permutations(products.len()) {
        let mut acc = products[perm[0]];
        for &idx in &perm[1..] {
            acc = binary_reference(BinaryOp::Add, fmt, precision, acc, products[idx]);
        }
        result = result | acc;
    }
    result
}

/// `Length<Size>::doExpand` - `sqrt(dot(x, x))`, reusing `Sqrt`'s own
/// already-resolved `DerivedFunc` composition (`derived_unary_reference`) rather
/// than a second copy of it.
fn length_reference(fmt: FloatFormat, precision: Precision, a: &[Interval]) -> Interval {
    derived_unary_reference(UnaryOp::Sqrt, fmt, precision, dot_reference(fmt, precision, a, a))
}

/// `Distance<Size>::doExpand` - `length(x - y)`, lanewise subtraction first.
fn distance_reference(fmt: FloatFormat, precision: Precision, a: &[Interval], b: &[Interval]) -> Interval {
    let diff: Vec<Interval> = a
        .iter()
        .zip(b)
        .map(|(&x, &y)| binary_reference(BinaryOp::Sub, fmt, precision, x, y))
        .collect();
    length_reference(fmt, precision, &diff)
}

/// `Normalize<Size>::doExpand` - `x / length(x)`: one shared `length` interval
/// divided into every lane independently. Unlike every other vector function here,
/// this is the only one that reuses a single combined interval across every output
/// lane rather than combining per-lane operands pairwise into a single scalar.
fn normalize_reference(fmt: FloatFormat, precision: Precision, a: &[Interval]) -> Vec<Interval> {
    let len = length_reference(fmt, precision, a);
    a.iter()
        .map(|&x| binary_reference(BinaryOp::Div, fmt, precision, x, len))
        .collect()
}

/// `Cross::doExpand` - `vec3(a[1]*b[2] - b[1]*a[2], a[2]*b[0] - b[2]*a[0], a[0]*b[1] -
/// b[0]*a[1])`, read directly off the C++ (`glsBuiltinPrecisionTests.cpp` ~3296-3297)
/// component ordering rather than inferred from the textbook formula, which happens
/// to agree here but need not in general.
fn cross_reference(fmt: FloatFormat, precision: Precision, a: &[Interval], b: &[Interval]) -> [Interval; 3] {
    let term = |i: usize, j: usize, k: usize, l: usize| {
        let p0 = binary_reference(BinaryOp::Mul, fmt, precision, a[i], b[j]);
        let p1 = binary_reference(BinaryOp::Mul, fmt, precision, b[k], a[l]);
        binary_reference(BinaryOp::Sub, fmt, precision, p0, p1)
    };
    [term(1, 2, 1, 2), term(2, 0, 2, 0), term(0, 1, 0, 1)]
}

/// `Dot<Size>`/`Distance<Size>` - the two `GenVec` functions taking two vector
/// inputs and producing one scalar output, sharing `VecScalarOp2Case`'s shape and
/// `generate_inputs`'s existing two-vector sampling (identical to what
/// `BinaryOpCase` already needs - the only difference is the *reference*
/// computation combining lanes instead of computing one independently per lane).
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum VecScalarOp2 {
    Dot,
    Distance,
}

impl VecScalarOp2 {
    fn name(self) -> &'static str {
        match self {
            Self::Dot => "dot",
            Self::Distance => "distance",
        }
    }
}

fn build_vec_scalar2_spec(op: VecScalarOp2, context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(DataType::Float, Some(precision))));
    spec.source = format!("out0 = {}(in0, in1);", op.name());
    spec
}

struct VecScalarOp2Case {
    op: VecScalarOp2,
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for VecScalarOp2Case {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_vec_scalar2_spec(self.op, context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x7665_6332
            ^ ((self.op as i32 as u32) << 16)
            ^ ((self.precision as i32 as u32) << 8)
            ^ ((self.stage as i32 as u32) << 4)
            ^ lanes as u32;
        let (in0, in1) = generate_inputs(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; num_values * 4];
        {
            let inputs: [&[u8]; 2] = [f32_bytes(&in0), f32_bytes(&in1)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let a = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let b = read_lanes(fmt, &in1[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let reference = highp_fmt.convert(match self.op {
                VecScalarOp2::Dot => dot_reference(fmt, self.precision, &a, &b),
                VecScalarOp2::Distance => distance_reference(fmt, self.precision, &a, &b),
            });
            let got = out0[value_ndx] as f64;

            if !reference.contains(got) {
                let is_warning = reference.contains_warning(got);
                if is_warning {
                    num_warnings += 1;
                } else {
                    num_errors += 1;
                }
                if first_message.is_none() {
                    first_message = Some(format!("sample {value_ndx}: got {}", out0[value_ndx]));
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `createFuncGroup`, restricted to `Dot`/`Distance`'s own `TemplateFuncCaseFactory`
/// shape - same `scalar`/`vec2`/`vec3`/`vec4` nesting as `binary_op_group`.
pub fn vec_scalar2_group(op: VecScalarOp2, stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(op.name());
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(VecScalarOp2Case {
                    op,
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

/// `Length<Size>` - one vector input, one scalar output; reuses `generate_inputs1`'s
/// existing single-vector sampling (identical to what `UnaryOpCase` already needs).
fn build_length_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    spec.inputs.push(Symbol::new(
        "in0",
        VarType::basic(gen_type.data_type(), Some(precision)),
    ));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(DataType::Float, Some(precision))));
    spec.source = "out0 = length(in0);".to_string();
    spec
}

struct LengthCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for LengthCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_length_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x6c65_6e67 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let in0 = generate_inputs1(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; num_values * 4];
        {
            let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let a = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let reference = highp_fmt.convert(length_reference(fmt, self.precision, &a));
            let got = out0[value_ndx] as f64;

            if !reference.contains(got) {
                let is_warning = reference.contains_warning(got);
                if is_warning {
                    num_warnings += 1;
                } else {
                    num_errors += 1;
                }
                if first_message.is_none() {
                    first_message = Some(format!("sample {value_ndx}: got {}", out0[value_ndx]));
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn length_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("length");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(LengthCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

/// `Normalize<Size>` - one vector input, one *vector* output (unlike every other
/// vector function ported this batch, which all reduce to a scalar) - checked
/// lanewise like `UnaryOpCase`, just against `normalize_reference`'s combined
/// (not per-lane-independent) reference vector.
fn build_normalize_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = "out0 = normalize(in0);".to_string();
    spec
}

struct NormalizeCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for NormalizeCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_normalize_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x6e6f_726d ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let in0 = generate_inputs1(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let a = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let reference = normalize_reference(fmt, self.precision, &a);
            for (lane, &reference_lane) in reference.iter().enumerate() {
                let idx = value_ndx * lanes + lane;
                let reference_lane = highp_fmt.convert(reference_lane);
                let got = out0[idx] as f64;

                if !reference_lane.contains(got) {
                    let is_warning = reference_lane.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn normalize_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("normalize");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(NormalizeCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

/// `Cross` - `SimpleFuncCaseFactory`-shaped like `Modf` (one case per
/// precision/stage, no `GenType` nesting at all - `Cross` only ever operates on
/// `Vec3`), but with vector, not scalar, inputs/outputs - reuses `generate_inputs`'s
/// two-vector sampling at a fixed `lanes == 3`.
fn build_cross_spec(context: &Context, precision: Precision) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    spec.inputs
        .push(Symbol::new("in0", VarType::basic(DataType::FloatVec3, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(DataType::FloatVec3, Some(precision))));
    spec.outputs.push(Symbol::new(
        "out0",
        VarType::basic(DataType::FloatVec3, Some(precision)),
    ));
    spec.source = "out0 = cross(in0, in1);".to_string();
    spec
}

struct CrossCase {
    name: String,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for CrossCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        const LANES: usize = 3;
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_cross_spec(context, self.precision);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x6372_6f73 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4);
        let (in0, in1) = generate_inputs(fmt, LANES, seed);
        let num_values = in0.len() / LANES;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 2] = [f32_bytes(&in0), f32_bytes(&in1)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let a = read_lanes(fmt, &in0[value_ndx * LANES..(value_ndx + 1) * LANES]);
            let b = read_lanes(fmt, &in1[value_ndx * LANES..(value_ndx + 1) * LANES]);
            let reference = cross_reference(fmt, self.precision, &a, &b);
            for (lane, &reference_lane) in reference.iter().enumerate() {
                let idx = value_ndx * LANES + lane;
                let reference_lane = highp_fmt.convert(reference_lane);
                let got = out0[idx] as f64;

                if !reference_lane.contains(got) {
                    let is_warning = reference_lane.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn cross_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("cross");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let name = format!("{}_{}", precision.name(), stage.as_str());
            group.add_child(Box::new(CrossCase { name, precision, stage }) as Box<dyn TestCase>);
        }
    }
    group
}

// ---------------------------------------------------------------------------------
// `FaceForward`/`Reflect`/`Refract` - the three vector-typed functions that branch on
// the *sign* of an interval-valued `dot`, needing both alternatives whenever that
// interval straddles zero. `Cond<T>::doApply` (`glsBuiltinPrecisionTests.cpp`
// ~1696-1725) unions the consequent/alternative branch depending on which is
// reachable, reachability itself decided by `LessThan<T>::canSucceed`/`canFail`
// (~1776-1784) purely from the tested interval's own numeric bounds - the NaN flag is
// never consulted when picking a branch, matching upstream exactly rather than trying
// to improve on it.

/// `LessThan<float>::canSucceed`/`canFail` specialised to `x < 0.0`, the only
/// comparison any of the three functions below need: `(possible_true, possible_false)`,
/// either or both of which can hold when `d`'s interval straddles zero.
fn less_than_zero_possible(d: Interval) -> (bool, bool) {
    // `Interval`'s own `lo`/`hi` are never NaN by construction (`Interval::exact`
    // converts a NaN value into an empty +inf/-inf pair plus a separate `has_nan`
    // flag - see its own doc comment), so `d.hi() >= 0.0` is exactly
    // `!(d.hi() < 0.0)` here, not merely "usually equivalent".
    (d.lo() < 0.0, d.hi() >= 0.0)
}

/// `FaceForward<Size>::doExpand` - `cond(dot(Nref, I) < 0, N, -N)`, per lane: `N` is
/// `args.a` (returned as-is when the consequent branch is reachable), `-N` per lane
/// via the already-ported `negate_reference` when the alternative is. `dot(Nref, I)`
/// matches upstream's own `dot(args.c, args.b)` argument order exactly (`args.b` is
/// `I`, `args.c` is `Nref`).
fn faceforward_reference(
    fmt: FloatFormat,
    precision: Precision,
    n: &[Interval],
    i: &[Interval],
    nref: &[Interval],
) -> Vec<Interval> {
    let d = dot_reference(fmt, precision, nref, i);
    let (possible_true, possible_false) = less_than_zero_possible(d);
    n.iter()
        .map(|&x| {
            let mut r = Interval::empty();
            if possible_true {
                r = r | x;
            }
            if possible_false {
                r = r | negate_reference(fmt, x);
            }
            r
        })
        .collect()
}

/// `ApplyReflect<Size, ...>::apply` (general, `Size > 1`, `glsBuiltinPrecisionTests.cpp`
/// ~3347-3355) - `I - alternatives((N * dotNI) * 2, N * (dotNI * 2))`, `dotNI = dot(N,
/// I)` (upstream's own `dot(n, i)`) shared across every lane, matching upstream's
/// `bindExpression` (computed once, reused, not per-lane-independent). `Size == 1`
/// (`ApplyReflect<1, ...>`, ~3358-3365) needs its own, wider formula - a third
/// alternative (`(N * N) * (I * 2)`) only valid at scalar width, where `dotNI`
/// literally *is* `N * I` and the extra rearrangement becomes available - so this is
/// dispatched on `i.len() == 1` rather than folded into the general case as a
/// no-op-at-Size-1 special case of it.
fn reflect_reference(fmt: FloatFormat, precision: Precision, i: &[Interval], n: &[Interval]) -> Vec<Interval> {
    let two = Interval::exact(2.0);
    if i.len() == 1 {
        let dot_ni = binary_reference(BinaryOp::Mul, fmt, precision, n[0], i[0]);
        let alt1a = binary_reference(
            BinaryOp::Mul,
            fmt,
            precision,
            binary_reference(BinaryOp::Mul, fmt, precision, n[0], dot_ni),
            two,
        );
        let alt1b = binary_reference(
            BinaryOp::Mul,
            fmt,
            precision,
            n[0],
            binary_reference(BinaryOp::Mul, fmt, precision, dot_ni, two),
        );
        let alt2 = binary_reference(
            BinaryOp::Mul,
            fmt,
            precision,
            binary_reference(BinaryOp::Mul, fmt, precision, n[0], n[0]),
            binary_reference(BinaryOp::Mul, fmt, precision, i[0], two),
        );
        let combined = alt1a | alt1b | alt2;
        return vec![binary_reference(BinaryOp::Sub, fmt, precision, i[0], combined)];
    }

    let dot_ni = dot_reference(fmt, precision, n, i);
    i.iter()
        .zip(n)
        .map(|(&iv, &nv)| {
            let term_a = binary_reference(
                BinaryOp::Mul,
                fmt,
                precision,
                binary_reference(BinaryOp::Mul, fmt, precision, nv, dot_ni),
                two,
            );
            let term_b = binary_reference(
                BinaryOp::Mul,
                fmt,
                precision,
                nv,
                binary_reference(BinaryOp::Mul, fmt, precision, dot_ni, two),
            );
            binary_reference(BinaryOp::Sub, fmt, precision, iv, term_a | term_b)
        })
        .collect()
}

/// `Refract<Size>::doExpand` (~3412-3426): `k1 = 1 - eta*eta*(1 - dotNI*dotNI)`,
/// `k2 = ((dotNI*(-dotNI)) + 1)*eta*(-eta) + 1` (an alternate rounding of the same
/// value, unioned via `alternatives`, matching `k1`/`k2` exactly as read off the C++
/// rather than simplified algebraically), `k = k1 | k2`; `cond(k < 0, vec(0), I*eta -
/// N*(eta*dotNI + sqrt(k)))` - `sqrt(k)` is only ever computed (and only ever needed)
/// when the alternative branch is reachable at all.
fn refract_reference(
    fmt: FloatFormat,
    precision: Precision,
    i: &[Interval],
    n: &[Interval],
    eta: Interval,
) -> Vec<Interval> {
    let dot_ni = dot_reference(fmt, precision, n, i);
    let one = Interval::exact(1.0);

    let eta_sq = binary_reference(BinaryOp::Mul, fmt, precision, eta, eta);
    let dotni_sq = binary_reference(BinaryOp::Mul, fmt, precision, dot_ni, dot_ni);
    let one_minus_dotni_sq = binary_reference(BinaryOp::Sub, fmt, precision, one, dotni_sq);
    let k1 = binary_reference(
        BinaryOp::Sub,
        fmt,
        precision,
        one,
        binary_reference(BinaryOp::Mul, fmt, precision, eta_sq, one_minus_dotni_sq),
    );

    let neg_dot_ni = negate_reference(fmt, dot_ni);
    let neg_eta = negate_reference(fmt, eta);
    let inner = binary_reference(
        BinaryOp::Add,
        fmt,
        precision,
        binary_reference(BinaryOp::Mul, fmt, precision, dot_ni, neg_dot_ni),
        one,
    );
    let k2 = binary_reference(
        BinaryOp::Add,
        fmt,
        precision,
        binary_reference(BinaryOp::Mul, fmt, precision, inner, eta),
        neg_eta,
    );
    // `k2`'s trailing `* -eta + 1` (upstream: `(...) * eta * (-eta) + 1`).
    let k2 = binary_reference(BinaryOp::Mul, fmt, precision, k2, neg_eta);
    let k2 = binary_reference(BinaryOp::Add, fmt, precision, k2, one);

    let k = k1 | k2;
    let (possible_true, possible_false) = less_than_zero_possible(k);

    let scale = if possible_false {
        let sqrt_k = derived_unary_reference(UnaryOp::Sqrt, fmt, precision, k);
        Some(binary_reference(
            BinaryOp::Add,
            fmt,
            precision,
            binary_reference(BinaryOp::Mul, fmt, precision, eta, dot_ni),
            sqrt_k,
        ))
    } else {
        None
    };

    i.iter()
        .zip(n)
        .map(|(&iv, &nv)| {
            let mut r = Interval::empty();
            if possible_true {
                r = r | Interval::exact(0.0);
            }
            if let Some(scale) = scale {
                let i_eta = binary_reference(BinaryOp::Mul, fmt, precision, iv, eta);
                let n_scale = binary_reference(BinaryOp::Mul, fmt, precision, nv, scale);
                r = r | binary_reference(BinaryOp::Sub, fmt, precision, i_eta, n_scale);
            }
            r
        })
        .collect()
}

/// `FaceForward<Size>` - three vector inputs of the same `GenType`, one vector
/// output, reusing `generate_inputs3`'s existing three-way sampling unchanged (it
/// already treats every argument as a broadcast-vector-shaped `Vector<T, Size>`, the
/// same model `TernaryOpCase`'s three scalar/broadcast arguments already use).
fn build_face_forward_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in2", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = "out0 = faceforward(in0, in1, in2);".to_string();
    spec
}

struct FaceForwardCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for FaceForwardCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_face_forward_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x6666_7764 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let (in0, in1, in2) = generate_inputs3(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 3] = [f32_bytes(&in0), f32_bytes(&in1), f32_bytes(&in2)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let n = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let i = read_lanes(fmt, &in1[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let nref = read_lanes(fmt, &in2[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let reference = faceforward_reference(fmt, self.precision, &n, &i, &nref);
            for (lane, &reference_lane) in reference.iter().enumerate() {
                let idx = value_ndx * lanes + lane;
                let reference_lane = highp_fmt.convert(reference_lane);
                let got = out0[idx] as f64;

                if !reference_lane.contains(got) {
                    let is_warning = reference_lane.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn face_forward_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("faceforward");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(FaceForwardCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

/// `Reflect<Size>` - two vector inputs (`I`, `N`), one vector output, reusing
/// `generate_inputs`'s existing two-vector sampling unchanged (same shape
/// `BinaryOpCase`/`VecScalarOp2Case` already need).
fn build_reflect_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = "out0 = reflect(in0, in1);".to_string();
    spec
}

struct ReflectCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for ReflectCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_reflect_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x7265_666c ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let (in0, in1) = generate_inputs(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 2] = [f32_bytes(&in0), f32_bytes(&in1)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let i = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let n = read_lanes(fmt, &in1[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let reference = reflect_reference(fmt, self.precision, &i, &n);
            for (lane, &reference_lane) in reference.iter().enumerate() {
                let idx = value_ndx * lanes + lane;
                let reference_lane = highp_fmt.convert(reference_lane);
                let got = out0[idx] as f64;

                if !reference_lane.contains(got) {
                    let is_warning = reference_lane.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn reflect_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("reflect");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(ReflectCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

/// `Refract<Size>`'s own three-argument sampling shape: two vector arguments (`I`,
/// `N`) at `lanes` width plus one genuinely scalar argument (`eta`, always width 1
/// regardless of `GenType`) - the one place this port's vector family needs a mixed-
/// width fixed-sample cross product, so `generate_inputs3` (which broadcasts all
/// three to the same `lanes`) does not fit and this gets its own generator.
fn generate_inputs_refract(fmt: FloatFormat, lanes: usize, seed: u32) -> (Vec<f32>, Vec<f32>, Vec<f32>) {
    let fixed = gen_fixed_samples(fmt);
    let fixed_count = fixed.len() * fixed.len() * fixed.len();
    let mut i_vals = Vec::with_capacity((fixed_count + NUM_RANDOM_SAMPLES) * lanes);
    let mut n_vals = Vec::with_capacity(i_vals.capacity());
    let mut eta_vals = Vec::with_capacity(fixed_count + NUM_RANDOM_SAMPLES);

    for &f0 in &fixed {
        for &f1 in &fixed {
            for &f2 in &fixed {
                i_vals.extend(std::iter::repeat_n(f0, lanes));
                n_vals.extend(std::iter::repeat_n(f1, lanes));
                eta_vals.push(f2);
            }
        }
    }

    let mut rnd = Random::new(seed);
    for _ in 0..NUM_RANDOM_SAMPLES {
        for _ in 0..lanes {
            i_vals.push(gen_random_sample(fmt, &mut rnd));
        }
        for _ in 0..lanes {
            n_vals.push(gen_random_sample(fmt, &mut rnd));
        }
        eta_vals.push(gen_random_sample(fmt, &mut rnd));
    }

    (i_vals, n_vals, eta_vals)
}

fn build_refract_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let ty = gen_type.data_type();
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in2", VarType::basic(DataType::Float, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = "out0 = refract(in0, in1, in2);".to_string();
    spec
}

struct RefractCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for RefractCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_refract_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x7265_6672 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let (in0, in1, in2) = generate_inputs_refract(fmt, lanes, seed);
        let num_values = in2.len();

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 3] = [f32_bytes(&in0), f32_bytes(&in1), f32_bytes(&in2)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let i = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let n = read_lanes(fmt, &in1[value_ndx * lanes..(value_ndx + 1) * lanes]);
            let eta = fmt.convert(fmt.round_out_point(in2[value_ndx] as f64, false));
            let reference = refract_reference(fmt, self.precision, &i, &n, eta);
            for (lane, &reference_lane) in reference.iter().enumerate() {
                let idx = value_ndx * lanes + lane;
                let reference_lane = highp_fmt.convert(reference_lane);
                let got = out0[idx] as f64;

                if !reference_lane.contains(got) {
                    let is_warning = reference_lane.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn refract_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("refract");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(RefractCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

// ---------------------------------------------------------------------------------
// The matrix-typed family - `matrixCompMult`/`outerProduct`/`transpose`/`determinant`/
// `inverse`, the last piece of `glsBuiltinPrecisionTests.cpp`. Needed
// `gls::shader_exec_util` to grow real matrix-typed fragment-output and buffer-I/O
// support first (see that module's own header) - every ported function before this one
// only ever needed scalar/vector I/O. Every matrix value here is a flat, column-major
// `Vec<Interval>` (`a[col*rows+row]`), matching both `ShaderExecUtil`'s own convention
// and GLSL's own storage order - never upstream's `Matrix<T,Rows,Cols>::operator()`,
// whose row/col argument order this port never materializes; every formula below is
// re-derived from first principles off the flat layout instead (see each function's own
// comment for the exact C++ read). `Determinant`/`Inverse` are `mat2`-only, matching
// upstream itself: `SquareMatrixFuncCaseFactory` `#if 0`-disables `mat3`/`mat4` ("until
// we get reasonable results"), not a gap this port introduces.
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum MatrixOp {
    CompMult,
    OuterProduct,
    Transpose,
    Determinant,
    Inverse,
}

impl MatrixOp {
    fn glsl_name(self) -> &'static str {
        match self {
            Self::CompMult => "matrixCompMult",
            Self::OuterProduct => "outerProduct",
            Self::Transpose => "transpose",
            Self::Determinant => "determinant",
            Self::Inverse => "inverse",
        }
    }
}

/// `MatrixCompMult<Rows,Cols>` (`CompMatFunc<ScalarMatrixCompMult,...>`) - per-element
/// `Mul`; element order does not matter for a lanewise op, only that both operands and
/// the result agree on it, which they do here by construction (same flat layout as
/// everywhere else in this module).
fn matrix_comp_mult_reference(fmt: FloatFormat, precision: Precision, a: &[Interval], b: &[Interval]) -> Vec<Interval> {
    a.iter()
        .zip(b)
        .map(|(&x, &y)| binary_reference(BinaryOp::Mul, fmt, precision, x, y))
        .collect()
}

/// `OuterProduct<Rows,Cols>::doApply` - `ret[col][row] = a[row] * b[col]`, i.e. flat
/// `ret[col*rows+row] = a[row]*b[col]` under this port's own column-major convention.
fn outer_product_reference(
    fmt: FloatFormat,
    precision: Precision,
    a: &[Interval],
    b: &[Interval],
    rows: usize,
) -> Vec<Interval> {
    let cols = b.len();
    let mut out = vec![Interval::empty(); rows * cols];
    for col in 0..cols {
        for row in 0..rows {
            out[col * rows + row] = binary_reference(BinaryOp::Mul, fmt, precision, a[row], b[col]);
        }
    }
    out
}

/// `Transpose<Rows,Columns>` - a pure rearrangement (`PrimitiveFunc`, no `doApply`
/// epsilon at all - no `binary_reference`/interval arithmetic here, each output
/// interval is copied through unchanged). Derived directly from the flat column-major
/// layout rather than upstream's own `operator()(row,col)` convention (never
/// materialized in this port): input is `in_rows x in_cols` (flat `a[c*in_rows+r]`),
/// output is `in_cols x in_rows` (flat `out[c'*in_cols+r']`), and
/// `out[row_out][col_out] = in[col_out][row_out]` gives the indexing below.
fn transpose_reference(a: &[Interval], in_rows: usize, in_cols: usize) -> Vec<Interval> {
    let mut out = vec![Interval::empty(); in_rows * in_cols];
    for row_out in 0..in_cols {
        for col_out in 0..in_rows {
            out[col_out * in_cols + row_out] = a[row_out * in_rows + col_out];
        }
    }
    out
}

/// `Determinant<2>::doExpand` - `mat[0][0]*mat[1][1] - mat[1][0]*mat[0][1]`, i.e.
/// `a[0]*a[3] - a[2]*a[1]` in this port's flat column-major order (`a[col*2+row]`:
/// `a[0]` is `mat[0][0]`, `a[1]` is `mat[0][1]`, `a[2]` is `mat[1][0]`, `a[3]` is
/// `mat[1][1]`).
fn determinant2_reference(fmt: FloatFormat, precision: Precision, a: &[Interval]) -> Interval {
    let p0 = binary_reference(BinaryOp::Mul, fmt, precision, a[0], a[3]);
    let p1 = binary_reference(BinaryOp::Mul, fmt, precision, a[2], a[1]);
    binary_reference(BinaryOp::Sub, fmt, precision, p0, p1)
}

/// `Inverse<2>::doExpand` - `mat2(vec2(mat[1][1]/det, -mat[0][1]/det),
/// vec2(-mat[1][0]/det, mat[0][0]/det))`, i.e. flat
/// `[a[3]/det, -a[1]/det, -a[2]/det, a[0]/det]` (same index convention as
/// `determinant2_reference`, which this reuses rather than recomputing).
fn inverse2_reference(fmt: FloatFormat, precision: Precision, a: &[Interval]) -> Vec<Interval> {
    let det = determinant2_reference(fmt, precision, a);
    let div = |x: Interval| binary_reference(BinaryOp::Div, fmt, precision, x, det);
    vec![
        div(a[3]),
        div(negate_reference(fmt, a[1])),
        div(negate_reference(fmt, a[2])),
        div(a[0]),
    ]
}

fn build_matrix_spec(op: MatrixOp, context: &Context, precision: Precision, cols: usize, rows: usize) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {} float;\n", precision.name());

    let mat_ty = glu::get_data_type_matrix(cols as i32, rows as i32);
    match op {
        MatrixOp::CompMult => {
            spec.inputs
                .push(Symbol::new("in0", VarType::basic(mat_ty, Some(precision))));
            spec.inputs
                .push(Symbol::new("in1", VarType::basic(mat_ty, Some(precision))));
            spec.outputs
                .push(Symbol::new("out0", VarType::basic(mat_ty, Some(precision))));
            spec.source = format!("out0 = {}(in0, in1);", op.glsl_name());
        }
        MatrixOp::OuterProduct => {
            let vec_a = glu::get_data_type_float_vec(rows as i32);
            let vec_b = glu::get_data_type_float_vec(cols as i32);
            spec.inputs
                .push(Symbol::new("in0", VarType::basic(vec_a, Some(precision))));
            spec.inputs
                .push(Symbol::new("in1", VarType::basic(vec_b, Some(precision))));
            spec.outputs
                .push(Symbol::new("out0", VarType::basic(mat_ty, Some(precision))));
            spec.source = format!("out0 = {}(in0, in1);", op.glsl_name());
        }
        MatrixOp::Transpose => {
            let out_ty = glu::get_data_type_matrix(rows as i32, cols as i32);
            spec.inputs
                .push(Symbol::new("in0", VarType::basic(mat_ty, Some(precision))));
            spec.outputs
                .push(Symbol::new("out0", VarType::basic(out_ty, Some(precision))));
            spec.source = format!("out0 = {}(in0);", op.glsl_name());
        }
        MatrixOp::Determinant => {
            spec.inputs
                .push(Symbol::new("in0", VarType::basic(mat_ty, Some(precision))));
            spec.outputs
                .push(Symbol::new("out0", VarType::basic(DataType::Float, Some(precision))));
            spec.source = format!("out0 = {}(in0);", op.glsl_name());
        }
        MatrixOp::Inverse => {
            spec.inputs
                .push(Symbol::new("in0", VarType::basic(mat_ty, Some(precision))));
            spec.outputs
                .push(Symbol::new("out0", VarType::basic(mat_ty, Some(precision))));
            spec.source = format!("out0 = {}(in0);", op.glsl_name());
        }
    }
    spec
}

struct MatrixOpCase {
    name: String,
    op: MatrixOp,
    cols: usize,
    rows: usize,
    precision: Precision,
    stage: ShaderType,
}

impl TestCase for MatrixOpCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);
        let precision = self.precision;
        let (cols, rows) = (self.cols, self.rows);
        let lanes = cols * rows;

        let spec = build_matrix_spec(self.op, context, self.precision, cols, rows);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed = 0x6d61_7472
            ^ ((precision as i32 as u32) << 8)
            ^ ((self.stage as i32 as u32) << 4)
            ^ ((cols as u32) << 2)
            ^ rows as u32;

        // Per-op sample generation, executor dispatch and reference computation - the
        // shapes genuinely differ (one or two inputs, vector or matrix operands,
        // `out_lanes` != `lanes` for `Determinant`) - everything after the match
        // (comparing each output lane against its own reference interval, tallying
        // pass/warning/fail) is shared across all five.
        let (out_lanes, out0, references): (usize, Vec<f32>, Vec<Vec<Interval>>) = match self.op {
            MatrixOp::CompMult => {
                let (in0, in1) = generate_inputs(fmt, lanes, seed);
                let n = in0.len() / lanes;
                let mut out_bytes = vec![0u8; in0.len() * 4];
                {
                    let inputs: [&[u8]; 2] = [f32_bytes(&in0), f32_bytes(&in1)];
                    let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
                    executor.execute(n as i32, &inputs, &mut outputs)?;
                }
                let out0 = floats_from_bytes(&out_bytes);
                let refs = (0..n)
                    .map(|v| {
                        let a = read_lanes(fmt, &in0[v * lanes..(v + 1) * lanes]);
                        let b = read_lanes(fmt, &in1[v * lanes..(v + 1) * lanes]);
                        matrix_comp_mult_reference(fmt, precision, &a, &b)
                    })
                    .collect();
                (lanes, out0, refs)
            }
            MatrixOp::OuterProduct => {
                let (in0, in1) = generate_inputs_asym(fmt, rows, cols, seed);
                let n = in0.len() / rows;
                let mut out_bytes = vec![0u8; n * lanes * 4];
                {
                    let inputs: [&[u8]; 2] = [f32_bytes(&in0), f32_bytes(&in1)];
                    let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
                    executor.execute(n as i32, &inputs, &mut outputs)?;
                }
                let out0 = floats_from_bytes(&out_bytes);
                let refs = (0..n)
                    .map(|v| {
                        let a = read_lanes(fmt, &in0[v * rows..(v + 1) * rows]);
                        let b = read_lanes(fmt, &in1[v * cols..(v + 1) * cols]);
                        outer_product_reference(fmt, precision, &a, &b, rows)
                    })
                    .collect();
                (lanes, out0, refs)
            }
            MatrixOp::Transpose => {
                let in0 = generate_inputs1(fmt, lanes, seed);
                let n = in0.len() / lanes;
                let mut out_bytes = vec![0u8; in0.len() * 4];
                {
                    let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
                    let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
                    executor.execute(n as i32, &inputs, &mut outputs)?;
                }
                let out0 = floats_from_bytes(&out_bytes);
                let refs = (0..n)
                    .map(|v| transpose_reference(&read_lanes(fmt, &in0[v * lanes..(v + 1) * lanes]), rows, cols))
                    .collect();
                (lanes, out0, refs)
            }
            MatrixOp::Determinant => {
                let in0 = generate_inputs1(fmt, lanes, seed);
                let n = in0.len() / lanes;
                let mut out_bytes = vec![0u8; n * 4];
                {
                    let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
                    let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
                    executor.execute(n as i32, &inputs, &mut outputs)?;
                }
                let out0 = floats_from_bytes(&out_bytes);
                let refs = (0..n)
                    .map(|v| {
                        vec![determinant2_reference(
                            fmt,
                            precision,
                            &read_lanes(fmt, &in0[v * lanes..(v + 1) * lanes]),
                        )]
                    })
                    .collect();
                (1, out0, refs)
            }
            MatrixOp::Inverse => {
                let in0 = generate_inputs1(fmt, lanes, seed);
                let n = in0.len() / lanes;
                let mut out_bytes = vec![0u8; in0.len() * 4];
                {
                    let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
                    let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
                    executor.execute(n as i32, &inputs, &mut outputs)?;
                }
                let out0 = floats_from_bytes(&out_bytes);
                let refs = (0..n)
                    .map(|v| inverse2_reference(fmt, precision, &read_lanes(fmt, &in0[v * lanes..(v + 1) * lanes])))
                    .collect();
                (lanes, out0, refs)
            }
        };

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for (value_ndx, reference) in references.iter().enumerate() {
            for (lane, &reference_lane) in reference.iter().enumerate() {
                let idx = value_ndx * out_lanes + lane;
                let reference_lane = highp_fmt.convert(reference_lane);
                let got = out0[idx] as f64;

                if !reference_lane.contains(got) {
                    let is_warning = reference_lane.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

/// `MatrixFuncCaseFactory`'s nine `Rows x Cols` combinations (`{2,3,4}` each) -
/// `matrixCompMult`/`outerProduct`/`transpose`.
const ALL_MATRIX_SHAPES: [(usize, usize); 9] = [(2, 2), (2, 3), (2, 4), (3, 2), (3, 3), (3, 4), (4, 2), (4, 3), (4, 4)];

/// `SquareMatrixFuncCaseFactory`'s one enabled shape - `mat2` only, see this section's
/// own module note on why `mat3`/`mat4` stay out.
const SQUARE2_SHAPE: [(usize, usize); 1] = [(2, 2)];

fn matrix_op_group(op: MatrixOp, group_name: &str, shapes: &[(usize, usize)], stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new(group_name);
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &(cols, rows) in shapes {
                let name = glu::get_data_type_matrix(cols as i32, rows as i32).name().to_string();
                stage_group.add_child(Box::new(MatrixOpCase {
                    name,
                    op,
                    cols,
                    rows,
                    precision,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

pub fn matrix_comp_mult_group(stages: &[ShaderType]) -> TestCaseGroup {
    matrix_op_group(MatrixOp::CompMult, "matrixcompmult", &ALL_MATRIX_SHAPES, stages)
}

pub fn outer_product_group(stages: &[ShaderType]) -> TestCaseGroup {
    matrix_op_group(MatrixOp::OuterProduct, "outerproduct", &ALL_MATRIX_SHAPES, stages)
}

pub fn transpose_group(stages: &[ShaderType]) -> TestCaseGroup {
    matrix_op_group(MatrixOp::Transpose, "transpose", &ALL_MATRIX_SHAPES, stages)
}

pub fn determinant_group(stages: &[ShaderType]) -> TestCaseGroup {
    matrix_op_group(MatrixOp::Determinant, "determinant", &SQUARE2_SHAPE, stages)
}

pub fn inverse_group(stages: &[ShaderType]) -> TestCaseGroup {
    matrix_op_group(MatrixOp::Inverse, "inverse", &SQUARE2_SHAPE, stages)
}

// ---------------------------------------------------------------------------------
// `FrExp`/`LdExp` - upstream's `createES31BuiltinCases`, alongside `Fma` (already
// ported - see `TernaryOp::Fma`'s own doc comment). The last two functions in
// `glsBuiltinPrecisionTests.cpp`, and the first ones in this file whose I/O is not
// entirely `float`/vector-of-`float`: `frexp(x, out exp)`'s second parameter and
// `ldexp(x, exp)`'s second parameter are genuinely `int`/`ivec`-typed. Both are
// `PrimitiveFunc`s (exact bit manipulation for `FrExp`, no precision-based epsilon at
// all; `LdExp` composes `Exp2`/`Mul`, already-ported primitives) - hand-derived the
// same way as everything else in this file, no AST needed.

/// `DefaultSampling<int>::genRandom`'s own bound - 8/16/32 bits for lowp/mediump/highp,
/// matching upstream's three-way switch exactly (`getNumBits` in
/// `glsBuiltinPrecisionTests.cpp` ~4457-4470).
fn num_int_bits(precision: Precision) -> i32 {
    match precision {
        Precision::LowP => 8,
        Precision::MediumP => 16,
        Precision::HighP => 32,
    }
}

/// `DefaultSampling<int>::genFixeds`/`genRandom` - fixed `{0, -1, 1}` cycled in,
/// plus a random value in `+-[0, 2^exp]` for `exp` drawn from `[0, num_int_bits-2]`.
/// Only `LdExp`'s own exponent parameter needs this (`FrExp`'s exponent is an output,
/// not sampled) - see the module header on why bit-for-bit fidelity to upstream's own
/// `de::Random` stream is not needed here, only a value's magnitude relative to the
/// case's own precision.
fn generate_int_exponent_inputs(precision: Precision, count: usize, seed: u32) -> Vec<i32> {
    let mut rnd = Random::new(seed);
    let max_exp = (num_int_bits(precision) - 2).max(0);
    (0..count)
        .map(|i| match i % 8 {
            0 => 0,
            1 => -1,
            2 => 1,
            _ => {
                let exp = rnd.get_int(0, max_exp);
                let magnitude = rnd.get_int(0, 1i32 << exp);
                if rnd.get_bool() { -magnitude } else { magnitude }
            }
        })
        .collect()
}

/// `deFrExp`, via `tcu::float_format::fract_exp` (`frac` in `[1,2)` there, `[0.5,1)`
/// here) - see that function's own doc comment. Zero is special-cased directly
/// (`deFrExp(0.0)` is `(0.0, 0)`, not what shifting `fract_exp`'s own zero passthrough
/// by one would give).
fn de_frexp(x: f64) -> (f64, i32) {
    if x == 0.0 {
        return (0.0, 0);
    }
    let (frac, exp) = fract_exp(x);
    (frac / 2.0, exp + 1)
}

/// `FrExp::doApply` (`glsBuiltinPrecisionTests.cpp` ~3733-3782) - exact bit
/// manipulation, no `precision`-based epsilon at all (the one thing every other
/// function in this file has). Returns `(mantissa, exponent)`; `getOutParamIndex() ==
/// 1` is what makes the *second* element the GLSL `out` parameter rather than an
/// ordinary second return value the way `Modf`'s own `(frac, whole)` pair is.
fn frexp_reference(x: Interval) -> (Interval, Interval) {
    if x.has_nan() || x.contains(f64::INFINITY) || x.contains(f64::NEG_INFINITY) {
        // "GLSL (in contrast to IEEE) says that result of applying frexp to infinity
        // is undefined."
        return (
            Interval::unbounded(true),
            Interval::new(-(2f64.powi(31)), 2f64.powi(31) - 1.0),
        );
    }
    if x.is_empty() {
        return (Interval::empty(), Interval::empty());
    }

    let (lo_frac, lo_exp) = de_frexp(x.lo());
    let (hi_frac, hi_exp) = de_frexp(x.hi());

    if de_sign(lo_frac) != de_sign(hi_frac) {
        // The range straddles a sign change (through zero) or a power-of-two boundary
        // that flips which side of `+-0.5` the fraction falls on; either way, the
        // exponent could be anything up to the larger of the two, extending to
        // `-infinity` on the low end (mirroring upstream's own `Interval(-TCU_INFINITY,
        // max(loExp, hiExp))` exactly, not an approximation of it).
        let exponent = Interval::new(f64::NEG_INFINITY, (lo_exp.max(hi_exp)) as f64);
        let mut ret = Interval::empty();
        if de_sign(lo_frac) < 0.0 {
            ret = ret | Interval::new(-1.0 + f64::EPSILON * 0.5, 0.0);
        }
        if de_sign(hi_frac) > 0.0 {
            ret = ret | Interval::new(0.0, 1.0 - f64::EPSILON * 0.5);
        }
        (ret, exponent)
    } else {
        let exponent = Interval::new(lo_exp as f64, hi_exp as f64);
        let ret = if lo_exp == hi_exp {
            Interval::new(lo_frac, hi_frac)
        } else if de_sign(lo_frac) < 0.0 {
            Interval::new(-(1.0 - f64::EPSILON * 0.5), -0.5)
        } else {
            Interval::new(0.5, 1.0 - f64::EPSILON * 0.5)
        };
        (ret, exponent)
    }
}

/// `LdExp::doApply` - `exp2(exponent)`, NaN-widened if `exp2` overflows to
/// `+-infinity` ("Khronos bug 11180 consensus: if exp2(exponent) cannot be
/// represented, the result is undefined"), then `Mul` - both already-ported
/// primitives, reused directly rather than recomputed.
fn ldexp_reference(fmt: FloatFormat, precision: Precision, a: Interval, b: Interval) -> Interval {
    let mut exp2_b = unary_reference(UnaryOp::Exp2, fmt, precision, b);
    if exp2_b.contains(f64::INFINITY) || exp2_b.contains(f64::NEG_INFINITY) {
        exp2_b = exp2_b | Interval::exact(f64::NAN);
    }
    binary_reference(BinaryOp::Mul, fmt, precision, a, exp2_b)
}

fn build_ldexp_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {p} float;\nprecision {p} int;\n", p = precision.name());

    let ty = gen_type.data_type();
    let int_ty = if matches!(gen_type, GenType::Scalar) {
        DataType::Int
    } else {
        get_data_type_int_vec(gen_type.lanes() as i32)
    };
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.inputs
        .push(Symbol::new("in1", VarType::basic(int_ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.source = "out0 = ldexp(in0, in1);".to_string();
    spec
}

struct LdExpCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for LdExpCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_ldexp_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x6c64_6578 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let in0 = generate_inputs1(fmt, lanes, seed);
        let num_values = in0.len() / lanes;
        let in1 = generate_int_exponent_inputs(self.precision, num_values * lanes, seed ^ 0x9e37_79b9);

        let mut out_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 2] = [f32_bytes(&in0), i32_bytes(&in1)];
            let mut outputs: [&mut [u8]; 1] = [&mut out_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let a = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            for (lane, &a_lane) in a.iter().enumerate() {
                let idx = value_ndx * lanes + lane;
                let b = fmt.convert(Interval::exact(f64::from(in1[idx])));
                let reference = ldexp_reference(fmt, self.precision, a_lane, b);
                let reference = highp_fmt.convert(reference);
                let got = out0[idx] as f64;

                if !reference.contains(got) {
                    let is_warning = reference.contains_warning(got);
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!("sample {value_ndx} lane {lane}: got {}", out0[idx]));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn ldexp_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("ldexp");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(LdExpCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

fn build_frexp_spec(context: &Context, precision: Precision, gen_type: GenType) -> ShaderSpec {
    let supports_es32 = context.context_type().supports(3, 2);
    let mut spec = ShaderSpec::new(if supports_es32 {
        glu::GlslVersion::Es320
    } else {
        glu::GlslVersion::Es310
    });
    spec.global_declarations = format!("precision {p} float;\nprecision {p} int;\n", p = precision.name());

    let ty = gen_type.data_type();
    let int_ty = if matches!(gen_type, GenType::Scalar) {
        DataType::Int
    } else {
        get_data_type_int_vec(gen_type.lanes() as i32)
    };
    spec.inputs
        .push(Symbol::new("in0", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out0", VarType::basic(ty, Some(precision))));
    spec.outputs
        .push(Symbol::new("out1", VarType::basic(int_ty, Some(precision))));
    spec.source = "out0 = frexp(in0, out1);".to_string();
    spec
}

struct FrExpCase {
    precision: Precision,
    gen_type: GenType,
    stage: ShaderType,
}

impl TestCase for FrExpCase {
    fn name(&self) -> &str {
        self.gen_type.case_name()
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        let lanes = self.gen_type.lanes();
        let fmt = precision_format(self.precision);
        let highp_fmt = precision_format(Precision::HighP);

        let spec = build_frexp_spec(context, self.precision, self.gen_type);
        let gl = context.gl();
        let executor = shader_exec_util::create_executor(&context.render_context, self.stage, &spec)?;
        if !executor.is_ok() {
            return Err(TestError::Fail(format!(
                "Shader compilation failed: {}",
                executor.build_failure_summary().unwrap_or_default()
            )));
        }
        executor.use_program(gl);

        let seed =
            0x6672_6578 ^ ((self.precision as i32 as u32) << 8) ^ ((self.stage as i32 as u32) << 4) ^ lanes as u32;
        let in0 = generate_inputs1(fmt, lanes, seed);
        let num_values = in0.len() / lanes;

        let mut out0_bytes = vec![0u8; in0.len() * 4];
        let mut out1_bytes = vec![0u8; in0.len() * 4];
        {
            let inputs: [&[u8]; 1] = [f32_bytes(&in0)];
            let mut outputs: [&mut [u8]; 2] = [&mut out0_bytes, &mut out1_bytes];
            executor.execute(num_values as i32, &inputs, &mut outputs)?;
        }
        let out0 = floats_from_bytes(&out0_bytes);
        let out1 = ints_from_bytes(&out1_bytes);

        let mut num_errors = 0usize;
        let mut num_warnings = 0usize;
        let mut first_message: Option<String> = None;

        for value_ndx in 0..num_values {
            let a = read_lanes(fmt, &in0[value_ndx * lanes..(value_ndx + 1) * lanes]);
            for (lane, &a_lane) in a.iter().enumerate() {
                let idx = value_ndx * lanes + lane;
                let (mantissa_ref, exponent_ref) = frexp_reference(a_lane);
                let mantissa_ref = highp_fmt.convert(mantissa_ref);
                let got_mantissa = out0[idx] as f64;
                let got_exponent = f64::from(out1[idx]);

                let mantissa_ok = mantissa_ref.contains(got_mantissa);
                let exponent_ok = exponent_ref.contains(got_exponent);
                if !mantissa_ok || !exponent_ok {
                    let is_warning = (mantissa_ok || mantissa_ref.contains_warning(got_mantissa))
                        && (exponent_ok || exponent_ref.contains_warning(got_exponent));
                    if is_warning {
                        num_warnings += 1;
                    } else {
                        num_errors += 1;
                    }
                    if first_message.is_none() {
                        first_message = Some(format!(
                            "sample {value_ndx} lane {lane}: got mantissa {}, exponent {}",
                            out0[idx], out1[idx]
                        ));
                    }
                }
            }
        }

        if num_errors > 0 {
            Ok(TestStatus::fail(first_message.unwrap_or_else(|| {
                "Shader output is outside acceptable range".to_string()
            })))
        } else if num_warnings > 0 {
            Ok(TestStatus::new(
                TestResult::QualityWarning,
                first_message.unwrap_or_default(),
            ))
        } else {
            Ok(TestStatus::pass("Pass"))
        }
    }
}

pub fn frexp_group(stages: &[ShaderType]) -> TestCaseGroup {
    let mut group = TestCaseGroup::new("frexp");
    for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
        for &stage in stages {
            let mut stage_group = TestCaseGroup::new(format!("{}_{}", precision.name(), stage.as_str()));
            for &gen_type in &ALL_GEN_TYPES {
                stage_group.add_child(Box::new(FrExpCase {
                    precision,
                    gen_type,
                    stage,
                }) as Box<dyn TestCase>);
            }
            group.add_child(stage_group);
        }
    }
    group
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn add_reference_of_two_ordinary_values_is_exact_at_highp() {
        let highp = precision_format(Precision::HighP);
        let a = highp.convert(highp.round_out_point(1.0, false));
        let b = highp.convert(highp.round_out_point(2.0, false));
        let r = binary_reference(BinaryOp::Add, highp, Precision::HighP, a, b);
        assert!(r.contains(3.0), "expected 3.0 in [{}, {}]", r.lo(), r.hi());
    }

    #[test]
    fn sub_mul_and_div_reference_are_exact_at_highp_too() {
        let highp = precision_format(Precision::HighP);
        let a = highp.convert(highp.round_out_point(5.0, false));
        let b = highp.convert(highp.round_out_point(2.0, false));
        assert!(binary_reference(BinaryOp::Sub, highp, Precision::HighP, a, b).contains(3.0));
        assert!(binary_reference(BinaryOp::Mul, highp, Precision::HighP, a, b).contains(10.0));
        assert!(binary_reference(BinaryOp::Div, highp, Precision::HighP, a, b).contains(2.5));
    }

    #[test]
    fn binary_reference_propagates_nan_from_either_operand() {
        let highp = precision_format(Precision::HighP);
        let nan = highp.round_out_point(f64::NAN, false);
        let one = highp.convert(highp.round_out_point(1.0, false));
        for op in [
            BinaryOp::Add,
            BinaryOp::Sub,
            BinaryOp::Mul,
            BinaryOp::Div,
            BinaryOp::Min,
            BinaryOp::Max,
        ] {
            assert!(binary_reference(op, highp, Precision::HighP, nan, one).has_nan());
            assert!(binary_reference(op, highp, Precision::HighP, one, nan).has_nan());
        }
    }

    /// `Div::innerExtrema`'s two independent conditions on a zero-containing
    /// denominator: `nom.contains(0.0)` gates only the `NaN` branch, `nom.lo() < 0.0 ||
    /// nom.hi() > 0.0` gates the unbounded one - upstream fires the unbounded branch
    /// for *any* nonzero numerator (den might be arbitrarily close to zero, not
    /// necessarily exactly zero), so `5/0` is legally "any number" and never `NaN`,
    /// while `0/0` is legally `NaN` and (since `nom.hi() > 0.0` is false for the
    /// single point `{0}`) *only* `NaN` at the `inner_extrema` level - though at highp
    /// (`has_nan: Maybe`) the final `fmt.convert` reopens the numeric range to
    /// unbounded there too, since NaN being merely "maybe" supported means any
    /// non-NaN value must also be considered legal. The two must still be told apart
    /// by the flag alone.
    #[test]
    fn div_reference_distinguishes_nonzero_over_zero_from_zero_over_zero() {
        let highp = precision_format(Precision::HighP);
        let five = highp.convert(highp.round_out_point(5.0, false));
        let zero = highp.convert(highp.round_out_point(0.0, false));

        let five_over_zero = binary_reference(BinaryOp::Div, highp, Precision::HighP, five, zero);
        assert!(!five_over_zero.has_nan(), "5/0 must never be NaN");
        assert!(five_over_zero.contains(f64::INFINITY));

        let zero_over_zero = binary_reference(BinaryOp::Div, highp, Precision::HighP, zero, zero);
        assert!(zero_over_zero.has_nan(), "0/0 must legally be NaN");
    }

    /// `Div::precision`'s "any number" branch: a denominator whose magnitude falls
    /// outside `[2^minExp, 2^(maxExp-1)]` must widen the reference to unbounded, with
    /// no `NaN` involved (the denominator here is a nonzero point, never containing
    /// zero, so `inner_extrema` never fires either).
    #[test]
    fn div_reference_widens_to_unbounded_for_an_out_of_normal_range_denominator() {
        let highp = precision_format(Precision::HighP);
        let one = highp.convert(highp.round_out_point(1.0, false));
        let tiny = highp.convert(highp.round_out_point(ldexp(1.0, highp.min_exp() - highp.fraction_bits()), false));
        let r = binary_reference(BinaryOp::Div, highp, Precision::HighP, one, tiny);
        assert_eq!(r.lo(), f64::NEG_INFINITY);
        assert_eq!(r.hi(), f64::INFINITY);
        assert!(!r.has_nan());
    }

    /// `Div::applyPoint`'s overflow-reclassification, tested directly against
    /// `div_point` rather than through `binary_reference`: the final `fmt.convert` at
    /// the end of `binary_reference` independently re-derives the same has-infinity
    /// clamp from any raw bound whose exponent overflows the format (regardless of
    /// how far past), which masks the reclassification's effect once the full
    /// pipeline runs - so this checks the one place it is actually observable, the
    /// point evaluation itself. Neither operand here is infinite, and the division
    /// overflows mediump's own range (`max_exp = 13`) even though the denominator is
    /// itself within the "normal" (finite-precision) division range - the
    /// reclassification must widen the raw `exact +/- prec` range (which sits far
    /// beyond `max_value`) down to include the format's largest finite value, not
    /// leave the range stranded entirely above what mediump can represent.
    #[test]
    fn div_point_reclassifies_a_finite_overflow_as_the_formats_max_value() {
        let mediump = precision_format(Precision::MediumP);
        let x = mediump.max_value();
        let y = ldexp(1.0, -5); // within [2^minExp, 2^(maxExp-1)] = [2^-13, 2^12]
        let r = div_point(mediump, x, y);
        assert!(
            r.contains(mediump.max_value()),
            "expected the format's max value to be included, got [{}, {}]",
            r.lo(),
            r.hi()
        );
    }

    /// Negative control for `symmetric_error_interval`'s NaN-cancellation handling: an
    /// infinite `exact` combined with an infinite `prec` (reachable when a sampled
    /// operand is itself `+-inf` and the denominator falls outside the normal
    /// division range) must not silently collapse to an empty, non-NaN range.
    #[test]
    fn symmetric_error_interval_flags_nan_when_opposite_signed_infinities_cancel() {
        let r = symmetric_error_interval(f64::INFINITY, f64::INFINITY);
        assert!(r.has_nan());
        assert!(r.contains(f64::INFINITY));
        assert!(!r.contains(f64::NEG_INFINITY));

        let r2 = symmetric_error_interval(f64::NEG_INFINITY, f64::INFINITY);
        assert!(r2.has_nan());
        assert!(r2.contains(f64::NEG_INFINITY));
        assert!(!r2.contains(f64::INFINITY));
    }

    #[test]
    fn add_reference_at_mediump_widens_for_a_value_mediump_cannot_land_on() {
        // 9 fraction bits: 1.0 + a value smaller than mediump's own quantum must still
        // report a legal (nonzero-width, in general) range containing the exact sum.
        let mediump = precision_format(Precision::MediumP);
        let a = mediump.convert(mediump.round_out_point(1.0, false));
        let b = mediump.convert(mediump.round_out_point(1.0 / 3.0, false));
        let r = binary_reference(BinaryOp::Add, mediump, Precision::HighP, a, b);
        assert!(r.contains(1.0 + 1.0 / 3.0));
    }

    /// `Mul::innerExtrema` - `infinity * 0` must report `NaN` as a legal answer even
    /// though neither corner-point evaluation of the sampled intervals would produce
    /// it by itself (the corners here are exactly `(inf, 0)`, `(inf, 5)`, `(3, 0)`,
    /// `(3, 5)` - only the first is the degenerate case, and `0 * inf` in plain `f64`
    /// arithmetic already *is* `NaN`, so this specific case would pass even without
    /// `inner_extrema` - the real test is the one below, where neither operand's
    /// interval contains the exact corner pairing).
    #[test]
    fn mul_reference_reports_nan_as_legal_when_an_operand_spans_zero_and_the_other_spans_infinity() {
        let highp = precision_format(Precision::HighP);
        // [3, inf] * [0, 5]: no single corner pairs a finite zero with an infinity,
        // but the *interval* combination still legally contains that product.
        let unbounded_positive = Interval::new(3.0, f64::INFINITY);
        let spans_zero = Interval::new(0.0, 5.0);
        let r = binary_reference(BinaryOp::Mul, highp, Precision::HighP, unbounded_positive, spans_zero);
        assert!(r.has_nan(), "expected NaN to be a legal answer for [3, inf] * [0, 5]");
    }

    /// Negative control for `inner_extrema`: gate it to `Mul` only, or it would also
    /// fire for `Add`/`Sub` (whose own upstream classes never override it).
    #[test]
    fn inner_extrema_is_empty_for_add_and_sub() {
        let highp = precision_format(Precision::HighP);
        let unbounded_positive = Interval::new(3.0, f64::INFINITY);
        let spans_zero = Interval::new(0.0, 5.0);
        assert!(
            BinaryOp::Add
                .inner_extrema(highp, unbounded_positive, spans_zero)
                .is_empty()
        );
        assert!(
            BinaryOp::Sub
                .inner_extrema(highp, unbounded_positive, spans_zero)
                .is_empty()
        );
    }

    /// Negative control for `apply_monotone2`'s simplifying assumption (see its own
    /// comment): a hand-built empty-but-not-NaN interval must not silently make the
    /// whole result NaN-flagged just because it looks like a "sampled NaN" would.
    #[test]
    fn apply_monotone2_only_flags_nan_when_an_argument_actually_carries_it() {
        let a = Interval::new(1.0, 2.0);
        let b = Interval::new(3.0, 4.0);
        let r = apply_monotone2(a, b, |x, y| Interval::exact(x + y));
        assert!(!r.has_nan());
        assert!(r.contains(4.0) && r.contains(6.0));
    }

    /// `MinMaxFunc::applyPoint`'s ordinary case: distinguishable operands, so `min`/
    /// `max` return the smaller/larger one exactly (`precision()` is unconditionally
    /// `0.0`).
    #[test]
    fn min_and_max_reference_pick_the_ordinary_smaller_and_larger_operand_exactly() {
        let highp = precision_format(Precision::HighP);
        let a = highp.convert(highp.round_out_point(3.0, false));
        let b = highp.convert(highp.round_out_point(7.0, false));
        let min_r = binary_reference(BinaryOp::Min, highp, Precision::HighP, a, b);
        let max_r = binary_reference(BinaryOp::Max, highp, Precision::HighP, a, b);
        assert!(
            min_r.contains(3.0) && !min_r.contains(7.0),
            "min([3,7]) got [{}, {}]",
            min_r.lo(),
            min_r.hi()
        );
        assert!(
            max_r.contains(7.0) && !max_r.contains(3.0),
            "max([3,7]) got [{}, {}]",
            max_r.lo(),
            max_r.hi()
        );
    }

    /// `compare`'s subnormal-indistinguishability branch: a format without subnormal
    /// support (`lowp`, `has_subnormal: Yes` here though - use `mediump`, whose
    /// `with_support` default is `Maybe`, i.e. not `Yes`) must treat two operands that
    /// both fall within the smallest-representable-magnitude band as equal, so either
    /// is a legal `min`/`max` answer even though they differ in plain `f64` arithmetic.
    #[test]
    fn min_max_compare_cannot_distinguish_two_subnormals_when_the_format_has_none() {
        let mediump = precision_format(Precision::MediumP);
        assert_ne!(mediump.has_subnormal(), YesNoMaybe::Yes);
        let min_quantum = ldexp(1.0, mediump.min_exp() - mediump.fraction_bits());
        let min_normalized = ldexp(1.0, mediump.min_exp());
        // Two distinct values, both inside [0, min_normalized) - the subnormal band a
        // format without subnormal support cannot represent at all.
        let x = min_quantum;
        let y = min_normalized - min_quantum;
        assert!(x < y, "test setup: expected {x} < {y}");
        assert_eq!(
            compare(mediump, x, y),
            0,
            "expected the two subnormals to compare equal"
        );

        let r = min_max_point(BinaryOp::Min, mediump, x, y);
        assert!(
            r.contains(x) && r.contains(y),
            "expected either subnormal to be a legal min, got [{}, {}]",
            r.lo(),
            r.hi()
        );
    }

    /// Negative control for `inner_extrema`: `Min`/`Max` must not gain `Mul`'s
    /// `infinity * 0` extremum just by sharing its arm in a combined match pattern.
    #[test]
    fn inner_extrema_is_empty_for_min_and_max() {
        let highp = precision_format(Precision::HighP);
        let unbounded_positive = Interval::new(3.0, f64::INFINITY);
        let spans_zero = Interval::new(0.0, 5.0);
        assert!(
            BinaryOp::Min
                .inner_extrema(highp, unbounded_positive, spans_zero)
                .is_empty()
        );
        assert!(
            BinaryOp::Max
                .inner_extrema(highp, unbounded_positive, spans_zero)
                .is_empty()
        );
    }

    /// `ATan2::applyExact` - `deAtan2(x, y) = atan2(x, y)`; an ordinary in-range point
    /// (`atan2(1, 1) == pi/4`) has no domain exclusion and no branch-cut proximity, so
    /// this must land tightly around the exact value.
    #[test]
    fn atan2_reference_of_an_ordinary_point_is_close_to_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let one = highp.convert(highp.round_out_point(1.0, false));
        let r = binary_reference(BinaryOp::ATan2, highp, Precision::HighP, one, one);
        let exact = 1.0f64.atan2(1.0);
        assert!(r.contains(exact), "expected pi/4 in [{}, {}]", r.lo(), r.hi());
        assert!(
            !r.contains(0.0),
            "range should be tight around pi/4, not spanning back to zero"
        );
    }

    /// `ATan2::innerExtrema`'s first branch: a numerator interval spanning zero
    /// together with a denominator that can itself be zero makes `NaN` (`atan2(0, 0)`,
    /// undefined) a legal answer, on top of whatever the corner points alone produce.
    #[test]
    fn atan2_reference_admits_nan_when_both_operands_can_be_zero() {
        let highp = precision_format(Precision::HighP);
        let spans_zero = Interval::new(-1.0, 1.0);
        let r = binary_reference(BinaryOp::ATan2, highp, Precision::HighP, spans_zero, spans_zero);
        assert!(r.has_nan(), "expected atan2(0, 0) to be a legal NaN answer");
    }

    /// `ATan2::innerExtrema`'s second branch: a numerator spanning zero with a
    /// denominator that can be negative-or-zero crosses the branch cut, so the whole
    /// `[-pi, pi]` range becomes legal - not just the two corner-point angles.
    #[test]
    fn atan2_reference_covers_the_whole_angle_range_across_the_branch_cut() {
        let highp = precision_format(Precision::HighP);
        let y_spans_zero = Interval::new(-1.0, 1.0);
        let x_negative_or_zero = Interval::new(-5.0, -1.0);
        let r = binary_reference(
            BinaryOp::ATan2,
            highp,
            Precision::HighP,
            y_spans_zero,
            x_negative_or_zero,
        );
        assert!(
            r.contains(std::f64::consts::PI) && r.contains(-std::f64::consts::PI),
            "expected [-pi, pi] to be covered, got [{}, {}]",
            r.lo(),
            r.hi()
        );
    }

    /// Negative control for `atan2_inner_extrema`'s branch-cut condition: a denominator
    /// that stays strictly positive must never trigger the whole-range widening, even
    /// though the numerator still spans zero.
    #[test]
    fn atan2_reference_does_not_widen_when_the_denominator_stays_positive() {
        let highp = precision_format(Precision::HighP);
        let y_spans_zero = Interval::new(-1.0, 1.0);
        let x_positive = Interval::new(1.0, 5.0);
        let r = binary_reference(BinaryOp::ATan2, highp, Precision::HighP, y_spans_zero, x_positive);
        assert!(!r.has_nan(), "a strictly positive denominator must never admit NaN");
        assert!(
            !r.contains(std::f64::consts::PI),
            "must not widen to the whole angle range"
        );
    }

    /// `Clamp::applyPoint`'s ordinary case: `x` already within `[minVal, maxVal]`
    /// passes through unchanged.
    #[test]
    fn clamp_reference_of_an_ordinary_in_range_value_is_exact() {
        let highp = precision_format(Precision::HighP);
        let x = highp.convert(highp.round_out_point(5.0, false));
        let min_val = highp.convert(highp.round_out_point(0.0, false));
        let max_val = highp.convert(highp.round_out_point(10.0, false));
        let r = clamp_reference(highp, x, min_val, max_val);
        assert!(
            r.contains(5.0) && !r.contains(11.0),
            "expected exactly 5.0, got [{}, {}]",
            r.lo(),
            r.hi()
        );
    }

    /// `Clamp::applyPoint`'s two saturating branches: below `minVal` clamps to
    /// `minVal`, above `maxVal` clamps to `maxVal`.
    #[test]
    fn clamp_reference_saturates_outside_the_range() {
        let highp = precision_format(Precision::HighP);
        let min_val = highp.convert(highp.round_out_point(0.0, false));
        let max_val = highp.convert(highp.round_out_point(10.0, false));

        let below = highp.convert(highp.round_out_point(-5.0, false));
        let r_below = clamp_reference(highp, below, min_val, max_val);
        assert!(r_below.contains(0.0) && !r_below.contains(-5.0));

        let above = highp.convert(highp.round_out_point(15.0, false));
        let r_above = clamp_reference(highp, above, min_val, max_val);
        assert!(r_above.contains(10.0) && !r_above.contains(15.0));
    }

    /// `Clamp::applyPoint`'s degenerate case: `minVal > maxVal` is legally `NaN`,
    /// regardless of `x` - ported verbatim from upstream's own first check.
    #[test]
    fn clamp_reference_is_nan_when_the_range_is_inverted() {
        let highp = precision_format(Precision::HighP);
        let x = highp.convert(highp.round_out_point(5.0, false));
        let min_val = highp.convert(highp.round_out_point(10.0, false));
        let max_val = highp.convert(highp.round_out_point(0.0, false));
        let r = clamp_reference(highp, x, min_val, max_val);
        assert!(r.has_nan(), "expected minVal > maxVal to legally report NaN");
    }

    /// Negative control for `clamp_point`'s saturating branches: swapping which bound
    /// a below-range value clamps to must be caught by the ordinary-case test above,
    /// not silently accepted - checked directly here rather than by mutating the
    /// source, since the two branches are structurally identical and a source-level
    /// swap would be easy to get wrong by accident.
    #[test]
    fn clamp_point_below_range_clamps_to_min_not_max() {
        let highp = precision_format(Precision::HighP);
        let r = clamp_point(highp, -5.0, 0.0, 10.0);
        assert!(r.contains(0.0) && !r.contains(10.0));
    }

    #[test]
    fn gen_fixed_samples_cover_every_documented_boundary() {
        let highp = precision_format(Precision::HighP);
        let samples = gen_fixed_samples(highp);
        assert!(samples.iter().any(|v| v.is_nan()));
        assert!(samples.contains(&0.0));
        assert!(samples.contains(&f32::INFINITY));
        assert!(samples.contains(&f32::NEG_INFINITY));
        assert_eq!(samples.len(), 20);
    }

    #[test]
    fn binary_op_group_names_match_the_real_gles31_mustpass() {
        for (op, name) in [
            (BinaryOp::Add, "add"),
            (BinaryOp::Sub, "sub"),
            (BinaryOp::Mul, "mul"),
            (BinaryOp::Div, "div"),
            (BinaryOp::Min, "min"),
            (BinaryOp::Max, "max"),
            (BinaryOp::ATan2, "atan2"),
        ] {
            let group = binary_op_group(op, &[ShaderType::Compute]);
            let flat = crate::tcu::flatten(group);
            let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
            names.sort();
            assert_eq!(names.len(), 12);
            assert!(names.contains(&format!("{name}.highp_compute.vec4")));
            assert!(names.contains(&format!("{name}.lowp_compute.scalar")));
        }
    }

    #[test]
    fn binary_op_group_names_match_the_real_gles3_mustpass() {
        for (op, name) in [
            (BinaryOp::Add, "add"),
            (BinaryOp::Sub, "sub"),
            (BinaryOp::Mul, "mul"),
            (BinaryOp::Div, "div"),
            (BinaryOp::Min, "min"),
            (BinaryOp::Max, "max"),
            (BinaryOp::ATan2, "atan2"),
        ] {
            let group = binary_op_group(op, &[ShaderType::Vertex, ShaderType::Fragment]);
            let flat = crate::tcu::flatten(group);
            let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
            names.sort();
            assert_eq!(names.len(), 24);
            assert!(names.contains(&format!("{name}.highp_vertex.vec4")));
            assert!(names.contains(&format!("{name}.mediump_fragment.scalar")));
        }
    }

    #[test]
    fn unary_op_group_names_match_both_real_mustpasses() {
        for (op, name) in [
            (UnaryOp::Sin, "sin"),
            (UnaryOp::Cos, "cos"),
            (UnaryOp::ASin, "asin"),
            (UnaryOp::ACos, "acos"),
            (UnaryOp::ATan, "atan"),
        ] {
            let compute = unary_op_group(op, &[ShaderType::Compute]);
            let flat = crate::tcu::flatten(compute);
            let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
            names.sort();
            assert_eq!(names.len(), 12);
            assert!(names.contains(&format!("{name}.highp_compute.vec4")));
            assert!(names.contains(&format!("{name}.lowp_compute.scalar")));

            let vertfrag = unary_op_group(op, &[ShaderType::Vertex, ShaderType::Fragment]);
            let flat = crate::tcu::flatten(vertfrag);
            let mut names: Vec<String> = flat.iter().map(|c| c.full_name.clone()).collect();
            names.sort();
            assert_eq!(names.len(), 24);
            assert!(names.contains(&format!("{name}.highp_vertex.vec4")));
            assert!(names.contains(&format!("{name}.mediump_fragment.scalar")));
        }
    }

    #[test]
    fn sin_and_cos_reference_are_exact_at_a_zero_angle_at_highp() {
        let highp = precision_format(Precision::HighP);
        let zero = highp.convert(highp.round_out_point(0.0, false));
        assert!(unary_reference(UnaryOp::Sin, highp, Precision::HighP, zero).contains(0.0));
        assert!(unary_reference(UnaryOp::Cos, highp, Precision::HighP, zero).contains(1.0));
    }

    #[test]
    fn asin_and_acos_reference_propagate_nan_from_a_sampled_nan() {
        let highp = precision_format(Precision::HighP);
        let nan = highp.round_out_point(f64::NAN, false);
        for op in [UnaryOp::Sin, UnaryOp::Cos, UnaryOp::ASin, UnaryOp::ACos, UnaryOp::ATan] {
            assert!(
                unary_reference(op, highp, Precision::HighP, nan).has_nan(),
                "{op:?} should propagate NaN"
            );
        }
    }

    /// `ASin`/`ACos`'s own domain check (`ArcTrigFunc`/the inline `ASin` override): a
    /// value outside `[-1, 1]` makes `precision()` return `TCU_NAN`, which - since
    /// `applyExact` (`asin`/`acos` themselves) already returns NaN for the same input -
    /// makes the reference NaN-only regardless of which of the two paths supplied it.
    #[test]
    fn asin_and_acos_are_nan_outside_their_domain() {
        let highp = precision_format(Precision::HighP);
        let out_of_domain = highp.convert(highp.round_out_point(1.5, false));
        assert!(unary_reference(UnaryOp::ASin, highp, Precision::HighP, out_of_domain).has_nan());
        assert!(unary_reference(UnaryOp::ACos, highp, Precision::HighP, out_of_domain).has_nan());
    }

    /// `TrigFunc::innerExtrema` - an angle interval spanning more than a full period
    /// must legally produce the whole `[-1, 1]` codomain, not just the two endpoint
    /// evaluations union.
    #[test]
    fn sin_reference_over_a_full_period_covers_the_whole_codomain() {
        let highp = precision_format(Precision::HighP);
        let full_turn = Interval::new(0.0, 2.0 * std::f64::consts::PI + 0.1);
        let r = unary_reference(UnaryOp::Sin, highp, Precision::HighP, full_turn);
        assert!(
            r.contains(-1.0) && r.contains(1.0),
            "expected [-1, 1] to be covered, got [{}, {}]",
            r.lo(),
            r.hi()
        );
    }

    /// `ATan`'s codomain is unrestricted (`ArcTrigFunc`'s default, never narrowed,
    /// unlike `Sin`/`Cos`'s own `[-1, 1]` override) - `atan(1e30)` is close to `pi/2`,
    /// well outside `[-1, 1]`, and must not be clipped down into it the way it would be
    /// if `ATan` wrongly shared `Sin`/`Cos`'s codomain.
    #[test]
    fn atan_reference_is_not_clipped_to_a_narrow_codomain() {
        let highp = precision_format(Precision::HighP);
        let big = highp.convert(highp.round_out_point(1.0e30, false));
        let r = unary_reference(UnaryOp::ATan, highp, Precision::HighP, big);
        assert!(
            r.contains(1.0e30_f64.atan()),
            "expected the exact value itself to be in range, got [{}, {}]",
            r.lo(),
            r.hi()
        );
        assert!(
            r.hi() > 1.0,
            "atan's result must not be clipped to [-1, 1], got hi = {}",
            r.hi()
        );
    }

    /// `gen_random_sample`'s cubic exponent distribution needs to draw noticeably more
    /// samples close to `+-1.0` (exponent `0`/`-1`) than a uniform distribution over
    /// highp's whole `[-126, 127]` exponent range would - this is what makes
    /// `ASin`/`ACos`'s domain-edge `QualityWarning` sampling-density issue (see the
    /// function's own doc comment) actually fixed rather than just differently wrong.
    #[test]
    fn gen_random_sample_favours_exponents_near_zero_over_a_uniform_distribution() {
        let fmt = precision_format(Precision::MediumP);
        let mut rnd = Random::new(0x9e3779b9);
        let mut near_one = 0usize;
        let mut total_finite = 0usize;
        for _ in 0..20000 {
            let v = gen_random_sample(fmt, &mut rnd);
            if v.is_finite() {
                total_finite += 1;
                if v.abs() >= 0.5 && v.abs() < 2.0 {
                    near_one += 1;
                }
            }
        }
        // Mediump's exponent range is `[-13, 13]`, 27 buckets; a uniform distribution
        // would put roughly `2/27 ~= 7.4%` of draws in the `[0.5, 2)` band (exponents
        // `-1` and `0`). The cubic distribution's density peaks exactly there, so this
        // expects well over double that share.
        let fraction = near_one as f64 / total_finite as f64;
        assert!(
            fraction > 0.20,
            "expected the cubic distribution to favour exponents near zero, got {fraction:.3}"
        );
    }

    /// `derived_unary_reference` for an ordinary in-range point stays tight around the
    /// exact mathematical value - `radians(90) == pi/2`, `degrees(pi) == 180`.
    #[test]
    fn radians_and_degrees_reference_matches_the_exact_value_for_an_ordinary_point() {
        let highp = precision_format(Precision::HighP);
        let ninety = highp.convert(highp.round_out_point(90.0, false));
        let r = derived_unary_reference(UnaryOp::Radians, highp, Precision::HighP, ninety);
        assert!(
            r.contains(std::f64::consts::FRAC_PI_2),
            "expected pi/2 in [{}, {}]",
            r.lo(),
            r.hi()
        );

        let pi = highp.convert(highp.round_out_point(std::f64::consts::PI, false));
        let d = derived_unary_reference(UnaryOp::Degrees, highp, Precision::HighP, pi);
        assert!(d.contains(180.0), "expected 180 in [{}, {}]", d.lo(), d.hi());
    }

    /// `Radians`/`Degrees` are pure `Mul`-by-constant compositions with no domain
    /// exclusion anywhere in the chain (unlike `ASin`/`ACos`/`Div`) - an ordinary finite
    /// interval must never produce a NaN-admitting reference.
    #[test]
    fn radians_and_degrees_reference_never_admits_nan_for_an_ordinary_interval() {
        let highp = precision_format(Precision::HighP);
        let arg = Interval::new(-1000.0, 1000.0);
        assert!(!derived_unary_reference(UnaryOp::Radians, highp, Precision::HighP, arg).has_nan());
        assert!(!derived_unary_reference(UnaryOp::Degrees, highp, Precision::HighP, arg).has_nan());
    }

    /// Negative control for the composition itself: `radians`/`degrees` must not be
    /// reciprocal-symmetric in the same way an accidentally-swapped constant would still
    /// look plausible for - confirms the two constants are genuinely each other's
    /// reciprocal (`(pi/180) * (180/pi) == 1`) rather than both silently using the same
    /// one.
    #[test]
    fn radians_and_degrees_constants_are_reciprocal() {
        let highp = precision_format(Precision::HighP);
        let one = highp.convert(highp.round_out_point(1.0, false));
        let r = derived_unary_reference(UnaryOp::Radians, highp, Precision::HighP, one);
        let back = derived_unary_reference(UnaryOp::Degrees, highp, Precision::HighP, r);
        assert!(
            back.contains(1.0),
            "radians(1) then degrees(...) should recover ~1, got [{}, {}]",
            back.lo(),
            back.hi()
        );
    }

    /// `Sqrt = 1.0 / InverseSqrt(x)` - `sqrt(4) == 2` at an ordinary point.
    #[test]
    fn sqrt_reference_matches_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let four = highp.convert(highp.round_out_point(4.0, false));
        let r = derived_unary_reference(UnaryOp::Sqrt, highp, Precision::HighP, four);
        assert!(r.contains(2.0), "expected 2.0 in [{}, {}]", r.lo(), r.hi());
    }

    /// At `x == 0`, `Sqrt`'s own reference is genuinely NaN-admitting - not because of
    /// the ternary's dead `constant(1.0f)` branch (confirmed unreachable, see
    /// `derived_unary_reference`'s own doc comment), but because `Sqrt` composes
    /// `InverseSqrt`, whose own `precision()` is `x <= 0 ? TCU_NAN : ...` - `x == 0` is
    /// squarely inside that exclusion (`1.0 / InverseSqrt(0)` is genuinely `1/0`
    /// upstream's own reference has no defined error bound for). This is upstream's own
    /// real behaviour, faithfully reproduced by composing the already-verified
    /// `InverseSqrt` primitive - not a bug introduced by this port. `FloatFormat::convert`
    /// then widens a NaN-admitting range to fully unbounded whenever `has_nan` is only
    /// `Maybe` (every precision format in this file is), so the reference legally
    /// admits *any* value at `x == 0`, matching the same "any answer is acceptable at an
    /// undefined edge" shape `Div`'s own `0/0` case already documents above.
    #[test]
    fn sqrt_reference_admits_nan_at_zero_because_inverse_sqrt_is_out_of_domain_there() {
        let highp = precision_format(Precision::HighP);
        let zero = highp.convert(highp.round_out_point(0.0, false));
        let z = derived_unary_reference(UnaryOp::Sqrt, highp, Precision::HighP, zero);
        assert!(
            z.has_nan(),
            "expected sqrt(0)'s reference to be NaN-admitting (InverseSqrt(0) is out of InverseSqrt's own domain)"
        );
    }

    /// `InverseSqrt::precision` is unconditionally 2 ULPs with no branch on the case's
    /// precision qualifier - confirmed directly rather than assumed, since every other
    /// `FloatFunc1` primitive in this file does branch.
    #[test]
    fn inverse_sqrt_reference_matches_at_every_precision_qualifier() {
        for &precision in &[Precision::HighP, Precision::MediumP, Precision::LowP] {
            let fmt = precision_format(precision);
            let nine = fmt.convert(fmt.round_out_point(9.0, false));
            let r = unary_reference(UnaryOp::InverseSqrt, fmt, precision, nine);
            assert!(
                r.contains(1.0 / 3.0),
                "expected 1/3 in [{}, {}] at {:?}",
                r.lo(),
                r.hi(),
                precision
            );
        }
    }

    /// `InverseSqrt`'s domain excludes `x <= 0` (`TCU_NAN`) - a negative argument must
    /// admit NaN.
    #[test]
    fn inverse_sqrt_reference_admits_nan_outside_its_domain() {
        let highp = precision_format(Precision::HighP);
        let neg = highp.convert(highp.round_out_point(-4.0, false));
        assert!(unary_reference(UnaryOp::InverseSqrt, highp, Precision::HighP, neg).has_nan());
    }

    /// `Exp2`/`Log2` are exact inverses at an ordinary point: `log2(8) == 3`,
    /// `exp2(3) == 8`.
    #[test]
    fn exp2_and_log2_reference_match_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let eight = highp.convert(highp.round_out_point(8.0, false));
        let l = unary_reference(UnaryOp::Log2, highp, Precision::HighP, eight);
        assert!(l.contains(3.0), "expected log2(8) == 3 in [{}, {}]", l.lo(), l.hi());

        let three = highp.convert(highp.round_out_point(3.0, false));
        let e = unary_reference(UnaryOp::Exp2, highp, Precision::HighP, three);
        assert!(e.contains(8.0), "expected exp2(3) == 8 in [{}, {}]", e.lo(), e.hi());
    }

    /// `Pow = exp2(y * log2(x))` - `pow(2, 10) == 1024`.
    #[test]
    fn pow_reference_matches_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let two = highp.convert(highp.round_out_point(2.0, false));
        let ten = highp.convert(highp.round_out_point(10.0, false));
        let r = pow_reference(highp, Precision::HighP, two, ten);
        assert!(r.contains(1024.0), "expected 2^10 == 1024 in [{}, {}]", r.lo(), r.hi());
    }

    /// `ASinh`/`ACosh` at an ordinary point, cross-checked against `f64`'s own
    /// `asinh`/`acosh` (not ported from - these are the real transcendental functions,
    /// used here only as an independent oracle for the test itself).
    #[test]
    fn asinh_and_acosh_reference_match_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let two = highp.convert(highp.round_out_point(2.0, false));
        let r = derived_unary_reference(UnaryOp::ASinh, highp, Precision::HighP, two);
        assert!(
            r.contains(2.0f64.asinh()),
            "expected asinh(2) in [{}, {}]",
            r.lo(),
            r.hi()
        );

        let c = derived_unary_reference(UnaryOp::ACosh, highp, Precision::HighP, two);
        assert!(
            c.contains(2.0f64.acosh()),
            "expected acosh(2) in [{}, {}]",
            c.lo(),
            c.hi()
        );
    }

    /// `PreciseFunc1` family (`Abs`/`Floor`/`Trunc`/`RoundEven`/`Ceil`) - each exact
    /// (`precision()` unconditionally `0.0`) at an ordinary point that already
    /// distinguishes every one of them from the others.
    #[test]
    fn precise_func1_family_matches_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let x = highp.convert(highp.round_out_point(-2.5, false));
        assert!(unary_reference(UnaryOp::Abs, highp, Precision::HighP, x).contains(2.5));
        assert!(unary_reference(UnaryOp::Floor, highp, Precision::HighP, x).contains(-3.0));
        assert!(unary_reference(UnaryOp::Trunc, highp, Precision::HighP, x).contains(-2.0));
        assert!(unary_reference(UnaryOp::Ceil, highp, Precision::HighP, x).contains(-2.0));
        // `roundEven(-2.5) == -2.0` (ties to even), distinguishing it from plain `Round`
        // below, which legally admits *both* `-2.0` and `-3.0` at this exact halfway
        // point.
        assert!(unary_reference(UnaryOp::RoundEven, highp, Precision::HighP, x).contains(-2.0));
    }

    /// `Sign` - `deSign`'s three-way shape, plus the zero/NaN passthrough `signum()`
    /// alone would get wrong.
    #[test]
    fn sign_reference_matches_de_sign_including_at_zero() {
        let highp = precision_format(Precision::HighP);
        let pos = highp.convert(highp.round_out_point(3.0, false));
        assert!(unary_reference(UnaryOp::Sign, highp, Precision::HighP, pos).contains(1.0));
        let neg = highp.convert(highp.round_out_point(-3.0, false));
        assert!(unary_reference(UnaryOp::Sign, highp, Precision::HighP, neg).contains(-1.0));
        let zero = highp.convert(highp.round_out_point(0.0, false));
        assert!(unary_reference(UnaryOp::Sign, highp, Precision::HighP, zero).contains(0.0));
    }

    /// `Round` at an exact halfway point legally admits *both* neighbouring integers
    /// (GLSL leaves round-half behaviour implementation-defined) - `round(2.5)` must
    /// contain both `2.0` and `3.0`. Away from a halfway point there is exactly one
    /// legal answer.
    #[test]
    fn round_reference_admits_both_neighbours_at_a_halfway_point_only() {
        let highp = precision_format(Precision::HighP);
        let half = highp.convert(highp.round_out_point(2.5, false));
        let r = unary_reference(UnaryOp::Round, highp, Precision::HighP, half);
        assert!(
            r.contains(2.0) && r.contains(3.0),
            "expected both 2.0 and 3.0 in [{}, {}]",
            r.lo(),
            r.hi()
        );

        let ordinary = highp.convert(highp.round_out_point(2.3, false));
        let r2 = unary_reference(UnaryOp::Round, highp, Precision::HighP, ordinary);
        assert!(
            r2.contains(2.0) && !r2.contains(3.0),
            "expected only 2.0 in [{}, {}]",
            r2.lo(),
            r2.hi()
        );
    }

    /// Regression test for the real bug this batch's llvmpipe run + `diff_vs_deqp`
    /// caught: `round(+-inf)` must stay `+-inf`, not fall through to an empty interval.
    /// `f64::fract()` is a plain `self - self.trunc()`, which for infinite `x` is
    /// `inf - inf == NaN` - unlike C's `modf`, which special-cases infinity to a `0`
    /// fractional part. Before the fix this reported `QualityWarning` rather than
    /// `Fail` only because the warning range defaults to unbounded, which is why the
    /// bug survived `cargo test` and was caught only by the real driver + upstream
    /// diff, not by a unit test - hence adding it here now.
    #[test]
    fn round_reference_handles_infinite_input() {
        let highp = precision_format(Precision::HighP);
        let neg_inf = highp.convert(highp.round_out_point(f64::NEG_INFINITY, false));
        let r = unary_reference(UnaryOp::Round, highp, Precision::HighP, neg_inf);
        assert!(
            r.contains(f64::NEG_INFINITY),
            "expected round(-inf) == -inf, got [{}, {}]",
            r.lo(),
            r.hi()
        );

        let pos_inf = highp.convert(highp.round_out_point(f64::INFINITY, false));
        let r2 = unary_reference(UnaryOp::Round, highp, Precision::HighP, pos_inf);
        assert!(
            r2.contains(f64::INFINITY),
            "expected round(inf) == inf, got [{}, {}]",
            r2.lo(),
            r2.hi()
        );
    }

    /// `Fract = x - floor(x)` - `fract(2.75) == 0.75`.
    #[test]
    fn fract_reference_matches_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let x = highp.convert(highp.round_out_point(2.75, false));
        let r = derived_unary_reference(UnaryOp::Fract, highp, Precision::HighP, x);
        assert!(r.contains(0.75), "expected 0.75 in [{}, {}]", r.lo(), r.hi());
    }

    /// `Mod(x, y) = x - y * floor(x / y)` - `mod(5.5, 2.0) == 1.5`.
    #[test]
    fn mod_reference_matches_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let x = highp.convert(highp.round_out_point(5.5, false));
        let y = highp.convert(highp.round_out_point(2.0, false));
        let r = mod_reference(highp, Precision::HighP, x, y);
        assert!(r.contains(1.5), "expected 1.5 in [{}, {}]", r.lo(), r.hi());
    }

    /// `Step(edge, x) = x < edge ? 0.0 : 1.0` - exact on both sides of the edge.
    #[test]
    fn step_reference_matches_the_exact_value_on_both_sides() {
        let highp = precision_format(Precision::HighP);
        let edge = highp.convert(highp.round_out_point(1.0, false));
        let below = highp.convert(highp.round_out_point(0.5, false));
        let above = highp.convert(highp.round_out_point(1.5, false));
        assert!(binary_reference(BinaryOp::Step, highp, Precision::HighP, edge, below).contains(0.0));
        assert!(binary_reference(BinaryOp::Step, highp, Precision::HighP, edge, above).contains(1.0));
    }

    /// `Mix(x, y, a) = x*(1-a) + y*a` (interpolation) - `mix(2.0, 10.0, 0.25) == 4.0`.
    #[test]
    fn mix_reference_matches_the_exact_value() {
        let highp = precision_format(Precision::HighP);
        let x = highp.convert(highp.round_out_point(2.0, false));
        let y = highp.convert(highp.round_out_point(10.0, false));
        let a = highp.convert(highp.round_out_point(0.25, false));
        let r = mix_reference(highp, Precision::HighP, x, y, a);
        assert!(r.contains(4.0), "expected 4.0 in [{}, {}]", r.lo(), r.hi());
    }

    /// `SmoothStep(0, 1, 0.5) == 0.5` (the midpoint of the Hermite curve is always
    /// exactly `0.5`, regardless of the edge values, since `t == 0.5` there and
    /// `t*t*(3-2t)` at `t=0.5` is `0.25 * 2 == 0.5`) - `smoothstep(0, 1, 1.0) == 1.0` at
    /// the upper edge, where `t` saturates to `1`.
    #[test]
    fn smoothstep_reference_matches_the_exact_value_at_known_points() {
        let highp = precision_format(Precision::HighP);
        let edge0 = highp.convert(highp.round_out_point(0.0, false));
        let edge1 = highp.convert(highp.round_out_point(1.0, false));

        let mid = highp.convert(highp.round_out_point(0.5, false));
        let r = smoothstep_reference(highp, Precision::HighP, edge0, edge1, mid);
        assert!(r.contains(0.5), "expected 0.5 in [{}, {}]", r.lo(), r.hi());

        let at_edge1 = highp.convert(highp.round_out_point(1.0, false));
        let r2 = smoothstep_reference(highp, Precision::HighP, edge0, edge1, at_edge1);
        assert!(r2.contains(1.0), "expected 1.0 in [{}, {}]", r2.lo(), r2.hi());
    }
}

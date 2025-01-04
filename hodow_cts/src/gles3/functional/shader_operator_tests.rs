// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderOperatorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Ported: `angle_and_trigonometry`, `exponential`, `common_functions`, `geometric`,
// `float_compare`, `int_compare`, `bool_compare`, `unary_operator` (all 11 of upstream's
// 11 sub-groups, now including the 16 symbolic `minus`/`UGT` cases below), `binary_operator`,
// `selection` and `sequence`. `common_functions`'
// `min`/`max`/`clamp` int/uint overloads are what need `build_case`'s `has_reference`
// branch - a *second*, highp reference expression plus the bit-diff masking that decides
// how many of the advertised lowp/mediump bits the driver actually used (`hasReference` in
// upstream's `ShaderOperatorCase::setupShaderData`; see that function for the full
// "outOfRangeMask" derivation, ported near-verbatim in `build_case` below). `resultMask`
// (`FloatScalar::getValueMask`) is always 0 in every group here, because every
// `result_scale`/`result_bias` this masking branch itself reads is a plain constant - only
// a *symbolic* one ever yields a nonzero mask, and no group needs the masking branch for one
// (the two symbolic entries below use `PRECMASK_LOWP`/`PRECMASK_MEDIUMP`, so they go through
// the masking branch too, just with a resolved-not-constant scale/bias) - so that part of
// the upstream masking is skipped rather than implemented-and-dead.
//
// `unary_operator`'s "minus" on `UGT` at `PRECMASK_LOWP`/`PRECMASK_MEDIUMP` (16 cases,
// `BuiltinOperInfoSeparateRefScaleBias` upstream) are the *only* `FloatScalar` symbol use in
// this whole file - a full grep of upstream's `ShaderOperatorTests::init` for `SYMBOL_`
// finds exactly those two call sites and *zero* anywhere in `binary_operator`, including its
// mod/bitwise/shift entries, which all restrict their ranges to a plain constant instead.
// `UNARY_OPERATOR_FUNCS` itself still skips them (its own comment marks exactly where), but
// `add_unary_minus_uint_symbolic_cases`/`SymbolicUnaryMinusUintCase` add them separately:
// resolving a `FloatScalar` symbol needs `glGetShaderPrecisionFormat`, which nothing at
// registration time has a driver to ask, so each is its own small `TestCase` that defers to
// `build_case` (given an added `reference_scale_bias` override parameter, `None` at every
// other call site in this file, unused otherwise) on its own first `iterate()`, once a live
// `Context` can answer it - see `SymbolicUnaryMinusUintCase`'s own doc comment for the math.
// `binary_operator` needed one genuinely new mechanism: `Operand::Uint`, split out from
// the old shared-with-`Int` variant, because its highp entries run uint ranges up to 4e9 -
// past `i32::MAX` - and the wraparound `add`/`sub`/`mul`/`negate`/shift arithmetic has to
// operate on the operand's *real* bit width (see `Operand`'s own doc comment) to match
// what the driver's GLSL actually computes, the same way upstream's own `add`/`sub`/`mul`
// go through an `int64_t` intermediate specifically to avoid this.
//
// NOT ported: the (commented-out, never enabled upstream either) `matrix` group.
// `selection`/`sequence` use no `FloatScalar` symbol either (confirmed the same way as
// `unary_operator`/`binary_operator` above) and needed no new mechanism beyond two new
// registration functions (`add_selection_cases`/`add_sequence_cases`) plus their own `Func`
// variants - both reuse `build_case`/`ShaderDataSpec` unchanged.

use std::sync::OnceLock;

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::shader_util::{DataType, Precision};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw;
use crate::tcu::TestOutcome;
use crate::tcu::matrix::Mat4;
use crate::tcu::vector::Vec4;

/// `MAX_INPUTS`
const MAX_INPUTS: usize = 3;

/// `s_inSwizzles` - per input index, the component order to read at each scalar size.
const S_IN_SWIZZLES: [[&[usize]; 4]; MAX_INPUTS] = [
    [&[2], &[3, 1], &[2, 0, 1], &[1, 2, 3, 0]],
    [&[0], &[1, 0], &[1, 2, 0], &[3, 2, 1, 0]],
    [&[1], &[2, 1], &[3, 1, 2], &[0, 3, 2, 1]],
];

/// `s_outSwizzles` - where a result of each scalar size lands in the output colour.
const S_OUT_SWIZZLES: [&[usize]; 4] = [&[0], &[1, 2], &[0, 1, 2], &[0, 1, 2, 3]];

/// `s_inSwizzles`, as the shader spells them.
const SWIZZLE_NAMES: [[&str; 4]; MAX_INPUTS] = [
    ["z", "wy", "zxy", "yzwx"],
    ["x", "yx", "yzx", "wzyx"],
    ["y", "zy", "wyz", "xwzy"],
];

/// `s_outSwizzles`, as the shader spells them.
const OUT_SWIZZLE_NAMES: [&str; 4] = ["x", "yz", "xyz", "xyzw"];

/// `PrecisionMask`
const PRECMASK_NA: u32 = 0;
const PRECMASK_LOWP: u32 = 1 << 0;
const PRECMASK_MEDIUMP: u32 = 1 << 1;
const PRECMASK_HIGHP: u32 = 1 << 2;
const PRECMASK_MEDIUMP_HIGHP: u32 = PRECMASK_MEDIUMP | PRECMASK_HIGHP;
const PRECMASK_LOWP_MEDIUMP: u32 = PRECMASK_LOWP | PRECMASK_MEDIUMP;
const PRECMASK_ALL: u32 = PRECMASK_LOWP | PRECMASK_MEDIUMP | PRECMASK_HIGHP;

const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

fn precision_bit(precision: Precision) -> u32 {
    match precision {
        Precision::LowP => PRECMASK_LOWP,
        Precision::MediumP => PRECMASK_MEDIUMP,
        Precision::HighP => PRECMASK_HIGHP,
    }
}

/// `ValueType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum ValueType {
    None,
    Float,
    FloatVec,
    FloatGenType,
    Vec3,
    Bool,
    BoolVec,
    BoolGenType,
    Int,
    IntVec,
    IntGenType,
    Uint,
    UintVec,
    UintGenType,
}

// Upstream's shorthands, used verbatim in the tables below.
use ValueType::{
    Bool as B, BoolGenType as BGT, BoolVec as BV, Float as F, FloatGenType as GT, FloatVec as FV, Int as I,
    IntGenType as IGT, IntVec as IV, Uint as U, UintGenType as UGT, UintVec as UV, Vec3 as V3,
};

impl ValueType {
    /// `isScalarType`
    fn is_scalar(self) -> bool {
        matches!(self, Self::Float | Self::Bool | Self::Int | Self::Uint)
    }

    fn is_int(self) -> bool {
        matches!(self, Self::Int | Self::IntVec | Self::IntGenType)
    }

    fn is_uint(self) -> bool {
        matches!(self, Self::Uint | Self::UintVec | Self::UintGenType)
    }
}

/// `Value` (the `FloatScalar rangeMin/rangeMax` pair, restricted to the constant case -
/// see the file header for why no group here needs the symbolic one).
#[derive(Clone, Copy)]
struct Value {
    value_type: ValueType,
    range_min: f32,
    range_max: f32,
}

const fn v(value_type: ValueType, range_min: f32, range_max: f32) -> Value {
    Value {
        value_type,
        range_min,
        range_max,
    }
}

/// `notUsed`
const NOT_USED: Value = v(ValueType::None, 0.0, 0.0);

/// `OperationType` - every group ported here is `FUNCTION`; the other two variants are
/// kept so `add_func_cases`'s shape matches upstream's loop, ready for `binary_operator`.
#[derive(Clone, Copy, PartialEq, Eq)]
enum OperationType {
    Function,
    Operator,
    #[allow(dead_code)]
    SideEffectOperator,
}

/// Which input scalar sizes upstream declares an `eval_*` function for.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Sizes {
    /// `*_GENTYPE_FUNCS` - scalar through vec4.
    All,
    /// `*_VEC_FUNCS` - vec2 through vec4, the scalar entry being null.
    VecOnly,
    /// `cross`, whose only evaluator is the vec3 one.
    Vec3Only,
    /// `BOOL_FUNCS` - `unary_operator`'s `not`, whose only evaluator is the scalar one.
    ScalarOnly,
}

impl Sizes {
    fn has(self, in_scalar_size: i32) -> bool {
        match self {
            Self::All => true,
            Self::VecOnly => in_scalar_size >= 2,
            Self::Vec3Only => in_scalar_size == 3,
            Self::ScalarOnly => in_scalar_size == 1,
        }
    }
}

use Sizes::{All as ALL_SIZES, ScalarOnly as SCALAR_ONLY, Vec3Only as VEC3_ONLY, VecOnly as VEC_ONLY};

/// The operation an evaluator applies.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Func {
    BoolNot,
    LessThan,
    LessThanEqual,
    GreaterThan,
    GreaterThanEqual,
    Equal,
    NotEqual,
    Any,
    All,
    /// `allEqual`/`anyNotEqual` - `unary_operator`/`binary_operator`'s scalar-bool-result
    /// `==`/`!=` on a gentype, unlike `Equal`/`NotEqual` above (which produce a per-lane
    /// `bvecN`, for the `lessThan`-style vector functions).
    AllEqual,
    AnyNotEqual,
    LogicalAnd,
    LogicalOr,
    LogicalXor,

    /// `nop` - unary `+`.
    Nop,
    /// `negate` - unary `-`.
    Negate,
    /// `bitwiseNot` - unary `~`.
    BitwiseNot,
    /// `addOne`/`subOne` - the pre/post increment/decrement operators' side effect.
    AddOne,
    SubOne,

    Add,
    Sub,
    Mul,
    Div,
    BitwiseAnd,
    BitwiseOr,
    BitwiseXor,
    LeftShift,
    RightShift,

    Radians,
    Degrees,
    Sin,
    Cos,
    Tan,
    Asin,
    Acos,
    Atan,
    Atan2,
    Sinh,
    Cosh,
    Tanh,
    Asinh,
    Acosh,
    Atanh,

    Pow,
    Exp,
    Log,
    Exp2,
    Log2,
    Sqrt,
    InverseSqrt,

    Length,
    Distance,
    Dot,
    Cross,
    Normalize,
    FaceForward,
    Reflect,
    Refract,

    Abs,
    Sign,
    Floor,
    Trunc,
    RoundToEven,
    Ceil,
    Fract,
    Mod,
    Min,
    Max,
    Clamp,
    Mix,
    Step,
    SmoothStep,

    /// `selection` - the `?:` ternary operator, uniform across every one of its 16 types
    /// (`ins[0]` is always a scalar `bool`; `ins[1]`/`ins[2]` share `ins[0]`'s output family).
    Selection,

    /// `sequence` - the `,` operator. Each of upstream's 8 `s_sequenceCases` entries has its
    /// own hand-written reference formula (`sequenceNoSideEffCaseN`/`sequenceSideEffCaseN`),
    /// not a single generic shape the way `selection` has - see `apply`'s own match arms.
    SeqNoSideEff0,
    SeqNoSideEff1,
    SeqNoSideEff2,
    SeqNoSideEff3,
    SeqSideEff0,
    SeqSideEff1,
    SeqSideEff2,
    SeqSideEff3,
}

/// `BuiltinFuncInfo`
#[derive(Clone, Copy)]
struct BuiltinFuncInfo {
    case_name: &'static str,
    shader_func_name: &'static str,
    out_value: ValueType,
    inputs: [Value; MAX_INPUTS],
    result_scale: f32,
    result_bias: f32,
    precision_mask: u32,
    func: Func,
    sizes: Sizes,
    type_: OperationType,
    /// `isUnaryPrefix` - whether a unary operator is a prefix operator; redundant unless
    /// unary. Irrelevant (left `true`) for `OperationType::Function`.
    is_unary_prefix: bool,
}

/// `BuiltinFuncInfo(...)` with the default `FUNCTION` type.
#[allow(clippy::too_many_arguments)]
const fn func_info(
    case_name: &'static str,
    shader_func_name: &'static str,
    out_value: ValueType,
    input0: Value,
    input1: Value,
    input2: Value,
    result_scale: f32,
    result_bias: f32,
    precision_mask: u32,
    func: Func,
    sizes: Sizes,
) -> BuiltinFuncInfo {
    BuiltinFuncInfo {
        case_name,
        shader_func_name,
        out_value,
        inputs: [input0, input1, input2],
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        type_: OperationType::Function,
        is_unary_prefix: true,
    }
}

/// `BuiltinOperInfo` - operator syntax (`res = a <op> b;`), prefix when unary.
#[allow(clippy::too_many_arguments)]
const fn op_info(
    case_name: &'static str,
    shader_func_name: &'static str,
    out_value: ValueType,
    input0: Value,
    input1: Value,
    input2: Value,
    result_scale: f32,
    result_bias: f32,
    precision_mask: u32,
    func: Func,
    sizes: Sizes,
) -> BuiltinFuncInfo {
    BuiltinFuncInfo {
        case_name,
        shader_func_name,
        out_value,
        inputs: [input0, input1, input2],
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        type_: OperationType::Operator,
        is_unary_prefix: true,
    }
}

/// `BuiltinPostOperInfo` - postfix unary operator syntax (`res = in0<op>;`).
#[allow(clippy::too_many_arguments)]
const fn post_op_info(
    case_name: &'static str,
    shader_func_name: &'static str,
    out_value: ValueType,
    input0: Value,
    input1: Value,
    input2: Value,
    result_scale: f32,
    result_bias: f32,
    precision_mask: u32,
    func: Func,
    sizes: Sizes,
) -> BuiltinFuncInfo {
    BuiltinFuncInfo {
        case_name,
        shader_func_name,
        out_value,
        inputs: [input0, input1, input2],
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        type_: OperationType::Operator,
        is_unary_prefix: false,
    }
}

/// `BuiltinSideEffOperInfo` - tests a side-effect operator's mutation of its own operand
/// (`res = in0;\n<op>res;` for a prefix unary op, `res = in0;\nres <op>= in1;` for a
/// binary assignment op), not the expression's own result.
#[allow(clippy::too_many_arguments)]
const fn side_eff_op_info(
    case_name: &'static str,
    shader_func_name: &'static str,
    out_value: ValueType,
    input0: Value,
    input1: Value,
    input2: Value,
    result_scale: f32,
    result_bias: f32,
    precision_mask: u32,
    func: Func,
    sizes: Sizes,
) -> BuiltinFuncInfo {
    BuiltinFuncInfo {
        case_name,
        shader_func_name,
        out_value,
        inputs: [input0, input1, input2],
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        type_: OperationType::SideEffectOperator,
        is_unary_prefix: true,
    }
}

/// `BuiltinPostSideEffOperInfo` - postfix unary side-effect (`res = in0;\nres<op>;`).
#[allow(clippy::too_many_arguments)]
const fn post_side_eff_op_info(
    case_name: &'static str,
    shader_func_name: &'static str,
    out_value: ValueType,
    input0: Value,
    input1: Value,
    input2: Value,
    result_scale: f32,
    result_bias: f32,
    precision_mask: u32,
    func: Func,
    sizes: Sizes,
) -> BuiltinFuncInfo {
    BuiltinFuncInfo {
        case_name,
        shader_func_name,
        out_value,
        inputs: [input0, input1, input2],
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        type_: OperationType::SideEffectOperator,
        is_unary_prefix: false,
    }
}

/// `BuiltinFuncGroup`
struct BuiltinFuncGroup {
    name: &'static str,
    func_infos: Vec<BuiltinFuncInfo>,
}

/// `unary_operator` - upstream's `minus` on `UGT` at `PRECMASK_LOWP`/`PRECMASK_MEDIUMP`
/// (2 of upstream's entries, 16 cases) are the *only* `FloatScalar` symbol use in this
/// whole file (`unary_operator` or `binary_operator`) - confirmed by grepping upstream for
/// `SYMBOL_` outside the `FloatScalar` class itself. Both need `glGetShaderPrecisionFormat`,
/// which nothing at *registration* time has - skipped here, added separately by
/// `add_unary_minus_uint_symbolic_cases` (see the file header and that function's own doc
/// comment). The `PRECMASK_HIGHP` variant of the same `minus` uses a plain constant and is
/// ported normally, right below. Everything else - all of `binary_operator` included -
/// needs no symbol at all.
const UNARY_OPERATOR_FUNCS: &[BuiltinFuncInfo] = &[
    op_info(
        "plus",
        "+",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    op_info(
        "plus",
        "+",
        IGT,
        v(IGT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    op_info(
        "plus",
        "+",
        UGT,
        v(UGT, 0.0, 2e2),
        NOT_USED,
        NOT_USED,
        5e-3,
        0.0,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    op_info(
        "minus",
        "-",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Negate,
        ALL_SIZES,
    ),
    op_info(
        "minus",
        "-",
        IGT,
        v(IGT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Negate,
        ALL_SIZES,
    ),
    // Two `PRECMASK_LOWP`/`PRECMASK_MEDIUMP` `minus`/`UGT` entries skipped here - see above.
    op_info(
        "minus",
        "-",
        UGT,
        v(UGT, 0.0, 4e9),
        NOT_USED,
        NOT_USED,
        2e-10,
        0.0,
        PRECMASK_HIGHP,
        Func::Negate,
        ALL_SIZES,
    ),
    op_info(
        "not",
        "!",
        B,
        v(B, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::BoolNot,
        SCALAR_ONLY,
    ),
    op_info(
        "bitwise_not",
        "~",
        IGT,
        v(IGT, -1e5, 1e5),
        NOT_USED,
        NOT_USED,
        5e-5,
        0.5,
        PRECMASK_HIGHP,
        Func::BitwiseNot,
        ALL_SIZES,
    ),
    op_info(
        "bitwise_not",
        "~",
        UGT,
        v(UGT, 0.0, 2e9),
        NOT_USED,
        NOT_USED,
        2e-10,
        0.0,
        PRECMASK_HIGHP,
        Func::BitwiseNot,
        ALL_SIZES,
    ),
    // Pre/post incr/decr side-effect cases.
    side_eff_op_info(
        "pre_increment_effect",
        "++",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.0,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    side_eff_op_info(
        "pre_increment_effect",
        "++",
        IGT,
        v(IGT, -6.0, 4.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    side_eff_op_info(
        "pre_increment_effect",
        "++",
        UGT,
        v(UGT, 0.0, 9.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    side_eff_op_info(
        "pre_decrement_effect",
        "--",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        1.0,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    side_eff_op_info(
        "pre_decrement_effect",
        "--",
        IGT,
        v(IGT, -4.0, 6.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    side_eff_op_info(
        "pre_decrement_effect",
        "--",
        UGT,
        v(UGT, 1.0, 10.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    post_side_eff_op_info(
        "post_increment_effect",
        "++",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.0,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    post_side_eff_op_info(
        "post_increment_effect",
        "++",
        IGT,
        v(IGT, -6.0, 4.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    post_side_eff_op_info(
        "post_increment_effect",
        "++",
        UGT,
        v(UGT, 0.0, 9.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    post_side_eff_op_info(
        "post_decrement_effect",
        "--",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        1.0,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    post_side_eff_op_info(
        "post_decrement_effect",
        "--",
        IGT,
        v(IGT, -4.0, 6.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    post_side_eff_op_info(
        "post_decrement_effect",
        "--",
        UGT,
        v(UGT, 1.0, 10.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    // Pre/post incr/decr result cases.
    op_info(
        "pre_increment_result",
        "++",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.0,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    op_info(
        "pre_increment_result",
        "++",
        IGT,
        v(IGT, -6.0, 4.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    op_info(
        "pre_increment_result",
        "++",
        UGT,
        v(UGT, 0.0, 9.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::AddOne,
        ALL_SIZES,
    ),
    op_info(
        "pre_decrement_result",
        "--",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        1.0,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    op_info(
        "pre_decrement_result",
        "--",
        IGT,
        v(IGT, -4.0, 6.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    op_info(
        "pre_decrement_result",
        "--",
        UGT,
        v(UGT, 1.0, 10.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::SubOne,
        ALL_SIZES,
    ),
    post_op_info(
        "post_increment_result",
        "++",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    post_op_info(
        "post_increment_result",
        "++",
        IGT,
        v(IGT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    post_op_info(
        "post_increment_result",
        "++",
        UGT,
        v(UGT, 0.0, 9.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    post_op_info(
        "post_decrement_result",
        "--",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    post_op_info(
        "post_decrement_result",
        "--",
        IGT,
        v(IGT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
    post_op_info(
        "post_decrement_result",
        "--",
        UGT,
        v(UGT, 1.0, 10.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.0,
        PRECMASK_ALL,
        Func::Nop,
        ALL_SIZES,
    ),
];

/// 8.1 Angle and Trigonometry Functions.
const ANGLE_AND_TRIGONOMETRY_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "radians",
        "radians",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        25.0,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Radians,
        ALL_SIZES,
    ),
    func_info(
        "degrees",
        "degrees",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        0.04,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Degrees,
        ALL_SIZES,
    ),
    func_info(
        "sin",
        "sin",
        GT,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Sin,
        ALL_SIZES,
    ),
    func_info(
        "sin",
        "sin",
        GT,
        v(GT, -1.5, 1.5),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_LOWP,
        Func::Sin,
        ALL_SIZES,
    ),
    func_info(
        "cos",
        "cos",
        GT,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Cos,
        ALL_SIZES,
    ),
    func_info(
        "cos",
        "cos",
        GT,
        v(GT, -1.5, 1.5),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_LOWP,
        Func::Cos,
        ALL_SIZES,
    ),
    func_info(
        "tan",
        "tan",
        GT,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Tan,
        ALL_SIZES,
    ),
    func_info(
        "tan",
        "tan",
        GT,
        v(GT, -1.5, 5.5),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_LOWP,
        Func::Tan,
        ALL_SIZES,
    ),
    func_info(
        "asin",
        "asin",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Asin,
        ALL_SIZES,
    ),
    func_info(
        "acos",
        "acos",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Acos,
        ALL_SIZES,
    ),
    func_info(
        "atan",
        "atan",
        GT,
        v(GT, -4.0, 4.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Atan,
        ALL_SIZES,
    ),
    func_info(
        "atan2",
        "atan",
        GT,
        v(GT, -4.0, 4.0),
        v(GT, 0.5, 2.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Atan2,
        ALL_SIZES,
    ),
    func_info(
        "sinh",
        "sinh",
        GT,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Sinh,
        ALL_SIZES,
    ),
    func_info(
        "sinh",
        "sinh",
        GT,
        v(GT, -1.5, 1.5),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_LOWP,
        Func::Sinh,
        ALL_SIZES,
    ),
    func_info(
        "cosh",
        "cosh",
        GT,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Cosh,
        ALL_SIZES,
    ),
    func_info(
        "cosh",
        "cosh",
        GT,
        v(GT, -1.5, 1.5),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_LOWP,
        Func::Cosh,
        ALL_SIZES,
    ),
    func_info(
        "tanh",
        "tanh",
        GT,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Tanh,
        ALL_SIZES,
    ),
    func_info(
        "tanh",
        "tanh",
        GT,
        v(GT, -1.5, 5.5),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_LOWP,
        Func::Tanh,
        ALL_SIZES,
    ),
    func_info(
        "asinh",
        "asinh",
        GT,
        v(GT, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Asinh,
        ALL_SIZES,
    ),
    func_info(
        "acosh",
        "acosh",
        GT,
        v(GT, 1.0, 2.2),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Acosh,
        ALL_SIZES,
    ),
    func_info(
        "atanh",
        "atanh",
        GT,
        v(GT, -0.99, 0.99),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Atanh,
        ALL_SIZES,
    ),
];

/// 8.2 Exponential Functions.
const EXPONENTIAL_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "pow",
        "pow",
        GT,
        v(GT, 0.1, 8.0),
        v(GT, -4.0, 2.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Pow,
        ALL_SIZES,
    ),
    func_info(
        "exp",
        "exp",
        GT,
        v(GT, -6.0, 3.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Exp,
        ALL_SIZES,
    ),
    func_info(
        "log",
        "log",
        GT,
        v(GT, 0.1, 10.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.3,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Log,
        ALL_SIZES,
    ),
    func_info(
        "exp2",
        "exp2",
        GT,
        v(GT, -7.0, 2.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Exp2,
        ALL_SIZES,
    ),
    func_info(
        "log2",
        "log2",
        GT,
        v(GT, 0.1, 10.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Log2,
        ALL_SIZES,
    ),
    func_info(
        "sqrt",
        "sqrt",
        GT,
        v(GT, 0.0, 10.0),
        NOT_USED,
        NOT_USED,
        0.3,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Sqrt,
        ALL_SIZES,
    ),
    func_info(
        "inversesqrt",
        "inversesqrt",
        GT,
        v(GT, 0.5, 10.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_MEDIUMP_HIGHP,
        Func::InverseSqrt,
        ALL_SIZES,
    ),
];

/// 8.3 Common Functions.
const COMMON_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "abs",
        "abs",
        GT,
        v(GT, -2.0, 2.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Abs,
        ALL_SIZES,
    ),
    func_info(
        "sign",
        "sign",
        GT,
        v(GT, -1.5, 1.5),
        NOT_USED,
        NOT_USED,
        0.3,
        0.5,
        PRECMASK_ALL,
        Func::Sign,
        ALL_SIZES,
    ),
    func_info(
        "floor",
        "floor",
        GT,
        v(GT, -2.5, 2.5),
        NOT_USED,
        NOT_USED,
        0.2,
        0.7,
        PRECMASK_ALL,
        Func::Floor,
        ALL_SIZES,
    ),
    func_info(
        "trunc",
        "trunc",
        GT,
        v(GT, -2.5, 2.5),
        NOT_USED,
        NOT_USED,
        0.2,
        0.7,
        PRECMASK_ALL,
        Func::Trunc,
        ALL_SIZES,
    ),
    func_info(
        "round",
        "round",
        GT,
        v(GT, -2.5, 2.5),
        NOT_USED,
        NOT_USED,
        0.2,
        0.7,
        PRECMASK_ALL,
        Func::RoundToEven,
        ALL_SIZES,
    ),
    func_info(
        "roundEven",
        "roundEven",
        GT,
        v(GT, -2.5, 2.5),
        NOT_USED,
        NOT_USED,
        0.2,
        0.7,
        PRECMASK_ALL,
        Func::RoundToEven,
        ALL_SIZES,
    ),
    func_info(
        "ceil",
        "ceil",
        GT,
        v(GT, -2.5, 2.5),
        NOT_USED,
        NOT_USED,
        0.2,
        0.5,
        PRECMASK_ALL,
        Func::Ceil,
        ALL_SIZES,
    ),
    func_info(
        "fract",
        "fract",
        GT,
        v(GT, -1.5, 1.5),
        NOT_USED,
        NOT_USED,
        0.8,
        0.1,
        PRECMASK_ALL,
        Func::Fract,
        ALL_SIZES,
    ),
    func_info(
        "mod",
        "mod",
        GT,
        v(GT, -2.0, 2.0),
        v(GT, 0.9, 6.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Mod,
        ALL_SIZES,
    ),
    func_info(
        "mod",
        "mod",
        GT,
        v(FV, -2.0, 2.0),
        v(F, 0.9, 6.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Mod,
        VEC_ONLY,
    ),
    func_info(
        "min",
        "min",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Min,
        ALL_SIZES,
    ),
    func_info(
        "min",
        "min",
        GT,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Min,
        VEC_ONLY,
    ),
    func_info(
        "min",
        "min",
        IGT,
        v(IGT, -4.0, 4.0),
        v(IGT, -4.0, 4.0),
        NOT_USED,
        0.125,
        0.5,
        PRECMASK_ALL,
        Func::Min,
        ALL_SIZES,
    ),
    func_info(
        "min",
        "min",
        IGT,
        v(IV, -4.0, 4.0),
        v(I, -4.0, 4.0),
        NOT_USED,
        0.125,
        0.5,
        PRECMASK_ALL,
        Func::Min,
        VEC_ONLY,
    ),
    func_info(
        "min",
        "min",
        UGT,
        v(UGT, 0.0, 8.0),
        v(UGT, 0.0, 8.0),
        NOT_USED,
        0.125,
        0.0,
        PRECMASK_ALL,
        Func::Min,
        ALL_SIZES,
    ),
    func_info(
        "min",
        "min",
        UGT,
        v(UV, 0.0, 8.0),
        v(U, 0.0, 8.0),
        NOT_USED,
        0.125,
        0.0,
        PRECMASK_ALL,
        Func::Min,
        VEC_ONLY,
    ),
    func_info(
        "max",
        "max",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Max,
        ALL_SIZES,
    ),
    func_info(
        "max",
        "max",
        GT,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Max,
        VEC_ONLY,
    ),
    func_info(
        "max",
        "max",
        IGT,
        v(IGT, -4.0, 4.0),
        v(IGT, -4.0, 4.0),
        NOT_USED,
        0.125,
        0.5,
        PRECMASK_ALL,
        Func::Max,
        ALL_SIZES,
    ),
    func_info(
        "max",
        "max",
        IGT,
        v(IV, -4.0, 4.0),
        v(I, -4.0, 4.0),
        NOT_USED,
        0.125,
        0.5,
        PRECMASK_ALL,
        Func::Max,
        VEC_ONLY,
    ),
    func_info(
        "max",
        "max",
        UGT,
        v(UGT, 0.0, 8.0),
        v(UGT, 0.0, 8.0),
        NOT_USED,
        0.125,
        0.0,
        PRECMASK_ALL,
        Func::Max,
        ALL_SIZES,
    ),
    func_info(
        "max",
        "max",
        UGT,
        v(UV, 0.0, 8.0),
        v(U, 0.0, 8.0),
        NOT_USED,
        0.125,
        0.0,
        PRECMASK_ALL,
        Func::Max,
        VEC_ONLY,
    ),
    func_info(
        "clamp",
        "clamp",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -0.5, 0.5),
        v(GT, 0.5, 1.0),
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Clamp,
        ALL_SIZES,
    ),
    func_info(
        "clamp",
        "clamp",
        GT,
        v(FV, -1.0, 1.0),
        v(F, -0.5, 0.5),
        v(F, 0.5, 1.0),
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Clamp,
        VEC_ONLY,
    ),
    func_info(
        "clamp",
        "clamp",
        IGT,
        v(IGT, -4.0, 4.0),
        v(IGT, -2.0, 2.0),
        v(IGT, 2.0, 4.0),
        0.125,
        0.5,
        PRECMASK_ALL,
        Func::Clamp,
        ALL_SIZES,
    ),
    func_info(
        "clamp",
        "clamp",
        IGT,
        v(IV, -4.0, 4.0),
        v(I, -2.0, 2.0),
        v(I, 2.0, 4.0),
        0.125,
        0.5,
        PRECMASK_ALL,
        Func::Clamp,
        VEC_ONLY,
    ),
    func_info(
        "clamp",
        "clamp",
        UGT,
        v(UGT, 0.0, 8.0),
        v(UGT, 2.0, 6.0),
        v(UGT, 6.0, 8.0),
        0.125,
        0.0,
        PRECMASK_ALL,
        Func::Clamp,
        ALL_SIZES,
    ),
    func_info(
        "clamp",
        "clamp",
        UGT,
        v(UV, 0.0, 8.0),
        v(U, 2.0, 6.0),
        v(U, 6.0, 8.0),
        0.125,
        0.0,
        PRECMASK_ALL,
        Func::Clamp,
        VEC_ONLY,
    ),
    func_info(
        "mix",
        "mix",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        v(GT, 0.0, 1.0),
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Mix,
        ALL_SIZES,
    ),
    func_info(
        "mix",
        "mix",
        GT,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        v(F, 0.0, 1.0),
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Mix,
        VEC_ONLY,
    ),
    func_info(
        "step",
        "step",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 0.0),
        NOT_USED,
        0.5,
        0.25,
        PRECMASK_ALL,
        Func::Step,
        ALL_SIZES,
    ),
    func_info(
        "step",
        "step",
        GT,
        v(F, -1.0, 1.0),
        v(FV, -1.0, 0.0),
        NOT_USED,
        0.5,
        0.25,
        PRECMASK_ALL,
        Func::Step,
        VEC_ONLY,
    ),
    func_info(
        "smoothstep",
        "smoothstep",
        GT,
        v(GT, -0.5, 0.0),
        v(GT, 0.1, 1.0),
        v(GT, -1.0, 1.0),
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::SmoothStep,
        ALL_SIZES,
    ),
    func_info(
        "smoothstep",
        "smoothstep",
        GT,
        v(F, -0.5, 0.0),
        v(F, 0.1, 1.0),
        v(FV, -1.0, 1.0),
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::SmoothStep,
        VEC_ONLY,
    ),
];

/// 8.4 Geometric Functions.
const GEOMETRIC_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "length",
        "length",
        F,
        v(GT, -5.0, 5.0),
        NOT_USED,
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Length,
        ALL_SIZES,
    ),
    func_info(
        "distance",
        "distance",
        F,
        v(GT, -5.0, 5.0),
        v(GT, -5.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Distance,
        ALL_SIZES,
    ),
    func_info(
        "dot",
        "dot",
        F,
        v(GT, -5.0, 5.0),
        v(GT, -5.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Dot,
        ALL_SIZES,
    ),
    func_info(
        "cross",
        "cross",
        V3,
        v(GT, -5.0, 5.0),
        v(GT, -5.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Cross,
        VEC3_ONLY,
    ),
    func_info(
        "normalize",
        "normalize",
        GT,
        v(GT, 0.1, 4.0),
        NOT_USED,
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Normalize,
        ALL_SIZES,
    ),
    func_info(
        "faceforward",
        "faceforward",
        GT,
        v(GT, -5.0, 5.0),
        v(GT, -5.0, 5.0),
        v(GT, -1.0, 1.0),
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::FaceForward,
        ALL_SIZES,
    ),
    func_info(
        "reflect",
        "reflect",
        GT,
        v(GT, -0.8, -0.5),
        v(GT, 0.5, 0.8),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Reflect,
        ALL_SIZES,
    ),
    func_info(
        "refract",
        "refract",
        GT,
        v(GT, -0.8, 1.2),
        v(GT, -1.1, 0.5),
        v(F, 0.2, 1.5),
        0.5,
        0.5,
        PRECMASK_MEDIUMP_HIGHP,
        Func::Refract,
        ALL_SIZES,
    ),
];

/// 8.6 Vector Relational Functions - floating point.
const FLOAT_COMPARE_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "lessThan",
        "lessThan",
        BV,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThan,
        VEC_ONLY,
    ),
    func_info(
        "lessThanEqual",
        "lessThanEqual",
        BV,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThanEqual,
        VEC_ONLY,
    ),
    func_info(
        "greaterThan",
        "greaterThan",
        BV,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThan,
        VEC_ONLY,
    ),
    func_info(
        "greaterThanEqual",
        "greaterThanEqual",
        BV,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThanEqual,
        VEC_ONLY,
    ),
    func_info(
        "equal",
        "equal",
        BV,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Equal,
        VEC_ONLY,
    ),
    func_info(
        "notEqual",
        "notEqual",
        BV,
        v(FV, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::NotEqual,
        VEC_ONLY,
    ),
];

/// 8.6 Vector Relational Functions - integer.
const INT_COMPARE_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "lessThan",
        "lessThan",
        BV,
        v(IV, -5.2, 4.9),
        v(IV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThan,
        VEC_ONLY,
    ),
    func_info(
        "lessThanEqual",
        "lessThanEqual",
        BV,
        v(IV, -5.2, 4.9),
        v(IV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThanEqual,
        VEC_ONLY,
    ),
    func_info(
        "greaterThan",
        "greaterThan",
        BV,
        v(IV, -5.2, 4.9),
        v(IV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThan,
        VEC_ONLY,
    ),
    func_info(
        "greaterThanEqual",
        "greaterThanEqual",
        BV,
        v(IV, -5.2, 4.9),
        v(IV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThanEqual,
        VEC_ONLY,
    ),
    func_info(
        "equal",
        "equal",
        BV,
        v(IV, -5.2, 4.9),
        v(IV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Equal,
        VEC_ONLY,
    ),
    func_info(
        "notEqual",
        "notEqual",
        BV,
        v(IV, -5.2, 4.9),
        v(IV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::NotEqual,
        VEC_ONLY,
    ),
];

/// 8.6 Vector Relational Functions - boolean.
const BOOL_COMPARE_FUNCS: &[BuiltinFuncInfo] = &[
    func_info(
        "equal",
        "equal",
        BV,
        v(BV, -5.2, 4.9),
        v(BV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::Equal,
        VEC_ONLY,
    ),
    func_info(
        "notEqual",
        "notEqual",
        BV,
        v(BV, -5.2, 4.9),
        v(BV, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::NotEqual,
        VEC_ONLY,
    ),
    func_info(
        "any",
        "any",
        B,
        v(BV, -1.0, 0.3),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::Any,
        VEC_ONLY,
    ),
    func_info(
        "all",
        "all",
        B,
        v(BV, -0.3, 1.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::All,
        VEC_ONLY,
    ),
    func_info(
        "not",
        "not",
        BV,
        v(BV, -1.0, 1.0),
        NOT_USED,
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::BoolNot,
        VEC_ONLY,
    ),
];

/// `binary_operator` - built at runtime, unlike every other group in this file: upstream's
/// own `for (binaryOperatorType = 0; ...; <= 2)` loop (0: normal op, 1: assignment
/// side-effect, 2: assignment result) shares each operator family's data three ways,
/// including building the `"_assign_effect"`/`"_assign_result"` case-name suffixes and the
/// `"op="` operator string at runtime - not `const`-evaluable, so this mirrors the loop
/// directly instead of writing each family out three times over. Confirmed empty of
/// `FloatScalar` symbols the same way `UNARY_OPERATOR_FUNCS` is (see its own header) - the
/// mod/bitwise/shift families all restrict their ranges instead of resolving one.
#[derive(Clone, Copy, PartialEq, Eq)]
enum BinVariant {
    Normal,
    AssignEffect,
    AssignResult,
}

fn binary_operator_funcs() -> Vec<BuiltinFuncInfo> {
    let mut out = Vec::new();

    for variant in [BinVariant::Normal, BinVariant::AssignEffect, BinVariant::AssignResult] {
        let is_normal = variant == BinVariant::Normal;
        let suffix = match variant {
            BinVariant::Normal => "",
            BinVariant::AssignEffect => "_assign_effect",
            BinVariant::AssignResult => "_assign_result",
        };
        let op_suffix = if is_normal { "" } else { "=" };

        // `operInfoFunc = isAssignEff ? BuiltinSideEffOperInfo : BuiltinOperInfo` - the
        // normal-op and assign-result variants share the constructor (only the op string
        // differs, "+" vs "+="), and only assign-effect needs the side-effect shape.
        let mk = |case: &'static str,
                  op: &'static str,
                  out_v: ValueType,
                  i0: Value,
                  i1: Value,
                  scale: f32,
                  bias: f32,
                  mask: u32,
                  func: Func,
                  sizes: Sizes|
         -> BuiltinFuncInfo {
            // Leaked once per (case, variant) at group-construction time - there are a few
            // hundred of these for the whole process lifetime, not a per-frame cost - since
            // `BuiltinFuncInfo::case_name`/`shader_func_name` are `&'static str` everywhere
            // else in this file (plain literals there; this is the one group whose names
            // are computed).
            let name: &'static str = Box::leak(format!("{case}{suffix}").into_boxed_str());
            let op_str: &'static str = Box::leak(format!("{op}{op_suffix}").into_boxed_str());
            if variant == BinVariant::AssignEffect {
                side_eff_op_info(name, op_str, out_v, i0, i1, NOT_USED, scale, bias, mask, func, sizes)
            } else {
                op_info(name, op_str, out_v, i0, i1, NOT_USED, scale, bias, mask, func, sizes)
            }
        };

        // The add operator.
        out.push(mk(
            "add",
            "+",
            GT,
            v(GT, -1.0, 1.0),
            v(GT, -1.0, 1.0),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Add,
            ALL_SIZES,
        ));
        out.push(mk(
            "add",
            "+",
            IGT,
            v(IGT, -4.0, 6.0),
            v(IGT, -6.0, 5.0),
            0.1,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Add,
            ALL_SIZES,
        ));
        out.push(mk(
            "add",
            "+",
            IGT,
            v(IGT, -2e9, 2e9),
            v(IGT, -2e9, 2e9),
            4e-10,
            0.5,
            PRECMASK_HIGHP,
            Func::Add,
            ALL_SIZES,
        ));
        out.push(mk(
            "add",
            "+",
            UGT,
            v(UGT, 0.0, 1e2),
            v(UGT, 0.0, 1e2),
            5e-3,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Add,
            ALL_SIZES,
        ));
        out.push(mk(
            "add",
            "+",
            UGT,
            v(UGT, 0.0, 4e9),
            v(UGT, 0.0, 4e9),
            2e-10,
            0.0,
            PRECMASK_HIGHP,
            Func::Add,
            ALL_SIZES,
        ));
        out.push(mk(
            "add",
            "+",
            FV,
            v(FV, -1.0, 1.0),
            v(F, -1.0, 1.0),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Add,
            VEC_ONLY,
        ));
        out.push(mk(
            "add",
            "+",
            IV,
            v(IV, -4.0, 6.0),
            v(I, -6.0, 5.0),
            0.1,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Add,
            VEC_ONLY,
        ));
        out.push(mk(
            "add",
            "+",
            IV,
            v(IV, -2e9, 2e9),
            v(I, -2e9, 2e9),
            4e-10,
            0.5,
            PRECMASK_HIGHP,
            Func::Add,
            VEC_ONLY,
        ));
        out.push(mk(
            "add",
            "+",
            UV,
            v(UV, 0.0, 1e2),
            v(U, 0.0, 1e2),
            5e-3,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Add,
            VEC_ONLY,
        ));
        out.push(mk(
            "add",
            "+",
            UV,
            v(UV, 0.0, 4e9),
            v(U, 0.0, 4e9),
            2e-10,
            0.0,
            PRECMASK_HIGHP,
            Func::Add,
            VEC_ONLY,
        ));
        if is_normal {
            out.push(mk(
                "add",
                "+",
                FV,
                v(F, -1.0, 1.0),
                v(FV, -1.0, 1.0),
                1.0,
                0.0,
                PRECMASK_ALL,
                Func::Add,
                VEC_ONLY,
            ));
            out.push(mk(
                "add",
                "+",
                IV,
                v(I, -4.0, 6.0),
                v(IV, -6.0, 5.0),
                0.1,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::Add,
                VEC_ONLY,
            ));
            out.push(mk(
                "add",
                "+",
                IV,
                v(I, -2e9, 2e9),
                v(IV, -2e9, 2e9),
                4e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::Add,
                VEC_ONLY,
            ));
            out.push(mk(
                "add",
                "+",
                UV,
                v(U, 0.0, 1e2),
                v(UV, 0.0, 1e2),
                5e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::Add,
                VEC_ONLY,
            ));
            out.push(mk(
                "add",
                "+",
                UV,
                v(U, 0.0, 4e9),
                v(UV, 0.0, 4e9),
                2e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::Add,
                VEC_ONLY,
            ));
        }

        // The subtract operator.
        out.push(mk(
            "sub",
            "-",
            GT,
            v(GT, -1.0, 1.0),
            v(GT, -1.0, 1.0),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Sub,
            ALL_SIZES,
        ));
        out.push(mk(
            "sub",
            "-",
            IGT,
            v(IGT, -4.0, 6.0),
            v(IGT, -6.0, 5.0),
            0.1,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Sub,
            ALL_SIZES,
        ));
        out.push(mk(
            "sub",
            "-",
            IGT,
            v(IGT, -2e9, 2e9),
            v(IGT, -2e9, 2e9),
            4e-10,
            0.5,
            PRECMASK_HIGHP,
            Func::Sub,
            ALL_SIZES,
        ));
        out.push(mk(
            "sub",
            "-",
            UGT,
            v(UGT, 1e2, 2e2),
            v(UGT, 0.0, 1e2),
            5e-3,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Sub,
            ALL_SIZES,
        ));
        out.push(mk(
            "sub",
            "-",
            UGT,
            v(UGT, 0.5e9, 3.7e9),
            v(UGT, 0.0, 3.9e9),
            2e-10,
            0.0,
            PRECMASK_HIGHP,
            Func::Sub,
            ALL_SIZES,
        ));
        out.push(mk(
            "sub",
            "-",
            FV,
            v(FV, -1.0, 1.0),
            v(F, -1.0, 1.0),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Sub,
            VEC_ONLY,
        ));
        out.push(mk(
            "sub",
            "-",
            IV,
            v(IV, -4.0, 6.0),
            v(I, -6.0, 5.0),
            0.1,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Sub,
            VEC_ONLY,
        ));
        out.push(mk(
            "sub",
            "-",
            IV,
            v(IV, -2e9, 2e9),
            v(I, -2e9, 2e9),
            4e-10,
            0.5,
            PRECMASK_HIGHP,
            Func::Sub,
            VEC_ONLY,
        ));
        out.push(mk(
            "sub",
            "-",
            UV,
            v(UV, 1e2, 2e2),
            v(U, 0.0, 1e2),
            5e-3,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Sub,
            VEC_ONLY,
        ));
        out.push(mk(
            "sub",
            "-",
            UV,
            v(UV, 0.0, 4e9),
            v(U, 0.0, 4e9),
            2e-10,
            0.0,
            PRECMASK_HIGHP,
            Func::Sub,
            VEC_ONLY,
        ));
        if is_normal {
            out.push(mk(
                "sub",
                "-",
                FV,
                v(F, -1.0, 1.0),
                v(FV, -1.0, 1.0),
                1.0,
                0.0,
                PRECMASK_ALL,
                Func::Sub,
                VEC_ONLY,
            ));
            out.push(mk(
                "sub",
                "-",
                IV,
                v(I, -4.0, 6.0),
                v(IV, -6.0, 5.0),
                0.1,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::Sub,
                VEC_ONLY,
            ));
            out.push(mk(
                "sub",
                "-",
                IV,
                v(I, -2e9, 2e9),
                v(IV, -2e9, 2e9),
                4e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::Sub,
                VEC_ONLY,
            ));
            out.push(mk(
                "sub",
                "-",
                UV,
                v(U, 1e2, 2e2),
                v(UV, 0.0, 1e2),
                5e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::Sub,
                VEC_ONLY,
            ));
            out.push(mk(
                "sub",
                "-",
                UV,
                v(U, 0.0, 4e9),
                v(UV, 0.0, 4e9),
                2e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::Sub,
                VEC_ONLY,
            ));
        }

        // The multiply operator.
        out.push(mk(
            "mul",
            "*",
            GT,
            v(GT, -1.0, 1.0),
            v(GT, -1.0, 1.0),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Mul,
            ALL_SIZES,
        ));
        out.push(mk(
            "mul",
            "*",
            IGT,
            v(IGT, -4.0, 6.0),
            v(IGT, -6.0, 5.0),
            0.1,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mul,
            ALL_SIZES,
        ));
        out.push(mk(
            "mul",
            "*",
            IGT,
            v(IGT, -3e5, 3e5),
            v(IGT, -3e4, 3e4),
            4e-10,
            0.5,
            PRECMASK_HIGHP,
            Func::Mul,
            ALL_SIZES,
        ));
        out.push(mk(
            "mul",
            "*",
            UGT,
            v(UGT, 0.0, 16.0),
            v(UGT, 0.0, 16.0),
            4e-3,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mul,
            ALL_SIZES,
        ));
        out.push(mk(
            "mul",
            "*",
            UGT,
            v(UGT, 0.0, 6e5),
            v(UGT, 0.0, 6e4),
            2e-10,
            0.0,
            PRECMASK_HIGHP,
            Func::Mul,
            ALL_SIZES,
        ));
        out.push(mk(
            "mul",
            "*",
            FV,
            v(FV, -1.0, 1.0),
            v(F, -1.0, 1.0),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Mul,
            VEC_ONLY,
        ));
        out.push(mk(
            "mul",
            "*",
            IV,
            v(IV, -4.0, 6.0),
            v(I, -6.0, 5.0),
            0.1,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mul,
            VEC_ONLY,
        ));
        out.push(mk(
            "mul",
            "*",
            IV,
            v(IV, -3e5, 3e5),
            v(I, -3e4, 3e4),
            4e-10,
            0.5,
            PRECMASK_HIGHP,
            Func::Mul,
            VEC_ONLY,
        ));
        out.push(mk(
            "mul",
            "*",
            UV,
            v(UV, 0.0, 16.0),
            v(U, 0.0, 16.0),
            4e-3,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mul,
            VEC_ONLY,
        ));
        out.push(mk(
            "mul",
            "*",
            UV,
            v(UV, 0.0, 6e5),
            v(U, 0.0, 6e4),
            2e-10,
            0.0,
            PRECMASK_HIGHP,
            Func::Mul,
            VEC_ONLY,
        ));
        if is_normal {
            out.push(mk(
                "mul",
                "*",
                FV,
                v(F, -1.0, 1.0),
                v(FV, -1.0, 1.0),
                1.0,
                0.0,
                PRECMASK_ALL,
                Func::Mul,
                VEC_ONLY,
            ));
            out.push(mk(
                "mul",
                "*",
                IV,
                v(I, -4.0, 6.0),
                v(IV, -6.0, 5.0),
                0.1,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::Mul,
                VEC_ONLY,
            ));
            out.push(mk(
                "mul",
                "*",
                IV,
                v(I, -3e5, 3e5),
                v(IV, -3e4, 3e4),
                4e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::Mul,
                VEC_ONLY,
            ));
            out.push(mk(
                "mul",
                "*",
                UV,
                v(U, 0.0, 16.0),
                v(UV, 0.0, 16.0),
                4e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::Mul,
                VEC_ONLY,
            ));
            out.push(mk(
                "mul",
                "*",
                UV,
                v(U, 0.0, 6e5),
                v(UV, 0.0, 6e4),
                2e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::Mul,
                VEC_ONLY,
            ));
        }

        // The divide operator.
        out.push(mk(
            "div",
            "/",
            GT,
            v(GT, -1.0, 1.0),
            v(GT, -2.0, -0.5),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Div,
            ALL_SIZES,
        ));
        out.push(mk(
            "div",
            "/",
            IGT,
            v(IGT, 24.0, 24.0),
            v(IGT, -4.0, -1.0),
            0.04,
            1.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Div,
            ALL_SIZES,
        ));
        out.push(mk(
            "div",
            "/",
            IGT,
            v(IGT, 40320.0, 40320.0),
            v(IGT, -8.0, -1.0),
            1e-5,
            0.5,
            PRECMASK_HIGHP,
            Func::Div,
            ALL_SIZES,
        ));
        out.push(mk(
            "div",
            "/",
            UGT,
            v(UGT, 0.0, 24.0),
            v(UGT, 1.0, 4.0),
            0.04,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Div,
            ALL_SIZES,
        ));
        out.push(mk(
            "div",
            "/",
            UGT,
            v(UGT, 0.0, 40320.0),
            v(UGT, 1.0, 8.0),
            1e-5,
            0.0,
            PRECMASK_HIGHP,
            Func::Div,
            ALL_SIZES,
        ));
        out.push(mk(
            "div",
            "/",
            FV,
            v(FV, -1.0, 1.0),
            v(F, -2.0, -0.5),
            1.0,
            0.0,
            PRECMASK_ALL,
            Func::Div,
            VEC_ONLY,
        ));
        out.push(mk(
            "div",
            "/",
            IV,
            v(IV, 24.0, 24.0),
            v(I, -4.0, -1.0),
            0.04,
            1.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Div,
            VEC_ONLY,
        ));
        out.push(mk(
            "div",
            "/",
            IV,
            v(IV, 40320.0, 40320.0),
            v(I, -8.0, -1.0),
            1e-5,
            0.5,
            PRECMASK_HIGHP,
            Func::Div,
            VEC_ONLY,
        ));
        out.push(mk(
            "div",
            "/",
            UV,
            v(UV, 0.0, 24.0),
            v(U, 1.0, 4.0),
            0.04,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Div,
            VEC_ONLY,
        ));
        out.push(mk(
            "div",
            "/",
            UV,
            v(UV, 0.0, 40320.0),
            v(U, 1.0, 8.0),
            1e-5,
            0.0,
            PRECMASK_HIGHP,
            Func::Div,
            VEC_ONLY,
        ));
        if is_normal {
            out.push(mk(
                "div",
                "/",
                FV,
                v(F, -1.0, 1.0),
                v(FV, -2.0, -0.5),
                1.0,
                0.0,
                PRECMASK_ALL,
                Func::Div,
                VEC_ONLY,
            ));
            out.push(mk(
                "div",
                "/",
                IV,
                v(I, 24.0, 24.0),
                v(IV, -4.0, -1.0),
                0.04,
                1.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::Div,
                VEC_ONLY,
            ));
            out.push(mk(
                "div",
                "/",
                IV,
                v(I, 40320.0, 40320.0),
                v(IV, -8.0, -1.0),
                1e-5,
                0.5,
                PRECMASK_HIGHP,
                Func::Div,
                VEC_ONLY,
            ));
            out.push(mk(
                "div",
                "/",
                UV,
                v(U, 0.0, 24.0),
                v(UV, 1.0, 4.0),
                0.04,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::Div,
                VEC_ONLY,
            ));
            out.push(mk(
                "div",
                "/",
                UV,
                v(U, 0.0, 40320.0),
                v(UV, 1.0, 8.0),
                1e-5,
                0.0,
                PRECMASK_HIGHP,
                Func::Div,
                VEC_ONLY,
            ));
        }

        // The modulus operator.
        out.push(mk(
            "mod",
            "%",
            IGT,
            v(IGT, 0.0, 6.0),
            v(IGT, 1.1, 6.1),
            0.25,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mod,
            ALL_SIZES,
        ));
        out.push(mk(
            "mod",
            "%",
            IGT,
            v(IGT, 0.0, 14.0),
            v(IGT, 1.1, 11.1),
            0.1,
            0.5,
            PRECMASK_HIGHP,
            Func::Mod,
            ALL_SIZES,
        ));
        out.push(mk(
            "mod",
            "%",
            UGT,
            v(UGT, 0.0, 6.0),
            v(UGT, 1.1, 6.1),
            0.25,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mod,
            ALL_SIZES,
        ));
        out.push(mk(
            "mod",
            "%",
            UGT,
            v(UGT, 0.0, 24.0),
            v(UGT, 1.1, 11.1),
            0.1,
            0.0,
            PRECMASK_HIGHP,
            Func::Mod,
            ALL_SIZES,
        ));
        out.push(mk(
            "mod",
            "%",
            IV,
            v(IV, 0.0, 6.0),
            v(I, 1.1, 6.1),
            0.25,
            0.5,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mod,
            VEC_ONLY,
        ));
        out.push(mk(
            "mod",
            "%",
            IV,
            v(IV, 0.0, 6.0),
            v(I, 1.1, 11.1),
            0.1,
            0.5,
            PRECMASK_HIGHP,
            Func::Mod,
            VEC_ONLY,
        ));
        out.push(mk(
            "mod",
            "%",
            UV,
            v(UV, 0.0, 6.0),
            v(U, 1.1, 6.1),
            0.25,
            0.0,
            PRECMASK_LOWP_MEDIUMP,
            Func::Mod,
            VEC_ONLY,
        ));
        out.push(mk(
            "mod",
            "%",
            UV,
            v(UV, 0.0, 24.0),
            v(U, 1.1, 11.1),
            0.1,
            0.0,
            PRECMASK_HIGHP,
            Func::Mod,
            VEC_ONLY,
        ));
        if is_normal {
            out.push(mk(
                "mod",
                "%",
                IV,
                v(I, 0.0, 6.0),
                v(IV, 1.1, 6.1),
                0.25,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::Mod,
                VEC_ONLY,
            ));
            out.push(mk(
                "mod",
                "%",
                IV,
                v(I, 0.0, 6.0),
                v(IV, 1.1, 11.1),
                0.1,
                0.5,
                PRECMASK_HIGHP,
                Func::Mod,
                VEC_ONLY,
            ));
            out.push(mk(
                "mod",
                "%",
                UV,
                v(U, 0.0, 6.0),
                v(UV, 1.1, 6.1),
                0.25,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::Mod,
                VEC_ONLY,
            ));
            out.push(mk(
                "mod",
                "%",
                UV,
                v(U, 0.0, 24.0),
                v(UV, 1.1, 11.1),
                0.1,
                0.0,
                PRECMASK_HIGHP,
                Func::Mod,
                VEC_ONLY,
            ));
        }

        // The bitwise and/or/xor operators - identical ranges, one per `Func`/name/op.
        for (name, op, func) in [
            ("bitwise_and", "&", Func::BitwiseAnd),
            ("bitwise_or", "|", Func::BitwiseOr),
            ("bitwise_xor", "^", Func::BitwiseXor),
        ] {
            out.push(mk(
                name,
                op,
                IGT,
                v(IGT, -16.0, 16.0),
                v(IGT, -16.0, 16.0),
                0.03,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                func,
                ALL_SIZES,
            ));
            out.push(mk(
                name,
                op,
                IGT,
                v(IGT, -2e9, 2e9),
                v(IGT, -2e9, 2e9),
                4e-10,
                0.5,
                PRECMASK_HIGHP,
                func,
                ALL_SIZES,
            ));
            out.push(mk(
                name,
                op,
                UGT,
                v(UGT, 0.0, 32.0),
                v(UGT, 0.0, 32.0),
                0.03,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                func,
                ALL_SIZES,
            ));
            out.push(mk(
                name,
                op,
                UGT,
                v(UGT, 0.0, 4e9),
                v(UGT, 0.0, 4e9),
                2e-10,
                0.0,
                PRECMASK_HIGHP,
                func,
                ALL_SIZES,
            ));
            out.push(mk(
                name,
                op,
                IV,
                v(IV, -16.0, 16.0),
                v(I, -16.0, 16.0),
                0.03,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                func,
                VEC_ONLY,
            ));
            out.push(mk(
                name,
                op,
                IV,
                v(IV, -2e9, 2e9),
                v(I, -2e9, 2e9),
                4e-10,
                0.5,
                PRECMASK_HIGHP,
                func,
                VEC_ONLY,
            ));
            out.push(mk(
                name,
                op,
                UV,
                v(UV, 0.0, 32.0),
                v(U, 0.0, 32.0),
                0.03,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                func,
                VEC_ONLY,
            ));
            out.push(mk(
                name,
                op,
                UV,
                v(UV, 0.0, 4e9),
                v(U, 0.0, 4e9),
                2e-10,
                0.0,
                PRECMASK_HIGHP,
                func,
                VEC_ONLY,
            ));
            if is_normal {
                out.push(mk(
                    name,
                    op,
                    IV,
                    v(I, -16.0, 16.0),
                    v(IV, -16.0, 16.0),
                    0.03,
                    0.5,
                    PRECMASK_LOWP_MEDIUMP,
                    func,
                    VEC_ONLY,
                ));
                out.push(mk(
                    name,
                    op,
                    IV,
                    v(I, -2e9, 2e9),
                    v(IV, -2e9, 2e9),
                    4e-10,
                    0.5,
                    PRECMASK_HIGHP,
                    func,
                    VEC_ONLY,
                ));
                out.push(mk(
                    name,
                    op,
                    UV,
                    v(U, 0.0, 32.0),
                    v(UV, 0.0, 32.0),
                    0.03,
                    0.0,
                    PRECMASK_LOWP_MEDIUMP,
                    func,
                    VEC_ONLY,
                ));
                out.push(mk(
                    name,
                    op,
                    UV,
                    v(U, 0.0, 4e9),
                    v(UV, 0.0, 4e9),
                    2e-10,
                    0.0,
                    PRECMASK_HIGHP,
                    func,
                    VEC_ONLY,
                ));
            }
        }

        // The left shift operator. The shift amount can be either int or uint, even for a
        // uint or int base value respectively.
        for (g_type, s_type) in [(UGT, U), (IGT, I)] {
            out.push(mk(
                "left_shift",
                "<<",
                IGT,
                v(IGT, -7.0, 7.0),
                v(g_type, 0.0, 4.0),
                4e-3,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::LeftShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                IGT,
                v(IGT, -7.0, 7.0),
                v(g_type, 0.0, 27.0),
                5e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::LeftShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                UGT,
                v(UGT, 0.0, 7.0),
                v(g_type, 0.0, 5.0),
                4e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::LeftShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                UGT,
                v(UGT, 0.0, 7.0),
                v(g_type, 0.0, 28.0),
                5e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::LeftShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                IV,
                v(IV, -7.0, 7.0),
                v(s_type, 0.0, 4.0),
                4e-3,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::LeftShift,
                VEC_ONLY,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                IV,
                v(IV, -7.0, 7.0),
                v(s_type, 0.0, 27.0),
                5e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::LeftShift,
                VEC_ONLY,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                UV,
                v(UV, 0.0, 7.0),
                v(s_type, 0.0, 5.0),
                4e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::LeftShift,
                VEC_ONLY,
            ));
            out.push(mk(
                "left_shift",
                "<<",
                UV,
                v(UV, 0.0, 7.0),
                v(s_type, 0.0, 28.0),
                5e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::LeftShift,
                VEC_ONLY,
            ));
        }

        // The right shift operator. Same either-int-or-uint shift amount rule as above.
        for (g_type, s_type) in [(UGT, U), (IGT, I)] {
            out.push(mk(
                "right_shift",
                ">>",
                IGT,
                v(IGT, -127.0, 127.0),
                v(g_type, 0.0, 8.0),
                4e-3,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::RightShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                IGT,
                v(IGT, -2e9, 2e9),
                v(g_type, 0.0, 31.0),
                5e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::RightShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                UGT,
                v(UGT, 0.0, 255.0),
                v(g_type, 0.0, 8.0),
                4e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::RightShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                UGT,
                v(UGT, 0.0, 4e9),
                v(g_type, 0.0, 31.0),
                5e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::RightShift,
                ALL_SIZES,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                IV,
                v(IV, -127.0, 127.0),
                v(s_type, 0.0, 8.0),
                4e-3,
                0.5,
                PRECMASK_LOWP_MEDIUMP,
                Func::RightShift,
                VEC_ONLY,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                IV,
                v(IV, -2e9, 2e9),
                v(s_type, 0.0, 31.0),
                5e-10,
                0.5,
                PRECMASK_HIGHP,
                Func::RightShift,
                VEC_ONLY,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                UV,
                v(UV, 0.0, 255.0),
                v(s_type, 0.0, 8.0),
                4e-3,
                0.0,
                PRECMASK_LOWP_MEDIUMP,
                Func::RightShift,
                VEC_ONLY,
            ));
            out.push(mk(
                "right_shift",
                ">>",
                UV,
                v(UV, 0.0, 4e9),
                v(s_type, 0.0, 31.0),
                5e-10,
                0.0,
                PRECMASK_HIGHP,
                Func::RightShift,
                VEC_ONLY,
            ));
        }
    }

    // Rest of binary operators - added once, outside the `binaryOperatorType` loop, since
    // relational/equality/logical operators have no assignment form.
    out.push(op_info(
        "less",
        "<",
        B,
        v(F, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThan,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "less",
        "<",
        B,
        v(I, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThan,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "less",
        "<",
        B,
        v(U, 0.0, 16.0),
        v(U, 0.0, 16.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThan,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "less_or_equal",
        "<=",
        B,
        v(F, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThanEqual,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "less_or_equal",
        "<=",
        B,
        v(I, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThanEqual,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "less_or_equal",
        "<=",
        B,
        v(U, 0.0, 16.0),
        v(U, 0.0, 16.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::LessThanEqual,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "greater",
        ">",
        B,
        v(F, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThan,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "greater",
        ">",
        B,
        v(I, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThan,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "greater",
        ">",
        B,
        v(U, 0.0, 16.0),
        v(U, 0.0, 16.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThan,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "greater_or_equal",
        ">=",
        B,
        v(F, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThanEqual,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "greater_or_equal",
        ">=",
        B,
        v(I, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThanEqual,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "greater_or_equal",
        ">=",
        B,
        v(U, 0.0, 16.0),
        v(U, 0.0, 16.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::GreaterThanEqual,
        SCALAR_ONLY,
    ));

    // Equality comparison operators - `allEqual`/`anyNotEqual` reduce across the gentype's
    // own lanes to a single bool, unlike `Func::Equal`/`NotEqual` (a per-lane `bvecN`, used
    // by the vector *functions* `equal`/`notEqual` in `float_compare`/`int_compare`/
    // `bool_compare`).
    out.push(op_info(
        "equal",
        "==",
        B,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AllEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "equal",
        "==",
        B,
        v(IGT, -5.5, 4.7),
        v(IGT, -2.1, 0.1),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AllEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "equal",
        "==",
        B,
        v(UGT, 0.0, 8.0),
        v(UGT, 3.5, 4.5),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AllEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "equal",
        "==",
        B,
        v(BGT, -2.1, 2.1),
        v(BGT, -1.1, 3.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::AllEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "not_equal",
        "!=",
        B,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AnyNotEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "not_equal",
        "!=",
        B,
        v(IGT, -5.5, 4.7),
        v(IGT, -2.1, 0.1),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AnyNotEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "not_equal",
        "!=",
        B,
        v(UGT, 0.0, 8.0),
        v(UGT, 3.5, 4.5),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AnyNotEqual,
        ALL_SIZES,
    ));
    out.push(op_info(
        "not_equal",
        "!=",
        B,
        v(BGT, -2.1, 2.1),
        v(BGT, -1.1, 3.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::AnyNotEqual,
        ALL_SIZES,
    ));

    // Logical operators.
    out.push(op_info(
        "logical_and",
        "&&",
        B,
        v(B, -1.0, 1.0),
        v(B, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::LogicalAnd,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "logical_or",
        "||",
        B,
        v(B, -1.0, 1.0),
        v(B, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::LogicalOr,
        SCALAR_ONLY,
    ));
    out.push(op_info(
        "logical_xor",
        "^^",
        B,
        v(B, -1.0, 1.0),
        v(B, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_NA,
        Func::LogicalXor,
        SCALAR_ONLY,
    ));

    out
}

/// `funcInfoGroups`, in upstream's own order with the un-ported groups removed.
fn func_info_groups() -> Vec<BuiltinFuncGroup> {
    vec![
        BuiltinFuncGroup {
            name: "unary_operator",
            func_infos: UNARY_OPERATOR_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "binary_operator",
            func_infos: binary_operator_funcs(),
        },
        BuiltinFuncGroup {
            name: "angle_and_trigonometry",
            func_infos: ANGLE_AND_TRIGONOMETRY_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "exponential",
            func_infos: EXPONENTIAL_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "common_functions",
            func_infos: COMMON_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "geometric",
            func_infos: GEOMETRIC_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "float_compare",
            func_infos: FLOAT_COMPARE_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "int_compare",
            func_infos: INT_COMPARE_FUNCS.to_vec(),
        },
        BuiltinFuncGroup {
            name: "bool_compare",
            func_infos: BOOL_COMPARE_FUNCS.to_vec(),
        },
    ]
}

/// `s_floatTypes` / `s_intTypes` / `s_boolTypes`
const S_FLOAT_TYPES: [DataType; 4] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
];
const S_INT_TYPES: [DataType; 4] = [DataType::Int, DataType::IntVec2, DataType::IntVec3, DataType::IntVec4];
const S_UINT_TYPES: [DataType; 4] = [
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
];
const S_BOOL_TYPES: [DataType; 4] = [
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
];

/// The concrete `DataType` one `Value`'s own `ValueType` resolves to at a given scalar
/// size - each input's own family, not the whole case's (`left_shift`/`right_shift`'s
/// shift amount is deliberately the opposite family from its base value at half of this
/// file's entries, see `add_func_cases`'s own comment on this).
fn data_type_for(value_type: ValueType, scalar_size: i32) -> DataType {
    let ndx = scalar_size as usize - 1;
    if value_type.is_bool_value() {
        S_BOOL_TYPES[ndx]
    } else if value_type.is_int() {
        S_INT_TYPES[ndx]
    } else if value_type.is_uint() {
        S_UINT_TYPES[ndx]
    } else {
        S_FLOAT_TYPES[ndx]
    }
}

fn is_bool_data_type(data_type: DataType) -> bool {
    matches!(
        data_type,
        DataType::Bool | DataType::BoolVec2 | DataType::BoolVec3 | DataType::BoolVec4
    )
}

fn is_int_data_type(data_type: DataType) -> bool {
    matches!(
        data_type,
        DataType::Int | DataType::IntVec2 | DataType::IntVec3 | DataType::IntVec4
    )
}

fn is_uint_data_type(data_type: DataType) -> bool {
    matches!(
        data_type,
        DataType::Uint | DataType::UintVec2 | DataType::UintVec3 | DataType::UintVec4
    )
}

fn is_float_data_type(data_type: DataType) -> bool {
    matches!(
        data_type,
        DataType::Float | DataType::FloatVec2 | DataType::FloatVec3 | DataType::FloatVec4
    )
}

/// The operand an evaluator reads or produces, at its own declared type. `Int`/`Uint` are
/// separate (unlike a shared "one covers both, since every range stays non-negative"
/// variant, which is what this used to be before `binary_operator`): a `uint` range here
/// can run up to 4e9, past `i32::MAX`, and the wraparound arithmetic `binary_operator`'s
/// highp cases exist to exercise needs the real bit width of whichever type the shader
/// declared.
#[derive(Clone, Copy)]
enum Operand {
    Float(usize, [f32; 4]),
    Int(usize, [i32; 4]),
    Uint(usize, [u32; 4]),
    Bool(usize, [bool; 4]),
}

impl Operand {
    fn size(self) -> usize {
        match self {
            Self::Float(n, _) | Self::Int(n, _) | Self::Uint(n, _) | Self::Bool(n, _) => n,
        }
    }

    fn float_at(self, ndx: usize) -> f32 {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx],
            Self::Int(_, d) => d[ndx] as f32,
            Self::Uint(_, d) => d[ndx] as f32,
            Self::Bool(_, d) => f32::from(d[ndx]),
        }
    }

    fn int_at(self, ndx: usize) -> i32 {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx] as i32,
            Self::Int(_, d) => d[ndx],
            Self::Uint(_, d) => d[ndx] as i32,
            Self::Bool(_, d) => i32::from(d[ndx]),
        }
    }

    /// Only meaningful on a genuine `Uint` operand - used for `binary_operator`'s
    /// wraparound arithmetic, where reading a large value through `int_at`'s `as i32`
    /// would saturate instead of reinterpreting the bit pattern.
    fn uint_at(self, ndx: usize) -> u32 {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx] as u32,
            Self::Int(_, d) => d[ndx] as u32,
            Self::Uint(_, d) => d[ndx],
            Self::Bool(_, d) => u32::from(d[ndx]),
        }
    }

    fn bool_at(self, ndx: usize) -> bool {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx] > 0.0,
            Self::Int(_, d) => d[ndx] != 0,
            Self::Uint(_, d) => d[ndx] != 0,
            Self::Bool(_, d) => d[ndx],
        }
    }

    fn floats(self) -> [f32; 4] {
        std::array::from_fn(|ndx| self.float_at(ndx))
    }
}

/// `ShaderValue`
#[derive(Clone, Copy)]
struct ShaderValue {
    type_: DataType,
    range_min: f32,
    range_max: f32,
}

/// `ShaderDataSpec`
struct ShaderDataSpec {
    result_scale: f32,
    result_bias: f32,
    /// `PRECISION_LAST` upstream, i.e. "this case takes no precision qualifier".
    precision: Option<Precision>,
    output: DataType,
    inputs: Vec<ShaderValue>,
}

/// Reads input `input_ndx` the way the generated shader reads it: through that input's own
/// swizzle, then converted to the input's declared type (`ivecN(...)` truncates,
/// `greaterThan(..., 0.0)` is the boolean form).
fn read_input(ctx: &ShaderEvalContext, input_ndx: usize, data_type: DataType) -> Operand {
    let size = data_type.scalar_size() as usize;
    let swizzle = S_IN_SWIZZLES[input_ndx][size - 1];
    let raw: [f32; 4] = std::array::from_fn(|ndx| {
        if ndx < size {
            ctx.in_[input_ndx][swizzle[ndx]]
        } else {
            0.0
        }
    });

    if is_bool_data_type(data_type) {
        Operand::Bool(size, std::array::from_fn(|ndx| raw[ndx] > 0.0))
    } else if is_uint_data_type(data_type) {
        // `uint(...)` truncates toward zero, same as Rust's `as u32` for a value already
        // known to be non-negative and in range (every `uint` range here is, up to 4e9).
        Operand::Uint(size, std::array::from_fn(|ndx| raw[ndx] as u32))
    } else if is_int_data_type(data_type) {
        Operand::Int(size, std::array::from_fn(|ndx| raw[ndx] as i32))
    } else {
        Operand::Float(size, raw)
    }
}

fn dot_product(a: &[f32; 4], b: &[f32; 4], size: usize) -> f32 {
    (0..size).map(|ndx| a[ndx] * b[ndx]).sum()
}

// The scalar reference functions, `tcu`'s own definitions.

fn tcu_mod(x: f32, y: f32) -> f32 {
    x - y * (x / y).floor()
}

fn tcu_sign(f: f32) -> f32 {
    if f < 0.0 {
        -1.0
    } else if f > 0.0 {
        1.0
    } else {
        0.0
    }
}

fn tcu_fract(f: f32) -> f32 {
    f - f.floor()
}

fn tcu_mix(x: f32, y: f32, a: f32) -> f32 {
    x * (1.0 - a) + y * a
}

fn tcu_step(edge: f32, x: f32) -> f32 {
    if x < edge { 0.0 } else { 1.0 }
}

fn tcu_smooth_step(edge0: f32, edge1: f32, x: f32) -> f32 {
    if x <= edge0 {
        return 0.0;
    }
    if x >= edge1 {
        return 1.0;
    }
    let t = ((x - edge0) / (edge1 - edge0)).clamp(0.0, 1.0);
    t * t * (3.0 - 2.0 * t)
}

/// The result of one evaluation, in the output type's own terms.
enum Result {
    Float([f32; 4]),
    Bool([bool; 4]),
}

impl Result {
    fn float_at(&self, ndx: usize) -> f32 {
        match self {
            Self::Float(d) => d[ndx],
            Self::Bool(d) => f32::from(d[ndx]),
        }
    }
}

/// Every operation in `Func`, applied to the operands the case declared.
fn apply(func: Func, ins: &[Operand], out_size: usize) -> Result {
    let float_lanes =
        |f: &dyn Fn(usize) -> f32| Result::Float(std::array::from_fn(|ndx| if ndx < out_size { f(ndx) } else { 0.0 }));
    let bool_lanes = |f: &dyn Fn(usize) -> bool| {
        Result::Bool(std::array::from_fn(|ndx| if ndx < out_size { f(ndx) } else { false }))
    };

    match func {
        Func::BoolNot => bool_lanes(&|ndx| !ins[0].bool_at(ndx)),
        Func::LessThan => bool_lanes(&|ndx| compare_lane(ins[0], ins[1], ndx, |o| o.is_lt())),
        Func::LessThanEqual => bool_lanes(&|ndx| compare_lane(ins[0], ins[1], ndx, |o| o.is_le())),
        Func::GreaterThan => bool_lanes(&|ndx| compare_lane(ins[0], ins[1], ndx, |o| o.is_gt())),
        Func::GreaterThanEqual => bool_lanes(&|ndx| compare_lane(ins[0], ins[1], ndx, |o| o.is_ge())),
        Func::Equal => bool_lanes(&|ndx| lanes_equal(ins[0], ins[1], ndx)),
        Func::NotEqual => bool_lanes(&|ndx| !lanes_equal(ins[0], ins[1], ndx)),
        Func::Any => {
            let any = (0..ins[0].size()).any(|ndx| ins[0].bool_at(ndx));
            bool_lanes(&|_| any)
        }
        Func::All => {
            let all = (0..ins[0].size()).all(|ndx| ins[0].bool_at(ndx));
            bool_lanes(&|_| all)
        }
        Func::AllEqual => {
            let eq = (0..ins[0].size()).all(|ndx| lanes_equal(ins[0], ins[1], ndx));
            bool_lanes(&|_| eq)
        }
        Func::AnyNotEqual => {
            let neq = (0..ins[0].size()).any(|ndx| !lanes_equal(ins[0], ins[1], ndx));
            bool_lanes(&|_| neq)
        }
        Func::LogicalAnd => bool_lanes(&|_| ins[0].bool_at(0) && ins[1].bool_at(0)),
        Func::LogicalOr => bool_lanes(&|_| ins[0].bool_at(0) || ins[1].bool_at(0)),
        Func::LogicalXor => bool_lanes(&|_| ins[0].bool_at(0) != ins[1].bool_at(0)),

        Func::Radians => float_lanes(&|ndx| ins[0].float_at(ndx).to_radians()),
        Func::Degrees => float_lanes(&|ndx| ins[0].float_at(ndx).to_degrees()),
        Func::Sin => float_lanes(&|ndx| ins[0].float_at(ndx).sin()),
        Func::Cos => float_lanes(&|ndx| ins[0].float_at(ndx).cos()),
        Func::Tan => float_lanes(&|ndx| ins[0].float_at(ndx).tan()),
        Func::Asin => float_lanes(&|ndx| ins[0].float_at(ndx).asin()),
        Func::Acos => float_lanes(&|ndx| ins[0].float_at(ndx).acos()),
        Func::Atan => float_lanes(&|ndx| ins[0].float_at(ndx).atan()),
        Func::Atan2 => float_lanes(&|ndx| ins[0].float_at(ndx).atan2(ins[1].float_at(ndx))),
        Func::Sinh => float_lanes(&|ndx| ins[0].float_at(ndx).sinh()),
        Func::Cosh => float_lanes(&|ndx| ins[0].float_at(ndx).cosh()),
        Func::Tanh => float_lanes(&|ndx| ins[0].float_at(ndx).tanh()),
        Func::Asinh => float_lanes(&|ndx| ins[0].float_at(ndx).asinh()),
        Func::Acosh => float_lanes(&|ndx| ins[0].float_at(ndx).acosh()),
        Func::Atanh => float_lanes(&|ndx| ins[0].float_at(ndx).atanh()),

        Func::Pow => float_lanes(&|ndx| ins[0].float_at(ndx).powf(ins[1].float_at(ndx))),
        Func::Exp => float_lanes(&|ndx| ins[0].float_at(ndx).exp()),
        Func::Log => float_lanes(&|ndx| ins[0].float_at(ndx).ln()),
        Func::Exp2 => float_lanes(&|ndx| ins[0].float_at(ndx).exp2()),
        Func::Log2 => float_lanes(&|ndx| ins[0].float_at(ndx).log2()),
        Func::Sqrt => float_lanes(&|ndx| ins[0].float_at(ndx).sqrt()),
        Func::InverseSqrt => float_lanes(&|ndx| 1.0 / ins[0].float_at(ndx).sqrt()),

        Func::Length => {
            let a = ins[0].floats();
            let size = ins[0].size();
            let length = dot_product(&a, &a, size).sqrt();
            float_lanes(&|_| length)
        }
        Func::Distance => {
            let size = ins[0].size();
            let diff: [f32; 4] = std::array::from_fn(|ndx| ins[0].float_at(ndx) - ins[1].float_at(ndx));
            let distance = dot_product(&diff, &diff, size).sqrt();
            float_lanes(&|_| distance)
        }
        Func::Dot => {
            let value = dot_product(&ins[0].floats(), &ins[1].floats(), ins[0].size());
            float_lanes(&|_| value)
        }
        Func::Cross => {
            let (a, b) = (ins[0].floats(), ins[1].floats());
            let cross = [
                a[1] * b[2] - b[1] * a[2],
                a[2] * b[0] - b[2] * a[0],
                a[0] * b[1] - b[0] * a[1],
                0.0,
            ];
            float_lanes(&|ndx| cross[ndx])
        }
        Func::Normalize => {
            let a = ins[0].floats();
            let length = dot_product(&a, &a, ins[0].size()).sqrt();
            float_lanes(&|ndx| a[ndx] / length)
        }
        Func::FaceForward => {
            // `(dot(ref, i) < 0) ? n : -n`, with n = in0, i = in1, ref = in2.
            let flip = dot_product(&ins[2].floats(), &ins[1].floats(), ins[0].size()) < 0.0;
            float_lanes(&|ndx| {
                if flip {
                    ins[0].float_at(ndx)
                } else {
                    -ins[0].float_at(ndx)
                }
            })
        }
        Func::Reflect => {
            // `i - 2 * dot(n, i) * n`, with i = in0, n = in1.
            let scale = 2.0 * dot_product(&ins[1].floats(), &ins[0].floats(), ins[0].size());
            float_lanes(&|ndx| ins[0].float_at(ndx) - scale * ins[1].float_at(ndx))
        }
        Func::Refract => {
            // i = in0, n = in1, eta = in2 (always scalar).
            let eta = ins[2].float_at(0);
            let cos_angle = dot_product(&ins[1].floats(), &ins[0].floats(), ins[0].size());
            let k = 1.0 - eta * eta * (1.0 - cos_angle * cos_angle);
            if k < 0.0 {
                float_lanes(&|_| 0.0)
            } else {
                let scale = eta * cos_angle + k.sqrt();
                float_lanes(&|ndx| eta * ins[0].float_at(ndx) - scale * ins[1].float_at(ndx))
            }
        }

        // `common_functions`. Every one of these is evaluated in `f32` regardless of the
        // case's declared type - the shader side genuinely computes in int/uint, but the
        // int/uint cases in this file only ever draw from small ranges (`min`/`max`/`clamp`
        // over -8..8) that round-trip through `f32` exactly, so the host reference stays a
        // single generic implementation the way upstream's own templated `eval_*` does.
        Func::Abs => float_lanes(&|ndx| ins[0].float_at(ndx).abs()),
        Func::Sign => float_lanes(&|ndx| tcu_sign(ins[0].float_at(ndx))),
        Func::Floor => float_lanes(&|ndx| ins[0].float_at(ndx).floor()),
        Func::Trunc => float_lanes(&|ndx| ins[0].float_at(ndx).trunc()),
        Func::RoundToEven => float_lanes(&|ndx| ins[0].float_at(ndx).round_ties_even()),
        Func::Ceil => float_lanes(&|ndx| ins[0].float_at(ndx).ceil()),
        Func::Fract => float_lanes(&|ndx| tcu_fract(ins[0].float_at(ndx))),
        // `binary_operator`'s int/uint `mod` (`%`) reuses this arm - its ranges are all
        // non-negative, where GLSL's truncating `%` and the floor-based `tcu_mod` formula
        // common_functions' float `mod` needs agree, so the plain `%` used here for
        // integers is exactly `tcu_mod` would compute for the same non-negative inputs.
        Func::Mod => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| (ins[0].uint_at(ndx) % ins[1].uint_at(ndx)) as f32),
            Operand::Int(..) => float_lanes(&|ndx| (ins[0].int_at(ndx) % ins[1].int_at(ndx)) as f32),
            _ => float_lanes(&|ndx| tcu_mod(ins[0].float_at(ndx), ins[1].float_at(ndx))),
        },
        Func::Min => float_lanes(&|ndx| ins[0].float_at(ndx).min(ins[1].float_at(ndx))),
        Func::Max => float_lanes(&|ndx| ins[0].float_at(ndx).max(ins[1].float_at(ndx))),
        Func::Clamp => float_lanes(&|ndx| ins[0].float_at(ndx).clamp(ins[1].float_at(ndx), ins[2].float_at(ndx))),
        Func::Mix => float_lanes(&|ndx| tcu_mix(ins[0].float_at(ndx), ins[1].float_at(ndx), ins[2].float_at(ndx))),
        Func::Step => float_lanes(&|ndx| tcu_step(ins[0].float_at(ndx), ins[1].float_at(ndx))),
        Func::SmoothStep => {
            float_lanes(&|ndx| tcu_smooth_step(ins[0].float_at(ndx), ins[1].float_at(ndx), ins[2].float_at(ndx)))
        }

        // `unary_operator`/`binary_operator`. Each dispatches on `ins[0]`'s own `Operand`
        // variant (float/int/uint arithmetic all name the same GLSL operator, but need
        // different host semantics) and, for int/uint, computes in the operand's *real*
        // bit width via `wrapping_*` - matching upstream's own int64-intermediate `add`/
        // `sub`/`mul` and native `uint32_t` arithmetic - before casting to `f32` for
        // `ctx.color`, which is also where upstream's own `(float)result` cast happens.
        Func::Nop => float_lanes(&|ndx| ins[0].float_at(ndx)),
        Func::Negate => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_neg() as f32),
            Operand::Int(..) => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_neg() as f32),
            _ => float_lanes(&|ndx| -ins[0].float_at(ndx)),
        },
        Func::BitwiseNot => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| !ins[0].uint_at(ndx) as f32),
            _ => float_lanes(&|ndx| !ins[0].int_at(ndx) as f32),
        },
        Func::AddOne => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_add(1) as f32),
            Operand::Int(..) => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_add(1) as f32),
            _ => float_lanes(&|ndx| ins[0].float_at(ndx) + 1.0),
        },
        Func::SubOne => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_sub(1) as f32),
            Operand::Int(..) => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_sub(1) as f32),
            _ => float_lanes(&|ndx| ins[0].float_at(ndx) - 1.0),
        },
        Func::Add => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_add(ins[1].uint_at(ndx)) as f32),
            Operand::Int(..) => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_add(ins[1].int_at(ndx)) as f32),
            _ => float_lanes(&|ndx| ins[0].float_at(ndx) + ins[1].float_at(ndx)),
        },
        Func::Sub => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_sub(ins[1].uint_at(ndx)) as f32),
            Operand::Int(..) => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_sub(ins[1].int_at(ndx)) as f32),
            _ => float_lanes(&|ndx| ins[0].float_at(ndx) - ins[1].float_at(ndx)),
        },
        Func::Mul => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_mul(ins[1].uint_at(ndx)) as f32),
            Operand::Int(..) => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_mul(ins[1].int_at(ndx)) as f32),
            _ => float_lanes(&|ndx| ins[0].float_at(ndx) * ins[1].float_at(ndx)),
        },
        Func::Div => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| (ins[0].uint_at(ndx) / ins[1].uint_at(ndx)) as f32),
            Operand::Int(..) => float_lanes(&|ndx| (ins[0].int_at(ndx) / ins[1].int_at(ndx)) as f32),
            _ => float_lanes(&|ndx| ins[0].float_at(ndx) / ins[1].float_at(ndx)),
        },
        Func::BitwiseAnd => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| (ins[0].uint_at(ndx) & ins[1].uint_at(ndx)) as f32),
            _ => float_lanes(&|ndx| (ins[0].int_at(ndx) & ins[1].int_at(ndx)) as f32),
        },
        Func::BitwiseOr => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| (ins[0].uint_at(ndx) | ins[1].uint_at(ndx)) as f32),
            _ => float_lanes(&|ndx| (ins[0].int_at(ndx) | ins[1].int_at(ndx)) as f32),
        },
        Func::BitwiseXor => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| (ins[0].uint_at(ndx) ^ ins[1].uint_at(ndx)) as f32),
            _ => float_lanes(&|ndx| (ins[0].int_at(ndx) ^ ins[1].int_at(ndx)) as f32),
        },
        // The shift amount (`ins[1]`) is always read as a plain `int`, whatever its own
        // declared type - matches upstream's `eval_leftShift_int`/`eval_rightShift_int`,
        // which cast it with `(int)` regardless. `wrapping_sh{l,r}` is defensive - every
        // amount in this file's tables stays under 32 - and `>>`/`wrapping_shr` on `i32`
        // is already the sign-extending arithmetic shift upstream's `rightShift(int, int)`
        // computes by hand.
        Func::LeftShift => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_shl(ins[1].int_at(ndx) as u32) as f32),
            _ => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_shl(ins[1].int_at(ndx) as u32) as f32),
        },
        Func::RightShift => match ins[0] {
            Operand::Uint(..) => float_lanes(&|ndx| ins[0].uint_at(ndx).wrapping_shr(ins[1].int_at(ndx) as u32) as f32),
            _ => float_lanes(&|ndx| ins[0].int_at(ndx).wrapping_shr(ins[1].int_at(ndx) as u32) as f32),
        },

        // `selection` - `cond ? a : b`, `cond = ins[0]` (always a scalar bool). `ins[1]`
        // shares `ins[2]`'s family (both declared at the case's own `curType`), so which
        // family to pick from is read off `ins[1]` alone.
        Func::Selection => match ins[1] {
            Operand::Bool(..) => bool_lanes(&|ndx| {
                if ins[0].bool_at(0) {
                    ins[1].bool_at(ndx)
                } else {
                    ins[2].bool_at(ndx)
                }
            }),
            _ => float_lanes(&|ndx| {
                if ins[0].bool_at(0) {
                    ins[1].float_at(ndx)
                } else {
                    ins[2].float_at(ndx)
                }
            }),
        },

        // `sequence` - one hand-written reference per upstream `s_sequenceCases` entry, each
        // a direct transliteration of `sequence{NoSideEff,SideEff}Case{0..3}` (comments there
        // give each one's own expression). All eight land in a small enough integer/fraction
        // domain (see `SEQUENCE_CASES`' own ranges) that a plain `f32` intermediate is exact,
        // matching upstream's own `int64_t`-free scalar arithmetic here.
        Func::SeqNoSideEff0 => float_lanes(&|ndx| ins[1].float_at(ndx) + ins[0].float_at(ndx)),
        Func::SeqNoSideEff1 => float_lanes(&|_| ins[1].float_at(0) + ins[1].float_at(0)),
        Func::SeqNoSideEff2 => float_lanes(&|ndx| (f32::from(ins[0].bool_at(0)) + ins[2].float_at(ndx)) as i32 as f32),
        Func::SeqNoSideEff3 => float_lanes(&|ndx| ins[1].float_at(ndx)),
        Func::SeqSideEff0 => float_lanes(&|ndx| ins[0].float_at(ndx) + 1.0 + ins[2].float_at(ndx)),
        Func::SeqSideEff1 => float_lanes(&|_| (ins[1].float_at(0) + 1.0 + ins[2].float_at(0)) as u32 as f32),
        Func::SeqSideEff2 => {
            float_lanes(&|ndx| (ins[2].float_at(ndx) + 1.0 + f32::from(ins[0].bool_at(0))) as i32 as f32)
        }
        Func::SeqSideEff3 => float_lanes(&|ndx| {
            ins[1].float_at(ndx) + ((ins[0].float_at(ndx) + f32::from(ins[2].bool_at(ndx))) as i32) as f32
        }),
    }
}

/// One lane of a comparison, at the operands' own type: integers compare as integers, the
/// way upstream's `chopToInt` forms do, and booleans as booleans.
fn compare_lane(a: Operand, b: Operand, ndx: usize, accept: fn(std::cmp::Ordering) -> bool) -> bool {
    match a {
        Operand::Int(..) => accept(a.int_at(ndx).cmp(&b.int_at(ndx))),
        Operand::Uint(..) => accept(a.uint_at(ndx).cmp(&b.uint_at(ndx))),
        Operand::Bool(..) => accept(a.bool_at(ndx).cmp(&b.bool_at(ndx))),
        Operand::Float(..) => a.float_at(ndx).partial_cmp(&b.float_at(ndx)).is_some_and(accept),
    }
}

fn lanes_equal(a: Operand, b: Operand, ndx: usize) -> bool {
    match a {
        Operand::Int(..) => a.int_at(ndx) == b.int_at(ndx),
        Operand::Uint(..) => a.uint_at(ndx) == b.uint_at(ndx),
        Operand::Bool(..) => a.bool_at(ndx) == b.bool_at(ndx),
        Operand::Float(..) => a.float_at(ndx) == b.float_at(ndx),
    }
}

/// `gles3::Functional::ShaderOperatorCase`
struct ShaderOperatorCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
    func: Func,
    /// The declared input types, which decide how `evaluate` reads each one.
    input_types: Vec<DataType>,
    output: DataType,
    result_scale: f32,
    result_bias: f32,
    user_attrib_transforms: Vec<Mat4>,
}

impl ShaderRenderCaseSpec for ShaderOperatorCaseSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (&self.vert_src, &self.frag_src)
    }

    fn is_vertex_case(&self) -> bool {
        self.is_vertex_case
    }

    fn user_attrib_transforms(&self) -> Vec<Mat4> {
        self.user_attrib_transforms.clone()
    }

    /// The generated evaluator, plus `OperatorShaderEvaluator::evaluate`'s own scale and
    /// bias over the whole colour (always a plain constant here - see the file header).
    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        let ins: Vec<Operand> = self
            .input_types
            .iter()
            .enumerate()
            .map(|(ndx, &ty)| read_input(ctx, ndx, ty))
            .collect();
        let out_size = self.output.scalar_size() as usize;
        let result = apply(self.func, &ins, out_size);

        for (ndx, &component) in S_OUT_SWIZZLES[out_size - 1].iter().enumerate() {
            ctx.color[component] = result.float_at(ndx);
        }

        ctx.color = ctx.color * self.result_scale + self.result_bias;
    }
}

const VERTEX: bool = true;
const FRAGMENT: bool = false;

/// `ShaderOperatorCase::ShaderOperatorCase` plus `setupShaderData` - the `#version 300 es`
/// shader sources and the attribute transforms that give each input its declared range.
/// Rust's default `f32` `Display` drops the decimal point for a whole number (`25.0` ->
/// `"25"`), which GLSL parses as an *integer* literal - `color * 25` then fails to compile
/// ("operands to arithmetic operators must be numeric"), found via `angle_and_trigonometry`
/// (`radians`' scale is a plain `25.0`) once the result-scale formatting below stopped
/// truncating to 2 decimals.
fn glsl_float_literal(value: f32) -> String {
    let s = format!("{value}");
    if s.contains(['.', 'e', 'E']) {
        s
    } else {
        format!("{s}.0")
    }
}

/// `ShaderOperatorCase::ShaderOperatorCase` plus `setupShaderData`, shared by every entry in
/// this file.
///
/// `reference_scale_bias`, when `Some`, overrides the scale/bias `ShaderOperatorCaseSpec`
/// uses in `evaluate()` (the host-side reference) without touching what gets embedded in
/// the GLSL text (still `spec.result_scale`/`result_bias`) - upstream's own
/// `BuiltinOperInfoSeparateRefScaleBias`, needed by exactly the two symbolic
/// `unary_operator`/`minus`/`UGT` entries below (see the file header): their GLSL bias is a
/// plain `0.0`, but the *reference* needs a nonzero symbolic one to match a 32-bit host
/// `wrapping_neg` against a driver-precision-width shader result. Every other call site
/// passes `None`, which keeps this identical to the single scale/bias every other entry in
/// this file already had.
fn build_case(
    name: &str,
    is_vertex_case: bool,
    func: Func,
    shader_op: &str,
    spec: &ShaderDataSpec,
    reference_scale_bias: Option<(f32, f32)>,
) -> Box<dyn TestCase> {
    let mut vtx = String::from("#version 300 es\n");
    let mut frag = String::from("#version 300 es\n");

    macro_rules! op_out {
        ($($arg:tt)*) => {
            if is_vertex_case { vtx.push_str(&format!($($arg)*)) } else { frag.push_str(&format!($($arg)*)) }
        };
    }

    let precision = spec.precision.map(Precision::name);

    // Compute precision for inputs. \note Mediump interpolators are used for booleans,
    // and highp for integers - unconditionally, unlike the ES 2.0 port's "bump lowp to
    // mediump" rule, because GLSL ES 3.00 has real integer types to get wrong.
    let input_precision: Vec<&str> = spec
        .inputs
        .iter()
        .map(|input| {
            let is_bool_val = is_bool_data_type(input.type_);
            let is_int_val = is_int_data_type(input.type_) || is_uint_data_type(input.type_);
            if is_bool_val {
                Precision::MediumP.name()
            } else if is_int_val {
                Precision::HighP.name()
            } else {
                spec.precision.map(Precision::name).unwrap_or(Precision::MediumP.name())
            }
        })
        .collect();

    // Attributes.
    vtx.push_str("in highp vec4 a_position;\n");
    for (ndx, prec) in input_precision.iter().enumerate() {
        vtx.push_str(&format!("in {prec} vec4 a_in{ndx};\n"));
    }

    // Colour output.
    frag.push_str("layout(location = 0) out mediump vec4 o_color;\n");

    if is_vertex_case {
        vtx.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    } else {
        for (ndx, prec) in input_precision.iter().enumerate() {
            vtx.push_str(&format!("out {prec} vec4 v_in{ndx};\n"));
            frag.push_str(&format!("in {prec} vec4 v_in{ndx};\n"));
        }
    }

    vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
    frag.push_str("\nvoid main()\n{\n");

    // `hasReference`: whether the result needs a second, highp reference expression plus
    // the bit-diff masking that decides how many of the advertised lowp/mediump bits the
    // driver actually used - see the file header's `common_functions` note. `resultMask`
    // (`FloatScalar::getValueMask`) is always 0 here: every `result_scale` in this file is
    // a plain constant, and only a *symbolic* one (not ported) ever yields a nonzero mask.
    let is_res_bool_out = is_bool_data_type(spec.output);
    let is_res_float_vec = is_float_data_type(spec.output);
    let has_reference = !is_res_float_vec
        && !is_res_bool_out
        && matches!(spec.precision, Some(Precision::LowP) | Some(Precision::MediumP));
    let mut ref_shader_op = shader_op.to_string();

    // Expression inputs.
    let prefix = if is_vertex_case { "a_" } else { "v_" };
    for (ndx, input) in spec.inputs.iter().enumerate() {
        let in_type = input.type_;
        let in_size = in_type.scalar_size() as usize;
        let is_int = is_int_data_type(in_type);
        let is_uint = is_uint_data_type(in_type);
        let is_bool = is_bool_data_type(in_type);
        let type_name = in_type.name();
        let swizzle = SWIZZLE_NAMES[ndx][in_size - 1];
        let has_reference_in = has_reference && !is_bool;

        // For int/uint types with a reference, generate:
        //     highp type highp_inN = ...;
        //     precision type inN = highp_inN;
        // (`highp_inN` is used again below, for the reference expression.)
        let mut line = String::from("\t");
        if let Some(precision) = precision
            && !is_bool
        {
            if has_reference_in {
                line.push_str("highp ");
            } else {
                line.push_str(precision);
                line.push(' ');
            }
        }
        line.push_str(type_name);
        line.push(' ');
        if has_reference_in {
            line.push_str(&format!("highp_in{ndx} = "));
        } else {
            line.push_str(&format!("in{ndx} = "));
        }

        if is_bool {
            line.push_str(if in_size == 1 { "(" } else { "greaterThan(" });
        } else if is_int || is_uint {
            line.push_str(&format!("{type_name}("));
        }

        line.push_str(&format!("{prefix}in{ndx}.{swizzle}"));

        if is_bool {
            if in_size == 1 {
                line.push_str(" > 0.0)");
            } else {
                line.push_str(&format!(", vec{in_size}(0.0))"));
            }
        } else if is_int || is_uint {
            line.push(')');
        }

        line.push_str(";\n");
        op_out!("{line}");

        if has_reference_in {
            let precision = precision.expect("has_reference_in implies a precision-qualified case");
            op_out!("\t{precision} {type_name} in{ndx} = highp_in{ndx};\n");
            ref_shader_op = ref_shader_op.replace(&format!("in{ndx}"), &format!("highp_in{ndx}"));
        }
    }

    // Result variable.
    {
        let out_type_name = spec.output.name();
        let mut line = String::from("\t");
        if let Some(precision) = precision
            && !is_res_bool_out
        {
            line.push_str(precision);
            line.push(' ');
        }
        line.push_str(&format!("{out_type_name} res = {out_type_name}(0.0);\n"));
        if has_reference {
            line.push_str(&format!("\thighp {out_type_name} ref = {out_type_name}(0.0);\n"));
        }
        line.push('\n');
        op_out!("{line}");
    }

    // Expression.
    op_out!("\t{shader_op}\n");
    if has_reference {
        ref_shader_op = ref_shader_op.replace("res", "ref");
        op_out!("\t{ref_shader_op}\n");
    }
    op_out!("\n");

    let out_scalar_size = spec.output.scalar_size();
    // Implementations may use more bits than advertised. Assume an implementation
    // advertising 16 bits for mediump, but actually using 24 bits for a particular
    // operation. We have:
    //
    //     highp ref = expr;
    //     mediump res = expr;
    //
    // We expect res&0xFFFF to be correct, because that ensures that _at least_ 16 bits
    // were provided. However, we also need to make sure that if there is anything in the
    // upper 16 bits of res, that those bits match with ref. In short, we expect to see the
    // following bits (assume the advertised number of bits is N, and the actual
    // calculation is done in M bits):
    //
    //     ref = a31 ... aM aM-1 ... aN aN-1 ... a0
    //     res =   0 ...  0 bM-1 ... bN bN-1 ... b0
    //
    // The test verifies that bN-1 ... b0 is correct based on the shader output. We
    // additionally want to make sure that:
    //  - bM-1 ... bN is identical to aM-1 ... aN
    //  - bits above bM-1 are zero.
    //
    // This is done as follows:
    //     diff = res ^ ref  --> should produce a31 ... aM 0 ... 0
    //     diff == 0: accept res
    //     diff != 0:
    //         lsb = log2((~diff + 1u) & diff)  --> log2(0 .. 0 1 0 ...0) == findLSB(diff)
    //         outOfRangeMask = 0xFFFFFFFF << lsb  --> 1 ... 1 0 ... 0
    //         (res & outOfRangeMask) == 0: accept res
    let float_type = if !is_res_float_vec {
        if out_scalar_size == 1 {
            "float".to_string()
        } else {
            format!("vec{out_scalar_size}")
        }
    } else {
        String::new()
    };

    if has_reference {
        let is_int = is_int_data_type(spec.output);
        let out_type_name = spec.output.name();
        let out_basic_type_name = if is_int { "int" } else { "uint" };

        op_out!("\thighp {out_type_name} diff = res ^ ref;\n");
        op_out!("\tdiff = (~diff + {out_type_name}(1)) & diff;\n");
        op_out!("\thighp {out_type_name} lsb = {out_type_name}(32);\n");
        op_out!("\thighp {out_type_name} outOfRangeMask = {out_type_name}(0);\n");
        if out_scalar_size == 1 {
            op_out!("\tif (diff != {out_type_name}(0))\n\t{{\n");
            op_out!("\t\tlsb = {out_type_name}(log2({float_type}(diff)));\n");
            op_out!("\t\toutOfRangeMask = {out_type_name}(0xFFFFFFFF) << lsb;\n");
            op_out!("\t}}\n");
        } else {
            op_out!("\tbvec{out_scalar_size} isDiffZero = equal(diff, {out_type_name}(0));\n");
            op_out!(
                "\thighp {out_type_name} lsbUnsantized = {out_type_name}(log2(vec{out_scalar_size}((~diff + {out_type_name}(1)) & diff)));\n"
            );
            for channel in 0..out_scalar_size {
                op_out!("\tif (!isDiffZero[{channel}])\n\t{{\n");
                op_out!("\t\tlsb[{channel}] = lsbUnsantized[{channel}];\n");
                op_out!("\t\toutOfRangeMask[{channel}] = {out_basic_type_name}(0xFFFFFFFF) << lsb[{channel}];\n");
                op_out!("\t}}\n");
            }
        }
        op_out!("\thighp {out_type_name} outOfRangeRes = res & outOfRangeMask;\n");
        op_out!("\tif (outOfRangeRes != {out_type_name}(0)) res = {out_type_name}(0);\n");
        op_out!("\n");
    }

    // Convert to colour.
    op_out!("\thighp vec4 color = vec4(0.0, 0.0, 0.0, 1.0);\n");
    let res_expr = if !is_res_float_vec && out_scalar_size == 1 {
        "float(res)".to_string()
    } else if !is_res_float_vec {
        format!("vec{out_scalar_size}(res)")
    } else {
        "res".to_string()
    };
    op_out!(
        "\tcolor.{} = {res_expr};\n",
        OUT_SWIZZLE_NAMES[out_scalar_size as usize - 1]
    );

    // Scale & bias.
    if spec.result_scale != 1.0 || spec.result_bias != 0.0 {
        let mut line = String::from("\tcolor = color");
        if spec.result_scale != 1.0 {
            // `de::toString(resultScale)` upstream - full precision, unlike the bias below
            // (`de::floatToString(resultBias, 2)`, genuinely 2 decimal places there). Every
            // scale in the groups ported before `unary_operator`/`binary_operator` happened
            // to be exactly representable at 2 decimals, which is what let a `{:.2}` here
            // go unnoticed - it collapses `binary_operator`'s `5e-3`/`2e-10`-scale highp
            // entries to the literal `0.00`, discarding the whole result.
            line.push_str(&format!(" * {}", glsl_float_literal(spec.result_scale)));
        }
        if spec.result_bias != 0.0 {
            line.push_str(&format!(" + {:.2}", spec.result_bias));
        }
        line.push_str(";\n");
        op_out!("{line}");
    }

    if is_vertex_case {
        vtx.push_str("    v_color = color;\n");
        frag.push_str("    o_color = v_color;\n");
    } else {
        for ndx in 0..spec.inputs.len() {
            vtx.push_str(&format!("    v_in{ndx} = a_in{ndx};\n"));
        }
        frag.push_str("    o_color = color;\n");
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    // Setup the user attributes: each input's own range, as a transform of the grid's
    // normalized coordinates.
    let user_attrib_transforms = spec
        .inputs
        .iter()
        .enumerate()
        .map(|(input_ndx, value)| {
            let scale = value.range_max - value.range_min;
            let min_bias = value.range_min;
            let max_bias = value.range_max;
            let mut attrib_matrix = Mat4::zero();

            for row_ndx in 0..4 {
                let row = match (row_ndx + input_ndx) % 4 {
                    0 => Vec4::new(scale, 0.0, 0.0, min_bias),
                    1 => Vec4::new(0.0, scale, 0.0, min_bias),
                    2 => Vec4::new(-scale, 0.0, 0.0, max_bias),
                    _ => Vec4::new(0.0, -scale, 0.0, max_bias),
                };
                for col in 0..4 {
                    attrib_matrix.set(row_ndx, col, row[col]);
                }
            }

            attrib_matrix
        })
        .collect();

    let (eval_scale, eval_bias) = reference_scale_bias.unwrap_or((spec.result_scale, spec.result_bias));

    Box::new(ShaderRenderCase::new(ShaderOperatorCaseSpec {
        name: name.to_string(),
        vert_src: vtx,
        frag_src: frag,
        is_vertex_case,
        func,
        input_types: spec.inputs.iter().map(|input| input.type_).collect(),
        output: spec.output,
        result_scale: eval_scale,
        result_bias: eval_bias,
        user_attrib_transforms,
    }))
}

/// `getGLSLUintBits` - `range[0] + 1`. `build_case`'s own `has_reference` bit-diff masking
/// (already exercised by every other `PRECMASK_LOWP`/`PRECMASK_MEDIUMP` `UGT` entry in this
/// file, e.g. `common_functions`' `min`/`max`) is what covers a driver that actually
/// computes in more bits than this advertises - nothing here needs to account for that
/// separately.
fn glsl_uint_bits(gl: &glw::Functions, shader_type_gl: glw::GLenum, precision_type_gl: glw::GLenum) -> i32 {
    let mut range = [0i32; 2];
    let mut precision = 0i32;
    // SAFETY: `range` is two `GLint`s and `precision` one, both stack-allocated and sized
    // exactly to what the driver writes.
    unsafe { gl.get_shader_precision_format(shader_type_gl, precision_type_gl, range.as_mut_ptr(), &mut precision) };
    range[0] + 1
}

/// `nextafterf(x, 0)` for a positive, finite, non-zero `x` (every value this is used on) -
/// the one-ULP-towards-zero step `getGLSLUintMaxAsFloat` needs upstream: casting
/// `2^numBits - 1` to `float` can round *up* past the true integer once `numBits` exceeds
/// f32's 24-bit mantissa, and this undoes exactly that.
fn next_after_towards_zero(x: f32) -> f32 {
    debug_assert!(x > 0.0 && x.is_finite());
    f32::from_bits(x.to_bits() - 1)
}

/// `getGLSLUintMaxAsFloat`.
fn glsl_uint_max_as_float(num_bits: i32) -> f32 {
    let max_as_float = ((1u64 << num_bits) - 1) as f32;
    if num_bits > 24 {
        next_after_towards_zero(max_as_float).floor()
    } else {
        max_as_float
    }
}

/// `unary_operator`'s `minus` on `UGT` at `PRECMASK_LOWP`/`PRECMASK_MEDIUMP` - the 16 cases
/// (`{lowp,mediump}_{uint,uvec2,uvec3,uvec4}_{vertex,fragment}`) `UNARY_OPERATOR_FUNCS`
/// skips (see its own comment and the file header): the only two `FloatScalar` symbol uses
/// in this whole file. Unlike every other entry, these cannot be built by `add_func_cases`
/// at registration time - nothing there has a driver to ask `glGetShaderPrecisionFormat`
/// yet - so each is this small `TestCase` instead, which defers to `build_case` (otherwise
/// completely unchanged) on its own first `iterate()`, once a live `Context` can answer it,
/// caching the result (`OnceLock`, not `RefCell`/`Cell`: `TestCase` carries the same
/// `Send + Sync` bound `ShaderRenderCaseSpec` does).
///
/// The math (verified against upstream's own `FloatScalar`/`OperatorShaderEvaluator`
/// before writing this): the shader computes `negate` in the queried precision's own bit
/// width and scales by `1/uintMax` with a zero bias to land in `[0, 1]`; the host reference
/// instead computes a full 32-bit `wrapping_neg` (`Func::Negate` on `Operand::Uint` already
/// does this) and needs a *different*, nonzero bias (`1 - u32::MAX / uintMax`) applied
/// after the *same* scale to land on the identical value - the two are algebraically equal
/// for any bit width because `(2^bits - x) / uintMax == (2^32 - x) / uintMax + (1 -
/// 2^32 / uintMax)` when `uintMax == 2^bits - 1`. Confirmed empirically too: see this
/// batch's negative control.
struct SymbolicUnaryMinusUintCase {
    name: String,
    is_vertex_case: bool,
    precision: Precision,
    data_type: DataType,
    inner: OnceLock<Box<dyn TestCase>>,
}

impl SymbolicUnaryMinusUintCase {
    fn build(&self, context: &Context) -> Box<dyn TestCase> {
        let gl = context.gl();
        let shader_type_gl = if self.is_vertex_case {
            glw::GL_VERTEX_SHADER
        } else {
            glw::GL_FRAGMENT_SHADER
        };
        let precision_type_gl = match self.precision {
            Precision::LowP => glw::GL_LOW_INT,
            Precision::MediumP => glw::GL_MEDIUM_INT,
            Precision::HighP => unreachable!("only lowp/mediump need the symbolic form"),
        };

        let bits = glsl_uint_bits(gl, shader_type_gl, precision_type_gl);
        let uint_max = glsl_uint_max_as_float(bits);
        let scale = 1.0 / uint_max;
        let reference_bias = 1.0 - (u32::MAX as f32) / uint_max;

        let spec = ShaderDataSpec {
            result_scale: scale,
            result_bias: 0.0,
            precision: Some(self.precision),
            output: self.data_type,
            inputs: vec![ShaderValue {
                type_: self.data_type,
                range_min: 0.0,
                range_max: uint_max,
            }],
        };

        build_case(
            &self.name,
            self.is_vertex_case,
            Func::Negate,
            "res = -in0;",
            &spec,
            Some((scale, reference_bias)),
        )
    }
}

impl TestCase for SymbolicUnaryMinusUintCase {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        self.inner.get_or_init(|| self.build(context)).iterate(context)
    }
}

/// Adds the 16 symbolic `minus`/`UGT` cases above into `unary_operator`'s own `minus`
/// subgroup, alongside the (already-registered, plain-constant) float/int/highp-uint
/// siblings `add_func_cases` builds from `UNARY_OPERATOR_FUNCS`.
fn add_unary_minus_uint_symbolic_cases(group: &mut TestCaseGroup) {
    for precision in [Precision::LowP, Precision::MediumP] {
        for out_scalar_size in 1..=4i32 {
            let data_type = S_UINT_TYPES[out_scalar_size as usize - 1];
            for is_vertex_case in [VERTEX, FRAGMENT] {
                let stage_name = if is_vertex_case { "vertex" } else { "fragment" };
                let name = format!("{}_{}_{stage_name}", precision.name(), data_type.name());
                let case: Box<dyn TestCase> = Box::new(SymbolicUnaryMinusUintCase {
                    name,
                    is_vertex_case,
                    precision,
                    data_type,
                    inner: OnceLock::new(),
                });
                group.add_child(case);
            }
        }
    }
}

/// `ShaderOperatorTests::init`'s inner loop: one `BuiltinFuncInfo` into its cases.
fn add_func_cases(group: &mut TestCaseGroup, func_info: &BuiltinFuncInfo) {
    // Per-input family (float/int/uint/bool) comes from `data_type_for` below, not a
    // whole-case flag - see its own doc comment for why (`left_shift`/`right_shift`'s
    // shift amount is deliberately the opposite family from its base value at times).
    let is_bool_case = func_info.precision_mask == PRECMASK_NA;
    let is_bool_out = func_info.out_value.is_bool_value();
    let is_int_out = func_info.out_value.is_int();
    let is_uint_out = func_info.out_value.is_uint();
    let is_float_out = !is_bool_out && !is_int_out && !is_uint_out;

    for in_scalar_size in 1..=4 {
        let out_scalar_size = if matches!(func_info.out_value, F | B) {
            1
        } else {
            in_scalar_size
        };
        let out_data_type = if is_float_out {
            S_FLOAT_TYPES[out_scalar_size as usize - 1]
        } else if is_int_out {
            S_INT_TYPES[out_scalar_size as usize - 1]
        } else if is_uint_out {
            S_UINT_TYPES[out_scalar_size as usize - 1]
        } else {
            S_BOOL_TYPES[out_scalar_size as usize - 1]
        };

        if !func_info.sizes.has(in_scalar_size) {
            continue;
        }

        for precision in PRECISIONS {
            let precision_applies = func_info.precision_mask & precision_bit(precision) != 0;
            let bool_at_mediump = func_info.precision_mask == PRECMASK_NA && precision == Precision::MediumP;
            if !precision_applies && !bool_at_mediump {
                continue;
            }

            let precision_prefix = if is_bool_case {
                String::new()
            } else {
                format!("{}_", precision.name())
            };

            for is_vertex_case in [VERTEX, FRAGMENT] {
                let is_unary_op = func_info.inputs[1].value_type == ValueType::None;
                let mut name = precision_prefix.clone();

                let mut shader_op = String::from("res = ");
                let mut spec = ShaderDataSpec {
                    result_scale: func_info.result_scale,
                    result_bias: func_info.result_bias,
                    precision: if is_bool_case { None } else { Some(precision) },
                    output: out_data_type,
                    inputs: Vec::new(),
                };

                match func_info.type_ {
                    OperationType::Operator => {
                        if is_unary_op && func_info.is_unary_prefix {
                            shader_op.push_str(func_info.shader_func_name);
                        }
                    }
                    OperationType::Function => {
                        shader_op.push_str(func_info.shader_func_name);
                        shader_op.push('(');
                    }
                    OperationType::SideEffectOperator => shader_op.push_str("in0;\n\t"),
                }

                for input_ndx in 0..MAX_INPUTS {
                    let value = func_info.inputs[input_ndx];
                    let prev_value = func_info.inputs[if input_ndx == 0 { MAX_INPUTS - 1 } else { input_ndx - 1 }];

                    if value.value_type == ValueType::None {
                        continue;
                    }

                    let cur_in_scalar_size = if value.value_type.is_scalar() {
                        1
                    } else {
                        in_scalar_size
                    };
                    let cur_in_data_type = data_type_for(value.value_type, cur_in_scalar_size);

                    // \note Only write input type to case name if different from previous
                    // input type (avoid overly long names) - upstream's `prevInDataType !=
                    // curInDataType`, the *resolved* type of each input on its own (not the
                    // whole case's fundamental type): `left_shift`/`right_shift`'s shift
                    // amount is deliberately the *other* family from its base value at half
                    // of this file's entries ("Second operand (shift amount) can be either
                    // int or uint, even for uint and int first operand, respectively"), so
                    // `cur_in_data_type` has to come from each input's own `value_type`, not
                    // from `func_info.inputs[0]`'s. `refract`'s third operand is always
                    // scalar (`Value(F, ...)`) while its second is `GT`, which is also
                    // scalar at `in_scalar_size == 1` - the two must compare equal there
                    // (both resolve to `float`), and unequal everywhere else.
                    let prev_in_scalar_size = if prev_value.value_type.is_scalar() {
                        1
                    } else {
                        in_scalar_size
                    };
                    let prev_in_data_type = data_type_for(prev_value.value_type, prev_in_scalar_size);
                    if input_ndx == 0 || prev_in_data_type != cur_in_data_type {
                        name.push_str(cur_in_data_type.name());
                        name.push('_');
                    }

                    match func_info.type_ {
                        OperationType::Operator | OperationType::Function => {
                            if input_ndx != 0 {
                                if func_info.type_ == OperationType::Operator && !is_unary_op {
                                    shader_op.push_str(&format!(" {} ", func_info.shader_func_name));
                                } else {
                                    shader_op.push_str(", ");
                                }
                            }
                            shader_op.push_str(&format!("in{input_ndx}"));
                            if func_info.type_ == OperationType::Operator && is_unary_op && !func_info.is_unary_prefix {
                                shader_op.push_str(func_info.shader_func_name);
                            }
                        }
                        OperationType::SideEffectOperator => {
                            if input_ndx != 0 || (is_unary_op && func_info.is_unary_prefix) {
                                if is_unary_op {
                                    shader_op.push_str(func_info.shader_func_name);
                                } else {
                                    shader_op.push_str(&format!(" {} ", func_info.shader_func_name));
                                }
                            }
                            if input_ndx == 0 {
                                shader_op.push_str("res");
                            } else {
                                shader_op.push_str(&format!("in{input_ndx}"));
                            }
                            if is_unary_op && !func_info.is_unary_prefix {
                                shader_op.push_str(func_info.shader_func_name);
                            }
                        }
                    }

                    spec.inputs.push(ShaderValue {
                        type_: cur_in_data_type,
                        range_min: value.range_min,
                        range_max: value.range_max,
                    });
                }

                if func_info.type_ == OperationType::Function {
                    shader_op.push(')');
                }
                shader_op.push(';');

                name.push_str(if is_vertex_case { "vertex" } else { "fragment" });

                group.add_child(build_case(
                    &name,
                    is_vertex_case,
                    func_info.func,
                    &shader_op,
                    &spec,
                    None,
                ));
            }
        }
    }
}

impl ValueType {
    fn is_bool_value(self) -> bool {
        matches!(self, Self::Bool | Self::BoolVec | Self::BoolGenType)
    }
}

/// `s_selectionInfo`'s own 16 types, in upstream's own order.
const SELECTION_TYPES: [DataType; 16] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Uint,
    DataType::UintVec2,
    DataType::UintVec3,
    DataType::UintVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
];

/// "The `?:` selection operator" - a flat group, one case per (type, precision, stage), with
/// booleans skipping the precision axis entirely (mediump-only, no precision prefix in the
/// name) exactly like `unary_operator`'s own bool entries elsewhere in this file.
fn add_selection_cases(group: &mut TestCaseGroup) {
    for cur_type in SELECTION_TYPES {
        let is_bool_case = is_bool_data_type(cur_type);
        let is_float_case = is_float_data_type(cur_type);
        let is_uint_case = is_uint_data_type(cur_type);

        for precision in PRECISIONS {
            if is_bool_case && precision != Precision::MediumP {
                // Use mediump interpolators for booleans.
                continue;
            }
            let precision_prefix = if is_bool_case {
                String::new()
            } else {
                format!("{}_", precision.name())
            };

            let (result_scale, result_bias) = if is_bool_case {
                (1.0, 0.0)
            } else if is_float_case {
                (0.5, 0.5)
            } else if is_uint_case {
                (0.5, 0.0)
            } else {
                (0.1, 0.5)
            };
            let (range_min, range_max) = if is_bool_case || is_float_case {
                (-1.0, 1.0)
            } else if is_uint_case {
                (0.0, 2.0)
            } else {
                (-5.0, 5.0)
            };

            for is_vertex_case in [VERTEX, FRAGMENT] {
                let stage_name = if is_vertex_case { "vertex" } else { "fragment" };
                let name = format!("{precision_prefix}{}_{stage_name}", cur_type.name());

                let spec = ShaderDataSpec {
                    result_scale,
                    result_bias,
                    precision: if is_bool_case { None } else { Some(precision) },
                    output: cur_type,
                    inputs: vec![
                        ShaderValue {
                            type_: DataType::Bool,
                            range_min: -1.0,
                            range_max: 1.0,
                        },
                        ShaderValue {
                            type_: cur_type,
                            range_min,
                            range_max,
                        },
                        ShaderValue {
                            type_: cur_type,
                            range_min,
                            range_max,
                        },
                    ],
                };

                group.add_child(build_case(
                    &name,
                    is_vertex_case,
                    Func::Selection,
                    "res = in0 ? in1 : in2;",
                    &spec,
                    None,
                ));
            }
        }
    }
}

/// `s_sequenceCases`, in upstream's own order (four `no_side_effects`, then four
/// `side_effects`). Each case's own `expression` is the literal GLSL upstream passes to
/// `ShaderOperatorCase` (wrapped in `res = (...)`, matching upstream's own
/// `"res = (" + expressionStr + ");"`), and `func` is the matching hand-derived reference in
/// `apply` above.
struct SequenceCase {
    contains_side_effects: bool,
    case_name: &'static str,
    expression: &'static str,
    input_types: &'static [DataType],
    result_type: DataType,
    func: Func,
}

const SEQUENCE_CASES: &[SequenceCase] = &[
    SequenceCase {
        contains_side_effects: false,
        case_name: "vec4",
        expression: "in0, in2 + in1, in1 + in0",
        input_types: &[DataType::FloatVec4, DataType::FloatVec4, DataType::FloatVec4],
        result_type: DataType::FloatVec4,
        func: Func::SeqNoSideEff0,
    },
    SequenceCase {
        contains_side_effects: false,
        case_name: "float_uint",
        expression: "in0 + in2, in1 + in1",
        input_types: &[DataType::Float, DataType::Uint, DataType::Float],
        result_type: DataType::Uint,
        func: Func::SeqNoSideEff1,
    },
    SequenceCase {
        contains_side_effects: false,
        case_name: "bool_vec2",
        expression: "in0 && in1, in0, ivec2(vec2(in0) + in2)",
        input_types: &[DataType::Bool, DataType::Bool, DataType::FloatVec2],
        result_type: DataType::IntVec2,
        func: Func::SeqNoSideEff2,
    },
    SequenceCase {
        contains_side_effects: false,
        case_name: "vec4_ivec4_bvec4",
        expression: "in0 + vec4(in1), in2, in1",
        input_types: &[DataType::FloatVec4, DataType::IntVec4, DataType::BoolVec4],
        result_type: DataType::IntVec4,
        func: Func::SeqNoSideEff3,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "vec4",
        expression: "in0++, in1 = in0 + in2, in2 = in1",
        input_types: &[DataType::FloatVec4, DataType::FloatVec4, DataType::FloatVec4],
        result_type: DataType::FloatVec4,
        func: Func::SeqSideEff0,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "float_uint",
        expression: "in1++, in0 = float(in1), in1 = uint(in0 + in2)",
        input_types: &[DataType::Float, DataType::Uint, DataType::Float],
        result_type: DataType::Uint,
        func: Func::SeqSideEff1,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "bool_vec2",
        expression: "in1 = in0, in2++, in2 = in2 + vec2(in1), ivec2(in2)",
        input_types: &[DataType::Bool, DataType::Bool, DataType::FloatVec2],
        result_type: DataType::IntVec2,
        func: Func::SeqSideEff2,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "vec4_ivec4_bvec4",
        expression: "in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++",
        input_types: &[DataType::FloatVec4, DataType::IntVec4, DataType::BoolVec4],
        result_type: DataType::IntVec4,
        func: Func::SeqSideEff3,
    },
];

/// "The sequence operator (comma)" - splits into `no_side_effects`/`side_effects` subgroups,
/// each flat (one case per (case, precision, stage), unlike `selection` there is no bool
/// special-casing: every `SEQUENCE_CASES` entry always carries a real precision).
fn add_sequence_cases(no_side_eff_group: &mut TestCaseGroup, side_eff_group: &mut TestCaseGroup) {
    for case in SEQUENCE_CASES {
        for precision in PRECISIONS {
            let inputs = case
                .input_types
                .iter()
                .map(|&type_| {
                    let (range_min, range_max) = if is_float_data_type(type_) {
                        (-0.5, 0.5)
                    } else if is_int_data_type(type_) {
                        (-2.0, 2.0)
                    } else if is_uint_data_type(type_) {
                        (0.0, 2.0)
                    } else {
                        (-1.0, 1.0)
                    };
                    ShaderValue {
                        type_,
                        range_min,
                        range_max,
                    }
                })
                .collect();

            let spec = ShaderDataSpec {
                result_scale: 0.5,
                result_bias: 0.0,
                precision: Some(precision),
                output: case.result_type,
                inputs,
            };
            let shader_op = format!("res = ({});", case.expression);

            for is_vertex_case in [VERTEX, FRAGMENT] {
                let stage_name = if is_vertex_case { "vertex" } else { "fragment" };
                let name = format!("{}_{}_{stage_name}", precision.name(), case.case_name);

                let target = if case.contains_side_effects {
                    &mut *side_eff_group
                } else {
                    &mut *no_side_eff_group
                };
                target.add_child(build_case(&name, is_vertex_case, case.func, &shader_op, &spec, None));
            }
        }
    }
}

/// `ShaderOperatorTests::init`, restricted to the groups listed in the file header.
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("operator");

    for outer_group_info in func_info_groups() {
        let mut outer_group = TestCaseGroup::new(outer_group_info.name);
        let mut inner_group: Option<TestCaseGroup> = None;

        for func_info in &outer_group_info.func_infos {
            if inner_group.as_ref().is_none_or(|g| g.name() != func_info.case_name) {
                if let Some(mut previous) = inner_group.take() {
                    // The 16 symbolic `minus`/`UGT` cases `UNARY_OPERATOR_FUNCS` itself
                    // skips (see its own comment) belong in this same subgroup, alongside
                    // the plain-constant siblings `add_func_cases` just finished adding to
                    // it - added here, at the point `minus`'s own inner group is about to
                    // be finalized, not folded into `add_func_cases` itself.
                    if outer_group_info.name == "unary_operator" && previous.name() == "minus" {
                        add_unary_minus_uint_symbolic_cases(&mut previous);
                    }
                    outer_group.add_child(previous);
                }
                inner_group = Some(TestCaseGroup::new(func_info.case_name));
            }

            add_func_cases(inner_group.as_mut().expect("just created"), func_info);
        }

        if let Some(mut last) = inner_group.take() {
            if outer_group_info.name == "unary_operator" && last.name() == "minus" {
                add_unary_minus_uint_symbolic_cases(&mut last);
            }
            outer_group.add_child(last);
        }

        group.add_child(outer_group);
    }

    let mut selection_group = TestCaseGroup::new("selection");
    add_selection_cases(&mut selection_group);
    group.add_child(selection_group);

    let mut sequence_group = TestCaseGroup::new("sequence");
    let mut no_side_eff_group = TestCaseGroup::new("no_side_effects");
    let mut side_eff_group = TestCaseGroup::new("side_effects");
    add_sequence_cases(&mut no_side_eff_group, &mut side_eff_group);
    sequence_group.add_child(no_side_eff_group);
    sequence_group.add_child(side_eff_group);
    group.add_child(sequence_group);

    group
}

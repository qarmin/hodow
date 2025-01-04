// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderOperatorTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream declares one `eval_<func>_<type>` per (operation, operand shape) through the
// `DECLARE_*_FUNCS` macros - several hundred functions, each one reading its inputs at a
// fixed swizzle and writing the result at another. Every one of them is the same three
// steps, and all three are already stated by the case's own `ShaderDataSpec`: read input
// `i` through `S_IN_SWIZZLES[i]` at that input's declared type and size, apply the
// operation, write the result through `S_OUT_SWIZZLES`. `evaluate` below does exactly
// that once, so `Func` names the operation alone and the shapes stay in the tables.
//
// That collapse is also what removes the vec-and-scalar duplicates: `modVecFloat` is
// `mod` whose second input is declared scalar, not a second operation, so a size-1
// operand broadcasts in `apply` and one `Func::Mod` covers both rows of the table.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::shader_util::{DataType, Precision};
use crate::glu::{TestCase, TestCaseGroup};
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

/// `PrecisionMask`
const PRECMASK_NA: u32 = 0;
const PRECMASK_LOWP: u32 = 1 << 0;
const PRECMASK_MEDIUMP: u32 = 1 << 1;
const PRECMASK_HIGHP: u32 = 1 << 2;
const PRECMASK_MEDIUMP_HIGHP: u32 = PRECMASK_MEDIUMP | PRECMASK_HIGHP;
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
}

// Upstream's shorthands, used verbatim in the tables below.
use ValueType::{
    Bool as B, BoolGenType as BGT, BoolVec as BV, Float as F, FloatGenType as GT, FloatVec as FV, Int as I,
    IntGenType as IGT, IntVec as IV, Vec3 as V3,
};

impl ValueType {
    /// `isScalarType`
    fn is_scalar(self) -> bool {
        matches!(self, Self::Float | Self::Bool | Self::Int)
    }

    fn is_bool(self) -> bool {
        matches!(self, Self::Bool | Self::BoolVec | Self::BoolGenType)
    }

    fn is_int(self) -> bool {
        matches!(self, Self::Int | Self::IntVec | Self::IntGenType)
    }
}

/// `Value`
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

/// `OperationType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum OperationType {
    Function,
    Operator,
    /// Test the side-effect (as opposed to the result) of a side-effect operator.
    SideEffectOperator,
}

/// The operation an evaluator applies. Upstream reaches each of these through its own
/// generated `eval_*` function per operand shape; the shape lives in `Eval::sizes` and in
/// the case's declared input types instead.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Func {
    Nop,
    Negate,
    AddOne,
    SubOne,
    Add,
    Sub,
    Mul,
    Div,
    Selection,
    BoolNot,
    LogicalAnd,
    LogicalOr,
    LogicalXor,

    Radians,
    Degrees,
    Sin,
    Cos,
    Tan,
    Asin,
    Acos,
    Atan,
    Atan2,
    Pow,
    Exp,
    Log,
    Exp2,
    Log2,
    Sqrt,
    InverseSqrt,
    Abs,
    Sign,
    Floor,
    Ceil,
    Fract,
    Mod,
    Min,
    Max,
    Clamp,
    Mix,
    Step,
    SmoothStep,

    Length,
    Distance,
    Dot,
    Cross,
    Normalize,
    FaceForward,
    Reflect,
    Refract,

    AllEqual,
    AnyNotEqual,
    LessThan,
    LessThanEqual,
    GreaterThan,
    GreaterThanEqual,
    Equal,
    NotEqual,
    Any,
    All,

    /// The eight `sequence*Case*` references, which are one expression each rather than a
    /// lanewise operation.
    SequenceNoSideEffCase0,
    SequenceNoSideEffCase1,
    SequenceNoSideEffCase2,
    SequenceNoSideEffCase3,
    SequenceSideEffCase0,
    SequenceSideEffCase1,
    SequenceSideEffCase2,
    SequenceSideEffCase3,
}

/// Which input scalar sizes upstream declares an `eval_*` function for. A size with no
/// evaluator is skipped, which is how `cross` ends up vec3-only and `logicalAnd` scalar-only.
#[derive(Clone, Copy, PartialEq, Eq)]
enum Sizes {
    /// `*_GENTYPE_FUNCS` - scalar through vec4.
    All,
    /// `*_VEC_FUNCS` - vec2 through vec4, the scalar entry being null.
    VecOnly,
    /// A single `eval_*_{float,int,bool}` with three nulls after it.
    ScalarOnly,
    /// `cross`, whose only evaluator is the vec3 one.
    Vec3Only,
}

impl Sizes {
    fn has(self, in_scalar_size: i32) -> bool {
        match self {
            Self::All => true,
            Self::VecOnly => in_scalar_size >= 2,
            Self::ScalarOnly => in_scalar_size == 1,
            Self::Vec3Only => in_scalar_size == 3,
        }
    }
}

/// `BuiltinFuncInfo`
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
    /// Whether a unary operator is a prefix operator; redundant unless unary.
    is_unary_prefix: bool,
}

#[allow(clippy::too_many_arguments)]
const fn builtin_func_info(
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
    type_: OperationType,
    is_unary_prefix: bool,
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
        type_,
        is_unary_prefix,
    }
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
    builtin_func_info(
        case_name,
        shader_func_name,
        out_value,
        input0,
        input1,
        input2,
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        OperationType::Function,
        true,
    )
}

/// `BuiltinOperInfo`
#[allow(clippy::too_many_arguments)]
const fn oper_info(
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
    builtin_func_info(
        case_name,
        shader_func_name,
        out_value,
        input0,
        input1,
        input2,
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        OperationType::Operator,
        true,
    )
}

/// `BuiltinPostOperInfo` - for postfix (unary) operators.
#[allow(clippy::too_many_arguments)]
const fn post_oper_info(
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
    builtin_func_info(
        case_name,
        shader_func_name,
        out_value,
        input0,
        input1,
        input2,
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        OperationType::Operator,
        false,
    )
}

/// `BuiltinSideEffOperInfo`
#[allow(clippy::too_many_arguments)]
const fn side_eff_oper_info(
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
    builtin_func_info(
        case_name,
        shader_func_name,
        out_value,
        input0,
        input1,
        input2,
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        OperationType::SideEffectOperator,
        true,
    )
}

/// `BuiltinPostSideEffOperInfo` - for postfix (unary) operators, testing side-effect.
#[allow(clippy::too_many_arguments)]
const fn post_side_eff_oper_info(
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
    builtin_func_info(
        case_name,
        shader_func_name,
        out_value,
        input0,
        input1,
        input2,
        result_scale,
        result_bias,
        precision_mask,
        func,
        sizes,
        OperationType::SideEffectOperator,
        false,
    )
}

/// `BuiltinFuncGroup`
struct BuiltinFuncGroup {
    name: &'static str,
    func_infos: &'static [BuiltinFuncInfo],
}

// The value one operand carries during evaluation. A scalar is size 1 and broadcasts.
#[derive(Clone, Copy)]
enum Operand {
    Float(usize, [f32; 4]),
    Int(usize, [i32; 4]),
    Bool(usize, [bool; 4]),
}

impl Operand {
    fn size(self) -> usize {
        match self {
            Self::Float(n, _) | Self::Int(n, _) | Self::Bool(n, _) => n,
        }
    }

    fn float_at(self, ndx: usize) -> f32 {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx],
            Self::Int(_, d) => d[ndx] as f32,
            Self::Bool(_, d) => f32::from(d[ndx]),
        }
    }

    fn int_at(self, ndx: usize) -> i32 {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx] as i32,
            Self::Int(_, d) => d[ndx],
            Self::Bool(_, d) => i32::from(d[ndx]),
        }
    }

    fn bool_at(self, ndx: usize) -> bool {
        let ndx = if self.size() == 1 { 0 } else { ndx };
        match self {
            Self::Float(_, d) => d[ndx] > 0.0,
            Self::Int(_, d) => d[ndx] != 0,
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

/// `s_floatTypes` / `s_intTypes` / `s_boolTypes`
const S_FLOAT_TYPES: [DataType; 4] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
];
const S_INT_TYPES: [DataType; 4] = [DataType::Int, DataType::IntVec2, DataType::IntVec3, DataType::IntVec4];
const S_BOOL_TYPES: [DataType; 4] = [
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
];

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

fn is_float_data_type(data_type: DataType) -> bool {
    matches!(
        data_type,
        DataType::Float | DataType::FloatVec2 | DataType::FloatVec3 | DataType::FloatVec4
    )
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
    } else if is_int_data_type(data_type) {
        // `chopToInt` / `asInt()`, i.e. truncation toward zero.
        Operand::Int(size, std::array::from_fn(|ndx| raw[ndx] as i32))
    } else {
        Operand::Float(size, raw)
    }
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

fn dot_product(a: &[f32; 4], b: &[f32; 4], size: usize) -> f32 {
    (0..size).map(|ndx| a[ndx] * b[ndx]).sum()
}

/// The result of one evaluation, in the output type's own terms.
enum Result {
    Float([f32; 4]),
    Int([i32; 4]),
    Bool([bool; 4]),
}

impl Result {
    fn float_at(&self, ndx: usize) -> f32 {
        match self {
            Self::Float(d) => d[ndx],
            Self::Int(d) => d[ndx] as f32,
            Self::Bool(d) => f32::from(d[ndx]),
        }
    }
}

/// Every operation in `Func`, applied to the operands the case declared. Upstream's
/// generated evaluators differ from one another only in how they read and write; this is
/// what is left once that is factored out.
fn apply(func: Func, ins: &[Operand], out_size: usize) -> Result {
    let float_lanes =
        |f: &dyn Fn(usize) -> f32| Result::Float(std::array::from_fn(|ndx| if ndx < out_size { f(ndx) } else { 0.0 }));
    let int_lanes =
        |f: &dyn Fn(usize) -> i32| Result::Int(std::array::from_fn(|ndx| if ndx < out_size { f(ndx) } else { 0 }));
    let bool_lanes = |f: &dyn Fn(usize) -> bool| {
        Result::Bool(std::array::from_fn(|ndx| if ndx < out_size { f(ndx) } else { false }))
    };

    // An operation over integers when its first operand is one, over floats otherwise -
    // upstream picks between the `INT_GENTYPE` and `FLOAT_GENTYPE` evaluator the same way.
    let is_int = matches!(ins[0], Operand::Int(..));

    match func {
        Func::Nop => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx))
            }
        }
        Func::Negate => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_neg())
            } else {
                float_lanes(&|ndx| -ins[0].float_at(ndx))
            }
        }
        Func::AddOne => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_add(1))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx) + 1.0)
            }
        }
        Func::SubOne => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_sub(1))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx) - 1.0)
            }
        }
        Func::Add => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_add(ins[1].int_at(ndx)))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx) + ins[1].float_at(ndx))
            }
        }
        Func::Sub => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_sub(ins[1].int_at(ndx)))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx) - ins[1].float_at(ndx))
            }
        }
        Func::Mul => {
            if is_int {
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_mul(ins[1].int_at(ndx)))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx) * ins[1].float_at(ndx))
            }
        }
        Func::Div => {
            if is_int {
                // The table keeps every int divisor away from zero; `wrapping_div` only
                // guards the one value C would leave undefined anyway.
                int_lanes(&|ndx| ins[0].int_at(ndx).wrapping_div(ins[1].int_at(ndx)))
            } else {
                float_lanes(&|ndx| ins[0].float_at(ndx) / ins[1].float_at(ndx))
            }
        }
        Func::Selection => {
            let cond = ins[0].bool_at(0);
            let picked = if cond { ins[1] } else { ins[2] };
            match picked {
                Operand::Int(..) => int_lanes(&|ndx| picked.int_at(ndx)),
                Operand::Bool(..) => bool_lanes(&|ndx| picked.bool_at(ndx)),
                Operand::Float(..) => float_lanes(&|ndx| picked.float_at(ndx)),
            }
        }

        Func::BoolNot => bool_lanes(&|ndx| !ins[0].bool_at(ndx)),
        Func::LogicalAnd => bool_lanes(&|ndx| ins[0].bool_at(ndx) && ins[1].bool_at(ndx)),
        Func::LogicalOr => bool_lanes(&|ndx| ins[0].bool_at(ndx) || ins[1].bool_at(ndx)),
        Func::LogicalXor => bool_lanes(&|ndx| ins[0].bool_at(ndx) != ins[1].bool_at(ndx)),

        Func::Radians => float_lanes(&|ndx| ins[0].float_at(ndx).to_radians()),
        Func::Degrees => float_lanes(&|ndx| ins[0].float_at(ndx).to_degrees()),
        Func::Sin => float_lanes(&|ndx| ins[0].float_at(ndx).sin()),
        Func::Cos => float_lanes(&|ndx| ins[0].float_at(ndx).cos()),
        Func::Tan => float_lanes(&|ndx| ins[0].float_at(ndx).tan()),
        Func::Asin => float_lanes(&|ndx| ins[0].float_at(ndx).asin()),
        Func::Acos => float_lanes(&|ndx| ins[0].float_at(ndx).acos()),
        Func::Atan => float_lanes(&|ndx| ins[0].float_at(ndx).atan()),
        Func::Atan2 => float_lanes(&|ndx| ins[0].float_at(ndx).atan2(ins[1].float_at(ndx))),
        Func::Pow => float_lanes(&|ndx| ins[0].float_at(ndx).powf(ins[1].float_at(ndx))),
        Func::Exp => float_lanes(&|ndx| ins[0].float_at(ndx).exp()),
        Func::Log => float_lanes(&|ndx| ins[0].float_at(ndx).ln()),
        Func::Exp2 => float_lanes(&|ndx| ins[0].float_at(ndx).exp2()),
        Func::Log2 => float_lanes(&|ndx| ins[0].float_at(ndx).log2()),
        Func::Sqrt => float_lanes(&|ndx| ins[0].float_at(ndx).sqrt()),
        Func::InverseSqrt => float_lanes(&|ndx| 1.0 / ins[0].float_at(ndx).sqrt()),
        Func::Abs => float_lanes(&|ndx| ins[0].float_at(ndx).abs()),
        Func::Sign => float_lanes(&|ndx| tcu_sign(ins[0].float_at(ndx))),
        Func::Floor => float_lanes(&|ndx| ins[0].float_at(ndx).floor()),
        Func::Ceil => float_lanes(&|ndx| ins[0].float_at(ndx).ceil()),
        Func::Fract => float_lanes(&|ndx| tcu_fract(ins[0].float_at(ndx))),
        Func::Mod => float_lanes(&|ndx| tcu_mod(ins[0].float_at(ndx), ins[1].float_at(ndx))),
        Func::Min => float_lanes(&|ndx| ins[0].float_at(ndx).min(ins[1].float_at(ndx))),
        Func::Max => float_lanes(&|ndx| ins[0].float_at(ndx).max(ins[1].float_at(ndx))),
        Func::Clamp => float_lanes(&|ndx| ins[0].float_at(ndx).clamp(ins[1].float_at(ndx), ins[2].float_at(ndx))),
        Func::Mix => float_lanes(&|ndx| tcu_mix(ins[0].float_at(ndx), ins[1].float_at(ndx), ins[2].float_at(ndx))),
        Func::Step => float_lanes(&|ndx| tcu_step(ins[0].float_at(ndx), ins[1].float_at(ndx))),
        Func::SmoothStep => {
            float_lanes(&|ndx| tcu_smooth_step(ins[0].float_at(ndx), ins[1].float_at(ndx), ins[2].float_at(ndx)))
        }

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

        Func::AllEqual => {
            let size = ins[0].size();
            let equal = (0..size).all(|ndx| lanes_equal(ins[0], ins[1], ndx));
            bool_lanes(&|_| equal)
        }
        Func::AnyNotEqual => {
            let size = ins[0].size();
            let not_equal = (0..size).any(|ndx| !lanes_equal(ins[0], ins[1], ndx));
            bool_lanes(&|_| not_equal)
        }
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

        // Reference for expression "in0, in2 + in1, in1 + in0"
        Func::SequenceNoSideEffCase0 => float_lanes(&|ndx| ins[1].float_at(ndx) + ins[0].float_at(ndx)),
        // Reference for expression "in0 + in2, in1 + in1"
        Func::SequenceNoSideEffCase1 => {
            let value = ins[1].int_at(0).wrapping_add(ins[1].int_at(0));
            int_lanes(&|_| value)
        }
        // Reference for expression "in0 && in1, in0, ivec2(vec2(in0) + in2)"
        Func::SequenceNoSideEffCase2 => {
            let in0 = f32::from(ins[0].bool_at(0));
            int_lanes(&|ndx| (in0 + ins[2].float_at(ndx)) as i32)
        }
        // Reference for expression "in0 + vec4(in1), in2, in1"
        Func::SequenceNoSideEffCase3 => int_lanes(&|ndx| ins[1].int_at(ndx)),
        // Reference for expression "in0++, in1 = in0 + in2, in2 = in1"
        Func::SequenceSideEffCase0 => float_lanes(&|ndx| ins[0].float_at(ndx) + 1.0 + ins[2].float_at(ndx)),
        // Reference for expression "in1++, in0 = float(in1), in1 = int(in0 + in2)"
        Func::SequenceSideEffCase1 => {
            let value = (ins[1].int_at(0) as f32 + 1.0 + ins[2].float_at(0)) as i32;
            int_lanes(&|_| value)
        }
        // Reference for expression "in1 = in0, in2++, in2 = in2 + vec2(in1), ivec2(in2)"
        Func::SequenceSideEffCase2 => {
            let in0 = f32::from(ins[0].bool_at(0));
            int_lanes(&|ndx| (ins[2].float_at(ndx) + 1.0 + in0) as i32)
        }
        // Reference for expression "in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++"
        Func::SequenceSideEffCase3 => int_lanes(&|ndx| {
            let in0 = ins[0].float_at(ndx) + f32::from(ins[2].bool_at(ndx));
            ins[1].int_at(ndx).wrapping_add(in0 as i32)
        }),
    }
}

/// One lane of a comparison, at the operands' own type: integers compare as integers, the
/// way upstream's `chopToInt` forms do, and booleans as booleans.
fn compare_lane(a: Operand, b: Operand, ndx: usize, accept: fn(std::cmp::Ordering) -> bool) -> bool {
    match a {
        Operand::Int(..) => accept(a.int_at(ndx).cmp(&b.int_at(ndx))),
        Operand::Bool(..) => accept(a.bool_at(ndx).cmp(&b.bool_at(ndx))),
        Operand::Float(..) => a.float_at(ndx).partial_cmp(&b.float_at(ndx)).is_some_and(accept),
    }
}

fn lanes_equal(a: Operand, b: Operand, ndx: usize) -> bool {
    match a {
        Operand::Int(..) => a.int_at(ndx) == b.int_at(ndx),
        Operand::Bool(..) => a.bool_at(ndx) == b.bool_at(ndx),
        Operand::Float(..) => a.float_at(ndx) == b.float_at(ndx),
    }
}

/// `gles2::Functional::ShaderOperatorCase`
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

    /// The generated `eval_*` function, plus `OperatorShaderEvaluator::evaluate`'s own
    /// scale and bias over the whole colour.
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

/// `ShaderOperatorCase::ShaderOperatorCase` - the shader sources and the attribute
/// transforms that give each input its declared range.
fn build_case(
    name: &str,
    is_vertex_case: bool,
    func: Func,
    shader_op: &str,
    spec: &ShaderDataSpec,
) -> Box<dyn TestCase> {
    let mut vtx = String::new();
    let mut frag = String::new();

    macro_rules! op_out {
        ($($arg:tt)*) => {
            if is_vertex_case { vtx.push_str(&format!($($arg)*)) } else { frag.push_str(&format!($($arg)*)) }
        };
    }

    let precision = spec.precision.map(Precision::name);

    // Compute precision for inputs.
    // \note Mediump interpolators are used for booleans and lowp ints.
    let input_precision: Vec<&str> = spec
        .inputs
        .iter()
        .map(|input| {
            let is_bool_val = is_bool_data_type(input.type_);
            let is_int_val = is_int_data_type(input.type_);
            if is_bool_val || (is_int_val && spec.precision == Some(Precision::LowP)) {
                Precision::MediumP.name()
            } else {
                spec.precision.map(Precision::name).unwrap_or(Precision::MediumP.name())
            }
        })
        .collect();

    // Attributes.
    vtx.push_str("attribute highp vec4 a_position;\n");
    for (ndx, prec) in input_precision.iter().enumerate() {
        vtx.push_str(&format!("attribute {prec} vec4 a_in{ndx};\n"));
    }

    if is_vertex_case {
        vtx.push_str("varying mediump vec4 v_color;\n");
        frag.push_str("varying mediump vec4 v_color;\n");
    } else {
        for (ndx, prec) in input_precision.iter().enumerate() {
            vtx.push_str(&format!("varying {prec} vec4 v_in{ndx};\n"));
            frag.push_str(&format!("varying {prec} vec4 v_in{ndx};\n"));
        }
    }

    vtx.push_str("\nvoid main()\n{\n    gl_Position = a_position;\n");
    frag.push_str("\nvoid main()\n{\n");

    // Expression inputs.
    let prefix = if is_vertex_case { "a_" } else { "v_" };
    for (ndx, input) in spec.inputs.iter().enumerate() {
        let in_type = input.type_;
        let in_size = in_type.scalar_size() as usize;
        let is_int = is_int_data_type(in_type);
        let is_bool = is_bool_data_type(in_type);
        let type_name = in_type.name();
        let swizzle = SWIZZLE_NAMES[ndx][in_size - 1];

        let mut line = String::from("\t");
        if let Some(precision) = precision
            && !is_bool
        {
            line.push_str(precision);
            line.push(' ');
        }
        line.push_str(&format!("{type_name} in{ndx} = "));

        if is_bool {
            line.push_str(if in_size == 1 { "(" } else { "greaterThan(" });
        } else if is_int {
            line.push_str(&format!("{type_name}("));
        }

        line.push_str(&format!("{prefix}in{ndx}.{swizzle}"));

        if is_bool {
            if in_size == 1 {
                line.push_str(" > 0.0)");
            } else {
                line.push_str(&format!(", vec{in_size}(0.0))"));
            }
        } else if is_int {
            line.push(')');
        }

        line.push_str(";\n");
        op_out!("{line}");
    }

    // Result variable.
    {
        let out_type_name = spec.output.name();
        let is_bool_out = is_bool_data_type(spec.output);
        let mut line = String::from("\t");
        if let Some(precision) = precision
            && !is_bool_out
        {
            line.push_str(precision);
            line.push(' ');
        }
        line.push_str(&format!("{out_type_name} res = {out_type_name}(0.0);\n\n"));
        op_out!("{line}");
    }

    // Expression.
    op_out!("\t{shader_op}\n\n");

    // Convert to color.
    let is_res_float_vec = is_float_data_type(spec.output);
    let out_scalar_size = spec.output.scalar_size();

    op_out!("\tmediump vec4 color = vec4(0.0, 0.0, 0.0, 1.0);\n");
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
            line.push_str(&format!(" * {:.2}", spec.result_scale));
        }
        if spec.result_bias != 0.0 {
            line.push_str(&format!(" + {:.2}", spec.result_bias));
        }
        line.push_str(";\n");
        op_out!("{line}");
    }

    if is_vertex_case {
        vtx.push_str("    v_color = color;\n");
        frag.push_str("    gl_FragColor = v_color;\n");
    } else {
        for ndx in 0..spec.inputs.len() {
            vtx.push_str(&format!("    v_in{ndx} = a_in{ndx};\n"));
        }
        frag.push_str("    gl_FragColor = color;\n");
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

    Box::new(ShaderRenderCase::new(ShaderOperatorCaseSpec {
        name: name.to_string(),
        vert_src: vtx,
        frag_src: frag,
        is_vertex_case,
        func,
        input_types: spec.inputs.iter().map(|input| input.type_).collect(),
        output: spec.output,
        result_scale: spec.result_scale,
        result_bias: spec.result_bias,
        user_attrib_transforms,
    }))
}

/// `s_inSwizzles`, as the shader spells them.
const SWIZZLE_NAMES: [[&str; 4]; MAX_INPUTS] = [
    ["z", "wy", "zxy", "yzwx"],
    ["x", "yx", "yzx", "wzyx"],
    ["y", "zy", "wyz", "xwzy"],
];

/// `s_outSwizzles`, as the shader spells them.
const OUT_SWIZZLE_NAMES: [&str; 4] = ["x", "yz", "xyz", "xyzw"];

/// `ShaderOperatorTests::init`'s inner loop: one `BuiltinFuncInfo` into its cases.
fn add_func_cases(group: &mut TestCaseGroup, func_info: &BuiltinFuncInfo) {
    let is_bool_case = func_info.precision_mask == PRECMASK_NA;
    let is_int_case = func_info.inputs[0].value_type.is_int();
    // \todo [petri] Better check.
    let is_float_case = !is_bool_case && !is_int_case;
    let is_bool_out = func_info.out_value.is_bool();
    let is_int_out = func_info.out_value.is_int();
    let is_float_out = !is_bool_out && !is_int_out;

    for in_scalar_size in 1..=4 {
        // \todo [petri] Int.
        let out_scalar_size = if matches!(func_info.out_value, F | B) {
            1
        } else {
            in_scalar_size
        };
        let out_data_type = if is_float_out {
            S_FLOAT_TYPES[out_scalar_size as usize - 1]
        } else if is_int_out {
            S_INT_TYPES[out_scalar_size as usize - 1]
        } else {
            S_BOOL_TYPES[out_scalar_size as usize - 1]
        };

        // Skip if no valid eval func.
        // \todo [petri] Better check for V3 only etc. cases?
        if !func_info.sizes.has(in_scalar_size) {
            continue;
        }

        for precision in PRECISIONS {
            // use mediump interpolators for booleans
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

                // Generate shader op.
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
                        continue; // Skip unused input.
                    }

                    let cur_in_scalar_size = if value.value_type.is_scalar() {
                        1
                    } else {
                        in_scalar_size
                    };
                    let cur_in_data_type = if is_float_case {
                        S_FLOAT_TYPES[cur_in_scalar_size as usize - 1]
                    } else if is_int_case {
                        S_INT_TYPES[cur_in_scalar_size as usize - 1]
                    } else {
                        S_BOOL_TYPES[cur_in_scalar_size as usize - 1]
                    };

                    // \note Only write input type to case name if different from previous
                    // input type (avoid overly long names).
                    if input_ndx == 0 || prev_value.value_type.is_scalar() != value.value_type.is_scalar() {
                        name.push_str(cur_in_data_type.name());
                        name.push('_');
                    }

                    // Generate op input source.
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
                                let pad = if is_unary_op { "" } else { " " };
                                shader_op.push_str(&format!("{pad}{}{pad}", func_info.shader_func_name));
                            }

                            // \note in0 has already been assigned to res, so start from in1.
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

                group.add_child(build_case(&name, is_vertex_case, func_info.func, &shader_op, &spec));
            }
        }
    }
}

/// `ShaderOperatorTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("operator");

    for outer_group_info in FUNC_INFO_GROUPS {
        let mut outer_group = TestCaseGroup::new(outer_group_info.name);

        // Only create new group if name differs from previous one.
        let mut inner_group: Option<TestCaseGroup> = None;

        for func_info in outer_group_info.func_infos {
            if inner_group.as_ref().is_none_or(|g| g.name() != func_info.case_name) {
                if let Some(previous) = inner_group.take() {
                    outer_group.add_child(previous);
                }
                inner_group = Some(TestCaseGroup::new(func_info.case_name));
            }

            add_func_cases(inner_group.as_mut().expect("just created"), func_info);
        }

        if let Some(last) = inner_group.take() {
            outer_group.add_child(last);
        }

        group.add_child(outer_group);
    }

    group.add_child(create_selection_tests());
    group.add_child(create_sequence_tests());

    group
}

/// `s_selectionInfo` - the `?:` selection operator, over each operand type.
const SELECTION_TYPES: [DataType; 12] = [
    DataType::Float,
    DataType::FloatVec2,
    DataType::FloatVec3,
    DataType::FloatVec4,
    DataType::Int,
    DataType::IntVec2,
    DataType::IntVec3,
    DataType::IntVec4,
    DataType::Bool,
    DataType::BoolVec2,
    DataType::BoolVec3,
    DataType::BoolVec4,
];

/// The `?:` selection operator half of `ShaderOperatorTests::init`.
fn create_selection_tests() -> TestCaseGroup {
    let mut selection_group = TestCaseGroup::new("selection");

    for cur_type in SELECTION_TYPES {
        let is_bool_case = is_bool_data_type(cur_type);
        let is_float_case = is_float_data_type(cur_type);
        let data_type_str = cur_type.name();

        for precision in PRECISIONS {
            // Use mediump interpolators for booleans.
            if is_bool_case && precision != Precision::MediumP {
                continue;
            }

            let precision_prefix = if is_bool_case {
                String::new()
            } else {
                format!("{}_", precision.name())
            };

            for is_vertex_case in [VERTEX, FRAGMENT] {
                let name = format!(
                    "{precision_prefix}{data_type_str}_{}",
                    if is_vertex_case { "vertex" } else { "fragment" }
                );

                let (range_min, range_max) = if is_bool_case || is_float_case {
                    (-1.0, 1.0)
                } else {
                    (-5.0, 5.0)
                };
                let spec = ShaderDataSpec {
                    result_scale: if is_bool_case {
                        1.0
                    } else if is_float_case {
                        0.5
                    } else {
                        0.1
                    },
                    result_bias: if is_bool_case { 0.0 } else { 0.5 },
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

                selection_group.add_child(build_case(
                    &name,
                    is_vertex_case,
                    Func::Selection,
                    "res = in0 ? in1 : in2;",
                    &spec,
                ));
            }
        }
    }

    selection_group
}

/// `s_sequenceCases`
struct SequenceCase {
    contains_side_effects: bool,
    case_name: &'static str,
    expression_str: &'static str,
    input_types: &'static [DataType],
    result_type: DataType,
    func: Func,
}

const SEQUENCE_CASES: [SequenceCase; 8] = [
    SequenceCase {
        contains_side_effects: false,
        case_name: "vec4",
        expression_str: "in0, in2 + in1, in1 + in0",
        input_types: &[DataType::FloatVec4, DataType::FloatVec4, DataType::FloatVec4],
        result_type: DataType::FloatVec4,
        func: Func::SequenceNoSideEffCase0,
    },
    SequenceCase {
        contains_side_effects: false,
        case_name: "float_int",
        expression_str: "in0 + in2, in1 + in1",
        input_types: &[DataType::Float, DataType::Int, DataType::Float],
        result_type: DataType::Int,
        func: Func::SequenceNoSideEffCase1,
    },
    SequenceCase {
        contains_side_effects: false,
        case_name: "bool_vec2",
        expression_str: "in0 && in1, in0, ivec2(vec2(in0) + in2)",
        input_types: &[DataType::Bool, DataType::Bool, DataType::FloatVec2],
        result_type: DataType::IntVec2,
        func: Func::SequenceNoSideEffCase2,
    },
    SequenceCase {
        contains_side_effects: false,
        case_name: "vec4_ivec4_bvec4",
        expression_str: "in0 + vec4(in1), in2, in1",
        input_types: &[DataType::FloatVec4, DataType::IntVec4, DataType::BoolVec4],
        result_type: DataType::IntVec4,
        func: Func::SequenceNoSideEffCase3,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "vec4",
        expression_str: "in0++, in1 = in0 + in2, in2 = in1",
        input_types: &[DataType::FloatVec4, DataType::FloatVec4, DataType::FloatVec4],
        result_type: DataType::FloatVec4,
        func: Func::SequenceSideEffCase0,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "float_int",
        expression_str: "in1++, in0 = float(in1), in1 = int(in0 + in2)",
        input_types: &[DataType::Float, DataType::Int, DataType::Float],
        result_type: DataType::Int,
        func: Func::SequenceSideEffCase1,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "bool_vec2",
        expression_str: "in1 = in0, in2++, in2 = in2 + vec2(in1), ivec2(in2)",
        input_types: &[DataType::Bool, DataType::Bool, DataType::FloatVec2],
        result_type: DataType::IntVec2,
        func: Func::SequenceSideEffCase2,
    },
    SequenceCase {
        contains_side_effects: true,
        case_name: "vec4_ivec4_bvec4",
        expression_str: "in0 = in0 + vec4(in2), in1 = in1 + ivec4(in0), in1++",
        input_types: &[DataType::FloatVec4, DataType::IntVec4, DataType::BoolVec4],
        result_type: DataType::IntVec4,
        func: Func::SequenceSideEffCase3,
    },
];

/// The sequence operator (comma) half of `ShaderOperatorTests::init`, plus the three
/// regression cases for evaluation order that follow it.
fn create_sequence_tests() -> TestCaseGroup {
    let mut sequence_group = TestCaseGroup::new("sequence");
    let mut no_side_eff_group = TestCaseGroup::new("no_side_effects");
    let mut side_eff_group = TestCaseGroup::new("side_effects");

    for case in &SEQUENCE_CASES {
        for precision in PRECISIONS {
            for is_vertex_case in [VERTEX, FRAGMENT] {
                let name = format!(
                    "{}_{}_{}",
                    precision.name(),
                    case.case_name,
                    if is_vertex_case { "vertex" } else { "fragment" }
                );

                let inputs = case
                    .input_types
                    .iter()
                    .map(|&type_| {
                        let (range_min, range_max) = if is_float_data_type(type_) {
                            (-0.5, 0.5)
                        } else if is_int_data_type(type_) {
                            (-2.0, 2.0)
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

                let expression = format!("res = ({});", case.expression_str);
                let group = if case.contains_side_effects {
                    &mut side_eff_group
                } else {
                    &mut no_side_eff_group
                };
                group.add_child(build_case(&name, is_vertex_case, case.func, &expression, &spec));
            }
        }
    }

    // Regression tests for sequence operator.
    // http://khronos.org/registry/webgl/sdk/tests/conformance/glsl/bugs/sequence-operator-evaluation-order.html
    for (name, frag_src) in SEQUENCE_REGRESSION_CASES {
        let case: Box<dyn TestCase> = Box::new(ShaderRenderCase::new(SequenceRegressionCaseSpec {
            name: name.to_string(),
            frag_src,
        }));
        side_eff_group.add_child(case);
    }

    sequence_group.add_child(no_side_eff_group);
    sequence_group.add_child(side_eff_group);
    sequence_group
}

/// The `Case` class declared inline at the end of `ShaderOperatorTests::init`: a fixed
/// fragment shader that paints green when the driver evaluated the sequence in order.
struct SequenceRegressionCaseSpec {
    name: String,
    frag_src: &'static str,
}

impl ShaderRenderCaseSpec for SequenceRegressionCaseSpec {
    fn name(&self) -> &str {
        &self.name
    }

    fn shader_sources(&self) -> (&str, &str) {
        (
            "attribute vec4 a_position;\nvoid main()\n{\n    gl_Position = a_position;\n}\n",
            self.frag_src,
        )
    }

    fn is_vertex_case(&self) -> bool {
        false
    }

    fn evaluate(&self, ctx: &mut ShaderEvalContext) {
        ctx.color = Vec4::new(0.0, 1.0, 0.0, 1.0); // green
    }
}

// ESSL 1.00 section 5.9, about sequence operator:
// "All expressions are evaluated, in order, from left to right"
// Also use a ternary operator where the third operand has side effects to make sure
// only the second operand is evaluated.
const SEQUENCE_REGRESSION_CASES: [(&str, &str); 3] = [
    (
        "affect_ternary",
        "precision mediump float;\n\
         bool correct = true;\n\
         uniform float u_zero;\n\
         float wrong() {\n\
         \x20   correct = false;\n\
         \x20   return 0.0;\n\
         }\n\
         void main() {\n\
         \x20   float a = u_zero - 0.5; // Result should be -0.5.\n\
         \x20   float green = (a++, a > 0.0 ? 1.0 : wrong());\n\
         \x20   gl_FragColor = vec4(0.0, correct ? green : 0.0, 0.0, 1.0);\n\
         }\n",
    ),
    (
        "affect_and",
        "precision mediump float;\n\
         uniform bool u_false;\n\
         bool sideEffectA = false;\n\
         bool funcA() {\n\
         \x20   sideEffectA = true;\n\
         \x20   return true;\n\
         }\n\
         bool sideEffectB = false;\n\
         bool funcB() {\n\
         \x20   sideEffectB = true;\n\
         \x20   return true;\n\
         }\n\
         void main() {\n\
         \x20   bool b = (funcA(), u_false == sideEffectA && funcB());\n\
         \x20   gl_FragColor = (!b && sideEffectA && !sideEffectB) ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);\n\
         }\n",
    ),
    (
        "affect_or",
        "precision mediump float;\n\
         uniform bool u_false;\n\
         bool sideEffectA = false;\n\
         bool funcA() {\n\
         \x20   sideEffectA = true;\n\
         \x20   return false;\n\
         }\n\
         bool sideEffectB = false;\n\
         bool funcB() {\n\
         \x20   sideEffectB = true;\n\
         \x20   return false;\n\
         }\n\
         void main() {\n\
         \x20   bool b = (funcA(), (u_false == !sideEffectA) || funcB());\n\
         \x20   gl_FragColor = (b && sideEffectA && !sideEffectB) ? vec4(0, 1, 0, 1) : vec4(1, 0, 0, 1);\n\
         }\n",
    ),
];

// The `funcInfoGroups` tables, in upstream's own order. `Sizes` replaces the four
// nullable `eval_*` pointers: `All` is `*_GENTYPE_FUNCS`, `VecOnly` is `*_VEC_FUNCS`,
// `ScalarOnly` a lone scalar evaluator, `Vec3Only` is `cross`.
use Sizes::{All as ALL_SIZES, ScalarOnly as SCALAR_ONLY, Vec3Only as VEC3_ONLY, VecOnly as VEC_ONLY};

/// Unary operator tests
const UNARY_OPERATOR_FUNCS: &[BuiltinFuncInfo] = &[
    oper_info(
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
    oper_info(
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
    oper_info(
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
    oper_info(
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
    oper_info(
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
    // Pre/post incr/decr side effect cases.
    side_eff_oper_info(
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
    side_eff_oper_info(
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
    side_eff_oper_info(
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
    side_eff_oper_info(
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
    post_side_eff_oper_info(
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
    post_side_eff_oper_info(
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
    post_side_eff_oper_info(
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
    post_side_eff_oper_info(
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
    // Pre/post incr/decr result cases.
    oper_info(
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
    oper_info(
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
    oper_info(
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
    oper_info(
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
    post_oper_info(
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
    post_oper_info(
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
    post_oper_info(
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
    post_oper_info(
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
];

/// Binary operator tests
const BINARY_OPERATOR_FUNCS: &[BuiltinFuncInfo] = &[
    // Arithmetic operators.
    oper_info(
        "add",
        "+",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Add,
        ALL_SIZES,
    ),
    oper_info(
        "add",
        "+",
        IGT,
        v(IGT, -4.0, 6.0),
        v(IGT, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        ALL_SIZES,
    ),
    oper_info(
        "add",
        "+",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    oper_info(
        "add",
        "+",
        IV,
        v(IV, -4.0, 6.0),
        v(I, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    oper_info(
        "add",
        "+",
        FV,
        v(F, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    oper_info(
        "add",
        "+",
        IV,
        v(I, -4.0, 6.0),
        v(IV, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    oper_info(
        "sub",
        "-",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Sub,
        ALL_SIZES,
    ),
    oper_info(
        "sub",
        "-",
        IGT,
        v(IGT, -4.0, 6.0),
        v(IGT, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        ALL_SIZES,
    ),
    oper_info(
        "sub",
        "-",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    oper_info(
        "sub",
        "-",
        IV,
        v(IV, -4.0, 6.0),
        v(I, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    oper_info(
        "sub",
        "-",
        FV,
        v(F, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    oper_info(
        "sub",
        "-",
        IV,
        v(I, -4.0, 6.0),
        v(IV, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    oper_info(
        "mul",
        "*",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Mul,
        ALL_SIZES,
    ),
    oper_info(
        "mul",
        "*",
        IGT,
        v(IGT, -4.0, 6.0),
        v(IGT, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        ALL_SIZES,
    ),
    oper_info(
        "mul",
        "*",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    oper_info(
        "mul",
        "*",
        IV,
        v(IV, -4.0, 6.0),
        v(I, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    oper_info(
        "mul",
        "*",
        FV,
        v(F, -1.0, 1.0),
        v(FV, -1.0, 1.0),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    oper_info(
        "mul",
        "*",
        IV,
        v(I, -4.0, 6.0),
        v(IV, -6.0, 5.0),
        NOT_USED,
        0.1,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    oper_info(
        "div",
        "/",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -2.0, -0.5),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Div,
        ALL_SIZES,
    ),
    oper_info(
        "div",
        "/",
        IGT,
        v(IGT, 24.0, 24.0),
        v(IGT, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        ALL_SIZES,
    ),
    oper_info(
        "div",
        "/",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -2.0, -0.5),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    oper_info(
        "div",
        "/",
        IV,
        v(IV, 24.0, 24.0),
        v(I, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    oper_info(
        "div",
        "/",
        FV,
        v(F, -1.0, 1.0),
        v(FV, -2.0, -0.5),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    oper_info(
        "div",
        "/",
        IV,
        v(I, 24.0, 24.0),
        v(IV, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    // Arithmetic assignment side effect cases.
    side_eff_oper_info(
        "add_assign_effect",
        "+=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "add_assign_effect",
        "+=",
        IGT,
        v(IGT, -5.0, 5.0),
        v(IGT, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "add_assign_effect",
        "+=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "add_assign_effect",
        "+=",
        IV,
        v(IV, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "sub_assign_effect",
        "-=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "sub_assign_effect",
        "-=",
        IGT,
        v(IGT, -5.0, 5.0),
        v(IGT, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "sub_assign_effect",
        "-=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "sub_assign_effect",
        "-=",
        IV,
        v(IV, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "mul_assign_effect",
        "*=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "mul_assign_effect",
        "*=",
        IGT,
        v(IGT, -4.0, 4.0),
        v(IGT, -4.0, 4.0),
        NOT_USED,
        0.03,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "mul_assign_effect",
        "*=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "mul_assign_effect",
        "*=",
        IV,
        v(IV, -4.0, 4.0),
        v(I, -4.0, 4.0),
        NOT_USED,
        0.03,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "div_assign_effect",
        "/=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -2.0, -0.5),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Div,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "div_assign_effect",
        "/=",
        IGT,
        v(IGT, 24.0, 24.0),
        v(IGT, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        ALL_SIZES,
    ),
    side_eff_oper_info(
        "div_assign_effect",
        "/=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -2.0, -0.5),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    side_eff_oper_info(
        "div_assign_effect",
        "/=",
        IV,
        v(IV, 24.0, 24.0),
        v(I, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    // Arithmetic assignment result cases.
    oper_info(
        "add_assign_result",
        "+=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        ALL_SIZES,
    ),
    oper_info(
        "add_assign_result",
        "+=",
        IGT,
        v(IGT, -5.0, 5.0),
        v(IGT, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        ALL_SIZES,
    ),
    oper_info(
        "add_assign_result",
        "+=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    oper_info(
        "add_assign_result",
        "+=",
        IV,
        v(IV, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Add,
        VEC_ONLY,
    ),
    oper_info(
        "sub_assign_result",
        "-=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        ALL_SIZES,
    ),
    oper_info(
        "sub_assign_result",
        "-=",
        IGT,
        v(IGT, -5.0, 5.0),
        v(IGT, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        ALL_SIZES,
    ),
    oper_info(
        "sub_assign_result",
        "-=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    oper_info(
        "sub_assign_result",
        "-=",
        IV,
        v(IV, -5.0, 5.0),
        v(I, -5.0, 5.0),
        NOT_USED,
        0.05,
        0.5,
        PRECMASK_ALL,
        Func::Sub,
        VEC_ONLY,
    ),
    oper_info(
        "mul_assign_result",
        "*=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        ALL_SIZES,
    ),
    oper_info(
        "mul_assign_result",
        "*=",
        IGT,
        v(IGT, -4.0, 4.0),
        v(IGT, -4.0, 4.0),
        NOT_USED,
        0.03,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        ALL_SIZES,
    ),
    oper_info(
        "mul_assign_result",
        "*=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -1.0, 1.0),
        NOT_USED,
        0.5,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    oper_info(
        "mul_assign_result",
        "*=",
        IV,
        v(IV, -4.0, 4.0),
        v(I, -4.0, 4.0),
        NOT_USED,
        0.03,
        0.5,
        PRECMASK_ALL,
        Func::Mul,
        VEC_ONLY,
    ),
    oper_info(
        "div_assign_result",
        "/=",
        GT,
        v(GT, -1.0, 1.0),
        v(GT, -2.0, -0.5),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Div,
        ALL_SIZES,
    ),
    oper_info(
        "div_assign_result",
        "/=",
        IGT,
        v(IGT, 24.0, 24.0),
        v(IGT, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        ALL_SIZES,
    ),
    oper_info(
        "div_assign_result",
        "/=",
        FV,
        v(FV, -1.0, 1.0),
        v(F, -2.0, -0.5),
        NOT_USED,
        0.25,
        0.5,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    oper_info(
        "div_assign_result",
        "/=",
        IV,
        v(IV, 24.0, 24.0),
        v(I, -4.0, -1.0),
        NOT_USED,
        0.04,
        1.0,
        PRECMASK_ALL,
        Func::Div,
        VEC_ONLY,
    ),
    // Scalar relational operators.
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    // Equality comparison operators.
    oper_info(
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
    ),
    oper_info(
        "equal",
        "==",
        B,
        v(IGT, -5.5, 4.7),
        v(IGT, -4.9, 5.8),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AllEqual,
        ALL_SIZES,
    ),
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
        "not_equal",
        "!=",
        B,
        v(IGT, -5.5, 4.7),
        v(IGT, -4.9, 5.8),
        NOT_USED,
        1.0,
        0.0,
        PRECMASK_ALL,
        Func::AnyNotEqual,
        ALL_SIZES,
    ),
    oper_info(
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
    ),
    // Logical operators.
    oper_info(
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
    ),
    oper_info(
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
    ),
    oper_info(
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

/// `funcInfoGroups`
const FUNC_INFO_GROUPS: &[BuiltinFuncGroup] = &[
    BuiltinFuncGroup {
        name: "unary_operator",
        func_infos: UNARY_OPERATOR_FUNCS,
    },
    BuiltinFuncGroup {
        name: "binary_operator",
        func_infos: BINARY_OPERATOR_FUNCS,
    },
    BuiltinFuncGroup {
        name: "angle_and_trigonometry",
        func_infos: ANGLE_AND_TRIGONOMETRY_FUNCS,
    },
    BuiltinFuncGroup {
        name: "exponential",
        func_infos: EXPONENTIAL_FUNCS,
    },
    BuiltinFuncGroup {
        name: "common_functions",
        func_infos: COMMON_FUNCS,
    },
    BuiltinFuncGroup {
        name: "geometric",
        func_infos: GEOMETRIC_FUNCS,
    },
    BuiltinFuncGroup {
        name: "float_compare",
        func_infos: FLOAT_COMPARE_FUNCS,
    },
    BuiltinFuncGroup {
        name: "int_compare",
        func_infos: INT_COMPARE_FUNCS,
    },
    BuiltinFuncGroup {
        name: "bool_compare",
        func_infos: BOOL_COMPARE_FUNCS,
    },
];

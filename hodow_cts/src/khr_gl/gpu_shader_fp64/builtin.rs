// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (BuiltinFunctionTest, its function objects and `Math`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Upstream's function object templates (`unary`, `binaryByComponent`, `tenary`, ...) over `tcu::Vector`/`tcu::Matrix` become one `evaluate` over component vectors: a value is a flat list of components (matrices column-major, as `pack<tcu::Matrix>` lays them out) tagged with its `VarType`. The uniform and result byte layouts are computed with the same formulas.

use std::ffi::CString;

use crate::glu::{self, Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::{TestError, TestOutcome, TestStatus};

/// A GL call with a current context and with pointers into live locals of the right size.
macro_rules! gl {
    ($call:expr) => {
        // SAFETY: every call is made with a current context and with pointers into live locals of the right size.
        unsafe { $call }
    };
}

const EPSILON: f64 = 0.00002;
const N_VERTICES: u32 = 1024;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Base {
    Double,
    Int,
    Uint,
}

/// `Utils::_variable_type`, as a base type and the number of columns and rows
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
struct VarType {
    base: Base,
    columns: u32,
    rows: u32,
}

impl VarType {
    const fn double(columns: u32, rows: u32) -> Self {
        Self {
            base: Base::Double,
            columns,
            rows,
        }
    }

    const fn int(rows: u32) -> Self {
        Self {
            base: Base::Int,
            columns: 1,
            rows,
        }
    }

    const fn uint(rows: u32) -> Self {
        Self {
            base: Base::Uint,
            columns: 1,
            rows,
        }
    }

    fn components(self) -> u32 {
        self.columns * self.rows
    }

    /// `getBaseVariableTypeComponentSize`
    fn component_size(self) -> u32 {
        match self.base {
            Base::Double => 8,
            Base::Int | Base::Uint => 4,
        }
    }

    /// `getVariableTypeString`
    fn glsl_name(self) -> String {
        let (scalar, vector, matrix) = match self.base {
            Base::Double => ("double", "dvec", "dmat"),
            Base::Int => ("int", "ivec", "imat"),
            Base::Uint => ("uint", "uvec", "umat"),
        };
        match (self.columns, self.rows) {
            (1, 1) => scalar.to_string(),
            (1, rows) => format!("{vector}{rows}"),
            (columns, rows) if columns == rows => format!("{matrix}{columns}"),
            (columns, rows) => format!("{matrix}{columns}x{rows}"),
        }
    }
}

/// Components of one argument or result
#[derive(Clone, Debug)]
enum Value {
    D(Vec<f64>),
    I(Vec<i32>),
    U(Vec<u32>),
}

impl Value {
    fn d(&self) -> &[f64] {
        match self {
            Self::D(values) => values,
            _ => panic!("not a double value"),
        }
    }

    fn i(&self) -> &[i32] {
        match self {
            Self::I(values) => values,
            _ => panic!("not an int value"),
        }
    }

    fn u(&self) -> &[u32] {
        match self {
            Self::U(values) => values,
            _ => panic!("not a uint value"),
        }
    }

    fn decode(type_: VarType, bytes: &[u8]) -> Self {
        let count = type_.components() as usize;
        match type_.base {
            Base::Double => Self::D(
                (0..count)
                    .map(|i| f64::from_ne_bytes(bytes[i * 8..i * 8 + 8].try_into().expect("8 bytes")))
                    .collect(),
            ),
            Base::Int => Self::I(
                (0..count)
                    .map(|i| i32::from_ne_bytes(bytes[i * 4..i * 4 + 4].try_into().expect("4 bytes")))
                    .collect(),
            ),
            Base::Uint => Self::U(
                (0..count)
                    .map(|i| u32::from_ne_bytes(bytes[i * 4..i * 4 + 4].try_into().expect("4 bytes")))
                    .collect(),
            ),
        }
    }

    fn describe(&self) -> String {
        match self {
            Self::D(values) => values.iter().map(f64::to_string).collect::<Vec<_>>().join(", "),
            Self::I(values) => values.iter().map(i32::to_string).collect::<Vec<_>>().join(", "),
            Self::U(values) => values.iter().map(u32::to_string).collect::<Vec<_>>().join(", "),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum Function {
    Abs,
    Ceil,
    Clamp,
    ClampAgainstScalar,
    Cross,
    Determinant,
    Distance,
    Dot,
    Equal,
    FaceForward,
    Floor,
    Fma,
    Fract,
    Frexp,
    GreaterThan,
    GreaterThanEqual,
    Inverse,
    InverseSqrt,
    Ldexp,
    LessThan,
    LessThanEqual,
    Length,
    MatrixCompMult,
    Max,
    MaxAgainstScalar,
    Min,
    MinAgainstScalar,
    Mix,
    Mod,
    ModAgainstScalar,
    Modf,
    Normalize,
    NotEqual,
    OuterProduct,
    PackDouble2x32,
    Reflect,
    Refract,
    Round,
    RoundEven,
    Sign,
    Smoothstep,
    SmoothstepAgainstScalar,
    Sqrt,
    Step,
    StepAgainstScalar,
    Transpose,
    Trunc,
    UnpackDouble2x32,
    IsNan,
    IsInf,
}

/// The case name and the GLSL name of each function, in the order of `FunctionEnum`.
const FUNCTIONS: [(&str, &str, Function); 50] = [
    ("abs", "abs", Function::Abs),
    ("ceil", "ceil", Function::Ceil),
    ("clamp", "clamp", Function::Clamp),
    ("clamp_against_scalar", "clamp", Function::ClampAgainstScalar),
    ("cross", "cross", Function::Cross),
    ("determinant", "determinant", Function::Determinant),
    ("distance", "distance", Function::Distance),
    ("dot", "dot", Function::Dot),
    ("equal", "equal", Function::Equal),
    ("faceforward", "faceforward", Function::FaceForward),
    ("floor", "floor", Function::Floor),
    ("fma", "fma", Function::Fma),
    ("fract", "fract", Function::Fract),
    ("frexp", "frexp", Function::Frexp),
    ("greaterthan", "greaterThan", Function::GreaterThan),
    ("greaterthanequal", "greaterThanEqual", Function::GreaterThanEqual),
    ("inverse", "inverse", Function::Inverse),
    ("inversesqrt", "inversesqrt", Function::InverseSqrt),
    ("ldexp", "ldexp", Function::Ldexp),
    ("lessthan", "lessThan", Function::LessThan),
    ("lessthanequal", "lessThanEqual", Function::LessThanEqual),
    ("length", "length", Function::Length),
    ("matrixcompmult", "matrixCompMult", Function::MatrixCompMult),
    ("max", "max", Function::Max),
    ("max_against_scalar", "max", Function::MaxAgainstScalar),
    ("min", "min", Function::Min),
    ("min_against_scalar", "min", Function::MinAgainstScalar),
    ("mix", "mix", Function::Mix),
    ("mod", "mod", Function::Mod),
    ("mod_against_scalar", "mod", Function::ModAgainstScalar),
    ("modf", "modf", Function::Modf),
    ("normalize", "normalize", Function::Normalize),
    ("notequal", "notEqual", Function::NotEqual),
    ("outerproduct", "outerProduct", Function::OuterProduct),
    ("packdouble2x32", "packDouble2x32", Function::PackDouble2x32),
    ("reflect", "reflect", Function::Reflect),
    ("refract", "refract", Function::Refract),
    ("round", "round", Function::Round),
    ("roundeven", "roundEven", Function::RoundEven),
    ("sign", "sign", Function::Sign),
    ("smoothstep", "smoothstep", Function::Smoothstep),
    (
        "smoothstep_against_scalar",
        "smoothstep",
        Function::SmoothstepAgainstScalar,
    ),
    ("sqrt", "sqrt", Function::Sqrt),
    ("step", "step", Function::Step),
    ("step_against_scalar", "step", Function::StepAgainstScalar),
    ("transpose", "transpose", Function::Transpose),
    ("trunc", "trunc", Function::Trunc),
    ("unpackdouble2x32", "unpackDouble2x32", Function::UnpackDouble2x32),
    ("isnan", "isnan", Function::IsNan),
    ("isinf", "isinf", Function::IsInf),
];

/// `TypeDefinition`: name, columns, rows
const TYPES: [(&str, u32, u32); 13] = [
    ("double", 1, 1),
    ("dvec2", 1, 2),
    ("dvec3", 1, 3),
    ("dvec4", 1, 4),
    ("dmat2", 2, 2),
    ("dmat2x3", 2, 3),
    ("dmat2x4", 2, 4),
    ("dmat3x2", 3, 2),
    ("dmat3", 3, 3),
    ("dmat3x4", 3, 4),
    ("dmat4x2", 4, 2),
    ("dmat4x3", 4, 3),
    ("dmat4", 4, 4),
];

#[derive(Clone, Copy, PartialEq, Eq)]
enum GeneralType {
    Scalar,
    Vector,
    Matrix,
}

/// `BuiltinFunctionTest::isFunctionImplemented`
fn is_function_implemented(function: Function, columns: u32, rows: u32) -> bool {
    // SCALAR, VECTOR, MATRIX
    const LOOK_UP_TABLE: [[bool; 3]; 50] = [
        [true, true, false],
        [true, true, false],
        [true, true, false],
        [false, true, false],
        [false, true, false],
        [false, false, true],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [true, true, false],
        [true, true, false],
        [true, true, false],
        [true, true, false],
        [false, true, false],
        [false, true, false],
        [false, false, true],
        [true, true, false],
        [true, true, false],
        [false, true, false],
        [false, true, false],
        [false, true, false],
        [false, false, true],
        [true, true, false],
        [false, true, false],
        [true, true, false],
        [false, true, false],
        [true, true, false],
        [true, true, false],
        [false, true, false],
        [true, true, false],
        [false, true, false],
        [false, true, false],
        [false, false, true],
        [true, false, false],
        [false, true, false],
        [false, true, false],
        [true, true, false],
        [true, true, false],
        [true, false, false],
        [true, true, false],
        [false, true, false],
        [true, true, false],
        [true, true, false],
        [false, true, false],
        [false, false, false],
        [true, true, false],
        [true, false, false],
        [true, true, false],
        [true, true, false],
    ];

    let general_type = if columns == 1 {
        if rows == 1 {
            GeneralType::Scalar
        } else {
            GeneralType::Vector
        }
    } else {
        GeneralType::Matrix
    };
    let function_index = FUNCTIONS
        .iter()
        .position(|&(_, _, candidate)| candidate == function)
        .expect("every function is listed");
    let mut result = LOOK_UP_TABLE[function_index][general_type as usize];
    if result {
        match function {
            Function::Cross => result = rows == 3,
            Function::Determinant | Function::Inverse => result = columns == rows,
            _ => {}
        }
    }
    result
}

fn align32(value: u32, alignment: u32) -> u32 {
    value.div_ceil(alignment) * alignment
}

/// `BuiltinFunctionTest::functionObject`: the types of the arguments and of the results, and how to compute the results.
struct FunctionObject {
    function: Function,
    name: &'static str,
    arguments: Vec<VarType>,
    results: Vec<VarType>,
}

impl FunctionObject {
    #[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
    fn argument_stride(&self, argument: usize) -> u32 {
        self.arguments[argument].components() * self.arguments[argument].component_size()
    }

    #[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
    fn argument_offset(&self, argument: usize) -> u32 {
        (0..argument).map(|i| self.argument_stride(i)).sum()
    }

    #[expect(dead_code, reason = "ported with upstream's helpers, no caller yet")]
    fn arguments_stride(&self) -> u32 {
        (0..self.arguments.len()).map(|i| self.argument_stride(i)).sum()
    }

    fn base_type_size(&self, result: usize) -> u32 {
        self.results[result].component_size()
    }

    fn result_stride_of(&self, result: usize) -> u32 {
        self.results[result].components() * self.base_type_size(result)
    }

    fn result_offset(&self, result: usize) -> u32 {
        let mut offset = 0;
        for i in 0..result {
            offset += self.result_stride_of(i);
            offset = align32(offset, self.base_type_size(i));
        }
        offset
    }

    fn results_stride(&self) -> u32 {
        let mut stride = 0;
        let mut max_alignment = 0;
        for i in 0..self.results.len() {
            let alignment = self.base_type_size(i);
            stride += self.result_stride_of(i);
            stride = align32(stride, alignment);
            max_alignment = max_alignment.max(alignment);
        }
        // The stride of all results must also be aligned, so results for next vertex are aligned.
        align32(stride, max_alignment)
    }

    /// `getFunctionObject`
    fn new(function: Function, columns: u32, rows: u32) -> Self {
        let variable_type = VarType::double(columns, rows);
        let scalar = VarType::double(1, 1);
        let uint_type = VarType::uint(rows);
        let int_type = VarType::int(rows);
        let dvec = |size: u32| VarType::double(1, size);
        let name = FUNCTIONS
            .iter()
            .find(|&&(_, _, candidate)| candidate == function)
            .map(|&(_, glsl_name, _)| glsl_name)
            .expect("every function is listed");

        let (arguments, results): (Vec<VarType>, Vec<VarType>) = match function {
            Function::Abs
            | Function::Ceil
            | Function::Floor
            | Function::Fract
            | Function::InverseSqrt
            | Function::Round
            | Function::RoundEven
            | Function::Sign
            | Function::Sqrt
            | Function::Trunc
            | Function::Normalize
            | Function::Inverse => (vec![variable_type], vec![variable_type]),
            Function::IsNan | Function::IsInf => (vec![variable_type], vec![uint_type]),
            Function::Clamp | Function::Fma | Function::Mix | Function::Smoothstep | Function::FaceForward => {
                (vec![variable_type; 3], vec![variable_type])
            }
            Function::ClampAgainstScalar => (vec![variable_type, scalar, scalar], vec![variable_type]),
            Function::SmoothstepAgainstScalar => (vec![scalar, scalar, variable_type], vec![variable_type]),
            Function::Cross => (vec![dvec(3); 2], vec![dvec(3)]),
            Function::Determinant | Function::Length => (vec![variable_type], vec![scalar]),
            Function::Distance | Function::Dot => (vec![variable_type; 2], vec![scalar]),
            Function::Equal
            | Function::GreaterThan
            | Function::GreaterThanEqual
            | Function::LessThan
            | Function::LessThanEqual
            | Function::NotEqual => (vec![variable_type; 2], vec![uint_type]),
            Function::Frexp => (vec![variable_type], vec![variable_type, int_type]),
            Function::Modf => (vec![variable_type], vec![variable_type, variable_type]),
            Function::Ldexp => (vec![variable_type, int_type], vec![variable_type]),
            Function::MatrixCompMult
            | Function::Max
            | Function::Min
            | Function::Mod
            | Function::Step
            | Function::Reflect => (vec![variable_type; 2], vec![variable_type]),
            Function::MaxAgainstScalar | Function::MinAgainstScalar | Function::ModAgainstScalar => {
                (vec![variable_type, scalar], vec![variable_type])
            }
            Function::StepAgainstScalar => (vec![scalar, variable_type], vec![variable_type]),
            Function::OuterProduct => (vec![dvec(rows), dvec(columns)], vec![variable_type]),
            Function::PackDouble2x32 => (vec![VarType::uint(2)], vec![scalar]),
            Function::Refract => (vec![variable_type, variable_type, scalar], vec![variable_type]),
            Function::UnpackDouble2x32 => (vec![scalar], vec![VarType::uint(2)]),
            Function::Transpose => unreachable!("transpose is never implemented for any type"),
        };

        Self {
            function,
            name,
            arguments,
            results,
        }
    }

    /// `functionObject::call`
    fn call(&self, args: &[Value]) -> Vec<Value> {
        use Function::*;
        let d = |index: usize| args[index].d();
        let map = |f: fn(f64) -> f64| vec![Value::D(d(0).iter().copied().map(f).collect())];

        match self.function {
            Abs => map(f64::abs),
            Ceil => map(f64::ceil),
            Floor => map(f64::floor),
            Fract => map(math::fract),
            InverseSqrt => map(math::inverse_sqrt),
            Round => map(math::round),
            RoundEven => map(math::round_even),
            Sign => map(math::sign),
            Sqrt => map(f64::sqrt),
            Trunc => map(math::trunc),
            IsNan => vec![Value::U(d(0).iter().map(|&v| math::isnan(v)).collect())],
            IsInf => vec![Value::U(d(0).iter().map(|&v| math::isinf(v)).collect())],
            Clamp | ClampAgainstScalar => vec![Value::D(by_component3(d(0), d(1), d(2), math::clamp))],
            Fma => vec![Value::D(by_component3(d(0), d(1), d(2), math::fma))],
            Mix => vec![Value::D(by_component3(d(0), d(1), d(2), math::mix))],
            Smoothstep | SmoothstepAgainstScalar => vec![Value::D(by_component3(d(0), d(1), d(2), math::smooth_step))],
            MatrixCompMult => vec![Value::D(by_component2(d(0), d(1), |a, b| a * b))],
            Max | MaxAgainstScalar => vec![Value::D(by_component2(d(0), d(1), math::max))],
            Min | MinAgainstScalar => vec![Value::D(by_component2(d(0), d(1), math::min))],
            Mod | ModAgainstScalar => vec![Value::D(by_component2(d(0), d(1), math::modulo))],
            Step | StepAgainstScalar => vec![Value::D(by_component2(d(0), d(1), math::step))],
            Ldexp => {
                let (values, exponents) = (d(0), args[1].i());
                let n = values.len().max(exponents.len());
                let (step0, step1) = (usize::from(values.len() != 1), usize::from(exponents.len() != 1));
                vec![Value::D(
                    (0..n)
                        .map(|c| math::ldexp(values[c * step0], exponents[c * step1]))
                        .collect(),
                )]
            }
            Frexp => {
                let (mantissas, exponents): (Vec<f64>, Vec<i32>) = d(0).iter().map(|&v| math::frexp(v)).unzip();
                vec![Value::D(mantissas), Value::I(exponents)]
            }
            Modf => {
                let (fractions, integers): (Vec<f64>, Vec<f64>) = d(0).iter().map(|&v| math::modf(v)).unzip();
                vec![Value::D(fractions), Value::D(integers)]
            }
            Cross => {
                let (a, b) = (d(0), d(1));
                vec![Value::D(vec![
                    a[1] * b[2] - b[1] * a[2],
                    a[2] * b[0] - b[2] * a[0],
                    a[0] * b[1] - b[0] * a[1],
                ])]
            }
            Distance => {
                let difference: Vec<f64> = d(0).iter().zip(d(1)).map(|(a, b)| a - b).collect();
                vec![Value::D(vec![math::length(&difference)])]
            }
            Dot => vec![Value::D(vec![math::dot(d(0), d(1))])],
            Length => vec![Value::D(vec![math::length(d(0))])],
            Normalize => {
                let oo_len = 1.0 / math::length(d(0));
                vec![Value::D(d(0).iter().map(|&v| oo_len * v).collect())]
            }
            FaceForward => {
                let (n, i, reference) = (d(0), d(1), d(2));
                let selected: Vec<f64> = if math::dot(reference, i) < 0.0 {
                    n.to_vec()
                } else {
                    n.iter().map(|&v| -v).collect()
                };
                vec![Value::D(selected)]
            }
            Reflect => {
                let (i, n) = (d(0), d(1));
                let scale = 2.0 * math::dot(n, i);
                vec![Value::D(i.iter().zip(n).map(|(&i, &n)| i - scale * n).collect())]
            }
            Refract => {
                let (i, n, eta) = (d(0), d(1), d(2)[0]);
                let cos_angle = math::dot(n, i);
                let k = 1.0 - eta * eta * (1.0 - cos_angle * cos_angle);
                if k < 0.0 {
                    vec![Value::D(vec![0.0; i.len()])]
                } else {
                    vec![Value::D(
                        i.iter()
                            .zip(n)
                            .map(|(&i, &n)| i * eta - n * (eta * cos_angle + k.sqrt()))
                            .collect(),
                    )]
                }
            }
            Equal => vec![Value::U(compare_vectors(d(0), d(1), |a, b| a == b))],
            NotEqual => vec![Value::U(compare_vectors(d(0), d(1), |a, b| a != b))],
            GreaterThan => vec![Value::U(compare_vectors(d(0), d(1), |a, b| a > b))],
            GreaterThanEqual => vec![Value::U(compare_vectors(d(0), d(1), |a, b| a >= b))],
            LessThan => vec![Value::U(compare_vectors(d(0), d(1), |a, b| a < b))],
            LessThanEqual => vec![Value::U(compare_vectors(d(0), d(1), |a, b| a <= b))],
            Determinant => {
                let size = self.arguments[0].rows as usize;
                vec![Value::D(vec![math::determinant(&math::to_matrix(d(0), size, size))])]
            }
            Inverse => {
                let size = self.arguments[0].rows as usize;
                let inverse = math::inverse(&math::to_matrix(d(0), size, size));
                vec![Value::D(math::from_matrix(&inverse, size, size))]
            }
            OuterProduct => {
                // result(row, column) = left[row] * right[column], stored column-major
                let (left, right) = (d(0), d(1));
                let mut result = Vec::with_capacity(left.len() * right.len());
                for column in right {
                    for row in left {
                        result.push(row * column);
                    }
                }
                vec![Value::D(result)]
            }
            PackDouble2x32 => {
                let words = args[0].u();
                vec![Value::D(vec![f64::from_bits(
                    u64::from(words[1]) << 32 | u64::from(words[0]),
                )])]
            }
            UnpackDouble2x32 => {
                let bits = d(0)[0].to_bits();
                vec![Value::U(vec![bits as u32, (bits >> 32) as u32])]
            }
            Transpose => unreachable!("transpose is never implemented for any type"),
        }
    }
}

/// `binaryByComponent::call`
fn by_component2(a: &[f64], b: &[f64], f: impl Fn(f64, f64) -> f64) -> Vec<f64> {
    let n = a.len().max(b.len());
    let (step0, step1) = (usize::from(a.len() != 1), usize::from(b.len() != 1));
    (0..n).map(|c| f(a[c * step0], b[c * step1])).collect()
}

/// `tenaryByComponent::call`
fn by_component3(a: &[f64], b: &[f64], c: &[f64], f: impl Fn(f64, f64, f64) -> f64) -> Vec<f64> {
    let n = a.len().max(b.len()).max(c.len());
    let (step0, step1, step2) = (
        usize::from(a.len() != 1),
        usize::from(b.len() != 1),
        usize::from(c.len() != 1),
    );
    (0..n).map(|i| f(a[i * step0], b[i * step1], c[i * step2])).collect()
}

fn compare_vectors(a: &[f64], b: &[f64], f: impl Fn(f64, f64) -> bool) -> Vec<u32> {
    a.iter().zip(b).map(|(&a, &b)| u32::from(f(a, b))).collect()
}

/// `Math::*` and the pieces of the C library the reference functions call
mod math {
    pub type Matrix = Vec<Vec<f64>>;

    pub fn clamp(x: f64, min_val: f64, max_val: f64) -> f64 {
        min(max(x, min_val), max_val)
    }

    pub fn fma(a: f64, b: f64, c: f64) -> f64 {
        a * b + c
    }

    pub fn fract(val: f64) -> f64 {
        val - val.floor()
    }

    pub fn inverse_sqrt(val: f64) -> f64 {
        let root = val.sqrt();
        1.0 / root
    }

    pub fn isinf(val: f64) -> u32 {
        u32::from(val.is_infinite())
    }

    pub fn isnan(val: f64) -> u32 {
        u32::from(val.is_nan())
    }

    pub fn max(left: f64, right: f64) -> f64 {
        if left >= right { left } else { right }
    }

    pub fn min(left: f64, right: f64) -> f64 {
        if left <= right { left } else { right }
    }

    pub fn mix(left: f64, right: f64, weight: f64) -> f64 {
        left * (1.0 - weight) + right * weight
    }

    pub fn modulo(left: f64, right: f64) -> f64 {
        let div_res = left / right;
        let floored = div_res.floor();
        left - right * floored
    }

    pub fn round(t: f64) -> f64 {
        let frac = fract(t);
        let mut res = t - frac;
        if 0.5 < frac {
            res += 1.0;
        }
        res
    }

    #[expect(clippy::if_same_then_else, reason = "upstream spells out both branches")]
    pub fn round_even(t: f64) -> f64 {
        let frac = fract(t);
        let mut res = t - frac;
        if 0.5 < frac {
            res += 1.0;
        } else if 0.5 == frac && (res as i32) % 2 != 0 {
            res += 1.0;
        }
        res
    }

    pub fn sign(t: f64) -> f64 {
        if 0.0 > t {
            -1.0
        } else if 0.0 == t {
            0.0
        } else {
            1.0
        }
    }

    pub fn smooth_step(e0: f64, e1: f64, val: f64) -> f64 {
        if e0 >= val {
            return 0.0;
        }
        if e1 <= val {
            return 1.0;
        }
        let temp = (val - e0) / (e1 - e0);
        temp * temp * (3.0 - 2.0 * temp)
    }

    pub fn step(edge: f64, val: f64) -> f64 {
        if edge > val { 0.0 } else { 1.0 }
    }

    pub fn trunc(t: f64) -> f64 {
        let abs_value = t.abs();
        let result_value = abs_value.floor();
        sign(t) * result_value
    }

    pub fn dot(a: &[f64], b: &[f64]) -> f64 {
        a.iter().zip(b).map(|(a, b)| a * b).sum()
    }

    pub fn length(a: &[f64]) -> f64 {
        dot(a, a).sqrt()
    }

    /// C `ldexp`, `x * 2^exp` without an intermediate overflow
    pub fn ldexp(x: f64, exp: i32) -> f64 {
        let mut x = x;
        let mut n = exp;
        if n > 1023 {
            x *= f64::from_bits(0x7fe0_0000_0000_0000);
            n -= 1023;
            if n > 1023 {
                x *= f64::from_bits(0x7fe0_0000_0000_0000);
                n -= 1023;
                n = n.min(1023);
            }
        } else if n < -1022 {
            // 2^-1022 * 2^53, so that the last multiplication is the only rounding
            x *= f64::from_bits(0x0010_0000_0000_0000) * f64::from_bits(0x4340_0000_0000_0000);
            n += 1022 - 53;
            if n < -1022 {
                x *= f64::from_bits(0x0010_0000_0000_0000) * f64::from_bits(0x4340_0000_0000_0000);
                n += 1022 - 53;
                n = n.max(-1022);
            }
        }
        x * f64::from_bits(((0x3ff + n) as u64) << 52)
    }

    /// C `frexp`: the mantissa in [0.5, 1) and the exponent, zero and the value itself for zero, infinities and NaN
    pub fn frexp(val: f64) -> (f64, i32) {
        if val == 0.0 || !val.is_finite() {
            return (val, 0);
        }
        let bits = val.to_bits();
        let exponent_bits = ((bits >> 52) & 0x7ff) as i32;
        if exponent_bits == 0 {
            // subnormal: scale into the normal range first
            let (mantissa, exponent) = frexp(val * f64::from_bits(0x4350_0000_0000_0000));
            return (mantissa, exponent - 54);
        }
        let exponent = exponent_bits - 1022;
        let mantissa = f64::from_bits((bits & !(0x7ffu64 << 52)) | (1022u64 << 52));
        (mantissa, exponent)
    }

    /// C `modf`: the fractional part (with the sign of the value) and the integral part
    pub fn modf(val: f64) -> (f64, f64) {
        if val.is_infinite() {
            return (0.0f64.copysign(val), val);
        }
        let integer = val.trunc();
        ((val - integer).copysign(val), integer)
    }

    pub fn to_matrix(flat: &[f64], rows: usize, columns: usize) -> Matrix {
        (0..rows)
            .map(|r| (0..columns).map(|c| flat[c * rows + r]).collect())
            .collect()
    }

    pub fn from_matrix(matrix: &Matrix, rows: usize, columns: usize) -> Vec<f64> {
        let mut flat = Vec::with_capacity(rows * columns);
        for c in 0..columns {
            for r in 0..rows {
                flat.push(matrix[r][c]);
            }
        }
        flat
    }

    fn det2(m00: f64, m10: f64, m01: f64, m11: f64) -> f64 {
        m00 * m11 - m01 * m10
    }

    #[allow(clippy::too_many_arguments)]
    fn det3(m00: f64, m10: f64, m20: f64, m01: f64, m11: f64, m21: f64, m02: f64, m12: f64, m22: f64) -> f64 {
        m00 * det2(m11, m21, m12, m22) - m10 * det2(m01, m21, m02, m22) + m20 * det2(m01, m11, m02, m12)
    }

    #[allow(clippy::too_many_arguments)]
    fn det4(
        m00: f64,
        m10: f64,
        m20: f64,
        m30: f64,
        m01: f64,
        m11: f64,
        m21: f64,
        m31: f64,
        m02: f64,
        m12: f64,
        m22: f64,
        m32: f64,
        m03: f64,
        m13: f64,
        m23: f64,
        m33: f64,
    ) -> f64 {
        m00 * det3(m11, m21, m31, m12, m22, m32, m13, m23, m33)
            - m10 * det3(m01, m21, m31, m02, m22, m32, m03, m23, m33)
            + m20 * det3(m01, m11, m31, m02, m12, m32, m03, m13, m33)
            - m30 * det3(m01, m11, m21, m02, m12, m22, m03, m13, m23)
    }

    /// `determinant` of a 2x2, 3x3 or 4x4 matrix, called with `mat(row, column)` in row-major order like upstream
    pub fn determinant(m: &Matrix) -> f64 {
        match m.len() {
            2 => det2(m[0][0], m[0][1], m[1][0], m[1][1]),
            3 => det3(
                m[0][0], m[0][1], m[0][2], m[1][0], m[1][1], m[1][2], m[2][0], m[2][1], m[2][2],
            ),
            4 => det4(
                m[0][0], m[0][1], m[0][2], m[0][3], m[1][0], m[1][1], m[1][2], m[1][3], m[2][0], m[2][1], m[2][2],
                m[2][3], m[3][0], m[3][1], m[3][2], m[3][3],
            ),
            _ => unreachable!("only square matrices of size 2 to 4 are tested"),
        }
    }

    /// `eliminate`: the matrix without `row` and `column`
    fn eliminate(matrix: &Matrix, column: usize, row: usize) -> Matrix {
        let size = matrix.len();
        let mut result = vec![vec![0.0; size - 1]; size - 1];
        for c in 0..size {
            if column == c {
                continue;
            }
            for r in 0..size {
                if row == r {
                    continue;
                }
                let r_offset = usize::from(r > row);
                let c_offset = usize::from(c > column);
                result[r - r_offset][c - c_offset] = matrix[r][c];
            }
        }
        result
    }

    /// `minor_impl`
    fn minor(matrix: &Matrix, column: usize, row: usize) -> f64 {
        if matrix.len() == 2 {
            let r = usize::from(row == 0);
            let c = usize::from(column == 0);
            return matrix[r][c];
        }
        determinant(&eliminate(matrix, column, row))
    }

    fn cofactors(matrix: &Matrix) -> Matrix {
        let size = matrix.len();
        let mut result = vec![vec![0.0; size]; size];
        for c in 0..size {
            for r in 0..size {
                let minor_value = minor(matrix, c, r);
                result[r][c] = if (c + r) % 2 == 1 { -minor_value } else { minor_value };
            }
        }
        result
    }

    pub fn inverse(matrix: &Matrix) -> Matrix {
        let size = matrix.len();
        let cof = cofactors(matrix);
        let adjugate: Matrix = (0..size).map(|r| (0..size).map(|c| cof[c][r]).collect()).collect();
        let det = determinant(matrix);
        let inv_det = 1.0 / det;
        adjugate
            .iter()
            .map(|row| row.iter().map(|value| value * inv_det).collect())
            .collect()
    }
}

/// `BuiltinFunctionTest::prepareComponents`
fn prepare_components(function_object: &FunctionObject, vertex: u32, argument: usize) -> Value {
    let n_arguments = function_object.arguments.len();
    let argument_type = function_object.arguments[argument];
    let n_components = argument_type.components();

    let mut argument_step = [0u32; 3];
    let mut argument_reset = [0u32; 3];
    let mut double_argument_start = [0.0f64; 3];
    let int_argument_start: u32 = 0u32.wrapping_sub(4);
    let mut uint_argument_start: u32 = 0;

    match n_arguments {
        1 => {
            argument_step[0] = 1;
            argument_reset[0] = 1024;
            double_argument_start[0] = -511.5;
        }
        2 => {
            argument_step[0] = 32;
            argument_step[1] = 1;
            argument_reset[0] = 32;
            argument_reset[1] = 32;
            double_argument_start[0] = -15.5;
            double_argument_start[1] = -15.5;
        }
        3 => {
            argument_step[0] = 64;
            argument_step[1] = 8;
            argument_step[2] = 1;
            argument_reset[0] = 16;
            argument_reset[1] = 8;
            argument_reset[2] = 8;
            double_argument_start[0] = -7.5;
            double_argument_start[1] = -3.5;
            double_argument_start[2] = -3.5;
        }
        _ => panic!("Not implemented"),
    }

    match function_object.function {
        // arg_2 must be less than arg_3
        Function::Clamp | Function::ClampAgainstScalar => double_argument_start[2] = 4.5,
        // inversesqrt is undefined for argument <= 0
        Function::InverseSqrt => double_argument_start[0] = 16.5,
        // arg_1 must be less than arg_2
        Function::Smoothstep | Function::SmoothstepAgainstScalar => {
            argument_step = [1, 8, 64];
            argument_reset = [8, 8, 16];
            double_argument_start = [-3.5, 4.5, -7.5];
        }
        _ => {}
    }

    let mut argument_index = [0u32; 3];
    for i in 0..n_arguments {
        argument_index[i] = (vertex / argument_step[i]) % argument_reset[i];
    }

    match argument_type.base {
        Base::Double => {
            double_argument_start[argument] += f64::from(argument_index[argument]);
            Value::D(
                (0..n_components)
                    .map(|component| {
                        let mut value = double_argument_start[argument] + f64::from(component) / 8.0;
                        // Result for 0.5 depends on implementation
                        if function_object.function == Function::Round && 0.5 == math::fract(value) {
                            value += 0.01;
                        }
                        value
                    })
                    .collect(),
            )
        }
        Base::Int => Value::I(
            (0..n_components)
                .map(|component| int_argument_start.wrapping_add(component) as i32)
                .collect(),
        ),
        Base::Uint => {
            uint_argument_start += argument_index[argument];
            Value::U(
                (0..n_components)
                    .map(|component| uint_argument_start + component)
                    .collect(),
            )
        }
    }
}

fn type_label(value_type: VarType) -> String {
    value_type.glsl_name()
}

/// `BuiltinFunctionTest::compare`
fn compare(type_: VarType, left: &Value, right: &Value) -> bool {
    let n_components = type_.components() as usize;
    match type_.base {
        Base::Double => (0..n_components).all(|component| {
            let (left_value, right_value) = (left.d()[component], right.d()[component]);
            !(left_value != right_value
                && EPSILON < (left_value - right_value).abs()
                && !left_value.is_nan()
                && !right_value.is_nan())
        }),
        Base::Int => left.i()[..n_components] == right.i()[..n_components],
        Base::Uint => left.u()[..n_components] == right.u()[..n_components],
    }
}

/// `BuiltinFunctionTest::isResultEdgeCase`: mod(a, a) may come out as `a` because GL allows some error in the division.
fn is_result_edge_case(
    function_object: &FunctionObject,
    arguments: &[Value],
    result_type: VarType,
    expected: &Value,
    actual: &Value,
) -> bool {
    match function_object.function {
        Function::Mod | Function::ModAgainstScalar => {
            let argument_1 = arguments[0].d();
            let argument_2 = arguments[1].d();
            let (expected_result, actual_result) = (expected.d(), actual.d());

            let mut recheck = false;
            let n_components = result_type.components() as usize;
            let mut corrected_expected_result = vec![0.0f64; n_components];
            for component in 0..n_components {
                let expected_result_component = expected_result[component];
                let actual_result_component = actual_result[component];
                let argument_1_component = argument_1[component];
                let argument_2_component = argument_2[if function_object.function == Function::Mod {
                    component
                } else {
                    0
                }];

                // if corresponding components of arguments are equal and if component of first argument and component of result are equal then expected result must be corrected
                let possible_edge_case = EPSILON
                    > ((argument_1_component / argument_2_component)
                        - (argument_1_component / argument_2_component).round())
                    .abs();
                let edge_case_present =
                    possible_edge_case && (EPSILON > (argument_2_component - actual_result_component).abs());
                recheck |= edge_case_present;
                corrected_expected_result[component] = if edge_case_present {
                    argument_2_component
                } else {
                    expected_result_component
                };
            }

            recheck && compare(result_type, &Value::D(corrected_expected_result), actual)
        }
        _ => false,
    }
}

/// `BuiltinFunctionTest`
struct BuiltinFunctionTest {
    name: String,
    function: Function,
    columns: u32,
    rows: u32,
}

#[derive(Default)]
struct Resources {
    transform_feedback_buffer_id: GLuint,
    vertex_array_object_id: GLuint,
}

fn uniform_name(argument: usize) -> String {
    format!("uniform_{argument}")
}

fn varying_name(result: usize) -> String {
    format!("result_{result}")
}

impl BuiltinFunctionTest {
    /// `prepareVertexShaderCode`
    fn vertex_shader_code(function_object: &FunctionObject) -> String {
        let mut argument_definition = String::new();
        let mut arguments = String::new();
        for (argument, type_) in function_object.arguments.iter().enumerate() {
            argument_definition.push_str(&format!("uniform {} {};\n", type_label(*type_), uniform_name(argument)));
            if argument != 0 {
                arguments.push_str(", ");
            }
            arguments.push_str(&uniform_name(argument));
        }

        let mut result_definition = String::new();
        for (result, type_) in function_object.results.iter().enumerate() {
            result_definition.push_str(&format!("flat out {} {};\n", type_label(*type_), varying_name(result)));
            if result != 0 {
                arguments.push_str(", ");
                arguments.push_str(&varying_name(result));
            }
        }

        format!(
            "#version 400 core\n\nprecision highp float;\n\n{argument_definition}\n{result_definition}\nvoid main()\n{{\n    {} = {}({}({arguments}));\n}}\n\n",
            varying_name(0),
            type_label(function_object.results[0]),
            function_object.name
        )
    }

    /// `testBegin`: the transform feedback buffer and the uniforms of one vertex
    fn test_begin(
        &self,
        context: &Context,
        resources: &Resources,
        function_object: &FunctionObject,
        program_id: GLuint,
        arguments: &[Value],
    ) -> Result<(), TestError> {
        let gl = context.gl();
        let result_buffer_size = function_object.results_stride();

        let transform_feedback_buffer_data = vec![0u8; result_buffer_size as usize];
        gl!(gl.bind_buffer(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            resources.transform_feedback_buffer_id
        ));
        glu::expect_no_error(gl, "BindBuffer")?;
        gl!(gl.buffer_data(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            result_buffer_size as isize,
            transform_feedback_buffer_data.as_ptr().cast(),
            glw::GL_DYNAMIC_COPY
        ));
        glu::expect_no_error(gl, "BufferData")?;
        gl!(gl.bind_buffer_range(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            0,
            resources.transform_feedback_buffer_id,
            0,
            result_buffer_size as isize
        ));
        glu::expect_no_error(gl, "BindBufferRange")?;

        gl!(gl.bind_vertex_array(resources.vertex_array_object_id));
        glu::expect_no_error(gl, "BindVertexArray")?;

        for (argument, argument_type) in function_object.arguments.iter().enumerate() {
            let name = CString::new(uniform_name(argument)).expect("no nul byte");
            let uniform_location = gl!(gl.get_uniform_location(program_id, name.as_ptr()));
            glu::expect_no_error(gl, "GetUniformLocation")?;

            if uniform_location == -1 {
                return Err(TestError::Fail("Inactive uniform".to_string()));
            }

            if argument_type.columns == 1 {
                match &arguments[argument] {
                    Value::D(values) => {
                        let pointer = values.as_ptr();
                        match argument_type.rows {
                            1 => gl!(gl.uniform_1dv(uniform_location, 1, pointer)),
                            2 => gl!(gl.uniform_2dv(uniform_location, 1, pointer)),
                            3 => gl!(gl.uniform_3dv(uniform_location, 1, pointer)),
                            4 => gl!(gl.uniform_4dv(uniform_location, 1, pointer)),
                            _ => return Err(TestError::Fail("Not implemented".to_string())),
                        }
                    }
                    Value::U(values) => {
                        if argument_type.rows == 2 {
                            gl!(gl.uniform_2uiv(uniform_location, 1, values.as_ptr()));
                        } else {
                            return Err(TestError::Fail("Not implemented".to_string()));
                        }
                    }
                    Value::I(values) => {
                        let pointer = values.as_ptr();
                        match argument_type.rows {
                            1 => gl!(gl.uniform_1iv(uniform_location, 1, pointer)),
                            2 => gl!(gl.uniform_2iv(uniform_location, 1, pointer)),
                            3 => gl!(gl.uniform_3iv(uniform_location, 1, pointer)),
                            4 => gl!(gl.uniform_4iv(uniform_location, 1, pointer)),
                            _ => return Err(TestError::Fail("Not implemented".to_string())),
                        }
                    }
                }
            } else {
                let pointer = arguments[argument].d().as_ptr();
                let transpose = 0;
                match (argument_type.columns, argument_type.rows) {
                    (2, 2) => gl!(gl.uniform_matrix_2dv(uniform_location, 1, transpose, pointer)),
                    (2, 3) => gl!(gl.uniform_matrix_2x_3dv(uniform_location, 1, transpose, pointer)),
                    (2, 4) => gl!(gl.uniform_matrix_2x_4dv(uniform_location, 1, transpose, pointer)),
                    (3, 3) => gl!(gl.uniform_matrix_3dv(uniform_location, 1, transpose, pointer)),
                    (3, 2) => gl!(gl.uniform_matrix_3x_2dv(uniform_location, 1, transpose, pointer)),
                    (3, 4) => gl!(gl.uniform_matrix_3x_4dv(uniform_location, 1, transpose, pointer)),
                    (4, 4) => gl!(gl.uniform_matrix_4dv(uniform_location, 1, transpose, pointer)),
                    (4, 2) => gl!(gl.uniform_matrix_4x_2dv(uniform_location, 1, transpose, pointer)),
                    (4, 3) => gl!(gl.uniform_matrix_4x_3dv(uniform_location, 1, transpose, pointer)),
                    _ => return Err(TestError::Fail("Not implemented".to_string())),
                }
            }
        }
        Ok(())
    }

    /// `verifyResults`
    fn verify_results(
        &self,
        context: &Context,
        resources: &Resources,
        function_object: &FunctionObject,
        arguments: &[Value],
        expected_results: &[Value],
        shader_code: &str,
    ) -> Result<bool, TestError> {
        let gl = context.gl();
        let mut test_result = true;
        let results_stride = function_object.results_stride() as usize;

        gl!(gl.bind_buffer(
            glw::GL_TRANSFORM_FEEDBACK_BUFFER,
            resources.transform_feedback_buffer_id
        ));
        glu::expect_no_error(gl, "BindBuffer")?;
        let feedback_pointer = gl!(gl.map_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, glw::GL_READ_ONLY)).cast::<u8>();
        glu::expect_no_error(gl, "MapBuffer")?;
        if feedback_pointer.is_null() {
            return Err(TestError::Fail("MapBuffer returned NULL".to_string()));
        }
        // SAFETY: the buffer was allocated with `results_stride` bytes and is mapped for reading until the unmap below.
        let feedback_data = unsafe { std::slice::from_raw_parts(feedback_pointer, results_stride) }.to_vec();

        for (result, &result_type) in function_object.results.iter().enumerate() {
            let result_offset = function_object.result_offset(result) as usize;
            let actual = Value::decode(result_type, &feedback_data[result_offset..]);
            if !compare(result_type, &expected_results[result], &actual)
                && !is_result_edge_case(
                    function_object,
                    arguments,
                    result_type,
                    &expected_results[result],
                    &actual,
                )
            {
                test_result = false;
            }
            if !test_result {
                break;
            }
        }

        gl!(gl.unmap_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER));
        glu::expect_no_error(gl, "UnmapBuffer")?;

        if !test_result {
            log::info!("Error. Invalid result.");
            log::info!("Function: {}", function_object.name);
            for (result, &result_type) in function_object.results.iter().enumerate() {
                let result_offset = function_object.result_offset(result) as usize;
                let actual = Value::decode(result_type, &feedback_data[result_offset..]);
                log::info!("Result ({}) [{}]", type_label(result_type), actual.describe());
                log::info!(
                    "Expected result ({}) [{}]",
                    type_label(result_type),
                    expected_results[result].describe()
                );
            }
            for (argument, &argument_type) in function_object.arguments.iter().enumerate() {
                log::info!(
                    "Argument ({}) [{}]",
                    type_label(argument_type),
                    arguments[argument].describe()
                );
            }
            log::info!("Shader:\n{shader_code}");
        }
        Ok(test_result)
    }

    /// `test`
    fn test(&self, context: &Context, resources: &Resources) -> Result<bool, TestError> {
        let gl = context.gl();

        // Skip if function is not implemented for type
        if !is_function_implemented(self.function, self.columns, self.rows) {
            return Ok(true);
        }

        let function_object = FunctionObject::new(self.function, self.columns, self.rows);
        let shader_code = Self::vertex_shader_code(&function_object);

        // prepareProgram: a vertex shader whose results are captured with transform feedback
        let varying_names: Vec<String> = (0..function_object.results.len()).map(varying_name).collect();
        let program = glu::ShaderProgram::new_reporting_build_failure(
            gl,
            &glu::ProgramSources::default()
                .with(glu::ShaderType::Vertex, shader_code.clone())
                .with_transform_feedback(&varying_names, glw::GL_INTERLEAVED_ATTRIBS),
        );
        if !program.is_ok() {
            if let Some(summary) = program.build_failure_summary() {
                log::info!("{summary}");
            }
            return Err(TestError::Fail("Failed to link program".to_string()));
        }

        // prepareTestData
        let mut arguments_per_vertex: Vec<Vec<Value>> = Vec::with_capacity(N_VERTICES as usize);
        let mut expected_per_vertex: Vec<Vec<Value>> = Vec::with_capacity(N_VERTICES as usize);
        for vertex in 0..N_VERTICES {
            let arguments: Vec<Value> = (0..function_object.arguments.len())
                .map(|argument| prepare_components(&function_object, vertex, argument))
                .collect();
            expected_per_vertex.push(function_object.call(&arguments));
            arguments_per_vertex.push(arguments);
        }

        gl!(gl.use_program(program.program()));
        glu::expect_no_error(gl, "UseProgram")?;

        for vertex in 0..N_VERTICES as usize {
            self.test_begin(
                context,
                resources,
                &function_object,
                program.program(),
                &arguments_per_vertex[vertex],
            )?;

            gl!(gl.begin_transform_feedback(glw::GL_POINTS));
            glu::expect_no_error(gl, "BeginTransformFeedback")?;
            gl!(gl.draw_arrays(glw::GL_POINTS, 0, 1));
            glu::expect_no_error(gl, "DrawArrays")?;
            gl!(gl.end_transform_feedback());
            glu::expect_no_error(gl, "EndTransformFeedback")?;

            if !self.verify_results(
                context,
                resources,
                &function_object,
                &arguments_per_vertex[vertex],
                &expected_per_vertex[vertex],
                &shader_code,
            )? {
                return Ok(false);
            }
        }
        Ok(true)
    }

    fn run(&self, context: &Context, resources: &mut Resources) -> TestOutcome {
        let gl = context.gl();

        // testInit
        gl!(gl.gen_buffers(1, &mut resources.transform_feedback_buffer_id));
        glu::expect_no_error(gl, "GenBuffers")?;
        gl!(gl.gen_vertex_arrays(1, &mut resources.vertex_array_object_id));
        glu::expect_no_error(gl, "GenVertexArrays")?;
        gl!(gl.enable(glw::GL_RASTERIZER_DISCARD));

        Ok(if self.test(context, resources)? {
            TestStatus::pass("Pass")
        } else {
            TestStatus::fail("Fail")
        })
    }
}

impl TestCase for BuiltinFunctionTest {
    fn name(&self) -> &str {
        &self.name
    }

    fn iterate(&self, context: &Context) -> TestOutcome {
        // Check if extension is supported
        if !context.context_info.is_extension_supported("GL_ARB_gpu_shader_fp64") {
            return Err(TestError::NotSupported(
                "GL_ARB_gpu_shader_fp64 is not supported".to_string(),
            ));
        }

        let gl = context.gl();
        let mut resources = Resources::default();
        let outcome = self.run(context, &mut resources);

        // deinit
        if resources.transform_feedback_buffer_id != 0 {
            gl!(gl.bind_buffer(glw::GL_TRANSFORM_FEEDBACK_BUFFER, 0));
            gl!(gl.delete_buffers(1, &resources.transform_feedback_buffer_id));
        }
        if resources.vertex_array_object_id != 0 {
            gl!(gl.bind_vertex_array(0));
            gl!(gl.delete_vertex_arrays(1, &resources.vertex_array_object_id));
        }
        outcome
    }
}

/// The `builtin` group of `GPUShaderFP64Tests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("builtin");
    for (function_name, _, function) in FUNCTIONS {
        for (type_name, columns, rows) in TYPES {
            group.add_child(Box::new(BuiltinFunctionTest {
                name: format!("{function_name}_{type_name}"),
                function,
                columns,
                rows,
            }) as Box<dyn TestCase>);
        }
    }
    group
}

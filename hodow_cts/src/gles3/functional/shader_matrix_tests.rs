// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles3/functional/es3fShaderMatrixTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream reaches every operand shape through `TypeTraits<DataT>::Type` and instantiates
// `Evaluator<Op, In0DataType, In1DataType>` for each combination the case tree builds.
// `Value` below carries its own shape instead, so one operator set covers what the
// templates cover - which matters more here than on ES 2.0, where every matrix is square:
// the nine matrix types alone would be 81 instantiations of the matrix-matrix product.
// The operations, their order and their names are the C++ ones; only the dispatch is a
// match rather than a switch over a packed key.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::shader_util::{DataType, Precision, get_data_type_float_vec, get_data_type_matrix};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::TestError;
use crate::tcu::matrix::Mat4;
use crate::tcu::pixel::{f16_bits_to_f32, f32_to_f16_bits};
use crate::tcu::vector::{Vec2, Vec3, Vec4};

// Uniform / constant values for tests.
// \note Input1 should not contain 0 components as it is used as divisor in div cases.
const S_CONST_IN_FLOAT: [f32; 2] = [0.5, -0.2];
const S_CONST_IN_VEC2: [Vec2; 2] = [Vec2::new(1.2, 0.5), Vec2::new(0.5, 1.0)];
const S_CONST_IN_VEC3: [Vec3; 2] = [Vec3::new(1.1, 0.1, 0.5), Vec3::new(-0.2, 0.5, 0.8)];
const S_CONST_IN_VEC4: [Vec4; 2] = [Vec4::new(1.4, 0.2, -0.5, 0.7), Vec4::new(0.2, -1.0, 0.5, 0.8)];

// Every table below is written out row-major, whatever the storage order is, and is
// uploaded to a uniform with `transpose = GL_TRUE` rather than being rearranged.
const S_CONST_IN_MAT2X2: [[f32; 4]; 2] = [[-0.1, 1.0, -0.2, 0.0], [0.8, 0.1, 0.5, -0.9]];
const S_CONST_IN_MAT3X2: [[f32; 6]; 2] = [[0.8, -0.3, 0.3, 1.0, 1.2, -1.2], [1.2, -1.0, 0.5, -0.8, 1.1, 0.3]];
const S_CONST_IN_MAT4X2: [[f32; 8]; 2] = [
    [-0.2, 0.5, 0.0, -1.0, 1.2, -0.5, 0.3, -0.9],
    [1.0, 0.1, -1.1, 0.6, 0.8, -1.2, -1.1, 0.7],
];
const S_CONST_IN_MAT2X3: [[f32; 6]; 2] = [[-0.6, -0.1, -0.7, -1.2, -0.2, 0.0], [1.1, 0.6, 0.8, 1.0, 0.7, 0.1]];
const S_CONST_IN_MAT3X3: [[f32; 9]; 2] = [
    [-0.2, 1.1, 1.2, -1.0, 1.2, 0.5, 0.7, -0.2, 1.0],
    [-0.1, -0.1, 0.1, -0.1, -0.2, 1.0, -0.5, 0.1, -0.4],
];
const S_CONST_IN_MAT4X3: [[f32; 12]; 2] = [
    [-0.9, 0.0, 0.6, 0.2, 0.9, -0.1, -0.3, -0.7, -0.1, 0.1, 1.0, 0.0],
    [0.5, 0.7, 0.7, 1.2, 1.1, 0.1, 1.0, -1.0, -0.2, -0.2, -0.3, -0.5],
];
const S_CONST_IN_MAT2X4: [[f32; 8]; 2] = [
    [-0.6, -1.1, -0.6, -0.6, -0.2, -0.6, -0.1, -0.1],
    [-1.2, -1.0, 0.7, -1.0, 0.7, 0.7, -0.4, -0.3],
];
const S_CONST_IN_MAT3X4: [[f32; 12]; 2] = [
    [0.6, -0.4, 1.2, 0.9, 0.8, 0.4, 1.1, 0.3, 0.5, -0.2, 0.0, 1.1],
    [-0.8, 1.2, -0.2, -1.1, -0.9, -0.5, -1.2, 1.0, 1.2, 0.1, -0.7, -0.5],
];
const S_CONST_IN_MAT4X4: [[f32; 16]; 2] = [
    [
        0.3, 0.9, -0.2, 1.0, -0.4, -0.6, 0.6, -1.0, -0.9, -0.1, 0.3, -0.2, -0.3, -0.9, 1.0, 0.1,
    ],
    [
        0.4, -0.7, -0.8, 0.7, -0.4, -0.8, 0.6, -0.3, 0.7, -1.0, 0.1, -0.3, 0.2, 0.6, 0.4, -1.0,
    ],
];

/// The `s_constInMat<cols>x<rows>` table for a matrix type, as upstream writes it: one
/// flat row-major array per input index.
fn const_matrix_table(data_type: DataType, input_ndx: usize) -> &'static [f32] {
    match data_type {
        DataType::FloatMat2 => &S_CONST_IN_MAT2X2[input_ndx],
        DataType::FloatMat2x3 => &S_CONST_IN_MAT2X3[input_ndx],
        DataType::FloatMat2x4 => &S_CONST_IN_MAT2X4[input_ndx],
        DataType::FloatMat3x2 => &S_CONST_IN_MAT3X2[input_ndx],
        DataType::FloatMat3 => &S_CONST_IN_MAT3X3[input_ndx],
        DataType::FloatMat3x4 => &S_CONST_IN_MAT3X4[input_ndx],
        DataType::FloatMat4x2 => &S_CONST_IN_MAT4X2[input_ndx],
        DataType::FloatMat4x3 => &S_CONST_IN_MAT4X3[input_ndx],
        DataType::FloatMat4 => &S_CONST_IN_MAT4X4[input_ndx],
        other => panic!("{} is not a matrix type", other.name()),
    }
}

// MatrixCaseUtils

/// `MatrixCaseUtils::InputType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum InputType {
    Const,
    Uniform,
    Dynamic,
    /// `INPUTTYPE_LAST`, which upstream passes as the second input of a unary case.
    Last,
}

/// `MatrixCaseUtils::ShaderInput`
#[derive(Clone, Copy)]
struct ShaderInput {
    input_type: InputType,
    data_type: Option<DataType>,
    precision: Option<Precision>,
}

impl ShaderInput {
    fn new(input_type: InputType, data_type: DataType, precision: Precision) -> Self {
        Self {
            input_type,
            data_type: Some(data_type),
            precision: Some(precision),
        }
    }

    /// `ShaderInput(INPUTTYPE_LAST, TYPE_LAST, PRECISION_LAST)` - the unused second input.
    fn void() -> Self {
        Self {
            input_type: InputType::Last,
            data_type: None,
            precision: None,
        }
    }

    fn data_type(&self) -> DataType {
        self.data_type.expect("a void input has no data type")
    }

    fn precision(&self) -> Precision {
        self.precision.expect("a void input has no precision")
    }
}

/// `MatrixCaseUtils::MatrixOp`
#[derive(Clone, Copy, PartialEq, Eq)]
enum MatrixOp {
    Add,
    Sub,
    Mul,
    Div,
    CompMul,
    OuterProduct,
    Transpose,
    Inverse,
    Determinant,
    UnaryPlus,
    Negation,
    PreIncrement,
    PreDecrement,
    PostIncrement,
    PostDecrement,
    AddInto,
    SubtractFrom,
    MultiplyInto,
    DivideInto,
}

/// `MatrixCaseUtils::OperationType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum OperationType {
    BinaryOperator,
    BinaryFunction,
    UnaryFunction,
    UnaryPrefixOperator,
    UnaryPostfixOperator,
    Assignment,
}

/// `getOperationName`
fn operation_name(op: MatrixOp) -> &'static str {
    match op {
        MatrixOp::Add => "+",
        MatrixOp::Sub => "-",
        MatrixOp::Mul => "*",
        MatrixOp::Div => "/",
        MatrixOp::CompMul => "matrixCompMult",
        MatrixOp::OuterProduct => "outerProduct",
        MatrixOp::Transpose => "transpose",
        MatrixOp::Inverse => "inverse",
        MatrixOp::Determinant => "determinant",
        MatrixOp::UnaryPlus => "+",
        MatrixOp::Negation => "-",
        MatrixOp::PreIncrement => "++",
        MatrixOp::PreDecrement => "--",
        MatrixOp::PostIncrement => "++",
        MatrixOp::PostDecrement => "--",
        MatrixOp::AddInto => "+=",
        MatrixOp::SubtractFrom => "-=",
        MatrixOp::MultiplyInto => "*=",
        MatrixOp::DivideInto => "/=",
    }
}

/// `getOperationType`
fn operation_type(op: MatrixOp) -> OperationType {
    match op {
        MatrixOp::Add | MatrixOp::Sub | MatrixOp::Mul | MatrixOp::Div => OperationType::BinaryOperator,
        MatrixOp::CompMul | MatrixOp::OuterProduct => OperationType::BinaryFunction,
        MatrixOp::Transpose | MatrixOp::Inverse | MatrixOp::Determinant => OperationType::UnaryFunction,
        MatrixOp::UnaryPlus | MatrixOp::Negation | MatrixOp::PreIncrement | MatrixOp::PreDecrement => {
            OperationType::UnaryPrefixOperator
        }
        MatrixOp::PostIncrement | MatrixOp::PostDecrement => OperationType::UnaryPostfixOperator,
        MatrixOp::AddInto | MatrixOp::SubtractFrom | MatrixOp::MultiplyInto | MatrixOp::DivideInto => {
            OperationType::Assignment
        }
    }
}

/// `MatrixCaseUtils::TestMatrixType`
#[derive(Clone, Copy, PartialEq, Eq)]
enum TestMatrixType {
    Default,
    Negated,
    Incremented,
    Decremented,
    NegatedIncremented,
    /// `TESTMATRIXTYPE_INCREMENTED_LESS`, which upstream's own adjustment *decrements* by
    /// a smaller step than `TESTMATRIXTYPE_DECREMENTED` does.
    IncrementedLess,
}

/// `getOperationTestMatrixType`
fn operation_test_matrix_type(op: MatrixOp) -> TestMatrixType {
    match op {
        MatrixOp::UnaryPlus | MatrixOp::DivideInto => TestMatrixType::Decremented,
        MatrixOp::Negation => TestMatrixType::NegatedIncremented,
        MatrixOp::PreIncrement | MatrixOp::PostIncrement | MatrixOp::MultiplyInto => TestMatrixType::Negated,
        MatrixOp::PreDecrement => TestMatrixType::Incremented,
        MatrixOp::SubtractFrom => TestMatrixType::IncrementedLess,
        _ => TestMatrixType::Default,
    }
}

/// `isOperationBinary`
fn is_operation_binary(op: MatrixOp) -> bool {
    matches!(
        operation_type(op),
        OperationType::BinaryOperator | OperationType::BinaryFunction | OperationType::Assignment
    )
}

/// `isOperationMatrixScalar`
fn is_operation_matrix_scalar(op: MatrixOp) -> bool {
    matches!(op, MatrixOp::Add | MatrixOp::Sub | MatrixOp::Mul | MatrixOp::Div)
}

/// `isOperationMatrixVector`
fn is_operation_matrix_vector(op: MatrixOp) -> bool {
    op == MatrixOp::Mul
}

/// `isOperationArithmeticMatrixMatrix`
fn is_operation_arithmetic_matrix_matrix(op: MatrixOp) -> bool {
    op == MatrixOp::Mul
}

/// `isOperationComponentwiseMatrixMatrix`
fn is_operation_componentwise_matrix_matrix(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::Add | MatrixOp::Sub | MatrixOp::Mul | MatrixOp::Div | MatrixOp::CompMul
    )
}

/// `isOperationVectorVector`
fn is_operation_vector_vector(op: MatrixOp) -> bool {
    op == MatrixOp::OuterProduct
}

/// `isOperationUnaryAnyMatrix`
fn is_operation_unary_any_matrix(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::Transpose
            | MatrixOp::UnaryPlus
            | MatrixOp::Negation
            | MatrixOp::PreIncrement
            | MatrixOp::PreDecrement
            | MatrixOp::PostIncrement
            | MatrixOp::PostDecrement
    )
}

/// `isOperationUnarySymmetricMatrix`
fn is_operation_unary_symmetric_matrix(op: MatrixOp) -> bool {
    matches!(op, MatrixOp::Inverse | MatrixOp::Determinant)
}

/// `isOperationValueModifying`
fn is_operation_value_modifying(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::PreIncrement | MatrixOp::PreDecrement | MatrixOp::PostIncrement | MatrixOp::PostDecrement
    )
}

/// `isOperationAssignmentAnyMatrix`
fn is_operation_assignment_any_matrix(op: MatrixOp) -> bool {
    matches!(op, MatrixOp::AddInto | MatrixOp::SubtractFrom | MatrixOp::DivideInto)
}

/// `isOperationAssignmentSymmetricMatrix`
fn is_operation_assignment_symmetric_matrix(op: MatrixOp) -> bool {
    op == MatrixOp::MultiplyInto
}

/// `isOperationAssignment`
fn is_operation_assignment(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::AddInto | MatrixOp::SubtractFrom | MatrixOp::MultiplyInto | MatrixOp::DivideInto
    )
}

/// `MatrixCaseUtils::OperationNature`
#[derive(Clone, Copy, PartialEq, Eq)]
enum OperationNature {
    Pure,
    Mutating,
    Assignment,
}

/// `getOperationNature`
fn operation_nature(op: MatrixOp) -> OperationNature {
    if is_operation_assignment(op) {
        OperationNature::Assignment
    } else if is_operation_value_modifying(op) {
        OperationNature::Mutating
    } else {
        OperationNature::Pure
    }
}

/// `tcu::Matrix<float, Rows, Cols>` with its shape carried at run time, stored
/// column-major exactly as upstream does: `data[col][row]` is upstream's `m(row, col)`.
/// Unused rows/columns stay zero so a column can always be read as a `Vec4`.
#[derive(Clone, Copy, PartialEq, Debug)]
struct MatValue {
    cols: usize,
    rows: usize,
    data: [[f32; 4]; 4],
}

impl MatValue {
    fn zero(cols: usize, rows: usize) -> Self {
        Self {
            cols,
            rows,
            data: [[0.0; 4]; 4],
        }
    }

    /// `tcu::Matrix::Matrix(const T src[Rows*Cols])`
    fn from_row_major(cols: usize, rows: usize, src: &[f32]) -> Self {
        let mut m = Self::zero(cols, rows);
        for row in 0..rows {
            for col in 0..cols {
                m.set(row, col, src[row * cols + col]);
            }
        }
        m
    }

    /// `tcu::Matrix::operator()(row, col)`
    fn at(&self, row: usize, col: usize) -> f32 {
        self.data[col][row]
    }

    fn set(&mut self, row: usize, col: usize, value: f32) {
        self.data[col][row] = value;
    }

    /// `tcu::Matrix::getColumn`, zero-extended to four components.
    fn column(&self, col: usize) -> Vec4 {
        Vec4::from_array(self.data[col])
    }

    /// The row-major data `glUniformMatrix*fv(..., GL_TRUE, ...)` takes, which is the
    /// order upstream's tables are already written in.
    fn row_major_data(&self) -> Vec<f32> {
        (0..self.rows)
            .flat_map(|row| (0..self.cols).map(move |col| self.at(row, col)))
            .collect()
    }
}

/// The value one input carries. Upstream's `TypeTraits<DataT>::Type` selects between the
/// same three shapes.
#[derive(Clone, Copy, Debug)]
enum Value {
    Float(f32),
    /// A `vec2`/`vec3`/`vec4`, with only the first `size` components meaningful.
    Vector(usize, Vec4),
    Matrix(MatValue),
}

impl Value {
    fn as_matrix(self) -> MatValue {
        match self {
            Self::Matrix(m) => m,
            _ => panic!("operand is not a matrix"),
        }
    }
}

/// The component-wise operators `tcu::Matrix` and `tcu::Vector` share.
fn component_wise(a: Value, b: Value, f: impl Fn(f32, f32) -> f32) -> Value {
    match (a, b) {
        (Value::Float(x), Value::Float(y)) => Value::Float(f(x, y)),
        (Value::Vector(n, v), Value::Float(y)) => {
            Value::Vector(n, Vec4::from_array(std::array::from_fn(|i| f(v[i], y))))
        }
        (Value::Float(x), Value::Vector(n, v)) => {
            Value::Vector(n, Vec4::from_array(std::array::from_fn(|i| f(x, v[i]))))
        }
        (Value::Vector(n, v), Value::Vector(_, w)) => {
            Value::Vector(n, Vec4::from_array(std::array::from_fn(|i| f(v[i], w[i]))))
        }
        (Value::Matrix(m), Value::Float(y)) => Value::Matrix(map_matrix(m, |x| f(x, y))),
        (Value::Float(x), Value::Matrix(m)) => Value::Matrix(map_matrix(m, |y| f(x, y))),
        (Value::Matrix(m), Value::Matrix(n)) => {
            assert_eq!(
                (m.cols, m.rows),
                (n.cols, n.rows),
                "component-wise operands differ in shape"
            );
            let mut res = MatValue::zero(m.cols, m.rows);
            for row in 0..m.rows {
                for col in 0..m.cols {
                    res.set(row, col, f(m.at(row, col), n.at(row, col)));
                }
            }
            Value::Matrix(res)
        }
        _ => panic!("no component-wise operator for this operand pair"),
    }
}

fn map_matrix(m: MatValue, f: impl Fn(f32) -> f32) -> MatValue {
    let mut res = MatValue::zero(m.cols, m.rows);
    for row in 0..m.rows {
        for col in 0..m.cols {
            res.set(row, col, f(m.at(row, col)));
        }
    }
    res
}

/// `tcu::operator*(Matrix, Matrix)`
fn mat_mul(m: MatValue, n: MatValue) -> MatValue {
    assert_eq!(m.cols, n.rows, "matrix product operands do not line up");
    let mut res = MatValue::zero(n.cols, m.rows);
    for row in 0..m.rows {
        for col in 0..n.cols {
            let mut v = 0.0;
            for ndx in 0..m.cols {
                v += m.at(row, ndx) * n.at(ndx, col);
            }
            res.set(row, col, v);
        }
    }
    res
}

/// `tcu::operator+(Matrix, Matrix)`
fn mat_add(m: MatValue, n: MatValue) -> MatValue {
    component_wise(Value::Matrix(m), Value::Matrix(n), |x, y| x + y).as_matrix()
}

/// `tcu::operator-(Matrix, Matrix)`
fn mat_sub(m: MatValue, n: MatValue) -> MatValue {
    component_wise(Value::Matrix(m), Value::Matrix(n), |x, y| x - y).as_matrix()
}

/// `tcu::operator+`
fn add(a: Value, b: Value) -> Value {
    component_wise(a, b, |x, y| x + y)
}

/// `tcu::operator-`
fn sub(a: Value, b: Value) -> Value {
    component_wise(a, b, |x, y| x - y)
}

/// `tcu::operator/`
fn div(a: Value, b: Value) -> Value {
    component_wise(a, b, |x, y| x / y)
}

/// `tcu::operator*` - a matrix product, a matrix-vector product or a component-wise
/// scaling, decided by the operand shapes exactly as the C++ overload set decides it.
fn mul(a: Value, b: Value) -> Value {
    match (a, b) {
        (Value::Matrix(m), Value::Matrix(n)) => Value::Matrix(mat_mul(m, n)),
        (Value::Matrix(m), Value::Vector(_, vec)) => {
            let mut res = Vec4::splat(0.0);
            for row in 0..m.rows {
                res[row] = (0..m.cols).map(|col| m.at(row, col) * vec[col]).sum();
            }
            Value::Vector(m.rows, res)
        }
        (Value::Vector(_, vec), Value::Matrix(m)) => {
            let mut res = Vec4::splat(0.0);
            for col in 0..m.cols {
                res[col] = (0..m.rows).map(|row| vec[row] * m.at(row, col)).sum();
            }
            Value::Vector(m.cols, res)
        }
        _ => component_wise(a, b, |x, y| x * y),
    }
}

/// `matrixCompMult`
fn matrix_comp_mult(a: Value, b: Value) -> Value {
    component_wise(a, b, |x, y| x * y)
}

/// `outerProduct` - upstream builds the transpose and flips it back to GL's column-major
/// form; the result is `m(row, col) = a[row] * b[col]` either way.
fn outer_product(a: Value, b: Value) -> MatValue {
    let (Value::Vector(a_size, a_vec), Value::Vector(b_size, b_vec)) = (a, b) else {
        panic!("outerProduct takes two vectors");
    };

    let mut res = MatValue::zero(b_size, a_size);
    for row in 0..a_size {
        for col in 0..b_size {
            res.set(row, col, a_vec[row] * b_vec[col]);
        }
    }
    res
}

/// `tcu::transpose`
fn transpose(m: MatValue) -> MatValue {
    let mut res = MatValue::zero(m.rows, m.cols);
    for row in 0..m.rows {
        for col in 0..m.cols {
            res.set(col, row, m.at(row, col));
        }
    }
    res
}

/// `determinant<2>`
fn determinant2(m: &MatValue) -> f32 {
    m.at(0, 0) * m.at(1, 1) - m.at(1, 0) * m.at(0, 1)
}

/// `determinant<3>`
fn determinant3(m: &MatValue) -> f32 {
    m.at(0, 0) * m.at(1, 1) * m.at(2, 2) + m.at(0, 1) * m.at(1, 2) * m.at(2, 0) + m.at(0, 2) * m.at(1, 0) * m.at(2, 1)
        - m.at(0, 0) * m.at(1, 2) * m.at(2, 1)
        - m.at(0, 1) * m.at(1, 0) * m.at(2, 2)
        - m.at(0, 2) * m.at(1, 1) * m.at(2, 0)
}

/// `determinant<4>` - the expansion along the first row upstream writes out as four
/// explicit minor matrices.
fn determinant4(m: &MatValue) -> f32 {
    let minor = |skip_col: usize| {
        let mut res = MatValue::zero(3, 3);
        for row in 0..3 {
            let mut dst_col = 0;
            for col in 0..4 {
                if col == skip_col {
                    continue;
                }
                res.set(row, dst_col, m.at(row + 1, col));
                dst_col += 1;
            }
        }
        res
    };

    m.at(0, 0) * determinant3(&minor(0)) - m.at(0, 1) * determinant3(&minor(1)) + m.at(0, 2) * determinant3(&minor(2))
        - m.at(0, 3) * determinant3(&minor(3))
}

/// `determinant<Size>`
fn determinant(m: &MatValue) -> f32 {
    match m.rows {
        2 => determinant2(m),
        3 => determinant3(m),
        4 => determinant4(m),
        size => panic!("no determinant for a {size}x{size} matrix"),
    }
}

/// `inverse<2>`
fn inverse2(m: &MatValue) -> MatValue {
    let det = determinant2(m);
    let mut res = MatValue::zero(2, 2);
    res.set(0, 0, m.at(1, 1) / det);
    res.set(0, 1, -m.at(0, 1) / det);
    res.set(1, 0, -m.at(1, 0) / det);
    res.set(1, 1, m.at(0, 0) / det);
    res
}

/// The `areaA`/`areaB`/`areaC`/`areaD` split blockwise inversion works on: the block of
/// `m` at `(row_ofs, col_ofs)` with the given shape.
fn block(m: &MatValue, row_ofs: usize, col_ofs: usize, cols: usize, rows: usize) -> MatValue {
    let mut res = MatValue::zero(cols, rows);
    for row in 0..rows {
        for col in 0..cols {
            res.set(row, col, m.at(row + row_ofs, col + col_ofs));
        }
    }
    res
}

/// `inverse<3>` and `inverse<4>` - both are the same blockwise inversion upstream writes
/// twice, differing only in the shape of the off-diagonal blocks and in the Schur
/// complement being a scalar reciprocal rather than a 2x2 inverse. The 3x3 case's scalar
/// stays a 1x1 matrix here, so the block products are one expression instead of two.
fn inverse_blockwise(m: &MatValue) -> MatValue {
    let size = m.rows;
    let rest = size - 2;

    let inv_a = inverse2(&block(m, 0, 0, 2, 2));
    let mat_b = block(m, 0, 2, rest, 2);
    let mat_c = block(m, 2, 0, 2, rest);
    let mat_d = block(m, 2, 2, rest, rest);

    let schur_input = mat_sub(mat_d, mat_mul(mat_mul(mat_c, inv_a), mat_b));
    let schur_complement = if rest == 1 {
        let mut scalar = MatValue::zero(1, 1);
        scalar.set(0, 0, 1.0 / schur_input.at(0, 0));
        scalar
    } else {
        inverse2(&schur_input)
    };

    let zero_mat = MatValue::zero(2, 2);
    let block_a = mat_add(
        inv_a,
        mat_mul(mat_mul(mat_mul(mat_mul(inv_a, mat_b), schur_complement), mat_c), inv_a),
    );
    let block_b = mat_mul(mat_mul(mat_sub(zero_mat, inv_a), mat_b), schur_complement);
    let block_c = mat_mul(mat_mul(map_matrix(schur_complement, |v| -v), mat_c), inv_a);
    let block_d = schur_complement;

    let mut res = MatValue::zero(size, size);
    for row in 0..2 {
        for col in 0..2 {
            res.set(row, col, block_a.at(row, col));
        }
        for col in 0..rest {
            res.set(row, col + 2, block_b.at(row, col));
        }
    }
    for row in 0..rest {
        for col in 0..2 {
            res.set(row + 2, col, block_c.at(row, col));
        }
        for col in 0..rest {
            res.set(row + 2, col + 2, block_d.at(row, col));
        }
    }
    res
}

/// `inverse<Size>`
fn inverse(m: &MatValue) -> MatValue {
    match m.rows {
        2 => inverse2(m),
        3 | 4 => inverse_blockwise(m),
        size => panic!("no inverse for a {size}x{size} matrix"),
    }
}

/// `negate`
fn negate(m: MatValue) -> MatValue {
    map_matrix(m, |v| -v)
}

/// `increment`
fn increment(m: MatValue) -> MatValue {
    map_matrix(m, |v| v + 1.0)
}

/// `decrement`
fn decrement(m: MatValue) -> MatValue {
    map_matrix(m, |v| v - 1.0)
}

/// `reduceToVec3`, over every result shape the cases produce.
fn reduce_to_vec3(value: Value) -> Vec3 {
    match value {
        Value::Float(v) => Vec3::new(v, v, v),
        Value::Vector(2, v) => v.swizzle([0, 1, 0]),
        Value::Vector(3, v) => v.swizzle([0, 1, 2]),
        Value::Vector(4, v) => Vec3::new(v[0], v[1], v[2] + v[3]),
        Value::Vector(n, _) => panic!("no vec3 reduction for a {n}-component vector"),
        Value::Matrix(m) => match (m.cols, m.rows) {
            (2, 2) => Vec3::new(m.at(0, 0), m.at(0, 1), m.at(1, 0) + m.at(1, 1)),
            (2, 3) => (m.column(0) + m.column(1)).swizzle([0, 1, 2]),
            (2, 4) => m.column(0).swizzle([0, 1, 2]) + m.column(1).swizzle([1, 2, 3]),
            (3, 2) => Vec3::new(
                m.at(0, 0) + m.at(1, 0),
                m.at(0, 1) + m.at(1, 1),
                m.at(0, 2) + m.at(1, 2),
            ),
            (3, 3) => (m.column(0) + m.column(1) + m.column(2)).swizzle([0, 1, 2]),
            (3, 4) => m.column(0).swizzle([0, 1, 2]) + m.column(1).swizzle([1, 2, 3]) + m.column(2).swizzle([2, 3, 0]),
            (4, 2) => Vec3::new(
                m.at(0, 0) + m.at(1, 0) + m.at(0, 3),
                m.at(0, 1) + m.at(1, 1) + m.at(1, 3),
                m.at(0, 2) + m.at(1, 2),
            ),
            (4, 3) => (m.column(0) + m.column(1) + m.column(2) + m.column(3)).swizzle([0, 1, 2]),
            (4, 4) => {
                m.column(0).swizzle([0, 1, 2])
                    + m.column(1).swizzle([1, 2, 3])
                    + m.column(2).swizzle([2, 3, 0])
                    + m.column(3).swizzle([3, 0, 1])
            }
            (cols, rows) => panic!("no vec3 reduction for a mat{cols}x{rows}"),
        },
    }
}

/// `getInputValue<INPUTTYPE_CONST, DataT>` - and `INPUTTYPE_UNIFORM`'s too, since the two
/// read the same tables. `setupUniforms` uploads exactly what this returns.
fn const_input_value(data_type: DataType, input_ndx: usize) -> Value {
    match data_type {
        DataType::Float => Value::Float(S_CONST_IN_FLOAT[input_ndx]),
        DataType::FloatVec2 => Value::Vector(2, S_CONST_IN_VEC2[input_ndx].to_width()),
        DataType::FloatVec3 => Value::Vector(3, S_CONST_IN_VEC3[input_ndx].to_width()),
        DataType::FloatVec4 => Value::Vector(4, S_CONST_IN_VEC4[input_ndx]),
        other => Value::Matrix(MatValue::from_row_major(
            other.matrix_num_columns() as usize,
            other.matrix_num_rows() as usize,
            const_matrix_table(other, input_ndx),
        )),
    }
}

/// `getInputValue<INPUTTYPE_DYNAMIC, DataT>`
fn dynamic_input_value(data_type: DataType, eval_ctx: &ShaderEvalContext) -> Value {
    match data_type {
        DataType::Float => Value::Float(eval_ctx.coords.x()),
        DataType::FloatVec2 => Value::Vector(2, eval_ctx.coords),
        DataType::FloatVec3 => Value::Vector(3, eval_ctx.coords),
        DataType::FloatVec4 => Value::Vector(4, eval_ctx.coords),
        other => {
            let num_cols = other.matrix_num_columns() as usize;
            let num_rows = other.matrix_num_rows() as usize;
            let mut m = MatValue::zero(num_cols, num_rows);
            for col in 0..num_cols {
                for row in 0..num_rows {
                    m.set(row, col, eval_ctx.in_[col][row]);
                }
            }
            Value::Matrix(m)
        }
    }
}

/// `getInputValue<InputT, DataT>`
fn get_input_value(input: &ShaderInput, eval_ctx: &ShaderEvalContext, input_ndx: usize) -> Value {
    if input.input_type == InputType::Dynamic {
        dynamic_input_value(input.data_type(), eval_ctx)
    } else {
        const_input_value(input.data_type(), input_ndx)
    }
}

// Shader source format utilities.

/// `de::floatToString(value, 1)`
fn float_to_string(value: f32) -> String {
    format!("{value:.1}")
}

/// `writeVectorConstructor`
fn write_vector_constructor(size: usize, v: Vec4) -> String {
    let components: Vec<String> = (0..size).map(|ndx| float_to_string(v[ndx])).collect();
    format!("vec{size}({})", components.join(", "))
}

/// `writeMatrixConstructor` - column-major, which is the order a GLSL matrix constructor
/// takes its arguments in.
fn write_matrix_constructor(m: &MatValue) -> String {
    let type_name = if m.rows == m.cols {
        format!("mat{}", m.cols)
    } else {
        format!("mat{}x{}", m.cols, m.rows)
    };

    let components: Vec<String> = (0..m.cols)
        .flat_map(|col| (0..m.rows).map(move |row| float_to_string(m.at(row, col))))
        .collect();
    format!("{type_name}({})", components.join(", "))
}

/// `gles3::Functional::ShaderMatrixCase`
struct ShaderMatrixCaseSpec {
    name: String,
    vert_src: String,
    frag_src: String,
    is_vertex_case: bool,
    in0: ShaderInput,
    in1: ShaderInput,
    op: MatrixOp,
    user_attrib_transforms: Vec<Mat4>,
}

impl ShaderMatrixCaseSpec {
    /// `ShaderMatrixCase::ShaderMatrixCase` plus `init`, which is where upstream builds
    /// both shader sources and the attribute transforms.
    fn new(name: &str, in0: ShaderInput, in1: ShaderInput, op: MatrixOp, is_vertex_case: bool) -> Self {
        let (vert_src, frag_src) = build_shader_sources(&in0, &in1, op, is_vertex_case);

        Self {
            name: name.to_string(),
            vert_src,
            frag_src,
            is_vertex_case,
            in0,
            in1,
            op,
            user_attrib_transforms: build_user_attrib_transforms(op, in0.precision()),
        }
    }
}

/// The `m_userAttribTransforms` half of `ShaderMatrixCase::init`.
fn build_user_attrib_transforms(op: MatrixOp, result_prec: Precision) -> Vec<Mat4> {
    // \todo [2012-02-14 pyry] Compute better values for matrix tests.
    let mut transforms = vec![Mat4::zero(); 4];
    for (attrib_ndx, transform) in transforms.iter_mut().enumerate() {
        // prevent matrix*vec from going into zero (assuming vec.w != 0)
        transform.set(0, 3, 0.1 + 0.1 * attrib_ndx as f32);
        transform.set(1, 3, 0.2 + 0.1 * attrib_ndx as f32);
        transform.set(2, 3, 0.3 + 0.1 * attrib_ndx as f32);
        transform.set(3, 3, 0.4 + 0.1 * attrib_ndx as f32);
        transform.set(attrib_ndx % 4, 0, 1.0);
        transform.set((attrib_ndx + 1) % 4, 1, 1.0);
        transform.set((attrib_ndx + 2) % 4, 2, 1.0);
        transform.set((attrib_ndx + 3) % 4, 3, 1.0);
    }

    // prevent bad reference cases such as black result images by fine-tuning used matrices
    let matrix_type = operation_test_matrix_type(op);
    if matrix_type != TestMatrixType::Default {
        for transform in &mut transforms {
            for row in 0..4 {
                for col in 0..4 {
                    let value = transform.at(row, col);
                    transform.set(
                        row,
                        col,
                        match matrix_type {
                            TestMatrixType::Negated => -value,
                            TestMatrixType::Incremented => value + 0.3,
                            TestMatrixType::Decremented => value - 0.3,
                            TestMatrixType::NegatedIncremented => -value + 0.3,
                            TestMatrixType::IncrementedLess => value - 0.1,
                            TestMatrixType::Default => unreachable!(),
                        },
                    );
                }
            }
        }
    }

    // The verification code doesn't deal with reduced precision, so we must quantize the data
    // here to try to avoid verification errors. No implementation seems to use lowp, so reduce
    // to mediump.
    if result_prec != Precision::HighP {
        for transform in &mut transforms {
            for row in 0..4 {
                for col in 0..4 {
                    transform.set(row, col, f16_bits_to_f32(f32_to_f16_bits(transform.at(row, col))));
                }
            }
        }
    }

    transforms
}

/// The result type the operation produces, off the two input types.
fn result_data_type(in0: &ShaderInput, in1: &ShaderInput, op: MatrixOp) -> DataType {
    let in0_type = in0.data_type();
    let in1_is_matrix = in1.data_type.is_some_and(DataType::is_matrix);

    if op == MatrixOp::Mul && in0_type.is_matrix() && in1_is_matrix {
        get_data_type_matrix(in1.data_type().matrix_num_columns(), in0_type.matrix_num_rows())
    } else if op == MatrixOp::OuterProduct {
        get_data_type_matrix(in1.data_type().scalar_size(), in0_type.scalar_size())
    } else if op == MatrixOp::Transpose {
        get_data_type_matrix(in0_type.matrix_num_rows(), in0_type.matrix_num_columns())
    } else if op == MatrixOp::Inverse {
        in0_type
    } else if op == MatrixOp::Determinant {
        DataType::Float
    } else if matches!(
        operation_type(op),
        OperationType::UnaryPrefixOperator | OperationType::UnaryPostfixOperator
    ) {
        in0_type
    } else if in0_type.is_matrix() && in1_is_matrix {
        assert_eq!(in0_type, in1.data_type());
        in0_type
    } else {
        assert!(in0_type.is_matrix() || in1_is_matrix);
        let mat_ndx = if in0_type.is_matrix() { 0 } else { 1 };
        let (matrix_type, other_type) = if mat_ndx == 0 {
            (in0_type, in1.data_type())
        } else {
            (in1.data_type(), in0_type)
        };

        if other_type == DataType::Float {
            matrix_type
        } else {
            assert!(other_type.is_vector());
            get_data_type_float_vec(if mat_ndx == 0 {
                matrix_type.matrix_num_rows()
            } else {
                matrix_type.matrix_num_columns()
            })
        }
    }
}

/// `ShaderMatrixCase::genGLSLMatToVec3Reduction`
fn gen_glsl_mat_to_vec3_reduction(mat_type: DataType, var_name: &str) -> String {
    match mat_type {
        DataType::Float => format!("{var_name}, {var_name}, {var_name}"),
        DataType::FloatVec2 => format!("{var_name}.x, {var_name}.y, {var_name}.x"),
        DataType::FloatVec3 => var_name.to_string(),
        DataType::FloatVec4 => format!("{var_name}.x, {var_name}.y, {var_name}.z+{var_name}.w"),
        DataType::FloatMat2 => format!("{var_name}[0][0], {var_name}[1][0], {var_name}[0][1]+{var_name}[1][1]"),
        DataType::FloatMat2x3 => format!("{var_name}[0] + {var_name}[1]"),
        DataType::FloatMat2x4 => format!("{var_name}[0].xyz + {var_name}[1].yzw"),
        DataType::FloatMat3x2 => format!(
            "{var_name}[0][0]+{var_name}[0][1], {var_name}[1][0]+{var_name}[1][1], {var_name}[2][0]+{var_name}[2][1]"
        ),
        DataType::FloatMat3 => format!("{var_name}[0] + {var_name}[1] + {var_name}[2]"),
        DataType::FloatMat3x4 => format!("{var_name}[0].xyz + {var_name}[1].yzw + {var_name}[2].zwx"),
        DataType::FloatMat4x2 => {
            format!(
                "{var_name}[0][0]+{var_name}[0][1]+{var_name}[3][0], {var_name}[1][0]+{var_name}[1][1]+{var_name}[3][1], {var_name}[2][0]+{var_name}[2][1]"
            )
        }
        DataType::FloatMat4x3 => format!("{var_name}[0] + {var_name}[1] + {var_name}[2] + {var_name}[3]"),
        DataType::FloatMat4 => format!("{var_name}[0].xyz+{var_name}[1].yzw+{var_name}[2].zwx+{var_name}[3].wxy"),
        other => panic!("no vec3 reduction for {}", other.name()),
    }
}

/// The GLSL literal for a constant input of the given type.
fn const_input_literal(data_type: DataType, input_ndx: usize) -> String {
    match const_input_value(data_type, input_ndx) {
        Value::Float(v) => float_to_string(v),
        Value::Vector(size, v) => write_vector_constructor(size, v),
        Value::Matrix(m) => write_matrix_constructor(&m),
    }
}

/// The shader-source half of `ShaderMatrixCase::init`.
fn build_shader_sources(in0: &ShaderInput, in1: &ShaderInput, op: MatrixOp, is_vertex_case: bool) -> (String, String) {
    let mut vtx = String::new();
    let mut frag = String::new();

    // Upstream aliases `op` onto whichever stream the operation is written into.
    macro_rules! op_out {
        ($($arg:tt)*) => {
            if is_vertex_case { vtx.push_str(&format!($($arg)*)) } else { frag.push_str(&format!($($arg)*)) }
        };
    }

    let mut in_values = [String::new(), String::new()];
    let result_prec = in0.precision();
    let result_type = result_data_type(in0, in1, op);
    let mut pass_vars: Vec<String> = Vec::new();
    let num_inputs = if is_operation_binary(op) { 2 } else { 1 };

    vtx.push_str("#version 300 es\n");
    frag.push_str("#version 300 es\n");

    vtx.push_str("in highp vec4 a_position;\n");
    frag.push_str("layout(location = 0) out mediump vec4 dEQP_FragColor;\n");
    if is_vertex_case {
        vtx.push_str("out mediump vec4 v_color;\n");
        frag.push_str("in mediump vec4 v_color;\n");
    }

    // Input declarations.
    for (in_ndx, in_value) in in_values.iter_mut().enumerate().take(num_inputs) {
        let input = if in_ndx > 0 { in1 } else { in0 };
        let prec_name = input.precision().name();
        let type_name = input.data_type().name();

        match input.input_type {
            InputType::Dynamic => {
                if input.data_type().is_matrix() {
                    // a_matN, v_matN
                    vtx.push_str(&format!("in {prec_name} {type_name} a_{type_name};\n"));
                    if !is_vertex_case {
                        vtx.push_str(&format!("out {prec_name} {type_name} v_{type_name};\n"));
                        frag.push_str(&format!("in {prec_name} {type_name} v_{type_name};\n"));
                        pass_vars.push(type_name.to_string());
                    }

                    *in_value = format!("{}{type_name}", if is_vertex_case { "a_" } else { "v_" });
                } else {
                    // a_coords, v_coords
                    vtx.push_str(&format!("in {prec_name} {type_name} a_coords;\n"));
                    if !is_vertex_case {
                        vtx.push_str(&format!("out {prec_name} {type_name} v_coords;\n"));
                        frag.push_str(&format!("in {prec_name} {type_name} v_coords;\n"));
                        pass_vars.push("coords".to_string());
                    }

                    *in_value = if is_vertex_case { "a_coords" } else { "v_coords" }.to_string();
                }
            }
            InputType::Uniform => {
                op_out!("uniform {prec_name} {type_name} u_in{in_ndx};\n");
                *in_value = format!("u_in{in_ndx}");
            }
            InputType::Const => {
                op_out!(
                    "const {prec_name} {type_name} in{in_ndx} = {};\n",
                    const_input_literal(input.data_type(), in_ndx)
                );
                *in_value = format!("in{in_ndx}");
            }
            InputType::Last => unreachable!("a void input is never declared"),
        }
    }

    vtx.push_str("\nvoid main (void)\n{\n    gl_Position = a_position;\n");
    frag.push_str("\nvoid main (void)\n{\n");

    if is_vertex_case {
        frag.push_str("    dEQP_FragColor = v_color;\n");
    } else {
        for name in &pass_vars {
            vtx.push_str(&format!("    v_{name} = a_{name};\n"));
        }
    }

    // Operation.
    let (operation_value0, operation_value1) = match operation_nature(op) {
        OperationNature::Pure | OperationNature::Assignment => (in_values[0].clone(), in_values[1].clone()),
        OperationNature::Mutating => {
            op_out!(
                "    {} {} tmpValue = {};\n",
                result_prec.name(),
                result_type.name(),
                in_values[0]
            );
            ("tmpValue".to_string(), in_values[1].clone())
        }
    };

    let prec_name = result_prec.name();
    let type_name = result_type.name();
    let op_name = operation_name(op);
    match operation_type(op) {
        OperationType::BinaryOperator => {
            op_out!("    {prec_name} {type_name} res = {operation_value0} {op_name} {operation_value1};\n")
        }
        OperationType::UnaryPrefixOperator => {
            op_out!("    {prec_name} {type_name} res = {op_name}{operation_value0};\n")
        }
        OperationType::UnaryPostfixOperator => {
            op_out!("    {prec_name} {type_name} res = {operation_value0}{op_name};\n")
        }
        OperationType::BinaryFunction => {
            op_out!("    {prec_name} {type_name} res = {op_name}({operation_value0}, {operation_value1});\n")
        }
        OperationType::UnaryFunction => op_out!("    {prec_name} {type_name} res = {op_name}({operation_value0});\n"),
        OperationType::Assignment => {
            op_out!("    {prec_name} {type_name} res = {operation_value0};\n");
            op_out!("    res {op_name} {operation_value1};\n");
        }
    }

    // Reduction to vec3 (rgb). Check the used value too if it was modified
    let dst = if is_vertex_case { "v_color" } else { "dEQP_FragColor" };
    if is_operation_value_modifying(op) {
        op_out!(
            "    {dst} = vec4({}, 1.0) + vec4({}, 0.0);\n",
            gen_glsl_mat_to_vec3_reduction(result_type, "res"),
            gen_glsl_mat_to_vec3_reduction(result_type, "tmpValue")
        );
    } else {
        op_out!(
            "    {dst} = vec4({}, 1.0);\n",
            gen_glsl_mat_to_vec3_reduction(result_type, "res")
        );
    }

    vtx.push_str("}\n");
    frag.push_str("}\n");

    (vtx, frag)
}

impl ShaderRenderCaseSpec for ShaderMatrixCaseSpec {
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

    /// `m_gridSize = 64` - reassign grid size prevent matrix inverse inf value.
    fn grid_size(&self) -> i32 {
        64
    }

    /// `Evaluator<Op, ...>::evaluate`
    fn evaluate(&self, c: &mut ShaderEvalContext) {
        let in0 = get_input_value(&self.in0, c, 0);
        let value = match self.op {
            MatrixOp::Add | MatrixOp::AddInto => reduce_to_vec3(add(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::Sub | MatrixOp::SubtractFrom => reduce_to_vec3(sub(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::Mul | MatrixOp::MultiplyInto => reduce_to_vec3(mul(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::Div | MatrixOp::DivideInto => reduce_to_vec3(div(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::CompMul => reduce_to_vec3(matrix_comp_mult(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::OuterProduct => {
                reduce_to_vec3(Value::Matrix(outer_product(in0, get_input_value(&self.in1, c, 1))))
            }
            MatrixOp::Transpose => reduce_to_vec3(Value::Matrix(transpose(in0.as_matrix()))),
            MatrixOp::Inverse => reduce_to_vec3(Value::Matrix(inverse(&in0.as_matrix()))),
            MatrixOp::Determinant => {
                let det = determinant(&in0.as_matrix());
                Vec3::new(det, det, det)
            }
            MatrixOp::UnaryPlus => reduce_to_vec3(in0),
            MatrixOp::Negation => reduce_to_vec3(Value::Matrix(negate(in0.as_matrix()))),
            // modifying reduction: sum modified value too
            MatrixOp::PreIncrement => {
                let incremented = reduce_to_vec3(Value::Matrix(increment(in0.as_matrix())));
                incremented + incremented
            }
            MatrixOp::PreDecrement => {
                let decremented = reduce_to_vec3(Value::Matrix(decrement(in0.as_matrix())));
                decremented + decremented
            }
            MatrixOp::PostIncrement => reduce_to_vec3(in0) + reduce_to_vec3(Value::Matrix(increment(in0.as_matrix()))),
            MatrixOp::PostDecrement => reduce_to_vec3(in0) + reduce_to_vec3(Value::Matrix(decrement(in0.as_matrix()))),
        };

        c.color.m_data[..3].copy_from_slice(&value.m_data);
    }

    /// `ShaderMatrixCase::setupUniforms`
    fn setup_uniforms(&self, context: &Context, program: GLuint, _const_coords: Vec4) -> Result<(), TestError> {
        let gl = context.gl();

        for (in_ndx, input) in [&self.in0, &self.in1].into_iter().enumerate() {
            if input.input_type != InputType::Uniform {
                continue;
            }

            let name = std::ffi::CString::new(format!("u_in{in_ndx}")).expect("no interior NUL");
            // SAFETY: a NUL-terminated name and a program this case built.
            let loc = unsafe { gl.get_uniform_location(program, name.as_ptr()) };
            if loc < 0 {
                continue;
            }

            let value = const_input_value(input.data_type(), in_ndx);
            // SAFETY: every pointer below covers exactly the element count passed with it.
            unsafe {
                match value {
                    Value::Float(v) => gl.uniform_1f(loc, v),
                    Value::Vector(2, v) => gl.uniform_2fv(loc, 1, v.m_data.as_ptr()),
                    Value::Vector(3, v) => gl.uniform_3fv(loc, 1, v.m_data.as_ptr()),
                    Value::Vector(4, v) => gl.uniform_4fv(loc, 1, v.m_data.as_ptr()),
                    Value::Vector(n, _) => panic!("no uniform setter for a {n}-component vector"),
                    // \note GLES3 supports transpose in matrix upload.
                    Value::Matrix(m) => {
                        let data = m.row_major_data();
                        match (m.cols, m.rows) {
                            (2, 2) => gl.uniform_matrix_2fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (2, 3) => gl.uniform_matrix_2x_3fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (2, 4) => gl.uniform_matrix_2x_4fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (3, 2) => gl.uniform_matrix_3x_2fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (3, 3) => gl.uniform_matrix_3fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (3, 4) => gl.uniform_matrix_3x_4fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (4, 2) => gl.uniform_matrix_4x_2fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (4, 3) => gl.uniform_matrix_4x_3fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (4, 4) => gl.uniform_matrix_4fv(loc, 1, glw::TRUE, data.as_ptr()),
                            (cols, rows) => panic!("no uniform setter for a mat{cols}x{rows}"),
                        }
                    }
                }
            }
        }

        Ok(())
    }
}

/// One entry of upstream's `ops[]` table.
struct OpSpec {
    name: &'static str,
    op: MatrixOp,
    /// `extendedInputTypeCases` - test with const and uniform types too.
    extended_input_type_cases: bool,
    /// `createInputTypeGroup` - create group for input types.
    create_input_type_group: bool,
}

const OPS: [OpSpec; 19] = [
    OpSpec {
        name: "add",
        op: MatrixOp::Add,
        extended_input_type_cases: true,
        create_input_type_group: true,
    },
    OpSpec {
        name: "sub",
        op: MatrixOp::Sub,
        extended_input_type_cases: true,
        create_input_type_group: true,
    },
    OpSpec {
        name: "mul",
        op: MatrixOp::Mul,
        extended_input_type_cases: true,
        create_input_type_group: true,
    },
    OpSpec {
        name: "div",
        op: MatrixOp::Div,
        extended_input_type_cases: true,
        create_input_type_group: true,
    },
    OpSpec {
        name: "matrixcompmult",
        op: MatrixOp::CompMul,
        extended_input_type_cases: false,
        create_input_type_group: true,
    },
    OpSpec {
        name: "outerproduct",
        op: MatrixOp::OuterProduct,
        extended_input_type_cases: false,
        create_input_type_group: true,
    },
    OpSpec {
        name: "transpose",
        op: MatrixOp::Transpose,
        extended_input_type_cases: false,
        create_input_type_group: true,
    },
    OpSpec {
        name: "determinant",
        op: MatrixOp::Determinant,
        extended_input_type_cases: false,
        create_input_type_group: true,
    },
    OpSpec {
        name: "inverse",
        op: MatrixOp::Inverse,
        extended_input_type_cases: false,
        create_input_type_group: true,
    },
    OpSpec {
        name: "unary_addition",
        op: MatrixOp::UnaryPlus,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "negation",
        op: MatrixOp::Negation,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "pre_increment",
        op: MatrixOp::PreIncrement,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "pre_decrement",
        op: MatrixOp::PreDecrement,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "post_increment",
        op: MatrixOp::PostIncrement,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "post_decrement",
        op: MatrixOp::PostDecrement,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "add_assign",
        op: MatrixOp::AddInto,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "sub_assign",
        op: MatrixOp::SubtractFrom,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "mul_assign",
        op: MatrixOp::MultiplyInto,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
    OpSpec {
        name: "div_assign",
        op: MatrixOp::DivideInto,
        extended_input_type_cases: false,
        create_input_type_group: false,
    },
];

/// `InputTypeSpec`
const EXTENDED_INPUT_TYPES: [(&str, InputType); 3] = [
    ("const", InputType::Const),
    ("uniform", InputType::Uniform),
    ("dynamic", InputType::Dynamic),
];
const REDUCED_INPUT_TYPES: [(&str, InputType); 1] = [("dynamic", InputType::Dynamic)];

const MATRIX_TYPES: [DataType; 9] = [
    DataType::FloatMat2,
    DataType::FloatMat2x3,
    DataType::FloatMat2x4,
    DataType::FloatMat3x2,
    DataType::FloatMat3,
    DataType::FloatMat3x4,
    DataType::FloatMat4x2,
    DataType::FloatMat4x3,
    DataType::FloatMat4,
];
const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

fn add_case(
    cases: &mut Vec<Box<dyn TestCase>>,
    name: String,
    in0: ShaderInput,
    in1: ShaderInput,
    op: MatrixOp,
    is_vertex_case: bool,
) {
    cases.push(Box::new(ShaderRenderCase::new(ShaderMatrixCaseSpec::new(
        &name,
        in0,
        in1,
        op,
        is_vertex_case,
    ))));
}

/// `ShaderMatrixTests::init`
pub fn create_tests() -> TestCaseGroup {
    let mut group = TestCaseGroup::new("matrix");

    for op_spec in &OPS {
        let in_type_list: &[(&str, InputType)] = if op_spec.extended_input_type_cases {
            &EXTENDED_INPUT_TYPES
        } else {
            &REDUCED_INPUT_TYPES
        };
        let op = op_spec.op;
        let mut op_group = TestCaseGroup::new(op_spec.name);

        for &(in_type_name, input_type) in in_type_list {
            let mut in_group: Vec<Box<dyn TestCase>> = Vec::new();

            for mat_type in MATRIX_TYPES {
                let num_cols = mat_type.matrix_num_columns();
                let num_rows = mat_type.matrix_num_rows();
                let mat_type_name = mat_type.name();

                for precision in PRECISIONS {
                    let prec_name = precision.name();
                    let base_name = format!("{prec_name}_{mat_type_name}_");
                    let mat_in = ShaderInput::new(input_type, mat_type, precision);

                    if is_operation_matrix_scalar(op) {
                        // Matrix-scalar \note For div cases we use uniform input.
                        let scalar_in = ShaderInput::new(
                            if op == MatrixOp::Div {
                                InputType::Uniform
                            } else {
                                InputType::Dynamic
                            },
                            DataType::Float,
                            precision,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_vertex"),
                            mat_in,
                            scalar_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_fragment"),
                            mat_in,
                            scalar_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_matrix_vector(op) {
                        // Matrix-vector.
                        let col_vec_type = get_data_type_float_vec(num_cols);
                        let col_vec_in = ShaderInput::new(
                            if op == MatrixOp::Div {
                                InputType::Uniform
                            } else {
                                InputType::Dynamic
                            },
                            col_vec_type,
                            precision,
                        );

                        add_case(
                            &mut in_group,
                            format!("{base_name}{}_vertex", col_vec_type.name()),
                            mat_in,
                            col_vec_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}{}_fragment", col_vec_type.name()),
                            mat_in,
                            col_vec_in,
                            op,
                            false,
                        );

                        // Vector-matrix.
                        let row_vec_type = get_data_type_float_vec(num_rows);
                        let row_vec_in = ShaderInput::new(
                            if op == MatrixOp::Div {
                                InputType::Uniform
                            } else {
                                InputType::Dynamic
                            },
                            row_vec_type,
                            precision,
                        );
                        let vec_mat_name = format!("{prec_name}_{}_{mat_type_name}", row_vec_type.name());

                        add_case(
                            &mut in_group,
                            format!("{vec_mat_name}_vertex"),
                            row_vec_in,
                            mat_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{vec_mat_name}_fragment"),
                            row_vec_in,
                            mat_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_arithmetic_matrix_matrix(op) {
                        // Arithmetic matrix-matrix multiplication.
                        for other_cols in 2..=4 {
                            let other_mat_in = ShaderInput::new(
                                if input_type == InputType::Dynamic {
                                    InputType::Uniform
                                } else {
                                    input_type
                                },
                                get_data_type_matrix(other_cols, num_cols),
                                precision,
                            );
                            let other_name = other_mat_in.data_type().name();
                            add_case(
                                &mut in_group,
                                format!("{base_name}{other_name}_vertex"),
                                mat_in,
                                other_mat_in,
                                op,
                                true,
                            );
                            add_case(
                                &mut in_group,
                                format!("{base_name}{other_name}_fragment"),
                                mat_in,
                                other_mat_in,
                                op,
                                false,
                            );
                        }
                    } else if is_operation_componentwise_matrix_matrix(op) {
                        // Component-wise.
                        let other_mat_in = ShaderInput::new(
                            if input_type == InputType::Dynamic {
                                InputType::Uniform
                            } else {
                                input_type
                            },
                            mat_type,
                            precision,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}{mat_type_name}_vertex"),
                            mat_in,
                            other_mat_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}{mat_type_name}_fragment"),
                            mat_in,
                            other_mat_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_vector_vector(op) {
                        let vec1_in = ShaderInput::new(input_type, get_data_type_float_vec(num_rows), precision);
                        let vec2_in = ShaderInput::new(
                            if input_type == InputType::Dynamic {
                                InputType::Uniform
                            } else {
                                input_type
                            },
                            get_data_type_float_vec(num_cols),
                            precision,
                        );

                        add_case(
                            &mut in_group,
                            format!("{base_name}float_vertex"),
                            vec1_in,
                            vec2_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_fragment"),
                            vec1_in,
                            vec2_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_unary_any_matrix(op)
                        || (is_operation_unary_symmetric_matrix(op) && num_cols == num_rows)
                    {
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_vertex"),
                            mat_in,
                            ShaderInput::void(),
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_fragment"),
                            mat_in,
                            ShaderInput::void(),
                            op,
                            false,
                        );
                    }

                    if is_operation_assignment_any_matrix(op)
                        || (is_operation_assignment_symmetric_matrix(op) && num_cols == num_rows)
                    {
                        let other_mat_in = ShaderInput::new(
                            if input_type == InputType::Dynamic {
                                InputType::Uniform
                            } else {
                                input_type
                            },
                            mat_type,
                            precision,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_vertex"),
                            mat_in,
                            other_mat_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut in_group,
                            format!("{base_name}float_fragment"),
                            mat_in,
                            other_mat_in,
                            op,
                            false,
                        );
                    }
                }
            }

            // The input-type group is only created for the operations upstream marks; the
            // rest put their cases straight into the operation group.
            if op_spec.create_input_type_group {
                let mut group_node = TestCaseGroup::new(in_type_name);
                for case in in_group {
                    group_node.add_child(case);
                }
                op_group.add_child(group_node);
            } else {
                for case in in_group {
                    op_group.add_child(case);
                }
            }
        }

        group.add_child(op_group);
    }

    group
}

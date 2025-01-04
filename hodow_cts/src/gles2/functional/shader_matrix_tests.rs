// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/gles2/functional/es2fShaderMatrixTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream reaches every operand shape through `TypeTraits<DataT>::Type` and instantiates
// `Evaluator<Op, In0Type, In0DataType, In1Type, In1DataType>` for each combination the
// case tree builds. `Value` below carries its own shape instead, so one operator set
// covers what the templates cover: the operations, their order and their names are the
// C++ ones, only the dispatch is a match rather than a switch over a packed key.

use crate::gls::shader_render_case::{ShaderEvalContext, ShaderRenderCase, ShaderRenderCaseSpec};
use crate::glu::shader_util::{DataType, Precision, get_data_type_float_vec};
use crate::glu::{Context, TestCase, TestCaseGroup};
use crate::glw::{self, GLuint};
use crate::tcu::TestError;
use crate::tcu::matrix::Mat4;
use crate::tcu::vector::{Vec2, Vec3, Vec4};

// Uniform / constant values for tests.
// \note Input1 should not contain 0 components as it is used as divisor in div cases.
const S_CONST_IN_FLOAT: [f32; 2] = [0.5, -0.2];
const S_CONST_IN_VEC2: [Vec2; 2] = [Vec2::new(1.2, 0.5), Vec2::new(0.5, 1.0)];
const S_CONST_IN_VEC3: [Vec3; 2] = [Vec3::new(1.1, 0.1, 0.5), Vec3::new(-0.2, 0.5, 0.8)];
const S_CONST_IN_VEC4: [Vec4; 2] = [Vec4::new(1.4, 0.2, -0.5, 0.7), Vec4::new(0.2, -1.0, 0.5, 0.8)];

const S_CONST_IN_MAT20: [f32; 4] = [0.6, -1.0, 0.7, 0.4];
const S_CONST_IN_MAT21: [f32; 4] = [-0.5, -0.4, 0.7, -0.8];

const S_CONST_IN_MAT31: [f32; 9] = [1.2, 0.1, -0.1, 0.1, 0.9, 0.2, 0.2, -0.1, 0.7];
const S_CONST_IN_MAT41: [f32; 16] = [
    1.2, -0.2, 0.4, 0.1, 0.1, 0.8, -0.1, -0.2, -0.2, 0.1, -1.1, 0.3, 0.1, 0.2, 0.3, 0.9,
];

/// `s_constInMat2`
fn const_in_mat2(input_ndx: usize) -> MatValue {
    MatValue::from_row_major(2, 2, &[S_CONST_IN_MAT20, S_CONST_IN_MAT21][input_ndx])
}

/// `s_constInMat3` - the first is `tcu::translationMatrix(Vec2(0.2, -0.3))`.
fn const_in_mat3(input_ndx: usize) -> MatValue {
    if input_ndx == 0 {
        MatValue::translation(&[0.2, -0.3])
    } else {
        MatValue::from_row_major(3, 3, &S_CONST_IN_MAT31)
    }
}

/// `s_constInMat4` - the first is `tcu::translationMatrix(Vec3(0.2, -0.3, 0.15))`.
fn const_in_mat4(input_ndx: usize) -> MatValue {
    if input_ndx == 0 {
        MatValue::translation(&[0.2, -0.3, 0.15])
    } else {
        MatValue::from_row_major(4, 4, &S_CONST_IN_MAT41)
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
        MatrixOp::CompMul => OperationType::BinaryFunction,
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
}

/// `getOperationTestMatrixType`
fn operation_test_matrix_type(op: MatrixOp) -> TestMatrixType {
    match op {
        MatrixOp::Negation | MatrixOp::PreIncrement | MatrixOp::PostIncrement => TestMatrixType::Negated,
        MatrixOp::PreDecrement => TestMatrixType::Incremented,
        MatrixOp::AddInto => TestMatrixType::Decremented,
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

/// `isOperationMatrixMatrix`
fn is_operation_matrix_matrix(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::Add | MatrixOp::Sub | MatrixOp::Mul | MatrixOp::Div | MatrixOp::CompMul
    )
}

/// `isOperationUnary`
fn is_operation_unary(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::UnaryPlus
            | MatrixOp::Negation
            | MatrixOp::PreIncrement
            | MatrixOp::PreDecrement
            | MatrixOp::PostIncrement
            | MatrixOp::PostDecrement
    )
}

/// `isOperationValueModifying`
fn is_operation_value_modifying(op: MatrixOp) -> bool {
    matches!(
        op,
        MatrixOp::PreIncrement | MatrixOp::PreDecrement | MatrixOp::PostIncrement | MatrixOp::PostDecrement
    )
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

    /// `tcu::Matrix::Matrix()` - the identity diagonal.
    fn identity(cols: usize, rows: usize) -> Self {
        let mut m = Self::zero(cols, rows);
        for ndx in 0..cols.min(rows) {
            m.set(ndx, ndx, 1.0);
        }
        m
    }

    /// `tcu::Matrix::Matrix(const T src[Rows*Cols])` - upstream's literal tables are
    /// written out row-major, whatever the storage order is.
    fn from_row_major(cols: usize, rows: usize, src: &[f32]) -> Self {
        let mut m = Self::zero(cols, rows);
        for row in 0..rows {
            for col in 0..cols {
                m.set(row, col, src[row * cols + col]);
            }
        }
        m
    }

    /// `tcu::translationMatrix`
    fn translation(translation: &[f32]) -> Self {
        let len = translation.len();
        let mut m = Self::identity(len + 1, len + 1);
        for (row, &value) in translation.iter().enumerate() {
            m.set(row, len, value);
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

    /// `tcu::Matrix::getColumnMajorData`, which is what `glUniformMatrix*fv` wants.
    fn column_major_data(&self) -> Vec<f32> {
        (0..self.cols)
            .flat_map(|col| (0..self.rows).map(move |row| self.at(row, col)))
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
        (Value::Matrix(m), Value::Matrix(n)) => {
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
            Value::Matrix(res)
        }
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
            (3, 3) => (m.column(0) + m.column(1) + m.column(2)).swizzle([0, 1, 2]),
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

/// `getInputValue<INPUTTYPE_CONST, DataT>` - and `INPUTTYPE_UNIFORM`'s too, which is why
/// upstream folds the two onto one key before dispatching. `setupUniforms` uploads
/// exactly what this returns.
fn const_input_value(data_type: DataType, input_ndx: usize) -> Value {
    match data_type {
        DataType::Float => Value::Float(S_CONST_IN_FLOAT[input_ndx]),
        DataType::FloatVec2 => Value::Vector(2, S_CONST_IN_VEC2[input_ndx].to_width()),
        DataType::FloatVec3 => Value::Vector(3, S_CONST_IN_VEC3[input_ndx].to_width()),
        DataType::FloatVec4 => Value::Vector(4, S_CONST_IN_VEC4[input_ndx]),
        DataType::FloatMat2 => Value::Matrix(const_in_mat2(input_ndx)),
        DataType::FloatMat3 => Value::Matrix(const_in_mat3(input_ndx)),
        DataType::FloatMat4 => Value::Matrix(const_in_mat4(input_ndx)),
        other => panic!("{} has no constant input value", other.name()),
    }
}

/// `getInputValue<INPUTTYPE_DYNAMIC, DataT>`
fn dynamic_input_value(data_type: DataType, eval_ctx: &ShaderEvalContext) -> Value {
    match data_type {
        DataType::Float => Value::Float(eval_ctx.coords.x()),
        DataType::FloatVec2 => Value::Vector(2, eval_ctx.coords),
        DataType::FloatVec3 => Value::Vector(3, eval_ctx.coords),
        DataType::FloatVec4 => Value::Vector(4, eval_ctx.coords),
        DataType::FloatMat2 | DataType::FloatMat3 | DataType::FloatMat4 => {
            let num_cols = data_type.matrix_num_columns() as usize;
            let num_rows = data_type.matrix_num_rows() as usize;
            let mut m = MatValue::zero(num_cols, num_rows);
            for col in 0..num_cols {
                for row in 0..num_rows {
                    m.set(row, col, eval_ctx.in_[col][row]);
                }
            }
            Value::Matrix(m)
        }
        other => panic!("{} has no dynamic input value", other.name()),
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

/// `gles2::Functional::ShaderMatrixCase`
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
            user_attrib_transforms: build_user_attrib_transforms(op),
        }
    }
}

/// The `m_userAttribTransforms` half of `ShaderMatrixCase::init`.
fn build_user_attrib_transforms(op: MatrixOp) -> Vec<Mat4> {
    // \todo [2012-02-14 pyry] Compute better values for matrix tests.
    let mut transforms = vec![Mat4::zero(); 4];
    for (attrib_ndx, transform) in transforms.iter_mut().enumerate() {
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
                            TestMatrixType::Decremented => value - 0.1,
                            TestMatrixType::Default => unreachable!(),
                        },
                    );
                }
            }
        }
    }

    transforms
}

/// The result type the operation produces, off the two input types.
fn result_data_type(in0: &ShaderInput, in1: &ShaderInput, op: MatrixOp) -> DataType {
    if in0.data_type().is_matrix() && in1.data_type.is_some_and(DataType::is_matrix) {
        assert_eq!(in0.data_type(), in1.data_type());
        in0.data_type()
    } else if matches!(
        operation_type(op),
        OperationType::UnaryPrefixOperator | OperationType::UnaryPostfixOperator
    ) {
        in0.data_type()
    } else {
        let mat_ndx = if in0.data_type().is_matrix() { 0 } else { 1 };
        let (matrix_type, other_type) = if mat_ndx == 0 {
            (in0.data_type(), in1.data_type())
        } else {
            (in1.data_type(), in0.data_type())
        };

        if other_type == DataType::Float {
            matrix_type
        } else {
            assert!(other_type.is_vector());
            other_type
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
        DataType::FloatMat3 => format!("{var_name}[0]+{var_name}[1]+{var_name}[2]"),
        DataType::FloatMat4 => format!("{var_name}[0].xyz+{var_name}[1].yzw+{var_name}[2].zwx+{var_name}[3].wxy"),
        other => panic!("no vec3 reduction for {}", other.name()),
    }
}

/// The GLSL literal for a constant input of the given type.
fn const_input_literal(data_type: DataType, input_ndx: usize) -> String {
    match data_type {
        DataType::Float => float_to_string(S_CONST_IN_FLOAT[input_ndx]),
        DataType::FloatVec2 => write_vector_constructor(2, S_CONST_IN_VEC2[input_ndx].to_width()),
        DataType::FloatVec3 => write_vector_constructor(3, S_CONST_IN_VEC3[input_ndx].to_width()),
        DataType::FloatVec4 => write_vector_constructor(4, S_CONST_IN_VEC4[input_ndx]),
        DataType::FloatMat2 => write_matrix_constructor(&const_in_mat2(input_ndx)),
        DataType::FloatMat3 => write_matrix_constructor(&const_in_mat3(input_ndx)),
        DataType::FloatMat4 => write_matrix_constructor(&const_in_mat4(input_ndx)),
        other => panic!("{} has no constant literal", other.name()),
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

    vtx.push_str("attribute highp vec4 a_position;\n");
    if is_vertex_case {
        vtx.push_str("varying mediump vec4 v_color;\n");
        frag.push_str("varying mediump vec4 v_color;\n");
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
                    vtx.push_str(&format!("attribute {prec_name} {type_name} a_{type_name};\n"));
                    if !is_vertex_case {
                        vtx.push_str(&format!("varying {prec_name} {type_name} v_{type_name};\n"));
                        frag.push_str(&format!("varying {prec_name} {type_name} v_{type_name};\n"));
                        pass_vars.push(type_name.to_string());
                    }

                    *in_value = format!("{}{type_name}", if is_vertex_case { "a_" } else { "v_" });
                } else {
                    // a_coords, v_coords
                    vtx.push_str(&format!("attribute {prec_name} {type_name} a_coords;\n"));
                    if !is_vertex_case {
                        vtx.push_str(&format!("varying {prec_name} {type_name} v_coords;\n"));
                        frag.push_str(&format!("varying {prec_name} {type_name} v_coords;\n"));
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
        frag.push_str("    gl_FragColor = v_color;\n");
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
        OperationType::Assignment => {
            op_out!("    {prec_name} {type_name} res = {operation_value0};\n");
            op_out!("    res {op_name} {operation_value1};\n");
        }
    }

    // Reduction to vec3 (rgb). Check the used value too if it was modified.
    let dst = if is_vertex_case { "v_color" } else { "gl_FragColor" };
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

    /// `Evaluator<Op, ...>::evaluate`
    fn evaluate(&self, c: &mut ShaderEvalContext) {
        let in0 = get_input_value(&self.in0, c, 0);
        let value = match self.op {
            MatrixOp::Add | MatrixOp::AddInto => reduce_to_vec3(add(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::Sub | MatrixOp::SubtractFrom => reduce_to_vec3(sub(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::Mul | MatrixOp::MultiplyInto => reduce_to_vec3(mul(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::Div | MatrixOp::DivideInto => reduce_to_vec3(div(in0, get_input_value(&self.in1, c, 1))),
            MatrixOp::CompMul => reduce_to_vec3(matrix_comp_mult(in0, get_input_value(&self.in1, c, 1))),
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
                    Value::Matrix(m) => {
                        let data = m.column_major_data();
                        match (m.cols, m.rows) {
                            (2, 2) => gl.uniform_matrix_2fv(loc, 1, glw::FALSE, data.as_ptr()),
                            (3, 3) => gl.uniform_matrix_3fv(loc, 1, glw::FALSE, data.as_ptr()),
                            (4, 4) => gl.uniform_matrix_4fv(loc, 1, glw::FALSE, data.as_ptr()),
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
}

const OPS: [OpSpec; 15] = [
    OpSpec {
        name: "add",
        op: MatrixOp::Add,
        extended_input_type_cases: true,
    },
    OpSpec {
        name: "sub",
        op: MatrixOp::Sub,
        extended_input_type_cases: true,
    },
    OpSpec {
        name: "mul",
        op: MatrixOp::Mul,
        extended_input_type_cases: true,
    },
    OpSpec {
        name: "div",
        op: MatrixOp::Div,
        extended_input_type_cases: true,
    },
    OpSpec {
        name: "matrixcompmult",
        op: MatrixOp::CompMul,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "unary_addition",
        op: MatrixOp::UnaryPlus,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "negation",
        op: MatrixOp::Negation,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "pre_increment",
        op: MatrixOp::PreIncrement,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "pre_decrement",
        op: MatrixOp::PreDecrement,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "post_increment",
        op: MatrixOp::PostIncrement,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "post_decrement",
        op: MatrixOp::PostDecrement,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "add_assign",
        op: MatrixOp::AddInto,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "sub_assign",
        op: MatrixOp::SubtractFrom,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "mul_assign",
        op: MatrixOp::MultiplyInto,
        extended_input_type_cases: false,
    },
    OpSpec {
        name: "div_assign",
        op: MatrixOp::DivideInto,
        extended_input_type_cases: false,
    },
];

/// `InputTypeSpec`
const EXTENDED_INPUT_TYPES: [(&str, InputType); 3] = [
    ("const", InputType::Const),
    ("uniform", InputType::Uniform),
    ("dynamic", InputType::Dynamic),
];
const REDUCED_INPUT_TYPES: [(&str, InputType); 1] = [("dynamic", InputType::Dynamic)];

const MATRIX_TYPES: [DataType; 3] = [DataType::FloatMat2, DataType::FloatMat3, DataType::FloatMat4];
const PRECISIONS: [Precision; 3] = [Precision::LowP, Precision::MediumP, Precision::HighP];

fn add_case(
    group: &mut TestCaseGroup,
    name: String,
    in0: ShaderInput,
    in1: ShaderInput,
    op: MatrixOp,
    is_vertex_case: bool,
) {
    let case: Box<dyn TestCase> = Box::new(ShaderRenderCase::new(ShaderMatrixCaseSpec::new(
        &name,
        in0,
        in1,
        op,
        is_vertex_case,
    )));
    group.add_child(case);
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
            for mat_type in MATRIX_TYPES {
                let mat_type_name = mat_type.name();

                for precision in PRECISIONS {
                    let prec_name = precision.name();
                    let base_name = format!("{in_type_name}_{prec_name}_{mat_type_name}_");
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
                            &mut op_group,
                            format!("{base_name}float_vertex"),
                            mat_in,
                            scalar_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut op_group,
                            format!("{base_name}float_fragment"),
                            mat_in,
                            scalar_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_matrix_vector(op) {
                        // Matrix-vector.
                        let vec_type = get_data_type_float_vec(mat_type.matrix_num_columns());
                        let vec_in = ShaderInput::new(
                            if op == MatrixOp::Div {
                                InputType::Uniform
                            } else {
                                InputType::Dynamic
                            },
                            vec_type,
                            precision,
                        );

                        add_case(
                            &mut op_group,
                            format!("{base_name}{}_vertex", vec_type.name()),
                            mat_in,
                            vec_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut op_group,
                            format!("{base_name}{}_fragment", vec_type.name()),
                            mat_in,
                            vec_in,
                            op,
                            false,
                        );

                        // Vector-matrix.
                        let vec_mat_name = format!("{in_type_name}_{prec_name}_{}_{mat_type_name}", vec_type.name());
                        add_case(
                            &mut op_group,
                            format!("{vec_mat_name}_vertex"),
                            vec_in,
                            mat_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut op_group,
                            format!("{vec_mat_name}_fragment"),
                            vec_in,
                            mat_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_matrix_matrix(op) {
                        // Matrix-matrix.
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
                            &mut op_group,
                            format!("{base_name}{mat_type_name}_vertex"),
                            mat_in,
                            other_mat_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut op_group,
                            format!("{base_name}{mat_type_name}_fragment"),
                            mat_in,
                            other_mat_in,
                            op,
                            false,
                        );
                    }

                    if is_operation_unary(op) {
                        // op matrix
                        add_case(
                            &mut op_group,
                            format!("{base_name}vertex"),
                            mat_in,
                            ShaderInput::void(),
                            op,
                            true,
                        );
                        add_case(
                            &mut op_group,
                            format!("{base_name}fragment"),
                            mat_in,
                            ShaderInput::void(),
                            op,
                            false,
                        );
                    }

                    if is_operation_assignment(op) {
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
                            &mut op_group,
                            format!("{base_name}vertex"),
                            mat_in,
                            other_mat_in,
                            op,
                            true,
                        );
                        add_case(
                            &mut op_group,
                            format!("{base_name}fragment"),
                            mat_in,
                            other_mat_in,
                            op,
                            false,
                        );
                    }
                }
            }
        }

        group.add_child(op_group);
    }

    group
}

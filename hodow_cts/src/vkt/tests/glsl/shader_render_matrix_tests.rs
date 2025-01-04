// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/shaderrender/vktShaderRenderMatrixTests.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. `ShaderMatrixCase::setupShader` and the loops of `ShaderMatrixTests::init` run in `scripts/gen_shader_render_matrix.py`, which writes
// the shaders and `shader_render_matrix_cases.rs`. The typed `Evaluator<Op, In0, In1>` templates of upstream are one evaluator over small column-major matrices: the inputs are the constant
// values of the table or, for dynamic inputs, the coordinates and the user attributes (a matrix column is `in[column]`), the operation is applied by name, and the result is
// reduced to a colour with the same formulas as the shader (`genGLSLMatToVec3Reduction`).

use super::shader_render::{AttribTransform, ShaderEvalContext, ShaderRenderCase, case_key};
use super::shader_render_matrix_cases::MATRIX_CASES;
use crate::vkt::{TestCase, TestCaseGroup};

/// One input of a case: dynamic or constant (the uniform ones are constants too, as in upstream's evaluators), its shape and its constant values (column-major)
pub struct MatrixInput {
    pub dynamic: bool,
    pub cols: usize,
    pub rows: usize,
    /// `s` scalar, `v` vector, `m` matrix
    pub kind: char,
    pub values: &'static [f32],
}

/// One row of the table `gen_shader_render_matrix.py` writes.
pub struct MatrixCaseData {
    pub path: &'static [&'static str],
    pub name: &'static str,
    pub is_vertex: bool,
    pub op: &'static str,
    pub in0: Option<MatrixInput>,
    pub in1: Option<MatrixInput>,
    pub uniforms: &'static [(u32, super::shader_render::UniformValue)],
}

/// A column-major matrix; scalars and vectors are matrices of one column (a scalar of one row)
#[derive(Clone, Debug)]
struct Mat {
    cols: usize,
    rows: usize,
    d: Vec<f32>,
}

impl Mat {
    fn at(&self, row: usize, col: usize) -> f32 {
        self.d[col * self.rows + row]
    }

    fn map(&self, f: impl Fn(f32) -> f32) -> Mat {
        Mat {
            cols: self.cols,
            rows: self.rows,
            d: self.d.iter().map(|&v| f(v)).collect(),
        }
    }

    fn zip(&self, other: &Mat, f: impl Fn(f32, f32) -> f32) -> Mat {
        let scalar = other.d.len() == 1;
        Mat {
            cols: self.cols,
            rows: self.rows,
            d: self
                .d
                .iter()
                .enumerate()
                .map(|(ndx, &v)| f(v, if scalar { other.d[0] } else { other.d[ndx] }))
                .collect(),
        }
    }

    fn transpose(&self) -> Mat {
        let mut d = vec![0.0; self.d.len()];
        for col in 0..self.cols {
            for row in 0..self.rows {
                d[row * self.cols + col] = self.at(row, col);
            }
        }
        Mat {
            cols: self.rows,
            rows: self.cols,
            d,
        }
    }

    /// The linear-algebra product of a matrix (or a column vector) and a matrix (or a column vector)
    fn product(&self, other: &Mat) -> Mat {
        let mut d = vec![0.0; self.rows * other.cols];
        for col in 0..other.cols {
            for row in 0..self.rows {
                d[col * self.rows + row] = (0..self.cols).map(|k| self.at(row, k) * other.at(k, col)).sum();
            }
        }
        Mat {
            cols: other.cols,
            rows: self.rows,
            d,
        }
    }

    fn minor(&self, skip_row: usize, skip_col: usize) -> Mat {
        let n = self.rows - 1;
        let mut d = Vec::with_capacity(n * n);
        for col in (0..self.cols).filter(|&c| c != skip_col) {
            for row in (0..self.rows).filter(|&r| r != skip_row) {
                d.push(self.at(row, col));
            }
        }
        Mat { cols: n, rows: n, d }
    }

    fn determinant(&self) -> f32 {
        match self.rows {
            1 => self.d[0],
            2 => self.at(0, 0) * self.at(1, 1) - self.at(1, 0) * self.at(0, 1),
            _ => (0..self.cols)
                .map(|col| if col % 2 == 0 { 1.0 } else { -1.0 } * self.at(0, col) * self.minor(0, col).determinant())
                .sum(),
        }
    }

    fn inverse(&self) -> Mat {
        let n = self.rows;
        let det = self.determinant();
        let mut d = vec![0.0; n * n];
        for row in 0..n {
            for col in 0..n {
                let cofactor = if (row + col) % 2 == 0 { 1.0 } else { -1.0 } * self.minor(row, col).determinant();
                // the inverse is the transposed cofactor matrix over the determinant
                d[row * n + col] = cofactor / det;
            }
        }
        Mat { cols: n, rows: n, d }
    }
}

/// The input value: the table's constants, or the coordinates (scalars and vectors) and the user attributes (a matrix column is `in[column]`) of a dynamic input
fn input_value(input: &MatrixInput, c: &ShaderEvalContext) -> Mat {
    if !input.dynamic {
        return Mat {
            cols: input.cols,
            rows: input.rows,
            d: input.values.to_vec(),
        };
    }
    if input.kind == 'm' {
        let mut d = Vec::with_capacity(input.cols * input.rows);
        for col in 0..input.cols {
            d.extend_from_slice(&c.inputs[col][..input.rows]);
        }
        Mat {
            cols: input.cols,
            rows: input.rows,
            d,
        }
    } else {
        Mat {
            cols: 1,
            rows: input.rows,
            d: c.coords[..input.rows].to_vec(),
        }
    }
}

/// `reduceToVec3`: the formulas of `genGLSLMatToVec3Reduction`
fn reduce(m: &Mat, kind: char) -> [f32; 3] {
    let col = |c: usize| (0..m.rows).map(|r| m.at(r, c)).collect::<Vec<_>>();
    match (kind, m.cols, m.rows) {
        ('s', _, _) => [m.d[0]; 3],
        ('v', _, 2) => [m.d[0], m.d[1], m.d[0]],
        ('v', _, 3) => [m.d[0], m.d[1], m.d[2]],
        ('v', _, _) => [m.d[0], m.d[1], m.d[2] + m.d[3]],
        (_, 2, 2) => [m.at(0, 0), m.at(0, 1), m.at(1, 0) + m.at(1, 1)],
        (_, 2, 3) => std::array::from_fn(|i| col(0)[i] + col(1)[i]),
        (_, 2, _) => std::array::from_fn(|i| col(0)[i] + col(1)[i + 1]),
        (_, 3, 2) => std::array::from_fn(|i| m.at(0, i) + m.at(1, i)),
        (_, 3, 3) => std::array::from_fn(|i| col(0)[i] + col(1)[i] + col(2)[i]),
        (_, 3, _) => std::array::from_fn(|i| col(0)[i] + col(1)[i + 1] + col(2)[(i + 2) % 4]),
        (_, 4, 2) => [
            m.at(0, 0) + m.at(1, 0) + m.at(0, 3),
            m.at(0, 1) + m.at(1, 1) + m.at(1, 3),
            m.at(0, 2) + m.at(1, 2),
        ],
        (_, 4, 3) => std::array::from_fn(|i| col(0)[i] + col(1)[i] + col(2)[i] + col(3)[i]),
        _ => std::array::from_fn(|i| col(0)[i] + col(1)[(i + 1) % 4] + col(2)[(i + 2) % 4] + col(3)[(i + 3) % 4]),
    }
}

/// The shape of the result, as `ShaderMatrixCase::setupShader` computes it
fn result_kind(data: &MatrixCaseData) -> char {
    match data.op {
        "OP_DETERMINANT" => 's',
        "OP_MUL" => {
            let (a, b) = (data.in0.as_ref().expect("in0"), data.in1.as_ref().expect("in1"));
            match (a.kind, b.kind) {
                ('m', 'm') => 'm',
                ('m', 's') | ('s', 'm') => 'm',
                _ => 'v',
            }
        }
        _ => data.in0.as_ref().map_or('m', |a| {
            if data.in1.as_ref().is_some_and(|b| a.kind != 'm' && b.kind == 'm') {
                'v'
            } else {
                a.kind
            }
        }),
    }
}

fn evaluate(data: &MatrixCaseData, c: &mut ShaderEvalContext) {
    let in0 = input_value(data.in0.as_ref().expect("in0"), c);
    let in1 = data.in1.as_ref().map(|input| input_value(input, c));
    let in1 = || in1.clone().expect("in1");
    let kind0 = data.in0.as_ref().map_or('m', |input| input.kind);
    let mut kind = kind0;
    let rgb = match data.op {
        "OP_ADD" | "OP_ADD_INTO" => reduce(&in0.zip(&in1(), |a, b| a + b), kind),
        "OP_SUB" | "OP_SUBTRACT_FROM" => reduce(&in0.zip(&in1(), |a, b| a - b), kind),
        "OP_DIV" | "OP_DIVIDE_INTO" => reduce(&in0.zip(&in1(), |a, b| a / b), kind),
        "OP_COMP_MUL" => reduce(&in0.zip(&in1(), |a, b| a * b), kind),
        "OP_MUL" | "OP_MULTIPLY_INTO" => {
            let other = in1();
            let other_kind = data.in1.as_ref().expect("in1").kind;
            kind = result_kind(data);
            let product = if kind0 == 's' || other_kind == 's' {
                in0.zip(&other, |a, b| a * b)
            } else if kind0 == 'v' {
                // a row vector times a matrix
                let mut d = vec![0.0; other.cols];
                for (col, value) in d.iter_mut().enumerate() {
                    *value = (0..in0.rows).map(|row| in0.d[row] * other.at(row, col)).sum();
                }
                Mat {
                    cols: 1,
                    rows: other.cols,
                    d,
                }
            } else {
                in0.product(&other)
            };
            reduce(&product, kind)
        }
        "OP_OUTER_PRODUCT" => {
            let other = in1();
            let mut d = vec![0.0; in0.rows * other.rows];
            for col in 0..other.rows {
                for row in 0..in0.rows {
                    d[col * in0.rows + row] = in0.d[row] * other.d[col];
                }
            }
            kind = 'm';
            reduce(
                &Mat {
                    cols: other.rows,
                    rows: in0.rows,
                    d,
                },
                kind,
            )
        }
        "OP_TRANSPOSE" => reduce(&in0.transpose(), kind),
        "OP_INVERSE" => reduce(&in0.inverse(), kind),
        "OP_DETERMINANT" => {
            kind = 's';
            reduce(
                &Mat {
                    cols: 1,
                    rows: 1,
                    d: vec![in0.determinant()],
                },
                kind,
            )
        }
        "OP_UNARY_PLUS" => reduce(&in0, kind),
        "OP_NEGATION" => reduce(&in0.map(|v| -v), kind),
        "OP_PRE_INCREMENT" => {
            let r = reduce(&in0.map(|v| v + 1.0), kind);
            std::array::from_fn(|i| r[i] + r[i])
        }
        "OP_PRE_DECREMENT" => {
            let r = reduce(&in0.map(|v| v - 1.0), kind);
            std::array::from_fn(|i| r[i] + r[i])
        }
        "OP_POST_INCREMENT" => {
            let (a, b) = (reduce(&in0, kind), reduce(&in0.map(|v| v + 1.0), kind));
            std::array::from_fn(|i| a[i] + b[i])
        }
        _ => {
            let (a, b) = (reduce(&in0, kind), reduce(&in0.map(|v| v - 1.0), kind));
            std::array::from_fn(|i| a[i] + b[i])
        }
    };
    c.color[..3].copy_from_slice(&rgb);
}

/// `ShaderMatrixInstance`: the four attribute transforms, adjusted by the kind of test matrix of the operation
fn attribute_transforms(op: &str) -> Vec<AttribTransform> {
    let inverse = op == "OP_INVERSE";
    (0..4usize)
        .map(|a| {
            let mut t = [[0.0f32; 4]; 4];
            t[0][3] = if inverse { -0.5 } else { 0.2 };
            t[1][3] = if inverse { -1.3 } else { 0.1 };
            t[2][3] = 0.4 + 0.15 * a as f32;
            t[3][3] = if inverse { -3.0 } else { 0.7 };
            t[a % 4][0] = 1.0;
            t[(1 + a) % 4][1] = 1.0;
            t[(2 + a) % 4][2] = 1.0;
            t[(3 + a) % 4][3] = 1.0;
            let adjust: Option<fn(f32) -> f32> = match op {
                "OP_UNARY_PLUS" | "OP_DIVIDE_INTO" => Some(|v| v - 0.3),
                "OP_NEGATION" => Some(|v| -v + 0.3),
                "OP_PRE_INCREMENT" | "OP_POST_INCREMENT" | "OP_MULTIPLY_INTO" => Some(|v| -v),
                "OP_PRE_DECREMENT" => Some(|v| v + 0.3),
                "OP_SUBTRACT_FROM" => Some(|v| v - 0.1),
                _ => None,
            };
            if let Some(adjust) = adjust {
                for row in t.iter_mut() {
                    for value in row.iter_mut() {
                        *value = adjust(*value);
                    }
                }
            }
            t
        })
        .collect()
}

/// `ShaderMatrixTests::init`
pub fn create_matrix_tests() -> TestCaseGroup {
    // Groups by path, in the order the table gives them.
    fn insert(groups: &mut Vec<(&'static str, Node)>, path: &[&'static str], case: Box<dyn TestCase>) {
        match path.split_first() {
            None => groups.push(("", Node::Case(case))),
            Some((head, rest)) => {
                let ndx = match groups
                    .iter()
                    .position(|(name, node)| name == head && matches!(node, Node::Group(_)))
                {
                    Some(ndx) => ndx,
                    None => {
                        groups.push((head, Node::Group(Vec::new())));
                        groups.len() - 1
                    }
                };
                if let Node::Group(children) = &mut groups[ndx].1 {
                    insert(children, rest, case);
                }
            }
        }
    }

    enum Node {
        Group(Vec<(&'static str, Node)>),
        Case(Box<dyn TestCase>),
    }

    fn build(name: &str, children: Vec<(&'static str, Node)>) -> TestCaseGroup {
        let mut group = TestCaseGroup::new(name);
        for (child_name, node) in children {
            match node {
                Node::Group(grandchildren) => group.add_child(build(child_name, grandchildren)),
                Node::Case(case) => group.add_child(case),
            };
        }
        group
    }

    let mut root: Vec<(&'static str, Node)> = Vec::new();
    for data in MATRIX_CASES.iter() {
        let key = case_key("matrix", &format!("{}_{}", data.path.join("_"), data.name));
        let dynamic_matrix_location = [&data.in0, &data.in1]
            .iter()
            .position(|input| input.as_ref().is_some_and(|input| input.dynamic && input.kind == 'm'));
        let mut case = ShaderRenderCase::with_closure(
            data.name.to_string(),
            key,
            data.is_vertex,
            Box::new(move |c: &mut ShaderEvalContext| evaluate(data, c)),
            data.uniforms.to_vec(),
        )
        .with_user_attributes(attribute_transforms(data.op))
        .with_first_user_location(4 + dynamic_matrix_location.unwrap_or(0) as u32);
        if data.is_vertex && data.op == "OP_INVERSE" {
            case = case.with_grid_size(64);
        }
        insert(&mut root, data.path, Box::new(case) as Box<dyn TestCase>);
    }
    build("matrix", root)
}

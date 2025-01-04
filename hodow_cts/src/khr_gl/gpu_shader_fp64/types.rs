// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/gl/gl4cGPUShaderFP64Tests.cpp (`Utils::_variable_type` and the `Utils` helpers that read it, for the double-precision types)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015-2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. A double-precision `Utils::_variable_type` is its GLSL name and its number of columns and rows.

/// A double-precision GLSL type: scalar, vector or matrix
#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub(super) struct DoubleType {
    pub name: &'static str,
    pub columns: u32,
    pub rows: u32,
}

impl DoubleType {
    /// `getNumberOfComponentsForVariableType`
    pub(super) fn components(self) -> u32 {
        self.columns * self.rows
    }

    /// `isMatrixVariableType`
    pub(super) fn is_matrix(self) -> bool {
        self.columns > 1
    }

    /// `isScalarVariableType`
    pub(super) fn is_scalar(self) -> bool {
        self.columns == 1 && self.rows == 1
    }

    /// `getTransposedMatrixVariableType`
    pub(super) fn transposed(self) -> Self {
        *MATRIX_TYPES
            .iter()
            .find(|candidate| candidate.columns == self.rows && candidate.rows == self.columns)
            .expect("only matrix types are transposed")
    }

    /// `getFPVariableTypeStringForVariableType`: the single-precision type of the same shape
    pub(super) fn fp_name(self) -> String {
        if self.name == "double" {
            "float".to_string()
        } else {
            self.name[1..].to_string()
        }
    }
}

pub(super) const fn double_type(name: &'static str, columns: u32, rows: u32) -> DoubleType {
    DoubleType { name, columns, rows }
}

/// The nine double-precision matrix types, in the order the tests list them
pub(super) const MATRIX_TYPES: [DoubleType; 9] = [
    double_type("dmat2", 2, 2),
    double_type("dmat2x3", 2, 3),
    double_type("dmat2x4", 2, 4),
    double_type("dmat3", 3, 3),
    double_type("dmat3x2", 3, 2),
    double_type("dmat3x4", 3, 4),
    double_type("dmat4", 4, 4),
    double_type("dmat4x2", 4, 2),
    double_type("dmat4x3", 4, 3),
];

/// The scalar and the vector double-precision types
pub(super) const SCALAR_TYPES: [DoubleType; 4] = [
    double_type("double", 1, 1),
    double_type("dvec2", 1, 2),
    double_type("dvec3", 1, 3),
    double_type("dvec4", 1, 4),
];

/// The iteration array of `GPUShaderFP64Test8` and `GPUShaderFP64Test9`: the matrices, then the scalar and the vectors
pub(super) const ALL_TYPES: [DoubleType; 13] = [
    double_type("dmat2", 2, 2),
    double_type("dmat2x3", 2, 3),
    double_type("dmat2x4", 2, 4),
    double_type("dmat3", 3, 3),
    double_type("dmat3x2", 3, 2),
    double_type("dmat3x4", 3, 4),
    double_type("dmat4", 4, 4),
    double_type("dmat4x2", 4, 2),
    double_type("dmat4x3", 4, 3),
    double_type("double", 1, 1),
    double_type("dvec2", 1, 2),
    double_type("dvec3", 1, 3),
    double_type("dvec4", 1, 4),
];

/// `getPostMatrixMultiplicationVariableType`: the type of `a * b`
pub(super) fn post_matrix_multiplication_type(a: DoubleType, b: DoubleType) -> DoubleType {
    *MATRIX_TYPES
        .iter()
        .find(|candidate| candidate.columns == b.columns && candidate.rows == a.rows)
        .expect("the product of two matrix types is a matrix type")
}

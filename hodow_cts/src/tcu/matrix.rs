// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuMatrix.hpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

use crate::tcu::vector::Vector;

/// `tcu::Matrix<T, Rows, Cols>` for `f32`, stored column-major exactly as upstream does,
/// so `m[col][row]` and upstream's `m(row, col)` address the same element.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Matrix<const ROWS: usize, const COLS: usize> {
    /// `m_data`, one `Vector<T, Rows>` per column.
    pub columns: [[f32; ROWS]; COLS],
}

impl<const ROWS: usize, const COLS: usize> Matrix<ROWS, COLS> {
    /// `tcu::Matrix::Matrix()` - the identity diagonal, which is what the default
    /// constructor produces.
    pub fn identity() -> Self {
        Self::diagonal(1.0)
    }

    /// `tcu::Matrix::Matrix(T)` - `value` down the diagonal, zero elsewhere.
    pub fn diagonal(value: f32) -> Self {
        let mut columns = [[0.0f32; ROWS]; COLS];
        for (col, column) in columns.iter_mut().enumerate() {
            if col < ROWS {
                column[col] = value;
            }
        }
        Self { columns }
    }

    pub fn zero() -> Self {
        Self {
            columns: [[0.0f32; ROWS]; COLS],
        }
    }

    /// `tcu::Matrix::operator()(row, col)`
    pub fn at(&self, row: usize, col: usize) -> f32 {
        self.columns[col][row]
    }

    pub fn set(&mut self, row: usize, col: usize, value: f32) {
        self.columns[col][row] = value;
    }

    /// `tcu::Matrix::getColumn`
    pub fn column(&self, col: usize) -> Vector<f32, ROWS> {
        Vector::from_array(self.columns[col])
    }

    /// `tcu::Matrix::getRow`
    pub fn row(&self, row: usize) -> Vector<f32, COLS> {
        Vector::from_array(std::array::from_fn(|col| self.columns[col][row]))
    }

    /// `tcu::transpose`
    pub fn transpose(&self) -> Matrix<COLS, ROWS> {
        Matrix {
            columns: std::array::from_fn(|row| std::array::from_fn(|col| self.columns[col][row])),
        }
    }
}

/// `tcu::operator*(Matrix, Vector)`
impl<const ROWS: usize, const COLS: usize> std::ops::Mul<Vector<f32, COLS>> for Matrix<ROWS, COLS> {
    type Output = Vector<f32, ROWS>;

    fn mul(self, rhs: Vector<f32, COLS>) -> Vector<f32, ROWS> {
        Vector::from_array(std::array::from_fn(|row| {
            (0..COLS).map(|col| self.columns[col][row] * rhs.m_data[col]).sum()
        }))
    }
}

pub type Mat2 = Matrix<2, 2>;
pub type Mat2x3 = Matrix<3, 2>;
pub type Mat2x4 = Matrix<4, 2>;
pub type Mat3x2 = Matrix<2, 3>;
pub type Mat3 = Matrix<3, 3>;
pub type Mat3x4 = Matrix<4, 3>;
pub type Mat4x2 = Matrix<2, 4>;
pub type Mat4x3 = Matrix<3, 4>;
pub type Mat4 = Matrix<4, 4>;

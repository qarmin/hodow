// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuVector.hpp
//   framework/common/tcuVectorUtil.hpp (multiplyComponents)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

/// `tcu::Vector<T, Size>`.
///
/// Only the accessors the ported tests actually use are provided; more get added
/// as tests need them, per the on-demand rule for the tcu layer.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Vector<T, const N: usize> {
    pub m_data: [T; N],
}

impl<T: Copy, const N: usize> Vector<T, N> {
    pub const fn from_array(m_data: [T; N]) -> Self {
        Self { m_data }
    }

    pub fn x(&self) -> T {
        self.m_data[0]
    }
}

impl<T: Copy, const N: usize> Vector<T, N> {
    pub fn y(&self) -> T
    where
        [T; N]: Sized,
    {
        assert!(N >= 2);
        self.m_data[1]
    }

    pub fn z(&self) -> T {
        assert!(N >= 3);
        self.m_data[2]
    }

    pub fn w(&self) -> T {
        assert!(N >= 4);
        self.m_data[3]
    }
}

pub type IVec2 = Vector<i32, 2>;
pub type IVec3 = Vector<i32, 3>;
pub type IVec4 = Vector<i32, 4>;
pub type UVec3 = Vector<u32, 3>;
pub type UVec4 = Vector<u32, 4>;
pub type Vec2 = Vector<f32, 2>;
pub type Vec3 = Vector<f32, 3>;
pub type Vec4 = Vector<f32, 4>;

impl IVec2 {
    pub const fn new(x: i32, y: i32) -> Self {
        Self::from_array([x, y])
    }
}

impl IVec3 {
    pub const fn new(x: i32, y: i32, z: i32) -> Self {
        Self::from_array([x, y, z])
    }
}

impl IVec4 {
    pub const fn new(x: i32, y: i32, z: i32, w: i32) -> Self {
        Self::from_array([x, y, z, w])
    }
}

impl UVec3 {
    pub const fn new(x: u32, y: u32, z: u32) -> Self {
        Self::from_array([x, y, z])
    }
}

impl UVec4 {
    pub const fn new(x: u32, y: u32, z: u32, w: u32) -> Self {
        Self::from_array([x, y, z, w])
    }
}

impl Vec2 {
    pub const fn new(x: f32, y: f32) -> Self {
        Self::from_array([x, y])
    }
}

impl Vec3 {
    pub const fn new(x: f32, y: f32, z: f32) -> Self {
        Self::from_array([x, y, z])
    }
}

impl Vec4 {
    pub const fn new(x: f32, y: f32, z: f32, w: f32) -> Self {
        Self::from_array([x, y, z, w])
    }
}

/// `tcu::multiplyComponents`
pub fn multiply_components(v: IVec3) -> i32 {
    v.x() * v.y() * v.z()
}

// Arithmetic. Upstream's `tcu::Vector` has the full component-wise operator set;
// the shader-render evaluators are written against it directly, so it is here in full
// for `f32` rather than added one operator at a time.

impl<const N: usize> Vector<f32, N> {
    /// `tcu::Vector::Vector(T)` - every component the same.
    pub const fn splat(value: f32) -> Self {
        Self { m_data: [value; N] }
    }

    /// `tcu::Vector::swizzle`
    pub fn swizzle<const M: usize>(&self, indices: [usize; M]) -> Vector<f32, M> {
        Vector {
            m_data: indices.map(|i| self.m_data[i]),
        }
    }

    /// `tcu::Vector::toWidth` - drops or zero-fills components.
    #[allow(clippy::wrong_self_convention)]
    pub fn to_width<const M: usize>(&self) -> Vector<f32, M> {
        let mut out = [0.0f32; M];
        for (dst, &src) in out.iter_mut().zip(self.m_data.iter()) {
            *dst = src;
        }
        Vector { m_data: out }
    }
}

impl<const N: usize> std::ops::Index<usize> for Vector<f32, N> {
    type Output = f32;

    fn index(&self, index: usize) -> &f32 {
        &self.m_data[index]
    }
}

impl<const N: usize> std::ops::IndexMut<usize> for Vector<f32, N> {
    fn index_mut(&mut self, index: usize) -> &mut f32 {
        &mut self.m_data[index]
    }
}

macro_rules! impl_vec_op {
    ($trait:ident, $method:ident, $op:tt) => {
        impl<const N: usize> std::ops::$trait for Vector<f32, N> {
            type Output = Self;

            fn $method(self, rhs: Self) -> Self {
                Self {
                    m_data: std::array::from_fn(|i| self.m_data[i] $op rhs.m_data[i]),
                }
            }
        }

        impl<const N: usize> std::ops::$trait<f32> for Vector<f32, N> {
            type Output = Self;

            fn $method(self, rhs: f32) -> Self {
                Self {
                    m_data: std::array::from_fn(|i| self.m_data[i] $op rhs),
                }
            }
        }
    };
}

impl_vec_op!(Add, add, +);
impl_vec_op!(Sub, sub, -);
impl_vec_op!(Mul, mul, *);
impl_vec_op!(Div, div, /);

impl<const N: usize> std::ops::Neg for Vector<f32, N> {
    type Output = Self;

    fn neg(self) -> Self {
        Self {
            m_data: self.m_data.map(|v| -v),
        }
    }
}

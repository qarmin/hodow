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
pub type UVec3 = Vector<u32, 3>;
pub type UVec4 = Vector<u32, 4>;
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

impl Vec4 {
    pub const fn new(x: f32, y: f32, z: f32, w: f32) -> Self {
        Self::from_array([x, y, z, w])
    }
}

/// `tcu::multiplyComponents`
pub fn multiply_components(v: IVec3) -> i32 {
    v.x() * v.y() * v.z()
}

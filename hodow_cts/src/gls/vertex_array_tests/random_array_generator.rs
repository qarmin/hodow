// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.cpp  (deqp::gls::RandomArrayGenerator)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// `generateQuads`/`generatePerQuad` - quad-grid vertex data, a different generator from
// `draw_test::random_array_generator` despite the shared upstream name. Only
// `Primitive::Triangles` is generated (every other primitive hits `DE_ASSERT(false)`
// upstream too). Upstream's `createQuads<T>` leans on the wrapped types' `%`, `fromFloat`,
// `to<float>` and comparison operators, so the arithmetic is gathered into the local
// `QuadScalar` trait, implemented over `draw_test::gl_value`'s wrapped types (which already
// carry the wrapping `+`/`-`, `random` and `minValue<T>` tables) rather than duplicating
// them in this module's own, arithmetic-free `GLValue`. `generateArray` is not ported:
// upstream never calls it from a live path (its one call site is commented out).

use super::array::{InputType, Primitive};
use super::gl_value::GLValue;
use crate::gls::draw_test::gl_value::{
    Byte, Double, Fixed, Float, Half, Int, MinSeparation, Short, Ubyte, Uint, Ushort,
};
use crate::tcu::Random;

trait QuadScalar: Copy + PartialOrd {
    const SIZE: usize;
    fn create_i(v: i32) -> Self;
    fn from_f32(v: f32) -> Self;
    fn to_f32(self) -> f32;
    fn add(self, o: Self) -> Self;
    fn sub(self, o: Self) -> Self;
    fn rem(self, o: Self) -> Self;
    fn draw(rnd: &mut Random, min: Self, max: Self) -> Self;
    fn min_value() -> Self;
    fn write_ne(self, dst: &mut [u8]);
}

macro_rules! quad_scalar_int {
    ($t:ty, $prim:ty) => {
        impl QuadScalar for $t {
            const SIZE: usize = std::mem::size_of::<$prim>();
            fn create_i(v: i32) -> Self {
                Self(v as $prim)
            }
            fn from_f32(v: f32) -> Self {
                Self(v as $prim)
            }
            fn to_f32(self) -> f32 {
                self.0 as f32
            }
            fn add(self, o: Self) -> Self {
                Self(self.0.wrapping_add(o.0))
            }
            fn sub(self, o: Self) -> Self {
                Self(self.0.wrapping_sub(o.0))
            }
            fn rem(self, o: Self) -> Self {
                Self(self.0.wrapping_rem(o.0))
            }
            fn draw(rnd: &mut Random, min: Self, max: Self) -> Self {
                <$t>::random(rnd, min, max)
            }
            fn min_value() -> Self {
                <$t as MinSeparation>::min_separation()
            }
            fn write_ne(self, dst: &mut [u8]) {
                dst[..Self::SIZE].copy_from_slice(&self.0.to_ne_bytes());
            }
        }
    };
}

quad_scalar_int!(Byte, i8);
quad_scalar_int!(Ubyte, u8);
quad_scalar_int!(Short, i16);
quad_scalar_int!(Ushort, u16);
quad_scalar_int!(Fixed, i32);
quad_scalar_int!(Int, i32);
quad_scalar_int!(Uint, u32);

macro_rules! quad_scalar_float {
    ($t:ty, $prim:ty) => {
        impl QuadScalar for $t {
            const SIZE: usize = std::mem::size_of::<$prim>();
            fn create_i(v: i32) -> Self {
                Self(v as $prim)
            }
            fn from_f32(v: f32) -> Self {
                Self(v as $prim)
            }
            fn to_f32(self) -> f32 {
                self.0 as f32
            }
            fn add(self, o: Self) -> Self {
                Self(self.0 + o.0)
            }
            fn sub(self, o: Self) -> Self {
                Self(self.0 - o.0)
            }
            fn rem(self, o: Self) -> Self {
                Self(self.0 % o.0)
            }
            fn draw(rnd: &mut Random, min: Self, max: Self) -> Self {
                <$t>::random(rnd, min, max)
            }
            fn min_value() -> Self {
                <$t as MinSeparation>::min_separation()
            }
            fn write_ne(self, dst: &mut [u8]) {
                dst[..Self::SIZE].copy_from_slice(&self.0.to_ne_bytes());
            }
        }
    };
}

quad_scalar_float!(Float, f32);
quad_scalar_float!(Double, f64);

impl QuadScalar for Half {
    const SIZE: usize = 2;
    fn create_i(v: i32) -> Self {
        Half::create(v as f32)
    }
    fn from_f32(v: f32) -> Self {
        Half::create(v)
    }
    fn to_f32(self) -> f32 {
        Half::to_f32(self)
    }
    fn add(self, o: Self) -> Self {
        Half::create(self.to_f32() + o.to_f32())
    }
    fn sub(self, o: Self) -> Self {
        Half::create(self.to_f32() - o.to_f32())
    }
    fn rem(self, o: Self) -> Self {
        Half::create(self.to_f32() % o.to_f32())
    }
    fn draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Half::random(rnd, min, max)
    }
    fn min_value() -> Self {
        <Half as MinSeparation>::min_separation()
    }
    fn write_ne(self, dst: &mut [u8]) {
        dst[..2].copy_from_slice(&self.bits().to_ne_bytes());
    }
}

/// `roundTo`
fn round_to<T: QuadScalar>(step: T, value: T) -> T {
    value.sub(value.rem(step))
}

/// `RandomArrayGenerator::createQuads<T>`
#[allow(clippy::too_many_arguments)]
fn create_quads<T: QuadScalar>(
    seed: u32,
    count: i32,
    component_count: i32,
    offset: i32,
    mut stride: i32,
    primitive: Primitive,
    min: T,
    max: T,
    grid_size: f32,
) -> Vec<u8> {
    assert!(
        primitive == Primitive::Triangles,
        "createQuads: only PRIMITIVE_TRIANGLES is generated"
    );

    let component_stride = T::SIZE as i32;
    if stride == 0 {
        stride = component_count * component_stride;
    }
    debug_assert!(stride >= component_count * component_stride);
    let quad_stride = stride * 6;

    let mut data = vec![0u8; (offset + quad_stride * count) as usize];
    let result_offset = offset as usize;
    let mut rnd = Random::new(seed);

    let min_quad_size = T::from_f32((max.to_f32() - min.to_f32()).abs() * grid_size);
    let min_diff = if T::min_value() > min_quad_size {
        T::min_value()
    } else {
        min_quad_size
    };
    let max_rounded = round_to(min_diff, max);

    let put = |data: &mut Vec<u8>, pos: i32, value: T| {
        value.write_ne(&mut data[result_offset + pos as usize..]);
    };

    for quad_ndx in 0..count {
        let base = quad_ndx * quad_stride;

        let x1 = round_to(min_diff, T::draw(&mut rnd, min, max_rounded.sub(min_diff)));
        let mut x2 = round_to(min_diff, T::draw(&mut rnd, x1.add(min_diff), max_rounded));

        let y1 = round_to(min_diff, T::draw(&mut rnd, min, max_rounded.sub(min_diff)));
        let mut y2 = round_to(min_diff, T::draw(&mut rnd, y1.add(min_diff), max_rounded));

        // Make sure the rounding doesn't drop the result below the original range of the random function.
        if x2 < x1.add(min_diff) {
            x2 = x1.add(min_diff);
        }
        if y2 < y1.add(min_diff) {
            y2 = y1.add(min_diff);
        }

        let z = if component_count > 2 {
            round_to(min_diff, T::draw(&mut rnd, min, max))
        } else {
            T::create_i(0)
        };
        let w = if component_count > 3 {
            round_to(min_diff, T::draw(&mut rnd, min, max))
        } else {
            T::create_i(1)
        };

        put(&mut data, base, x1);
        put(&mut data, base + component_stride, y1);

        put(&mut data, base + stride, x2);
        put(&mut data, base + stride + component_stride, y1);

        put(&mut data, base + stride * 2, x1);
        put(&mut data, base + stride * 2 + component_stride, y2);

        put(&mut data, base + stride * 3, x1);
        put(&mut data, base + stride * 3 + component_stride, y2);

        put(&mut data, base + stride * 4, x2);
        put(&mut data, base + stride * 4 + component_stride, y1);

        put(&mut data, base + stride * 5, x2);
        put(&mut data, base + stride * 5 + component_stride, y2);

        if component_count > 2 {
            for i in 0..6 {
                put(&mut data, base + stride * i + component_stride * 2, z);
            }
        }

        if component_count > 3 {
            for i in 0..6 {
                put(&mut data, base + stride * i + component_stride * 3, w);
            }
        }
    }

    data
}

/// `RandomArrayGenerator::createQuadsPacked`
fn create_quads_packed(
    seed: u32,
    count: i32,
    component_count: i32,
    offset: i32,
    mut stride: i32,
    primitive: Primitive,
) -> Vec<u8> {
    assert!(
        primitive == Primitive::Triangles,
        "createQuadsPacked: only PRIMITIVE_TRIANGLES is generated"
    );
    debug_assert_eq!(component_count, 4);

    if stride == 0 {
        stride = std::mem::size_of::<u32>() as i32;
    }
    let quad_stride = stride * 6;

    // The last element must be fully in the array; `inputTypeSize(INT_2_10_10_10)` is 1.
    let total = offset + quad_stride * (count - 1) + stride * 5 + component_count * InputType::Int2_10_10_10.size();
    let mut data = vec![0u8; total as usize];
    let result_offset = offset as usize;

    const MAX: u32 = 1024;
    const MIN: u32 = 10;
    const MAX2: u32 = 4;

    let mut rnd = Random::new(seed);

    for quad_ndx in 0..count {
        let x1 = MIN + rnd.get_uint32() % (MAX - MIN);
        let x2 = MIN + rnd.get_uint32() % (MAX - x1);

        let y1 = MIN + rnd.get_uint32() % (MAX - MIN);
        let y2 = MIN + rnd.get_uint32() % (MAX - y1);

        let z = MIN + rnd.get_uint32() % (MAX - MIN);
        let w = rnd.get_uint32() % MAX2;

        let val1 = (w << 30) | (z << 20) | (y1 << 10) | x1;
        let val2 = (w << 30) | (z << 20) | (y1 << 10) | x2;
        let val3 = (w << 30) | (z << 20) | (y2 << 10) | x1;

        let val4 = (w << 30) | (z << 20) | (y2 << 10) | x1;
        let val5 = (w << 30) | (z << 20) | (y1 << 10) | x2;
        let val6 = (w << 30) | (z << 20) | (y2 << 10) | x2;

        for (i, val) in [val1, val2, val3, val4, val5, val6].into_iter().enumerate() {
            let pos = result_offset + (quad_ndx * quad_stride + stride * i as i32) as usize;
            data[pos..pos + 4].copy_from_slice(&val.to_ne_bytes());
        }
    }

    data
}

/// `RandomArrayGenerator::createPerQuads<T>`
fn create_per_quads<T: QuadScalar>(
    seed: u32,
    count: i32,
    component_count: i32,
    mut stride: i32,
    primitive: Primitive,
    min: T,
    max: T,
) -> Vec<u8> {
    assert!(
        primitive == Primitive::Triangles,
        "createPerQuads: only PRIMITIVE_TRIANGLES is generated"
    );

    let mut rnd = Random::new(seed);
    let component_stride = T::SIZE as i32;
    if stride == 0 {
        stride = component_stride * component_count;
    }
    let quad_stride = stride * 6;

    let mut data = vec![0u8; (count * quad_stride) as usize];

    for quad_ndx in 0..count {
        for component_ndx in 0..component_count {
            let val = T::draw(&mut rnd, min, max);
            for i in 0..6 {
                let pos = (quad_ndx * quad_stride + stride * i + component_stride * component_ndx) as usize;
                val.write_ne(&mut data[pos..]);
            }
        }
    }

    data
}

macro_rules! dispatch_scalar {
    ($type_:expr, $min:expr, $max:expr, |$a:ident, $b:ident, $t:ident| $body:expr) => {
        match ($type_, $min, $max) {
            (InputType::Float, GLValue::Float(lo), GLValue::Float(hi)) => {
                type $t = Float;
                let ($a, $b) = (Float::create(lo.value()), Float::create(hi.value()));
                $body
            }
            (InputType::Fixed, GLValue::Fixed(lo), GLValue::Fixed(hi)) => {
                type $t = Fixed;
                let ($a, $b) = (Fixed::create(lo.value()), Fixed::create(hi.value()));
                $body
            }
            (InputType::Double, GLValue::Double(lo), GLValue::Double(hi)) => {
                type $t = Double;
                let ($a, $b) = (Double::create(lo.value()), Double::create(hi.value()));
                $body
            }
            (InputType::Byte, GLValue::Byte(lo), GLValue::Byte(hi)) => {
                type $t = Byte;
                let ($a, $b) = (Byte::create(lo.value()), Byte::create(hi.value()));
                $body
            }
            (InputType::Short, GLValue::Short(lo), GLValue::Short(hi)) => {
                type $t = Short;
                let ($a, $b) = (Short::create(lo.value()), Short::create(hi.value()));
                $body
            }
            (InputType::UnsignedByte, GLValue::Ubyte(lo), GLValue::Ubyte(hi)) => {
                type $t = Ubyte;
                let ($a, $b) = (Ubyte::create(lo.value()), Ubyte::create(hi.value()));
                $body
            }
            (InputType::UnsignedShort, GLValue::Ushort(lo), GLValue::Ushort(hi)) => {
                type $t = Ushort;
                let ($a, $b) = (Ushort::create(lo.value()), Ushort::create(hi.value()));
                $body
            }
            (InputType::UnsignedInt, GLValue::Uint(lo), GLValue::Uint(hi)) => {
                type $t = Uint;
                let ($a, $b) = (Uint::create(lo.value()), Uint::create(hi.value()));
                $body
            }
            (InputType::Int, GLValue::Int(lo), GLValue::Int(hi)) => {
                type $t = Int;
                let ($a, $b) = (Int::create(lo.value()), Int::create(hi.value()));
                $body
            }
            (InputType::Half, GLValue::Half(lo), GLValue::Half(hi)) => {
                type $t = Half;
                let ($a, $b) = (Half::create(lo.to_f32()), Half::create(hi.to_f32()));
                $body
            }
            (other, _, _) => panic!("RandomArrayGenerator: unsupported input type {other:?} for this min/max"),
        }
    };
}

/// `RandomArrayGenerator::generateQuads`
#[allow(clippy::too_many_arguments)]
pub fn generate_quads(
    seed: u32,
    count: i32,
    component_count: i32,
    offset: i32,
    stride: i32,
    primitive: Primitive,
    type_: InputType,
    min: GLValue,
    max: GLValue,
    grid_size: f32,
) -> Vec<u8> {
    if matches!(type_, InputType::Int2_10_10_10 | InputType::UnsignedInt2_10_10_10) {
        return create_quads_packed(seed, count, component_count, offset, stride, primitive);
    }

    dispatch_scalar!(type_, min, max, |lo, hi, T| create_quads::<T>(
        seed,
        count,
        component_count,
        offset,
        stride,
        primitive,
        lo,
        hi,
        grid_size
    ))
}

/// `RandomArrayGenerator::generatePerQuad`
#[allow(clippy::too_many_arguments)]
pub fn generate_per_quad(
    seed: u32,
    count: i32,
    component_count: i32,
    stride: i32,
    primitive: Primitive,
    type_: InputType,
    min: GLValue,
    max: GLValue,
) -> Vec<u8> {
    dispatch_scalar!(type_, min, max, |lo, hi, T| create_per_quads::<T>(
        seed,
        count,
        component_count,
        stride,
        primitive,
        lo,
        hi
    ))
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsVertexArrayTests.hpp / .cpp  (deqp::gls::GLValue, and the
//   file's own anonymous-namespace `getMaxValue`-table equivalents)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. See `super`'s own module doc comment
// for the note on this class's near-verbatim duplication inside `glsDrawTest.hpp`, and
// why this port keeps the two independent rather than sharing one `GLValue`.
//
// Same substitution `draw_test::gl_value` already made: upstream's tagged union (a
// `Array::InputType` discriminant plus a C `union` of ten `WrappedType<T>`
// instantiations) becomes a Rust enum of ten newtype wrappers. Unlike
// `draw_test::gl_value`, **no arithmetic or `getRandom<T>` is ported yet** - nothing in
// this module uses it until `RandomArrayGenerator` is ported (see `super`'s "Not yet
// ported" list), and `draw_test::gl_value`'s own precedent is exactly this: it grew
// `getRandom`/arithmetic only once `random_array_generator.rs` needed them, not ahead
// of a caller. Add the same machinery here (and the same `RandomRange`/`RandomDraw`
// traits, copied rather than shared - see `super`'s top doc comment on why duplication
// over a cross-module type is the deliberate choice here) when that piece is ported.

use super::array::InputType;
use crate::tcu::float::Float16;

/// `GLValue::WrappedFloatType<float>` (`GLValue::Float`)
#[derive(Debug, Clone, Copy, PartialEq, PartialOrd)]
pub struct Float(pub f32);

/// `GLValue::WrappedFloatType<double>` (`GLValue::Double`)
#[derive(Debug, Clone, Copy, PartialEq, PartialOrd)]
pub struct Double(pub f64);

/// `GLValue::WrappedType<int8_t>` (`GLValue::Byte`)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Byte(pub i8);

/// `GLValue::WrappedType<uint8_t>` (`GLValue::Ubyte`)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Ubyte(pub u8);

/// `GLValue::WrappedType<int16_t>` (`GLValue::Short`)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Short(pub i16);

/// `GLValue::WrappedType<uint16_t>` (`GLValue::Ushort`)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Ushort(pub u16);

/// `GLValue::WrappedType<int32_t>` (`GLValue::Int`). Unlike `draw_test::gl_value::Int`,
/// upstream's `glsVertexArrayTests.hpp` has no hand-written `Int` class that widens
/// through `int64_t` - it is a plain `WrappedType<int32_t>` here, same as every other
/// integer wrapper. Ported with wrapping arithmetic regardless (nothing here
/// constructs an overflowing add/sub/mul yet, since none is ported), matching
/// `draw_test::gl_value`'s own choice to widen uniformly rather than reproduce each
/// type's own C++ integer-promotion behaviour one at a time.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Int(pub i32);

/// `GLValue::WrappedType<uint32_t>` (`GLValue::Uint`)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Uint(pub u32);

/// `GLValue::Fixed` - a hand-written class upstream (plain `int32_t` arithmetic),
/// representing a GL fixed-point (16.16) value.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Fixed(pub i32);

/// `GLValue::Half` - stores the raw `deFloat16` bit pattern, exactly like upstream's
/// own member.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Half(u16);

impl Float {
    pub fn create(value: f32) -> Self {
        Self(value)
    }
    pub fn value(self) -> f32 {
        self.0
    }
}

impl Double {
    pub fn create(value: f64) -> Self {
        Self(value)
    }
    pub fn value(self) -> f64 {
        self.0
    }
}

macro_rules! wrapped_int {
    ($t:ty, $prim:ty) => {
        impl $t {
            pub fn create(value: $prim) -> Self {
                Self(value)
            }
            pub fn value(self) -> $prim {
                self.0
            }
        }
    };
}

wrapped_int!(Byte, i8);
wrapped_int!(Ubyte, u8);
wrapped_int!(Short, i16);
wrapped_int!(Ushort, u16);
wrapped_int!(Int, i32);
wrapped_int!(Uint, u32);
wrapped_int!(Fixed, i32);

impl Half {
    /// `GLValue::Half::create`/`floatToHalf`
    pub fn create(value: f32) -> Self {
        let f16 = Float16::new(value);
        debug_assert!(!f16.is_nan() && !f16.is_inf());
        Self(f16.bits())
    }

    /// `GLValue::Half::to<float>()`/`halfToFloat`
    pub fn to_f32(self) -> f32 {
        Float16::from_bits(self.0).as_float()
    }
}

/// `GLValue`
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum GLValue {
    Float(Float),
    Double(Double),
    Byte(Byte),
    Ubyte(Ubyte),
    Short(Short),
    Ushort(Ushort),
    Int(Int),
    Uint(Uint),
    Fixed(Fixed),
    Half(Half),
}

impl GLValue {
    /// `GLValue::toFloat`
    #[allow(clippy::wrong_self_convention)]
    pub fn to_float(&self) -> f32 {
        match self {
            GLValue::Float(v) => v.value(),
            GLValue::Byte(v) => v.value() as f32,
            GLValue::Ubyte(v) => v.value() as f32,
            GLValue::Short(v) => v.value() as f32,
            GLValue::Ushort(v) => v.value() as f32,
            GLValue::Fixed(v) => {
                // `(float)(double(2 * fi.getValue() + 1) / (maxValue - 1))`, maxValue == 65536.
                const MAX_VALUE: f64 = 65536.0;
                (f64::from(2 * v.value() + 1) / (MAX_VALUE - 1.0)) as f32
            }
            GLValue::Uint(v) => v.value() as f32,
            GLValue::Int(v) => v.value() as f32,
            GLValue::Half(v) => v.to_f32(),
            GLValue::Double(v) => v.value() as f32,
        }
    }

    /// `GLValue::getMaxValue` - only defined for the ten types the union actually
    /// carries. Upstream's own `rangesHi[(int)Array::INPUTTYPE_LAST]` array leaves the
    /// two packed `2_10_10_10` slots default-constructed (`type == INPUTTYPE_LAST`,
    /// i.e. "no value") rather than filled in - asking for one of those here is the
    /// same port-only programming error `draw_test::gl_value::max_value` already
    /// documents, not something any ported caller does.
    pub fn max_value(ty: InputType) -> GLValue {
        match ty {
            InputType::Float => GLValue::Float(Float::create(127.0)),
            InputType::Double => GLValue::Double(Double::create(127.0)),
            InputType::Byte => GLValue::Byte(Byte::create(127)),
            InputType::UnsignedByte => GLValue::Ubyte(Ubyte::create(255)),
            InputType::UnsignedShort => GLValue::Ushort(Ushort::create(65530)),
            InputType::Short => GLValue::Short(Short::create(32760)),
            InputType::Fixed => GLValue::Fixed(Fixed::create(32760)),
            InputType::Int => GLValue::Int(Int::create(2147483647)),
            InputType::UnsignedInt => GLValue::Uint(Uint::create(4294967295)),
            InputType::Half => GLValue::Half(Half::create(256.0)),
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 => {
                unreachable!("GLValue has no representation for {ty:?}")
            }
        }
    }

    /// `GLValue::getMinValue`
    pub fn min_value(ty: InputType) -> GLValue {
        match ty {
            InputType::Float => GLValue::Float(Float::create(-127.0)),
            InputType::Double => GLValue::Double(Double::create(-127.0)),
            InputType::Byte => GLValue::Byte(Byte::create(-127)),
            InputType::UnsignedByte => GLValue::Ubyte(Ubyte::create(0)),
            InputType::UnsignedShort => GLValue::Ushort(Ushort::create(0)),
            InputType::Short => GLValue::Short(Short::create(-32760)),
            InputType::Fixed => GLValue::Fixed(Fixed::create(-32760)),
            InputType::Int => GLValue::Int(Int::create(-2147483647)),
            InputType::UnsignedInt => GLValue::Uint(Uint::create(0)),
            InputType::Half => GLValue::Half(Half::create(-256.0)),
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 => {
                unreachable!("GLValue has no representation for {ty:?}")
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn to_float_float_byte_ubyte_short_ushort_int_uint() {
        assert_eq!(GLValue::Float(Float::create(1.5)).to_float(), 1.5);
        assert_eq!(GLValue::Byte(Byte::create(-5)).to_float(), -5.0);
        assert_eq!(GLValue::Ubyte(Ubyte::create(200)).to_float(), 200.0);
        assert_eq!(GLValue::Short(Short::create(-1000)).to_float(), -1000.0);
        assert_eq!(GLValue::Ushort(Ushort::create(60000)).to_float(), 60000.0);
        assert_eq!(GLValue::Int(Int::create(-100000)).to_float(), -100000.0);
        assert_eq!(GLValue::Uint(Uint::create(100000)).to_float(), 100000.0);
        assert_eq!(GLValue::Double(Double::create(3.25)).to_float(), 3.25);
    }

    #[test]
    fn to_float_fixed_is_signed_normalized() {
        // `(2*fi+1) / 65535`. fi=0 -> 1/65535.
        let v = GLValue::Fixed(Fixed::create(0));
        let expected = (1.0f64 / 65535.0) as f32;
        assert_eq!(v.to_float(), expected);

        // fi=32767 (about half of i16::MAX*2) -> (2*32767+1)/65535 = 65535/65535 = 1.0
        let v2 = GLValue::Fixed(Fixed::create(32767));
        assert_eq!(v2.to_float(), 1.0);

        // fi=-32768 -> (2*-32768+1)/65535 = -65535/65535 = -1.0
        let v3 = GLValue::Fixed(Fixed::create(-32768));
        assert_eq!(v3.to_float(), -1.0);
    }

    #[test]
    fn to_float_half() {
        let v = GLValue::Half(Half::create(2.5));
        assert_eq!(v.to_float(), 2.5);
    }

    #[test]
    fn max_value_table() {
        assert_eq!(
            GLValue::max_value(InputType::Float),
            GLValue::Float(Float::create(127.0))
        );
        assert_eq!(
            GLValue::max_value(InputType::Double),
            GLValue::Double(Double::create(127.0))
        );
        assert_eq!(GLValue::max_value(InputType::Byte), GLValue::Byte(Byte::create(127)));
        assert_eq!(
            GLValue::max_value(InputType::UnsignedByte),
            GLValue::Ubyte(Ubyte::create(255))
        );
        assert_eq!(
            GLValue::max_value(InputType::UnsignedShort),
            GLValue::Ushort(Ushort::create(65530))
        );
        assert_eq!(
            GLValue::max_value(InputType::Short),
            GLValue::Short(Short::create(32760))
        );
        assert_eq!(
            GLValue::max_value(InputType::Fixed),
            GLValue::Fixed(Fixed::create(32760))
        );
        assert_eq!(
            GLValue::max_value(InputType::Int),
            GLValue::Int(Int::create(2147483647))
        );
        assert_eq!(
            GLValue::max_value(InputType::UnsignedInt),
            GLValue::Uint(Uint::create(4294967295))
        );
        assert_eq!(GLValue::max_value(InputType::Half), GLValue::Half(Half::create(256.0)));
    }

    #[test]
    fn min_value_table() {
        assert_eq!(
            GLValue::min_value(InputType::Float),
            GLValue::Float(Float::create(-127.0))
        );
        assert_eq!(
            GLValue::min_value(InputType::Double),
            GLValue::Double(Double::create(-127.0))
        );
        assert_eq!(GLValue::min_value(InputType::Byte), GLValue::Byte(Byte::create(-127)));
        assert_eq!(
            GLValue::min_value(InputType::UnsignedByte),
            GLValue::Ubyte(Ubyte::create(0))
        );
        assert_eq!(
            GLValue::min_value(InputType::UnsignedShort),
            GLValue::Ushort(Ushort::create(0))
        );
        assert_eq!(
            GLValue::min_value(InputType::Short),
            GLValue::Short(Short::create(-32760))
        );
        assert_eq!(
            GLValue::min_value(InputType::Fixed),
            GLValue::Fixed(Fixed::create(-32760))
        );
        assert_eq!(
            GLValue::min_value(InputType::Int),
            GLValue::Int(Int::create(-2147483647))
        );
        assert_eq!(
            GLValue::min_value(InputType::UnsignedInt),
            GLValue::Uint(Uint::create(0))
        );
        assert_eq!(GLValue::min_value(InputType::Half), GLValue::Half(Half::create(-256.0)));
    }

    #[test]
    #[should_panic(expected = "GLValue has no representation")]
    fn max_value_panics_on_packed_int_2_10_10_10() {
        let _ = GLValue::max_value(InputType::Int2_10_10_10);
    }

    #[test]
    #[should_panic(expected = "GLValue has no representation")]
    fn min_value_panics_on_packed_unsigned_int_2_10_10_10() {
        let _ = GLValue::min_value(InputType::UnsignedInt2_10_10_10);
    }
}

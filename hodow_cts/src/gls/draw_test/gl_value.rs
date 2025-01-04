// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   modules/glshared/glsDrawTest.cpp  (deqp::gls::GLValue, GLValueTypeTraits,
//   extractGLValue, getRandom<T>, minValue<T>, abs<T> - all anonymous-namespace)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Upstream's `GLValue` is a tagged union: a `DrawTestSpec::InputType` tag plus a C
// `union` of ten `WrappedType<T>` instantiations (one per concrete GL input type other
// than the two packed `2_10_10_10` formats, which this class never represents directly -
// see `AttributeArray`/`RandomArrayGenerator`, not yet ported, for how those are built).
// A Rust `enum` is the direct, hazard-removing equivalent of "tag plus union" (the same
// substitution this crate already made for e.g. `rr::FaceType`), so `GLValue` here is an
// enum of ten newtype wrappers rather than a struct-with-a-union. Each wrapper keeps its
// own arithmetic (`WrappedType<T>::operator+` etc.), since upstream's own per-type
// semantics genuinely differ - `Int` widens through `int64_t` to dodge UB on overflow (a
// behaviour upstream singles out in its own comment), while every other wrapped type
// does not. This port widens **all** of them the same way `Int` already was, rather than
// reproducing each type's own C++ integer-promotion quirk one at a time (narrower
// widths inherit whatever a `deUint32`/`int` mixed expression promotes to, which is easy
// to get subtly wrong porting by hand and has no behavioural consequence here: nothing
// in this port's scope yet reads a `GLValue` arithmetic result bit-for-bit against a
// specific promotion rule).
//
// `GLValueTypeTraits<T>`/`extractGLValue<T>` (the C++ "map a concrete type back to its
// enum tag, and back out of the union" dispatch pair) have no Rust counterpart - that is
// exactly what matching on this enum's variants already does, so nothing is ported for
// them. A future caller generic over "whichever `GLValue` variant" should match on the
// enum directly rather than re-inventing them.

use std::cmp::Ordering;

use super::spec::InputType;
use crate::tcu::Random;
use crate::tcu::float::Float16;

/// `GLValue::WrappedType<float>` (`GLValue::Float`)
#[derive(Debug, Clone, Copy, PartialEq, PartialOrd)]
pub struct Float(pub f32);

/// `GLValue::WrappedType<double>` (`GLValue::Double`)
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

/// `GLValue::Int` - a hand-written (not `WrappedType<int32_t>`) class upstream, because
/// every operator widens through `int64_t` first "to avoid signed integer overflow
/// which is undefined". Ported as wrapping 32-bit arithmetic: the 64-bit-then-truncate
/// shape upstream uses is bit-for-bit equivalent to a 32-bit wraparound for the add/
/// sub/mul cases (and division only differs from it in the one UB-in-C++ corner case of
/// `i32::MIN / -1`, which nothing in this port's scope constructs).
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Int(pub i32);

/// `GLValue::WrappedType<uint32_t>` (`GLValue::Uint`)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Uint(pub u32);

/// `GLValue::Fixed` - a hand-written class upstream (plain `int32_t` arithmetic, no
/// widening), representing a GL fixed-point (16.16) value.
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub struct Fixed(pub i32);

/// `GLValue::Half` - stores the raw `deFloat16` bit pattern, exactly like upstream's own
/// member (`deFloat16 m_value`). All arithmetic goes through `f32` (`halfToFloat`/
/// `floatToHalf`), matching every operator in the C++ class.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Half(u16);

macro_rules! wrapping_int_ops {
    ($t:ty, $prim:ty) => {
        impl $t {
            pub fn create(value: $prim) -> Self {
                Self(value)
            }
            pub fn value(self) -> $prim {
                self.0
            }
        }
        impl std::ops::Add for $t {
            type Output = Self;
            fn add(self, other: Self) -> Self {
                Self(self.0.wrapping_add(other.0))
            }
        }
        impl std::ops::Sub for $t {
            type Output = Self;
            fn sub(self, other: Self) -> Self {
                Self(self.0.wrapping_sub(other.0))
            }
        }
        impl std::ops::Mul for $t {
            type Output = Self;
            fn mul(self, other: Self) -> Self {
                Self(self.0.wrapping_mul(other.0))
            }
        }
        impl std::ops::Div for $t {
            type Output = Self;
            fn div(self, other: Self) -> Self {
                Self(self.0.wrapping_div(other.0))
            }
        }
    };
}

wrapping_int_ops!(Byte, i8);
wrapping_int_ops!(Ubyte, u8);
wrapping_int_ops!(Short, i16);
wrapping_int_ops!(Ushort, u16);
wrapping_int_ops!(Int, i32);
wrapping_int_ops!(Uint, u32);
wrapping_int_ops!(Fixed, i32);

impl Float {
    pub fn create(value: f32) -> Self {
        Self(value)
    }
    pub fn value(self) -> f32 {
        self.0
    }
}
impl std::ops::Add for Float {
    type Output = Self;
    fn add(self, other: Self) -> Self {
        Self(self.0 + other.0)
    }
}
impl std::ops::Sub for Float {
    type Output = Self;
    fn sub(self, other: Self) -> Self {
        Self(self.0 - other.0)
    }
}
impl std::ops::Mul for Float {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        Self(self.0 * other.0)
    }
}
impl std::ops::Div for Float {
    type Output = Self;
    fn div(self, other: Self) -> Self {
        Self(self.0 / other.0)
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
impl std::ops::Add for Double {
    type Output = Self;
    fn add(self, other: Self) -> Self {
        Self(self.0 + other.0)
    }
}
impl std::ops::Sub for Double {
    type Output = Self;
    fn sub(self, other: Self) -> Self {
        Self(self.0 - other.0)
    }
}
impl std::ops::Mul for Double {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        Self(self.0 * other.0)
    }
}
impl std::ops::Div for Double {
    type Output = Self;
    fn div(self, other: Self) -> Self {
        Self(self.0 / other.0)
    }
}

impl Half {
    /// `GLValue::Half::create` (`floatToHalf`) - "no denorm support" upstream's own
    /// comment says, though the conversion it calls (`tcu::Float<..., 5, 10, 15, ...>`,
    /// the same one `tcu::Float16::new` is specialised from) does produce f16 denormals
    /// for a small enough input; what the comment really describes is the assert right
    /// after it, which only rules out the input rounding to infinity or NaN.
    pub fn create(value: f32) -> Self {
        let f16 = Float16::new(value);
        debug_assert!(!f16.is_nan() && !f16.is_inf());
        Self(f16.bits())
    }

    pub fn bits(self) -> u16 {
        self.0
    }

    /// `GLValue::Half::to<T>()` / `halfToFloat`
    pub fn to_f32(self) -> f32 {
        Float16::from_bits(self.0).as_float()
    }
}
impl std::ops::Add for Half {
    type Output = Self;
    fn add(self, other: Self) -> Self {
        Self::create(self.to_f32() + other.to_f32())
    }
}
impl std::ops::Sub for Half {
    type Output = Self;
    fn sub(self, other: Self) -> Self {
        Self::create(self.to_f32() - other.to_f32())
    }
}
impl std::ops::Mul for Half {
    type Output = Self;
    fn mul(self, other: Self) -> Self {
        Self::create(self.to_f32() * other.to_f32())
    }
}
impl std::ops::Div for Half {
    type Output = Self;
    fn div(self, other: Self) -> Self {
        Self::create(self.to_f32() / other.to_f32())
    }
}
impl PartialOrd for Half {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.to_f32().partial_cmp(&other.to_f32())
    }
}

/// `GLValue::getRandom<T>` - common shape across every integer specialisation: if the
/// range is empty (`max < min`) return `min` unchanged, a single value if `min == max`,
/// otherwise `min + (rnd % (max - min))`. **`max` is exclusive** here, matching
/// upstream's own formula exactly (it is `max - min`, never `max - min + 1`) - a drawn
/// value can equal `min` but never `max`, unless `min == max`.
macro_rules! random_int {
    ($t:ty, $prim:ty, $wide:ty) => {
        impl $t {
            pub fn random(rnd: &mut Random, min: Self, max: Self) -> Self {
                if max < min {
                    return min;
                }
                if min == max {
                    return min;
                }
                let min_w = min.0 as $wide;
                let max_w = max.0 as $wide;
                let range = max_w - min_w;
                let r = (rnd.get_uint32() as $wide) % range;
                Self((min_w + r) as $prim)
            }
        }
    };
}

random_int!(Short, i16, i64);
random_int!(Ushort, u16, i64);
random_int!(Byte, i8, i64);
random_int!(Ubyte, u8, i64);
random_int!(Fixed, i32, i64);
random_int!(Int, i32, i64);
random_int!(Uint, u32, i64);

impl Float {
    /// `getRandom<GLValue::Float>`
    pub fn random(rnd: &mut Random, min: Self, max: Self) -> Self {
        if max < min {
            return min;
        }
        Self::create(min.0 + rnd.get_float() * (max.0 - min.0))
    }
}

impl Double {
    /// `getRandom<GLValue::Double>` - the interpolation itself still runs at `f32`
    /// precision upstream (`min + getFloat() * (max.to<float>() - min.to<float>())`,
    /// where `min`'s implicit conversion to `double` is the only thing keeping the sum
    /// in `double`); ported as written, not upgraded to full `f64` precision.
    pub fn random(rnd: &mut Random, min: Self, max: Self) -> Self {
        if max < min {
            return min;
        }
        let min_f = min.0 as f32;
        let max_f = max.0 as f32;
        Self::create(min.0 + (rnd.get_float() * (max_f - min_f)) as f64)
    }
}

impl Half {
    /// `getRandom<GLValue::Half>`
    pub fn random(rnd: &mut Random, min: Self, max: Self) -> Self {
        if max < min {
            return min;
        }
        let f_min = min.to_f32();
        let f_max = max.to_f32();
        Self::create(f_min + rnd.get_float() * (f_max - f_min))
    }
}

/// `GLValue::getMinValue`/`getMaxValue`'s per-type table, factored out as a trait so
/// `RandomArrayGenerator` (`random_array_generator.rs`) can draw a value of a concrete
/// wrapped type directly, without unwrapping a `GLValue` enum variant it already knows
/// the shape of - `GLValue::min_value`/`max_value` below are themselves built from this,
/// so the literal range table exists exactly once.
pub trait RandomRange: Sized {
    fn range_min() -> Self;
    fn range_max() -> Self;
}
impl RandomRange for Float {
    fn range_min() -> Self {
        Self::create(-127.0)
    }
    fn range_max() -> Self {
        Self::create(127.0)
    }
}
impl RandomRange for Double {
    fn range_min() -> Self {
        Self::create(-127.0)
    }
    fn range_max() -> Self {
        Self::create(127.0)
    }
}
impl RandomRange for Byte {
    fn range_min() -> Self {
        Self::create(-127)
    }
    fn range_max() -> Self {
        Self::create(127)
    }
}
impl RandomRange for Ubyte {
    fn range_min() -> Self {
        Self::create(0)
    }
    fn range_max() -> Self {
        Self::create(255)
    }
}
impl RandomRange for Short {
    fn range_min() -> Self {
        Self::create(-32760)
    }
    fn range_max() -> Self {
        Self::create(32760)
    }
}
impl RandomRange for Ushort {
    fn range_min() -> Self {
        Self::create(0)
    }
    fn range_max() -> Self {
        // Genuinely `65530`, not `u16::MAX` - see `spec.rs`'s own note on the same value.
        Self::create(65530)
    }
}
impl RandomRange for Fixed {
    fn range_min() -> Self {
        Self::create(-32760)
    }
    fn range_max() -> Self {
        Self::create(32760)
    }
}
impl RandomRange for Int {
    fn range_min() -> Self {
        Self::create(-2147483647)
    }
    fn range_max() -> Self {
        Self::create(2147483647)
    }
}
impl RandomRange for Uint {
    fn range_min() -> Self {
        Self::create(0)
    }
    fn range_max() -> Self {
        Self::create(4294967295)
    }
}
impl RandomRange for Half {
    fn range_min() -> Self {
        Self::create(-256.0)
    }
    fn range_max() -> Self {
        Self::create(256.0)
    }
}

/// `getRandom<T>`, as a trait - the ten inherent `random` methods above already do the
/// work; this just lets `RandomArrayGenerator` (`random_array_generator.rs`) call it
/// generically over whichever wrapped type a given `InputType` maps to.
pub trait RandomDraw: Sized {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self;
}
impl RandomDraw for Float {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Double {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Half {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Short {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Ushort {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Byte {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Ubyte {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Fixed {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Int {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}
impl RandomDraw for Uint {
    fn random_draw(rnd: &mut Random, min: Self, max: Self) -> Self {
        Self::random(rnd, min, max)
    }
}

/// Minimum difference required between coordinates - `minValue<T>()`'s per-type table.
pub trait MinSeparation {
    fn min_separation() -> Self;
}
impl MinSeparation for Float {
    fn min_separation() -> Self {
        Self::create(4.0)
    }
}
impl MinSeparation for Double {
    fn min_separation() -> Self {
        Self::create(4.0)
    }
}
impl MinSeparation for Short {
    fn min_separation() -> Self {
        Self::create(4 * 256)
    }
}
impl MinSeparation for Ushort {
    fn min_separation() -> Self {
        Self::create(4 * 256)
    }
}
impl MinSeparation for Byte {
    fn min_separation() -> Self {
        Self::create(4)
    }
}
impl MinSeparation for Ubyte {
    fn min_separation() -> Self {
        Self::create(4 * 2)
    }
}
impl MinSeparation for Fixed {
    fn min_separation() -> Self {
        Self::create(4)
    }
}
impl MinSeparation for Int {
    fn min_separation() -> Self {
        Self::create(4 * 16777216)
    }
}
impl MinSeparation for Uint {
    fn min_separation() -> Self {
        Self::create(4 * 16777216)
    }
}
impl MinSeparation for Half {
    fn min_separation() -> Self {
        Self::create(4.0)
    }
}

/// `abs<T>` - every specialisation upstream provides.
pub trait WrappedAbs {
    fn wrapped_abs(self) -> Self;
}
impl WrappedAbs for Fixed {
    fn wrapped_abs(self) -> Self {
        // Masks off the sign bit of a 16-bit fixed-point value rather than negating -
        // upstream's own shape, ported verbatim.
        Self(0x7FFF & self.0)
    }
}
impl WrappedAbs for Ubyte {
    fn wrapped_abs(self) -> Self {
        self
    }
}
impl WrappedAbs for Byte {
    fn wrapped_abs(self) -> Self {
        Self((0x7Fu32 & (self.0 as u32)) as i8)
    }
}
impl WrappedAbs for Ushort {
    fn wrapped_abs(self) -> Self {
        self
    }
}
impl WrappedAbs for Short {
    fn wrapped_abs(self) -> Self {
        Self((0x7FFFu32 & (self.0 as u32)) as i16)
    }
}
impl WrappedAbs for Float {
    fn wrapped_abs(self) -> Self {
        Self(self.0.abs())
    }
}
impl WrappedAbs for Double {
    /// `abs<GLValue::Double>` - goes through `f32` first upstream
    /// (`std::fabs(val.to<float>())`), so this loses precision exactly like upstream does.
    fn wrapped_abs(self) -> Self {
        Self((self.0 as f32).abs() as f64)
    }
}
impl WrappedAbs for Uint {
    fn wrapped_abs(self) -> Self {
        self
    }
}
impl WrappedAbs for Int {
    fn wrapped_abs(self) -> Self {
        Self((0x7FFFFFFFu32 & (self.0 as u32)) as i32)
    }
}
impl WrappedAbs for Half {
    fn wrapped_abs(self) -> Self {
        Self::create(self.to_f32().abs())
    }
}

/// `GLValue` - see this module's top doc comment for why this is an enum rather than a
/// tagged union, and for why the two packed `2_10_10_10` `InputType`s have no variant.
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum GLValue {
    Float(Float),
    Fixed(Fixed),
    Byte(Byte),
    Ubyte(Ubyte),
    Short(Short),
    Ushort(Ushort),
    Int(Int),
    Uint(Uint),
    Half(Half),
    Double(Double),
    /// `GLValue::GLValue(void)` - no value set yet.
    None,
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
            GLValue::None => {
                debug_assert!(false, "GLValue::toFloat on an unset value");
                0.0
            }
        }
    }

    /// `GLValue::getMaxValue` - only defined for the ten types the union actually
    /// carries (see this module's top doc comment); asking for one of the two packed
    /// `2_10_10_10` types or `InputType::Last` is a port-only programming error, not
    /// something any ported caller does.
    pub fn max_value(ty: InputType) -> GLValue {
        match ty {
            InputType::Float => GLValue::Float(Float::range_max()),
            InputType::Double => GLValue::Double(Double::range_max()),
            InputType::Byte => GLValue::Byte(Byte::range_max()),
            InputType::UnsignedByte => GLValue::Ubyte(Ubyte::range_max()),
            InputType::UnsignedShort => GLValue::Ushort(Ushort::range_max()),
            InputType::Short => GLValue::Short(Short::range_max()),
            InputType::Fixed => GLValue::Fixed(Fixed::range_max()),
            InputType::Int => GLValue::Int(Int::range_max()),
            InputType::UnsignedInt => GLValue::Uint(Uint::range_max()),
            InputType::Half => GLValue::Half(Half::range_max()),
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 | InputType::Last => {
                unreachable!("GLValue has no representation for {ty:?}")
            }
        }
    }

    /// `GLValue::getMinValue`
    pub fn min_value(ty: InputType) -> GLValue {
        match ty {
            InputType::Float => GLValue::Float(Float::range_min()),
            InputType::Double => GLValue::Double(Double::range_min()),
            InputType::Byte => GLValue::Byte(Byte::range_min()),
            InputType::UnsignedByte => GLValue::Ubyte(Ubyte::range_min()),
            InputType::UnsignedShort => GLValue::Ushort(Ushort::range_min()),
            InputType::Short => GLValue::Short(Short::range_min()),
            InputType::Fixed => GLValue::Fixed(Fixed::range_min()),
            InputType::Int => GLValue::Int(Int::range_min()),
            InputType::UnsignedInt => GLValue::Uint(Uint::range_min()),
            InputType::Half => GLValue::Half(Half::range_min()),
            InputType::UnsignedInt2_10_10_10 | InputType::Int2_10_10_10 | InputType::Last => {
                unreachable!("GLValue has no representation for {ty:?}")
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn int_arithmetic_wraps_instead_of_panicking() {
        let a = Int::create(i32::MAX);
        let b = Int::create(1);
        assert_eq!((a + b).value(), i32::MIN);
    }

    #[test]
    fn fixed_sub_plain_wrapping() {
        let a = Fixed::create(i32::MIN);
        let b = Fixed::create(1);
        assert_eq!((a - b).value(), i32::MAX);
    }

    #[test]
    fn half_round_trips_exactly_representable_values() {
        let h = Half::create(2.5);
        assert_eq!(h.to_f32(), 2.5);
    }

    #[test]
    fn half_arithmetic_goes_through_f32() {
        let a = Half::create(1.5);
        let b = Half::create(0.25);
        assert_eq!((a + b).to_f32(), 1.75);
    }

    #[test]
    fn short_random_range_is_max_exclusive() {
        // min == max - 1 so the modulo divisor is 1: every draw must be exactly `min`.
        let mut rnd = Random::new(1);
        let min = Short::create(10);
        let max = Short::create(11);
        for _ in 0..8 {
            assert_eq!(Short::random(&mut rnd, min, max).value(), 10);
        }
    }

    #[test]
    fn short_random_returns_min_when_range_inverted() {
        let mut rnd = Random::new(2);
        let min = Short::create(10);
        let max = Short::create(5);
        assert_eq!(Short::random(&mut rnd, min, max).value(), 10);
    }

    #[test]
    fn short_random_returns_min_when_equal() {
        let mut rnd = Random::new(3);
        let v = Short::create(42);
        assert_eq!(Short::random(&mut rnd, v, v).value(), 42);
    }

    #[test]
    fn short_random_stays_within_half_open_range() {
        let mut rnd = Random::new(4);
        let min = Short::create(-5);
        let max = Short::create(5);
        for _ in 0..200 {
            let v = Short::random(&mut rnd, min, max).value();
            assert!((-5..5).contains(&v), "{v} out of [-5, 5)");
        }
    }

    #[test]
    fn uint_random_stays_within_half_open_range() {
        let mut rnd = Random::new(5);
        let min = Uint::create(100);
        let max = Uint::create(110);
        for _ in 0..200 {
            let v = Uint::random(&mut rnd, min, max).value();
            assert!((100..110).contains(&v));
        }
    }

    #[test]
    fn float_random_min_equal_max_degenerates() {
        let mut rnd = Random::new(6);
        let v = Float::create(3.0);
        assert_eq!(Float::random(&mut rnd, v, v).value(), 3.0);
    }

    #[test]
    fn float_random_stays_in_range() {
        let mut rnd = Random::new(7);
        let min = Float::create(-1.0);
        let max = Float::create(1.0);
        for _ in 0..200 {
            let v = Float::random(&mut rnd, min, max).value();
            assert!((-1.0..=1.0).contains(&v));
        }
    }

    #[test]
    fn abs_fixed_masks_sign_bit_rather_than_negating() {
        // -32768's bit pattern is 0xFFFF8000; masking with 0x7FFF clears everything
        // (the sign bit at 0x8000 and every bit above it), leaving 0 - not 32768, which
        // a true `abs()` would produce.
        let v = Fixed::create(-32768i32);
        assert_eq!(v.wrapped_abs().value(), 0);

        let v = Fixed::create(-1);
        assert_eq!(v.wrapped_abs().value(), 0x7FFF);
    }

    #[test]
    fn abs_int_masks_sign_bit() {
        // i32::MIN's bit pattern is 0x80000000 - masking with 0x7FFFFFFF clears only
        // the sign bit, leaving 0 (not `i32::MAX`, since this masks rather than negates).
        let v = Int::create(i32::MIN);
        assert_eq!(v.wrapped_abs().value(), 0);

        let v = Int::create(-1);
        assert_eq!(v.wrapped_abs().value(), i32::MAX);
    }

    #[test]
    fn abs_ubyte_uint_are_no_ops() {
        assert_eq!(Ubyte::create(200).wrapped_abs().value(), 200);
        assert_eq!(Uint::create(4_000_000_000).wrapped_abs().value(), 4_000_000_000);
    }

    #[test]
    fn gl_value_to_float_matches_upstream_per_type() {
        assert_eq!(GLValue::Float(Float::create(1.5)).to_float(), 1.5);
        assert_eq!(GLValue::Byte(Byte::create(-5)).to_float(), -5.0);
        assert_eq!(GLValue::Ubyte(Ubyte::create(5)).to_float(), 5.0);
        assert_eq!(GLValue::Int(Int::create(42)).to_float(), 42.0);
        assert_eq!(GLValue::Uint(Uint::create(42)).to_float(), 42.0);

        // Fixed(0) -> (2*0+1)/(65536-1) = 1/65535.
        let fixed_zero = GLValue::Fixed(Fixed::create(0)).to_float();
        assert!((fixed_zero - (1.0f32 / 65535.0f32)).abs() < 1e-9);
    }

    #[test]
    fn gl_value_max_min_tables_match_upstream() {
        assert_eq!(
            GLValue::max_value(InputType::UnsignedByte),
            GLValue::Ubyte(Ubyte::create(255))
        );
        assert_eq!(
            GLValue::min_value(InputType::UnsignedByte),
            GLValue::Ubyte(Ubyte::create(0))
        );
        assert_eq!(
            GLValue::max_value(InputType::UnsignedShort),
            GLValue::Ushort(Ushort::create(65530))
        );
        assert_eq!(
            GLValue::max_value(InputType::UnsignedInt),
            GLValue::Uint(Uint::create(4294967295))
        );
        assert_eq!(
            GLValue::min_value(InputType::Int),
            GLValue::Int(Int::create(-2147483647))
        );
    }
}

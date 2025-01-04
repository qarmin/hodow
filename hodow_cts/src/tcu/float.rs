// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuFloat.hpp  (tcu::Float, tcu::Float32)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, specialised to the 32-bit binding.
//
// Upstream's `Float` is a template over storage type, exponent/mantissa widths and bias,
// instantiated as Float16/Float32/Float64 and a pile of unsigned variants. Only the
// 32-bit and 16-bit signed ones are used by anything ported so far, so only those two
// exist here; widening this to a generic is a change to make when a third instantiation
// turns up, not before.
//
// What it is for: a test that checks a driver's arithmetic cannot use the host's
// arithmetic to say what the answer should be to within a ULP - it has to take the
// representation apart. `exponent()`, `mantissa()` and `construct()` are how the derivate
// tests build the "one ULP at this exponent" quantities their thresholds are made of.
// `Float16` exists specifically for `tcu::Float16(x).asFloat()`, the f32->f16->f32
// round-trip several `es3fShaderCommonFunctionTests.cpp` cases use to snap a random
// `mediump` input to a value fp16 can represent exactly before computing a reference -
// without it the reference (computed at full f32/f64 precision) can disagree with what
// the shader itself received, on an input that was never representable in mediump storage
// to begin with.

/// IEEE 754 binary32, taken apart.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Float32(u32);

const EXPONENT_BITS: u32 = 8;
const MANTISSA_BITS: u32 = 23;
const EXPONENT_BIAS: i32 = 127;

impl Float32 {
    pub fn new(value: f32) -> Self {
        Self(value.to_bits())
    }

    pub fn from_bits(bits: u32) -> Self {
        Self(bits)
    }

    pub fn bits(self) -> u32 {
        self.0
    }

    pub fn as_float(self) -> f32 {
        f32::from_bits(self.0)
    }

    pub fn sign_bit(self) -> u32 {
        (self.0 >> (EXPONENT_BITS + MANTISSA_BITS)) & 1
    }

    pub fn sign(self) -> i32 {
        if self.sign_bit() != 0 { -1 } else { 1 }
    }

    pub fn exponent_bits(self) -> u32 {
        (self.0 >> MANTISSA_BITS) & ((1 << EXPONENT_BITS) - 1)
    }

    pub fn mantissa_bits(self) -> u32 {
        self.0 & ((1 << MANTISSA_BITS) - 1)
    }

    /// The exponent as arithmetic uses it.
    ///
    /// A subnormal reports `1 - bias` rather than the `-bias` its stored bits would
    /// suggest: subnormals share the smallest normal's exponent and differ by having no
    /// implicit leading one. Getting this wrong makes every ULP computed near zero too
    /// small by a factor of two.
    pub fn exponent(self) -> i32 {
        if self.is_denorm() {
            1 - EXPONENT_BIAS
        } else {
            self.exponent_bits() as i32 - EXPONENT_BIAS
        }
    }

    /// The significand *with* its implicit leading one, except for zero and subnormals,
    /// which have none.
    pub fn mantissa(self) -> u32 {
        if self.is_zero() || self.is_denorm() {
            self.mantissa_bits()
        } else {
            self.mantissa_bits() | (1 << MANTISSA_BITS)
        }
    }

    pub fn is_zero(self) -> bool {
        self.exponent_bits() == 0 && self.mantissa_bits() == 0
    }

    pub fn is_denorm(self) -> bool {
        self.exponent_bits() == 0 && self.mantissa_bits() != 0
    }

    pub fn is_inf(self) -> bool {
        self.exponent_bits() == (1 << EXPONENT_BITS) - 1 && self.mantissa_bits() == 0
    }

    pub fn is_nan(self) -> bool {
        self.exponent_bits() == (1 << EXPONENT_BITS) - 1 && self.mantissa_bits() != 0
    }

    /// Builds a float from sign, arithmetic exponent and a mantissa that *includes* the
    /// implicit leading one.
    ///
    /// `construct(+1, e, 1 << 23)` is therefore `2^e`, which is what makes expressions
    /// like `construct(+1, e, (1 << 23) | (1 << k)) - construct(+1, e, 1 << 23)` read as
    /// "the value of bit k at exponent e" - one ULP, or a run of garbage bits. That
    /// idiom is the whole reason this type is here.
    ///
    /// `exponent == 0 && mantissa == 0` is upstream's shorthand for zero, so a caller
    /// never has to know how zero is encoded.
    pub fn construct(sign: i32, exponent: i32, mantissa: u32) -> Self {
        debug_assert!(sign == 1 || sign == -1);

        let shorthand_zero = exponent == 0 && mantissa == 0;
        // Zero and subnormals are the case where the leading mantissa bit is *not*
        // implicit-one, and they are stored with a zero exponent field rather than with
        // the `1 - bias` the arithmetic exponent says.
        let denorm_or_zero = exponent == 1 - EXPONENT_BIAS && (mantissa >> MANTISSA_BITS) == 0;

        let s = u32::from(sign < 0) << (EXPONENT_BITS + MANTISSA_BITS);
        let exp = if shorthand_zero || denorm_or_zero {
            0
        } else {
            (exponent + EXPONENT_BIAS) as u32
        };

        debug_assert!(shorthand_zero || denorm_or_zero || (mantissa >> MANTISSA_BITS) == 1);
        debug_assert!(exp >> EXPONENT_BITS == 0);

        Self(s | (exp << MANTISSA_BITS) | (mantissa & ((1 << MANTISSA_BITS) - 1)))
    }

    /// The same, but taking the stored exponent and mantissa fields verbatim.
    pub fn construct_bits(sign: i32, exponent: i32, mantissa_bits: u32) -> Self {
        let sign_bit = u32::from(sign < 0);
        let exponent_bits = (exponent + EXPONENT_BIAS) as u32;

        debug_assert!(sign == 1 || sign == -1);
        debug_assert!(exponent_bits >> EXPONENT_BITS == 0);
        debug_assert!(mantissa_bits >> MANTISSA_BITS == 0);

        Self((sign_bit << (EXPONENT_BITS + MANTISSA_BITS)) | (exponent_bits << MANTISSA_BITS) | mantissa_bits)
    }
}

/// IEEE 754-2008 binary16 ("half float"), taken apart the same way `Float32` is.
///
/// Only the two conversions this port actually needs exist: `new` (f32 -> f16, rounding
/// to nearest, ties to even - upstream's default `RoundingDirection`) and `as_float` (f16
/// -> f32, always exact - a 16-bit significand and exponent range both fit inside a
/// 32-bit one with room to spare, so this direction never rounds or overflows). Neither
/// is a generic `convert`; each is upstream's own `Float<..>::convert` template
/// specialised by hand to this one pair of widths (23/8/127 <-> 10/5/15), since no third
/// pairing exists in this port to justify writing the generic version.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Float16(u16);

const F16_EXPONENT_BITS: u32 = 5;
const F16_MANTISSA_BITS: u32 = 10;
const F16_EXPONENT_BIAS: i32 = 15;

impl Float16 {
    pub fn from_bits(bits: u16) -> Self {
        Self(bits)
    }

    pub fn bits(self) -> u16 {
        self.0
    }

    pub fn sign_bit(self) -> u16 {
        (self.0 >> (F16_EXPONENT_BITS + F16_MANTISSA_BITS)) & 1
    }

    pub fn sign(self) -> i32 {
        if self.sign_bit() != 0 { -1 } else { 1 }
    }

    pub fn exponent_bits(self) -> u16 {
        (self.0 >> F16_MANTISSA_BITS) & ((1 << F16_EXPONENT_BITS) - 1)
    }

    pub fn mantissa_bits(self) -> u16 {
        self.0 & ((1 << F16_MANTISSA_BITS) - 1)
    }

    pub fn exponent(self) -> i32 {
        if self.is_denorm() {
            1 - F16_EXPONENT_BIAS
        } else {
            i32::from(self.exponent_bits()) - F16_EXPONENT_BIAS
        }
    }

    pub fn mantissa(self) -> u16 {
        if self.is_zero() || self.is_denorm() {
            self.mantissa_bits()
        } else {
            self.mantissa_bits() | (1 << F16_MANTISSA_BITS)
        }
    }

    pub fn is_zero(self) -> bool {
        self.exponent_bits() == 0 && self.mantissa_bits() == 0
    }

    pub fn is_denorm(self) -> bool {
        self.exponent_bits() == 0 && self.mantissa_bits() != 0
    }

    pub fn is_inf(self) -> bool {
        self.exponent_bits() == (1 << F16_EXPONENT_BITS) - 1 && self.mantissa_bits() == 0
    }

    pub fn is_nan(self) -> bool {
        self.exponent_bits() == (1 << F16_EXPONENT_BITS) - 1 && self.mantissa_bits() != 0
    }

    fn zero(sign: i32) -> Self {
        Self(u16::from(sign < 0) << (F16_EXPONENT_BITS + F16_MANTISSA_BITS))
    }

    fn inf(sign: i32) -> Self {
        Self(
            (u16::from(sign < 0) << (F16_EXPONENT_BITS + F16_MANTISSA_BITS))
                | (((1 << F16_EXPONENT_BITS) - 1) << F16_MANTISSA_BITS),
        )
    }

    /// Upstream's `Float<..>::nan()`: an unconditional, fixed bit pattern (every exponent
    /// and mantissa bit set), not a propagated payload - a NaN source is always widened or
    /// narrowed to exactly this, never round-tripped bit-for-bit.
    fn nan() -> Self {
        Self((1u16 << (F16_EXPONENT_BITS + F16_MANTISSA_BITS)) - 1)
    }

    /// `Float<..>::construct` - see `Float32::construct`'s own doc comment, identical
    /// shape at this width.
    pub fn construct(sign: i32, exponent: i32, mantissa: u16) -> Self {
        debug_assert!(sign == 1 || sign == -1);

        let shorthand_zero = exponent == 0 && mantissa == 0;
        let denorm_or_zero = exponent == 1 - F16_EXPONENT_BIAS && (mantissa >> F16_MANTISSA_BITS) == 0;

        let s = u16::from(sign < 0) << (F16_EXPONENT_BITS + F16_MANTISSA_BITS);
        let exp = if shorthand_zero || denorm_or_zero {
            0
        } else {
            (exponent + F16_EXPONENT_BIAS) as u16
        };

        debug_assert!(shorthand_zero || denorm_or_zero || (mantissa >> F16_MANTISSA_BITS) == 1);
        debug_assert!(exp >> F16_EXPONENT_BITS == 0);

        Self(s | (exp << F16_MANTISSA_BITS) | (mantissa & ((1 << F16_MANTISSA_BITS) - 1)))
    }

    pub fn construct_bits(sign: i32, exponent: i32, mantissa_bits: u16) -> Self {
        let sign_bit = u16::from(sign < 0);
        let exponent_bits = (exponent + F16_EXPONENT_BIAS) as u16;

        debug_assert!(sign == 1 || sign == -1);
        debug_assert!(exponent_bits >> F16_EXPONENT_BITS == 0);
        debug_assert!(mantissa_bits >> F16_MANTISSA_BITS == 0);

        Self(
            (sign_bit << (F16_EXPONENT_BITS + F16_MANTISSA_BITS))
                | (exponent_bits << F16_MANTISSA_BITS)
                | mantissa_bits,
        )
    }

    /// `Float16(f32 value)` - upstream's constructor, which is `convert(Float32(bits))`
    /// with the default `RoundingDirection::ROUND_TO_EVEN`. Ported as a direct
    /// specialisation of `Float<..>::convert` rather than the generic template: the
    /// underflow-shift-left branch (`bitDiff < 0`) upstream's generic version guards is
    /// unreachable for this specific pair of widths (23 source mantissa bits, 10
    /// destination - `bitDiff` there is always `13 + (eMin - e)` with `e < eMin`, so it can
    /// never go negative) and is not carried over.
    pub fn new(value: f32) -> Self {
        let src = Float32::new(value);
        let sign = src.sign();

        if src.is_inf() {
            return Self::inf(sign);
        }
        if src.is_nan() {
            return Self::nan();
        }
        if src.is_zero() {
            return Self::zero(sign);
        }

        const OTHER_MANTISSA_BITS: u32 = 23;
        let e_min = 1 - F16_EXPONENT_BIAS;
        let e_max = ((1i32 << F16_EXPONENT_BITS) - 2) - F16_EXPONENT_BIAS;

        let s = u16::from(sign < 0) << (F16_EXPONENT_BITS + F16_MANTISSA_BITS);
        let mut e = src.exponent();
        let mut m: u64 = u64::from(src.mantissa());

        // Normalise a denormalised f32 input (mantissa's leading bit absent) before
        // treating `m`'s bit 23 as the implicit one everywhere below.
        while m & (1u64 << OTHER_MANTISSA_BITS) == 0 {
            m <<= 1;
            e -= 1;
        }

        if e < e_min {
            if e_min - e - 1 > F16_MANTISSA_BITS as i32 {
                // Too small even for a denormal f16.
                return Self::zero(sign);
            }
            let bit_diff = (OTHER_MANTISSA_BITS as i32 - F16_MANTISSA_BITS as i32) + (e_min - e);
            let last_bits_mask = (1u64 << bit_diff) - 1;
            let last_bits = m & last_bits_mask;
            let half = (1u64 << (bit_diff - 1)) - 1;
            let bias = (m >> bit_diff) & 1;
            let _ = last_bits; // only the other rounding directions upstream never asks for here need it
            return Self(s | (((m + half + bias) >> bit_diff) as u16));
        }

        // Remove the implicit leading one.
        m &= !(1u64 << OTHER_MANTISSA_BITS);

        let bit_diff = OTHER_MANTISSA_BITS as i32 - F16_MANTISSA_BITS as i32;
        let half = (1u64 << (bit_diff - 1)) - 1;
        let bias = (m >> bit_diff) & 1;
        m = (m + half + bias) >> bit_diff;
        if m & (1u64 << F16_MANTISSA_BITS) != 0 {
            // Rounding overflowed the mantissa back into the next exponent.
            m = 0;
            e += 1;
        }

        if e > e_max {
            return Self::inf(sign);
        }

        Self(s | (((e + F16_EXPONENT_BIAS) as u16) << F16_MANTISSA_BITS) | (m as u16))
    }

    /// `Float16::asFloat()` - `Float32::convert(*this)`, always exact at this width pair
    /// (see the type's own doc comment).
    pub fn as_float(self) -> f32 {
        let sign = self.sign();

        if self.is_inf() {
            return if sign < 0 { f32::NEG_INFINITY } else { f32::INFINITY };
        }
        if self.is_nan() {
            // Upstream's `Float32::nan()`: every exponent and mantissa bit set, not a
            // propagated payload.
            return f32::from_bits(0x7FFF_FFFF);
        }
        if self.is_zero() {
            return if sign < 0 { -0.0 } else { 0.0 };
        }

        let mut e = self.exponent();
        let mut m: u32 = u32::from(self.mantissa());

        while m & (1u32 << F16_MANTISSA_BITS) == 0 {
            m <<= 1;
            e -= 1;
        }
        m &= !(1u32 << F16_MANTISSA_BITS);

        let bit_diff = 23 - F16_MANTISSA_BITS;
        m <<= bit_diff;

        let bits = (u32::from(sign < 0) << 31) | (((e + 127) as u32) << 23) | m;
        f32::from_bits(bits)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    /// Pinned bit patterns rather than a round trip through this same code: the point of
    /// the type is to agree with IEEE 754 and with upstream, and a test written in terms
    /// of the implementation would agree with a wrong one just as happily.
    #[test]
    fn the_pieces_of_one_are_what_ieee_says() {
        let one = Float32::new(1.0);
        assert_eq!(one.bits(), 0x3F80_0000);
        assert_eq!(one.sign(), 1);
        assert_eq!(one.exponent_bits(), 127);
        assert_eq!(one.exponent(), 0);
        assert_eq!(one.mantissa_bits(), 0);
        assert_eq!(
            one.mantissa(),
            1 << 23,
            "the leading one is implicit in the bits and explicit here"
        );
        assert!(!one.is_zero() && !one.is_denorm() && !one.is_inf() && !one.is_nan());
    }

    #[test]
    fn exponents_and_signs_come_out_right() {
        assert_eq!(Float32::new(2.0).exponent(), 1);
        assert_eq!(Float32::new(0.5).exponent(), -1);
        assert_eq!(Float32::new(-4.0).exponent(), 2);
        assert_eq!(Float32::new(-4.0).sign(), -1);
        assert_eq!(Float32::new(1.5).mantissa_bits(), 1 << 22);
    }

    /// Zero and subnormals are the two cases where the stored exponent field and the
    /// arithmetic exponent disagree, and where the leading mantissa one is absent.
    #[test]
    fn zero_and_subnormals_report_the_smallest_normal_exponent() {
        let zero = Float32::new(0.0);
        assert!(zero.is_zero() && !zero.is_denorm());
        // Zero is *not* a denorm by upstream's test (its mantissa bits are zero), so it
        // falls through to the plain `exponent_bits - bias` and reports -127, one lower
        // than the -126 a subnormal reports. That asymmetry is upstream's and is relied
        // on: `computeFloatingPointError` clamps the exponent at -3 anyway, but code
        // that compares two exponents sees it.
        assert_eq!(zero.exponent(), -127);
        assert_eq!(zero.mantissa(), 0);

        let subnormal = Float32::from_bits(1);
        assert!(subnormal.is_denorm());
        assert_eq!(subnormal.exponent(), -126, "shares the smallest normal's exponent");
        assert_eq!(subnormal.mantissa(), 1, "no implicit leading one");

        let smallest_normal = Float32::new(f32::MIN_POSITIVE);
        assert!(!smallest_normal.is_denorm());
        assert_eq!(smallest_normal.exponent(), -126);
    }

    #[test]
    fn infinities_and_nans_are_told_apart() {
        assert!(Float32::new(f32::INFINITY).is_inf());
        assert!(Float32::new(f32::NEG_INFINITY).is_inf());
        assert_eq!(Float32::new(f32::NEG_INFINITY).sign(), -1);
        assert!(Float32::new(f32::NAN).is_nan());
        assert!(!Float32::new(f32::INFINITY).is_nan());
    }

    #[test]
    fn construct_round_trips_against_the_accessors() {
        for value in [1.0f32, -1.0, 2.0, 0.5, -4.25, 1e-30, 1e30] {
            let f = Float32::new(value);
            let rebuilt = Float32::construct(f.sign(), f.exponent(), f.mantissa());
            assert_eq!(rebuilt.as_float(), value, "{value}");
        }
    }

    /// `construct(+1, e, 1 << 23)` is 2^e. Everything the derivate thresholds are made of
    /// rests on that, so it is pinned against literals rather than against itself.
    #[test]
    fn construct_with_a_bare_leading_one_is_a_power_of_two() {
        assert_eq!(Float32::construct(1, 0, 1 << 23).as_float(), 1.0);
        assert_eq!(Float32::construct(1, 3, 1 << 23).as_float(), 8.0);
        assert_eq!(Float32::construct(-1, 3, 1 << 23).as_float(), -8.0);
        assert_eq!(Float32::construct(1, -2, 1 << 23).as_float(), 0.25);
    }

    /// The idiom the derivate tests use for "one ULP at this exponent": the difference
    /// between a mantissa with bit k set and one without.
    #[test]
    fn the_ulp_idiom_gives_the_value_of_one_mantissa_bit() {
        // At exponent 0, bit 0 of the mantissa is 2^-23.
        let ulp = Float32::construct(1, 0, (1 << 23) | 1).as_float() - Float32::construct(1, 0, 1 << 23).as_float();
        assert_eq!(ulp, f32::from_bits(0x3400_0000), "2^-23");
        assert_eq!(ulp, 2.0f32.powi(-23));

        // And it scales with the exponent, which is the whole point.
        let ulp_at_8 =
            Float32::construct(1, 3, (1 << 23) | 1).as_float() - Float32::construct(1, 3, 1 << 23).as_float();
        assert_eq!(ulp_at_8, ulp * 8.0);
    }

    #[test]
    fn the_zero_shorthand_is_accepted() {
        assert_eq!(Float32::construct(1, 0, 0).as_float(), 0.0);
        assert_eq!(Float32::construct(-1, 0, 0).as_float(), -0.0);
        assert!(Float32::construct(1, 0, 0).is_zero());
    }

    #[test]
    fn construct_bits_takes_the_fields_verbatim() {
        assert_eq!(Float32::construct_bits(1, 0, 0).bits(), 0x3F80_0000, "1.0");
        assert_eq!(Float32::construct_bits(-1, 1, 0).bits(), 0xC000_0000, "-2.0");
    }
}

#[cfg(test)]
mod float16_tests {
    use super::*;

    /// Every expected bit pattern here comes from Python's `struct` module (`'<e'`, IEEE
    /// 754 binary16, round-to-nearest-even) - an independent implementation, not this
    /// file's own code re-checked against itself.
    #[test]
    fn known_values_round_to_the_bits_python_struct_reports() {
        let cases: &[(f32, u16)] = &[
            (1.0, 0x3c00),
            (-1.0, 0xbc00),
            (0.5, 0x3800),
            (65504.0, 0x7bff),
            // The largest f32 (bit-exact, not a decimal literal - see the note below on
            // why a literal like `65519.999` is the wrong way to probe this boundary) that
            // still rounds down to the largest finite f16 rather than overflowing to
            // infinity: one ULP above this is `65520.0`, which does overflow (confirmed
            // against Python's `struct` module, itself given the f32 value rather than a
            // double).
            (f32::from_bits(0x477f_efff), 0x7bff),
            (2.0f32.powi(-14), 0x0400),
            (2.0f32.powi(-24), 0x0001),
            (0.0, 0x0000),
            (-0.0, 0x8000),
            (f32::INFINITY, 0x7c00),
            (f32::NEG_INFINITY, 0xfc00),
            (3.0, 0x4200),
        ];
        for &(value, expected_bits) in cases {
            assert_eq!(Float16::new(value).bits(), expected_bits, "{value}");
        }
    }

    /// The tie-breaking case this whole type exists to get right: a value exactly halfway
    /// between two representable f16s must round to the *even* one, not always down or
    /// always up. `1.00048828125` sits exactly halfway between `1.0` (mantissa bit 0,
    /// even) and `1.0009765625` (mantissa bit 1, odd) - confirmed against Python's
    /// `struct`, which rounds it to `0x3c00` (the even neighbour), not `0x3c01`.
    #[test]
    fn a_tie_rounds_to_the_even_mantissa() {
        assert_eq!(Float16::new(1.000_488_3).bits(), 0x3c00);
        assert_eq!(
            Float16::new(1.000_976_6).bits(),
            0x3c01,
            "not itself a tie - exactly representable"
        );
    }

    /// A random spread of magnitudes (normal, subnormal-adjacent, and ordinary), each
    /// checked both ways: `new` must land on the bit pattern Python's `struct` reports,
    /// and `as_float` on that same bit pattern must land on the f32 value Python reports
    /// for widening it back (which is not the original value - the whole point of a lossy
    /// round trip).
    #[test]
    fn a_spread_of_magnitudes_matches_an_independent_reference() {
        let cases: &[(f32, u16, f32)] = &[
            (-5.335_328, 0xc556, -5.3359375),
            (0.000_413_353_53, 0x0ec6, 0.000_413_417_82),
            (24.327_751, 0x4e15, 24.328125),
            (1.638_501_6, 0x3e8e, 1.638_671_9),
            (0.000_288_814_98, 0x0cbb, 0.000_288_724_9),
            (-1.340_381_1, 0xbd5d, -1.340_820_3),
            (0.000_318_544_4, 0x0d38, 0.000_318_527_22),
            (-109.285_55, 0xd6d5, -109.3125),
            (-0.004_237_002_7, 0x9c57, -0.004_238_128_7),
            (-1.570_901e-5, 0x8108, -1.573_562_6e-5),
            (1_299.490_6, 0x6513, 1299.0),
            (-71.506_62, 0xd478, -71.5),
            (-8.342_597_5e-6, 0x808c, -8.344_65e-6),
            (1.968_005_8, 0x3fdf, 1.967_773_4),
            (15.675_769, 0x4bd6, 15.671875),
            (-1_828.497_7, 0xe724, -1828.0),
            (-0.001_323_864, 0x956c, -0.001_323_7),
            (-6.685_868e-5, 0x8462, -6.687_641e-5),
            (39.814_32, 0x50fa, 39.8125),
            (2.923_095_7, 0x41d9, 2.923_828_1),
            (100.25, 0x5644, 100.25),
            (-100.25, 0xd644, -100.25),
        ];
        for &(value, expected_bits, expected_roundtrip) in cases {
            let half = Float16::new(value);
            assert_eq!(half.bits(), expected_bits, "{value}");
            assert_eq!(
                half.as_float(),
                expected_roundtrip,
                "{value} (bits 0x{expected_bits:04x})"
            );
        }
    }

    #[test]
    fn infinities_and_nans_are_told_apart() {
        assert!(Float16::new(f32::INFINITY).is_inf());
        assert!(Float16::new(f32::NEG_INFINITY).is_inf());
        assert_eq!(Float16::new(f32::NEG_INFINITY).sign(), -1);
        assert!(Float16::new(f32::NAN).is_nan());
        assert!(!Float16::new(f32::INFINITY).is_nan());
        assert_eq!(Float16::new(f32::INFINITY).as_float(), f32::INFINITY);
        assert_eq!(Float16::new(f32::NEG_INFINITY).as_float(), f32::NEG_INFINITY);
        assert!(Float16::new(f32::NAN).as_float().is_nan());
    }

    #[test]
    fn zero_round_trips_with_its_sign() {
        assert_eq!(Float16::new(0.0).as_float(), 0.0);
        assert!(Float16::new(0.0).as_float().is_sign_positive());
        assert_eq!(Float16::new(-0.0).as_float(), -0.0);
        assert!(Float16::new(-0.0).as_float().is_sign_negative());
    }

    /// A value too small even for a subnormal f16 flushes to zero, keeping its sign -
    /// upstream's `Float<..>::convert`'s own underflow-past-denormal branch.
    #[test]
    fn a_value_below_the_smallest_subnormal_flushes_to_zero() {
        let tiny = Float16::new(1e-30);
        assert!(tiny.is_zero());
        assert_eq!(tiny.sign(), 1);
        let tiny_neg = Float16::new(-1e-30);
        assert!(tiny_neg.is_zero());
        assert_eq!(tiny_neg.sign(), -1);
    }

    /// A value past the largest finite f16 rounds up to infinity - upstream's overflow
    /// branch (the default `RoundingDirection` never picks `largestNormal` instead).
    ///
    /// **A double-rounding trap found while writing this test, worth restating for
    /// whoever probes this exact boundary again**: a decimal literal like `65519.999`
    /// parses to the f64 `65519.999`, and Python's `struct.pack('<e', x)` converts a
    /// double straight to half - which rounds `65519.999` down to `65504.0` (`0x7bff`).
    /// But this function's own input is an `f32` (`Float32::new` inside `new`), and
    /// `65519.999` as an *f32 first* rounds up to exactly `65520.0` - one ULP past the
    /// point this file's own overflow-to-infinity branch trips, so the correct answer for
    /// `Float16::new(65519.999f32)` is infinity, not `0x7bff`. Checking a python one-liner
    /// against a decimal literal without first rounding it to the same width the Rust code
    /// actually receives silently asks a different, easier question.
    #[test]
    fn a_value_past_the_largest_finite_rounds_up_to_infinity() {
        assert!(Float16::new(1e30).is_inf());
        assert_eq!(Float16::new(1e30).sign(), 1);
        assert!(Float16::new(-1e30).is_inf());
        assert_eq!(Float16::new(-1e30).sign(), -1);
    }

    #[test]
    fn construct_round_trips_against_the_accessors() {
        for value in [1.0f32, -1.0, 2.0, 0.5, -4.25] {
            let f = Float16::new(value);
            let rebuilt = Float16::construct(f.sign(), f.exponent(), f.mantissa());
            assert_eq!(rebuilt.as_float(), value, "{value}");
        }
    }
}

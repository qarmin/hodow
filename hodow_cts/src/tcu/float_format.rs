// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuFloatFormat.hpp / tcuFloatFormat.cpp  (tcu::FloatFormat)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.
//
// Describes an adjustable-precision floating point format (GLSL's highp/mediump/lowp
// are each a differently-sized IEEE-shaped format, none of which is a real hardware
// type) and how a value or an `Interval` rounds, clamps or widens into it - what
// `gles31::functional::builtin_precision_tests` needs to turn "here is the exact
// mathematical answer" into "here is the range of answers a conformant driver at this
// precision is allowed to produce". Nothing else in this port needs it yet.
//
// Ported: `round`, `roundOut` (both overloads), `convert`, `ulp` and the plumbing they
// share (`exponentShift`, `clampValue`, `deFractExp`). Not ported: `floatToHex`/
// `intervalToHex` (log-message formatting only, no test in this port needs it to match
// upstream's hex layout) and `NormalizedFormat` (a fixed-point variant nothing here
// uses - GLSL's `lowp` is representable as a plain `FloatFormat` with `min_exp ==
// max_exp == 0`, exactly as upstream's own `addBuiltinPrecisionTests` constructs it).
//
// Where upstream switches the hardware rounding mode to compute a directed bound
// exactly, that is not needed here: every operation `round`/`ulp` perform is a
// power-of-two `ldexp`, a `floor`, or a `ceil`, each already exact in `f64` for the
// exponent ranges highp/mediump/lowp cover, so there is no rounding-mode-dependent step
// to replicate (contrast `tcu::interval`'s `widen`, which stands in for a genuinely
// inexact operation).

use super::interval::Interval;

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum YesNoMaybe {
    No,
    Maybe,
    Yes,
}

fn choose_interval(choice: YesNoMaybe, no: Interval, yes: Interval) -> Interval {
    match choice {
        YesNoMaybe::No => no,
        YesNoMaybe::Yes => yes,
        YesNoMaybe::Maybe => no | yes,
    }
}

/// `deFractExp`: returns `(frac, exp)` with `x == frac * 2^exp` and `frac` in `[1, 2)`
/// for finite nonzero `x` (`frac == 0.0` for zero; infinities/NaN pass through
/// unchanged, `exp == 0`). `pub(crate)` since `gls::builtin_precision_tests`'s own
/// `FrExp` reuses this rather than re-deriving the IEEE bit manipulation a second time
/// (it wants `frac` in `[0.5, 1)`, `deFrExp`'s own convention - `frac/2`, `exp+1`
/// converts between the two).
pub(crate) fn fract_exp(x: f64) -> (f64, i32) {
    if x == 0.0 || x.is_nan() || x.is_infinite() {
        return (x, 0);
    }
    let bits = x.to_bits();
    let sign = bits & (1u64 << 63);
    let exp_field = ((bits >> 52) & 0x7ff) as i32;
    let mantissa = bits & 0x000f_ffff_ffff_ffff;

    if exp_field == 0 {
        // Subnormal double: scale up by 2^54 (exact - it only changes the exponent
        // field) and undo the scaling in the returned exponent. An f64 subnormal is
        // many orders of magnitude smaller than anything a float/mediump/lowp format
        // can represent, so in practice this path is never exercised by a sampled
        // value here - kept for the same reason `Interval` widens rather than assumes.
        let scaled = f64::from_bits(sign | mantissa) * 18_014_398_509_481_984.0; // 2^54
        let (frac, exp) = fract_exp(scaled);
        return (frac, exp - 54);
    }

    let exp = exp_field - 1022; // frexp-style: x == m * 2^exp, m in [0.5, 1)
    let frac_bits = sign | (1022u64 << 52) | mantissa;
    (f64::from_bits(frac_bits) * 2.0, exp - 1)
}

fn ldexp(x: f64, exp: i32) -> f64 {
    x * 2f64.powi(exp)
}

/// `deSign` - `pub(crate)` for the same reason as `fract_exp` above (`FrExp`'s own
/// sign-mismatch branch needs it too).
pub(crate) fn de_sign(x: f64) -> f64 {
    if x.is_nan() {
        x
    } else if x > 0.0 {
        1.0
    } else if x < 0.0 {
        -1.0
    } else {
        0.0
    }
}

/// `tcu::FloatFormat`
#[derive(Clone, Copy, Debug)]
pub struct FloatFormat {
    min_exp: i32,
    max_exp: i32,
    fraction_bits: i32,
    has_subnormal: YesNoMaybe,
    has_inf: YesNoMaybe,
    has_nan: YesNoMaybe,
    exact_precision: bool,
    max_value: f64,
}

impl FloatFormat {
    /// The 4-argument upstream constructor, with every `YesNoMaybe` at its default
    /// (`Maybe`).
    pub fn new(min_exp: i32, max_exp: i32, fraction_bits: i32, exact_precision: bool) -> Self {
        Self::with_support(
            min_exp,
            max_exp,
            fraction_bits,
            exact_precision,
            YesNoMaybe::Maybe,
            YesNoMaybe::Maybe,
            YesNoMaybe::Maybe,
        )
    }

    pub fn with_support(
        min_exp: i32,
        max_exp: i32,
        fraction_bits: i32,
        exact_precision: bool,
        has_subnormal: YesNoMaybe,
        has_inf: YesNoMaybe,
        has_nan: YesNoMaybe,
    ) -> Self {
        debug_assert!(min_exp <= max_exp);
        let max_value = ldexp(1.0, max_exp) + ldexp(((1u64 << fraction_bits) - 1) as f64, max_exp - fraction_bits);
        Self {
            min_exp,
            max_exp,
            fraction_bits,
            has_subnormal,
            has_inf,
            has_nan,
            exact_precision,
            max_value,
        }
    }

    pub fn min_exp(self) -> i32 {
        self.min_exp
    }

    pub fn max_exp(self) -> i32 {
        self.max_exp
    }

    pub fn fraction_bits(self) -> i32 {
        self.fraction_bits
    }

    pub fn has_subnormal(self) -> YesNoMaybe {
        self.has_subnormal
    }

    pub fn max_value(self) -> f64 {
        self.max_value
    }

    fn exponent_shift(self, exp: i32) -> i32 {
        self.fraction_bits - (self.min_exp - exp).max(0)
    }

    /// The number closest to `d` that is exactly representable with this format's
    /// significand bits and minimum exponent - rounded up if `upward`, else down.
    pub fn round(self, d: f64, upward: bool) -> f64 {
        let (frac, exp) = fract_exp(d);
        let shift = self.exponent_shift(exp);
        let shift_frac = ldexp(frac, shift);
        let round_frac = if upward { shift_frac.ceil() } else { shift_frac.floor() };
        ldexp(round_frac, exp - shift)
    }

    /// The range of numbers `d` might be converted to, given this format's support (or
    /// lack of it) for infinities and subnormals.
    fn clamp_value(self, d: f64) -> Interval {
        debug_assert!(!d.is_nan());
        let sign = de_sign(d);
        let (_, exp) = fract_exp(d);

        if exp < self.min_exp {
            choose_interval(self.has_subnormal, Interval::exact(sign * 0.0), Interval::exact(d))
        } else if d.is_infinite() || exp > self.max_exp {
            choose_interval(
                self.has_inf,
                Interval::exact(sign * self.max_value),
                Interval::exact(sign * f64::INFINITY),
            )
        } else {
            Interval::exact(d)
        }
    }

    /// The range of numbers that might be used with this format to represent a number
    /// within `x`.
    pub fn convert(self, x: Interval) -> Interval {
        let mut ret = Interval::empty();
        let mut tmp = x;

        if x.has_nan() {
            // If NaN might be supported, NaN is a legal return value.
            if self.has_nan != YesNoMaybe::No {
                ret = ret | Interval::exact(f64::NAN);
            }
            // If NaN might not be supported, any (non-NaN) value is legal, subject to
            // clamping - hence widening `tmp`, not `ret`.
            if self.has_nan != YesNoMaybe::Yes {
                tmp = Interval::unbounded(false);
            }
        }

        // Round both bounds _inwards_ to the closest representable values.
        if !tmp.is_empty() {
            ret = ret | self.clamp_value(self.round(tmp.lo(), false)) | self.clamp_value(self.round(tmp.hi(), true));
        }

        // If this format's precision is not exact, the (possibly out-of-bounds)
        // original value is also a possible result.
        if !self.exact_precision {
            ret = ret | x;
        }

        ret
    }

    fn round_out_scalar(self, d: f64, upward: bool, round_under_overflow: bool) -> f64 {
        let (_, exp) = fract_exp(d);
        if round_under_overflow && exp > self.max_exp && (upward == (d < 0.0)) {
            de_sign(d) * self.max_value
        } else {
            self.round(d, upward)
        }
    }

    /// Round the output of an operation. `round_under_overflow` should be `false` if
    /// any operand was infinite (an overflow there is a real infinity, not a clamp),
    /// `true` otherwise (an overflow there clamps to the largest representable value
    /// rather than becoming an infinity that was never in the inputs).
    pub fn round_out_interval(self, x: Interval, round_under_overflow: bool) -> Interval {
        let mut ret = x.nan();
        if !x.is_empty() {
            ret = ret
                | Interval::new(
                    self.round_out_scalar(x.lo(), false, round_under_overflow),
                    self.round_out_scalar(x.hi(), true, round_under_overflow),
                );
        }
        ret
    }

    /// The 2-argument `FloatFormat::roundOut` upstream reaches through overload
    /// resolution on an implicit `double -> Interval` conversion: promote the single
    /// value (handling NaN exactly like that conversion does) and round it as a range.
    pub fn round_out_point(self, d: f64, round_under_overflow: bool) -> Interval {
        self.round_out_interval(Interval::exact(d), round_under_overflow)
    }

    /// `FloatFormat::ulp` - Harrison's ULP: the distance to the closest *other*
    /// representable number, which at a power-of-two boundary is the one below, not
    /// above. Not needed by `Add`/`Sub`/`Mul`/`Div` (all zero-precision `InfixOperator`s)
    /// but ported alongside `round`/`convert` since every other primitive function
    /// needs it, and it shares `fract_exp`/`exponent_shift` with what is already here.
    pub fn ulp(self, x: f64, count: f64) -> f64 {
        let (frac, mut exp) = fract_exp(x.abs());
        if frac.is_nan() {
            return f64::NAN;
        }
        if frac.is_infinite() {
            return ldexp(1.0, self.max_exp - self.fraction_bits);
        }
        if frac == 1.0 {
            exp -= 1;
        } else if frac == 0.0 {
            exp = self.min_exp;
        }
        exp = exp.max(self.min_exp);
        ldexp(1.0, exp - self.fraction_bits) * count
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn p(e: i32) -> f64 {
        ldexp(1.0, e)
    }

    /// `TestBinary32::runTest` - upstream's own `FloatFormat_selfTest`, minus the
    /// `floatToHex` assertions (not ported, see the module header).
    #[test]
    fn matches_upstreams_binary32_self_test() {
        let fmt = FloatFormat::new(-126, 127, 23, true);

        assert_eq!(fmt.ulp(p(0), 1.0), p(-24));
        assert_eq!(fmt.ulp(p(0) + p(-23), 1.0), p(-23));
        assert_eq!(fmt.ulp(p(-124), 1.0), p(-148));
        assert_eq!(fmt.ulp(p(-125), 1.0), p(-149));
        assert_eq!(fmt.ulp(p(-125) + p(-140), 1.0), p(-148));
        assert_eq!(fmt.ulp(p(-126), 1.0), p(-149));
        assert_eq!(fmt.ulp(p(-130), 1.0), p(-149));

        assert_eq!(fmt.round(p(0) + p(-20) + p(-40), false), p(0) + p(-20));
        assert_eq!(fmt.round(p(0) + p(-20) + p(-40), true), p(0) + p(-20) + p(-23));
        assert_eq!(fmt.round(p(-126) - p(-150), false), p(-126) - p(-149));
        assert_eq!(fmt.round(p(-126) - p(-150), true), p(-126));
    }

    #[test]
    fn convert_clamps_a_value_the_format_cannot_represent() {
        // mediump: exponent -13..=13, 9 fraction bits, not exact (widened results stay
        // legal at a higher precision too) - `addBuiltinPrecisionTests`'s own mediump.
        let mediump = FloatFormat::new(-13, 13, 9, false);
        let huge = mediump.convert(Interval::exact(1.0e10));
        // Not exact-precision, so the original (out-of-range) value is still legal...
        assert!(huge.contains(1.0e10));
        // ...alongside the clamp/overflow answer at mediump's own range.
        assert!(huge.hi() >= mediump.max_value());
    }

    #[test]
    fn round_out_point_widens_a_value_the_format_cannot_land_on_exactly() {
        let mediump = FloatFormat::new(-13, 13, 9, false);
        let one_third = mediump.round_out_point(1.0 / 3.0, false);
        // 1/3 is not exactly representable at 9 fraction bits either way; the interval
        // must bracket it without collapsing to a single (wrong) point.
        assert!(one_third.lo() <= 1.0 / 3.0 && one_third.hi() >= 1.0 / 3.0);
        assert!(one_third.lo() < one_third.hi());
    }

    #[test]
    fn round_out_point_of_nan_is_nan_only_never_a_numeric_range() {
        let highp = FloatFormat::new(-126, 127, 23, true);
        let r = highp.round_out_point(f64::NAN, false);
        assert!(r.is_empty());
        assert!(r.has_nan());
    }
}

// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuInterval.hpp / tcuInterval.cpp  (tcu::Interval)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts, as the subset described below.
//
// A closed range of doubles that an exact answer is guaranteed to lie in, plus the two
// upstream carries alongside it: a NaN flag (a result can legally be "this range, or
// NaN", which is not the same as either alone) and a separate "warning" range (wider
// than the range a fully-conformant driver must land in, used to flag a technically
// out-of-spec but low-quality result rather than a hard failure).
//
// **Ported here are what two callers need.** `shaders.derivate` uses only the plain
// two-endpoint range: construction from a pair, the two accessors, subtraction, and
// division by a positive scalar - none of it ever produces NaN or narrows the warning
// range, so those two fields stay at their default (no NaN, warning range unbounded)
// throughout and are invisible to it. `gles31::functional::builtin_precision_tests`
// (`Add`, so far) is what actually needs the full shape: an input can be sampled as
// NaN, and the reference interval for a NaN-producing operation is genuinely "empty
// range, NaN possible" rather than any finite range.
//
// Where upstream switches the rounding mode to round each bound outwards, this widens by
// one double ULP instead - Rust's standard library exposes no `fesetround`. That is never
// narrower than upstream's answer, which is the direction that matters: a narrower
// interval turns a legal driver result into a failure. Against the f32 quantities the
// derivate thresholds and the builtin-precision formats are made of, one double ULP is
// nothing. The check that this is right is the differential comparison against upstream,
// not this comment.

use std::ops::{BitAnd, BitOr, Div, Sub};

/// A closed range `[lo, hi]`, plus whether NaN is also a legal answer and a separate
/// (usually wider) range for a "quality warning" rather than a hard failure.
#[derive(Debug, Clone, Copy, PartialEq)]
pub struct Interval {
    has_nan: bool,
    lo: f64,
    hi: f64,
    warning_lo: f64,
    warning_hi: f64,
}

impl Interval {
    /// The range between two bounds, in either order. Never carries NaN.
    ///
    /// Upstream's two-argument constructor takes `(lo, hi)` already ordered; ordering
    /// here costs a comparison and removes a way for a caller to build a range that
    /// contains nothing by getting the arguments the wrong way round.
    pub fn new(a: f64, b: f64) -> Self {
        Self {
            has_nan: false,
            lo: a.min(b),
            hi: a.max(b),
            warning_lo: f64::NEG_INFINITY,
            warning_hi: f64::INFINITY,
        }
    }

    /// `Interval(double)` - a range containing exactly `value`, unless `value` is NaN,
    /// in which case the range is empty and only the NaN flag is set. This is the
    /// implicit promotion upstream gets from C++ overload resolution whenever a plain
    /// `double` is passed somewhere an `Interval` is expected.
    pub fn exact(value: f64) -> Self {
        let has_nan = value.is_nan();
        Self {
            has_nan,
            lo: if has_nan { f64::INFINITY } else { value },
            hi: if has_nan { f64::NEG_INFINITY } else { value },
            warning_lo: f64::NEG_INFINITY,
            warning_hi: f64::INFINITY,
        }
    }

    /// `Interval()` - contains nothing, not even NaN.
    pub fn empty() -> Self {
        Self {
            has_nan: false,
            lo: f64::INFINITY,
            hi: f64::NEG_INFINITY,
            warning_lo: f64::NEG_INFINITY,
            warning_hi: f64::INFINITY,
        }
    }

    /// `Interval::unbounded`
    pub fn unbounded(has_nan: bool) -> Self {
        Self {
            has_nan,
            lo: f64::NEG_INFINITY,
            hi: f64::INFINITY,
            warning_lo: f64::NEG_INFINITY,
            warning_hi: f64::INFINITY,
        }
    }

    pub fn lo(self) -> f64 {
        self.lo
    }

    pub fn hi(self) -> f64 {
        self.hi
    }

    pub fn warning_lo(self) -> f64 {
        self.warning_lo
    }

    pub fn warning_hi(self) -> f64 {
        self.warning_hi
    }

    pub fn has_nan(self) -> bool {
        self.has_nan
    }

    /// `Interval::nan` - the NaN-only part of this range, or nothing at all.
    pub fn nan(self) -> Self {
        if self.has_nan {
            Self::exact(f64::NAN)
        } else {
            Self::empty()
        }
    }

    pub fn is_empty(self) -> bool {
        self.lo > self.hi
    }

    /// Whether `value` is a legal answer for this range: `value` itself if it is not
    /// NaN, or the NaN flag if it is.
    pub fn contains(self, value: f64) -> bool {
        if value.is_nan() {
            self.has_nan
        } else {
            value >= self.lo && value <= self.hi
        }
    }

    /// Same as `contains`, against the (usually wider) warning range.
    pub fn contains_warning(self, value: f64) -> bool {
        if value.is_nan() {
            self.has_nan
        } else {
            value >= self.warning_lo && value <= self.warning_hi
        }
    }

    /// Widened by `amount` on both sides. Negative amounts are not a way to narrow one.
    pub fn extended(self, amount: f64) -> Self {
        debug_assert!(amount >= 0.0);
        Self {
            lo: self.lo - amount,
            hi: self.hi + amount,
            ..self
        }
    }

    /// Narrows (or widens) the warning range in place - upstream's `Interval::warning`.
    pub fn set_warning(&mut self, lo: f64, hi: f64) {
        self.warning_lo = lo;
        self.warning_hi = hi;
    }

    /// `Interval::intersects` - whether the two ranges' numeric parts overlap, or both
    /// may legally be NaN. First needed by `ATan2::innerExtrema`, which asks whether a
    /// denominator interval reaches into the negative-or-zero half of the line.
    pub fn intersects(self, other: Interval) -> bool {
        (other.hi >= self.lo && other.lo <= self.hi) || (other.has_nan && self.has_nan)
    }

    /// `Interval::isFinite(maxValue)` - both bounds strictly inside `(-maxValue,
    /// maxValue)`. Unlike `contains`/`is_empty`, this says nothing about the NaN flag
    /// or an empty range on its own (that's upstream's separate `isOrdinary`, not
    /// needed here) - `ATan2::innerExtrema` uses it to decide whether an operand's
    /// range reaches (or passes) the format's own largest representable value, in
    /// which case "infinity may not be supported" and NaN becomes a legal answer too.
    pub fn is_finite(self, max_value: f64) -> bool {
        self.lo > -max_value && self.hi < max_value
    }
}

/// `Interval::operator|` - the union: every value either side allows.
impl BitOr for Interval {
    type Output = Interval;

    fn bitor(self, other: Interval) -> Interval {
        Interval {
            has_nan: self.has_nan || other.has_nan,
            lo: self.lo.min(other.lo),
            hi: self.hi.max(other.hi),
            warning_lo: self.warning_lo.min(other.warning_lo),
            warning_hi: self.warning_hi.max(other.warning_hi),
        }
    }
}

/// `Interval::operator&` - the intersection: only values both sides allow, including
/// the NaN flag itself (both sides must permit NaN for the result to). First needed by
/// `FloatFunc1::applyMonotone`'s codomain restriction (`ret &= getCodomain() |
/// TCU_NAN`) - `Add`/`Sub`/`Mul`/`Div`/`Min`/`Max`/`Clamp` never call this, since none
/// of them narrows its codomain below `unbounded`.
impl BitAnd for Interval {
    type Output = Interval;

    fn bitand(self, other: Interval) -> Interval {
        Interval {
            has_nan: self.has_nan && other.has_nan,
            lo: self.lo.max(other.lo),
            hi: self.hi.min(other.hi),
            warning_lo: self.warning_lo.max(other.warning_lo),
            warning_hi: self.warning_hi.min(other.warning_hi),
        }
    }
}

/// One double ULP outwards on each side, standing in for upstream's directed rounding.
fn widen(lo: f64, hi: f64) -> Interval {
    Interval::new(next_down(lo), next_up(hi))
}

fn next_up(value: f64) -> f64 {
    if value.is_nan() || value == f64::INFINITY {
        return value;
    }
    // Ordering the bit patterns as integers is monotone within a sign, which is what
    // makes stepping by one representable value a single increment either way.
    let bits = value.to_bits();
    if value == 0.0 {
        f64::from_bits(1)
    } else if value > 0.0 {
        f64::from_bits(bits + 1)
    } else {
        f64::from_bits(bits - 1)
    }
}

fn next_down(value: f64) -> f64 {
    -next_up(-value)
}

impl Sub for Interval {
    type Output = Interval;

    /// `[x.lo - y.hi, x.hi - y.lo]` - the extremes over every combination of endpoints,
    /// which for a monotone operation is all four corners and for subtraction is these
    /// two. This is the one that matters to the derivate tests: the numerator of a finite
    /// difference is a subtraction, and it is where the significant bits cancel.
    fn sub(self, other: Interval) -> Interval {
        widen(self.lo - other.hi, self.hi - other.lo)
    }
}

impl Div<f64> for Interval {
    type Output = Interval;

    /// Division by a constant. Zero is rejected rather than quietly returning an
    /// unbounded range: upstream returns unbounded for a denominator spanning zero, which
    /// is correct there and would here be a silent way for a threshold to accept
    /// anything at all.
    fn div(self, divisor: f64) -> Interval {
        assert!(divisor != 0.0, "dividing an interval by zero accepts every result");
        let (a, b) = (self.lo / divisor, self.hi / divisor);
        widen(a.min(b), a.max(b))
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn a_range_orders_its_bounds() {
        assert_eq!(Interval::new(1.0, 2.0), Interval::new(2.0, 1.0));
        assert_eq!(Interval::new(2.0, 1.0).lo(), 1.0);
        assert_eq!(Interval::new(2.0, 1.0).hi(), 2.0);
        assert_eq!(Interval::exact(3.0).lo(), Interval::exact(3.0).hi());
    }

    /// `Interval::operator&` - only the NaN flag both sides allow, and only the range
    /// both sides allow.
    #[test]
    fn intersection_narrows_both_the_range_and_the_nan_flag() {
        let a = Interval::new(-1.0, 1.0);
        let b = Interval::new(-1.0, 1.0) | Interval::exact(f64::NAN);
        let r = a & b;
        assert!(!r.has_nan(), "a itself never allowed NaN");
        assert_eq!(r.lo(), -1.0);
        assert_eq!(r.hi(), 1.0);

        let c = Interval::new(-2.0, 0.5);
        let r2 = a & c;
        assert_eq!(r2.lo(), -1.0);
        assert_eq!(r2.hi(), 0.5);
    }

    /// Subtraction has to take the *widest* difference, or the range stops containing
    /// answers that are legal - which shows up as a driver failing a test it passes.
    #[test]
    fn subtraction_spans_every_pairing_of_endpoints() {
        let d = Interval::new(10.0, 12.0) - Interval::new(1.0, 3.0);
        assert!(
            d.lo() <= 7.0 && d.hi() >= 11.0,
            "expected to contain [7, 11], got [{}, {}]",
            d.lo(),
            d.hi()
        );
        // And nothing outside, beyond the one-ULP widening.
        assert!(d.lo() > 6.9 && d.hi() < 11.1);
    }

    #[test]
    fn subtracting_a_range_from_itself_contains_zero() {
        let a = Interval::new(-2.0, 5.0);
        assert!((a - a).contains(0.0));
    }

    #[test]
    fn division_by_a_constant_scales_both_bounds() {
        let d = Interval::new(3.0, 9.0) / 3.0;
        assert!(d.contains(1.0) && d.contains(3.0));
        assert!(d.lo() > 0.99 && d.hi() < 3.01);

        // A negative divisor swaps which bound is which, and must still order them.
        let n = Interval::new(3.0, 9.0) / -3.0;
        assert!(n.lo() < n.hi());
        assert!(n.contains(-1.0) && n.contains(-3.0));
    }

    #[test]
    #[should_panic(expected = "accepts every result")]
    fn dividing_by_zero_is_refused() {
        let _ = Interval::new(1.0, 2.0) / 0.0;
    }

    /// The widening must go outwards on both sides and never inwards, which is the whole
    /// reason it stands in for a rounding mode.
    #[test]
    fn widening_never_narrows() {
        for value in [0.0f64, 1.0, -1.0, 1e-300, 1e300, -3.7] {
            assert!(next_up(value) >= value, "next_up({value})");
            assert!(next_down(value) <= value, "next_down({value})");
        }
        assert!(next_up(1.0) > 1.0);
        assert!(next_down(1.0) < 1.0);
        assert_eq!(next_up(f64::INFINITY), f64::INFINITY);
        assert!(next_up(f64::NAN).is_nan());
    }

    #[test]
    fn extending_widens_by_the_amount_given() {
        let e = Interval::new(1.0, 2.0).extended(0.5);
        assert_eq!((e.lo(), e.hi()), (0.5, 2.5));
        assert!(!Interval::new(1.0, 2.0).contains(0.9));
        assert!(e.contains(0.9));
    }

    #[test]
    fn a_nan_sample_is_an_empty_range_with_the_flag_set() {
        let n = Interval::exact(f64::NAN);
        assert!(n.is_empty());
        assert!(n.has_nan());
        assert!(n.contains(f64::NAN));
        assert!(!n.contains(0.0));
    }

    #[test]
    fn union_keeps_the_widest_range_and_either_sides_nan() {
        let a = Interval::new(1.0, 2.0);
        let b = Interval::exact(f64::NAN);
        let u = a | b;
        assert_eq!((u.lo(), u.hi()), (1.0, 2.0));
        assert!(u.has_nan());
        assert!(u.contains(1.5));
        assert!(u.contains(f64::NAN));
        assert!(!u.contains(3.0));
    }

    #[test]
    fn warning_range_is_unbounded_until_narrowed() {
        let mut a = Interval::new(1.0, 2.0);
        assert!(a.contains_warning(1000.0));
        a.set_warning(0.5, 2.5);
        assert!(a.contains_warning(2.4));
        assert!(!a.contains_warning(1000.0));
    }
}

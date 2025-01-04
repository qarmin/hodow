// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/delibs/decpp/deStringUtil.hpp / .cpp  (de::toString)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright 2014 The Android Open Source Project
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts.

/// `de::toString(float)` - C++'s `ostringstream << float`, i.e. `printf("%g")` at the
/// default precision of 6 significant digits.
///
/// Rust's own `{}` prints the shortest round-tripping form instead (`49.93053` where C++
/// says `49.9305`), so any case that logs a non-round float needs this for
/// `diff_log_vs_deqp.sh` to be able to compare the two logs at all. The exponent is read
/// back out of the *rounded* scientific form, because rounding to 6 digits can carry into
/// it (9.999995 -> 10.0000).
pub fn to_string_f32(value: f32) -> String {
    const PRECISION: i32 = 6;

    if value == 0.0 {
        return "0".to_string();
    }
    if value.is_nan() {
        return "nan".to_string();
    }
    if value.is_infinite() {
        return if value > 0.0 {
            "inf".to_string()
        } else {
            "-inf".to_string()
        };
    }

    fn trim(s: &str) -> &str {
        if s.contains('.') {
            s.trim_end_matches('0').trim_end_matches('.')
        } else {
            s
        }
    }

    let scientific = format!("{:.*e}", (PRECISION - 1) as usize, value);
    let (mantissa, exponent) = scientific
        .split_once('e')
        .expect("Rust's `{:e}` always writes an exponent");
    let exponent: i32 = exponent
        .parse()
        .expect("Rust's `{:e}` always writes a decimal exponent");

    // %g picks scientific when the decimal exponent is below -4 or at least the precision.
    if !(-4..PRECISION).contains(&exponent) {
        return format!(
            "{}e{}{:02}",
            trim(mantissa),
            if exponent < 0 { '-' } else { '+' },
            exponent.abs()
        );
    }

    trim(&format!("{:.*}", (PRECISION - 1 - exponent).max(0) as usize, value)).to_string()
}

#[cfg(test)]
mod tests {
    use super::to_string_f32;

    #[test]
    fn matches_cpp_default_float_output() {
        // The shapes that differ from Rust's own `{}`: rounding to 6 significant digits,
        // rounding that carries into the exponent, and the two %g cutoffs.
        assert_eq!(to_string_f32(49.930_53), "49.9305");
        assert_eq!(to_string_f32(999_999.9), "1e+06");
        assert_eq!(to_string_f32(9.999_995e9), "9.99999e+09");
        assert_eq!(to_string_f32(0.0), "0");
        assert_eq!(to_string_f32(1.0), "1");
        assert_eq!(to_string_f32(0.187_5), "0.1875");
        assert_eq!(to_string_f32(0.000_1), "0.0001");
        assert_eq!(to_string_f32(0.000_01), "1e-05");
        assert_eq!(to_string_f32(123_456.0), "123456");
        assert_eq!(to_string_f32(1_234_567.0), "1.23457e+06");
        assert_eq!(to_string_f32(-2.5), "-2.5");
    }
}

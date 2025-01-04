// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   framework/common/tcuFloat.hpp (`tcu::Float<..>::convert` for a float32 source, `asFloat`, `largestNormal`, `inf`, `nan`)
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2014 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. One description of a signed, denormal-supporting format covers `Float16`, `BrainFloat16`, `FloatE5M2`
// and `FloatE4M3` for the cooperative matrix tests, which need all four rounding directions that `tcu::Float16` here lacks.

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum RoundingDirection {
    ToEven,
    Downward,
    Upward,
}

#[derive(Clone, Copy)]
pub struct SmallFloat {
    exponent_bits: u32,
    mantissa_bits: u32,
    exponent_bias: i32,
    no_infinity: bool,
}

pub const FLOAT16: SmallFloat = SmallFloat {
    exponent_bits: 5,
    mantissa_bits: 10,
    exponent_bias: 15,
    no_infinity: false,
};
pub const BFLOAT16: SmallFloat = SmallFloat {
    exponent_bits: 8,
    mantissa_bits: 7,
    exponent_bias: 127,
    no_infinity: false,
};
pub const FLOAT_E5M2: SmallFloat = SmallFloat {
    exponent_bits: 5,
    mantissa_bits: 2,
    exponent_bias: 15,
    no_infinity: false,
};
pub const FLOAT_E4M3: SmallFloat = SmallFloat {
    exponent_bits: 4,
    mantissa_bits: 3,
    exponent_bias: 7,
    no_infinity: true,
};

const OTHER_MANTISSA_BITS: u32 = 23;

impl SmallFloat {
    fn sign_shift(self) -> u32 {
        self.exponent_bits + self.mantissa_bits
    }

    fn zero(self, sign: i32) -> u32 {
        u32::from(sign < 0) << self.sign_shift()
    }

    fn inf(self, sign: i32) -> u32 {
        (u32::from(sign < 0) << self.sign_shift()) | (((1u32 << self.exponent_bits) - 1) << self.mantissa_bits)
    }

    pub fn nan(self) -> u32 {
        (1u32 << self.sign_shift()) - 1
    }

    /// `largestNormal(sign)`
    pub fn largest_normal(self, sign: i32) -> u32 {
        let s = u32::from(sign < 0) << self.sign_shift();
        let mantissa_mask = (1u32 << self.mantissa_bits) - 1;
        if !self.no_infinity {
            s | (((1u32 << self.exponent_bits) - 2) << self.mantissa_bits) | mantissa_mask
        } else {
            s | (((1u32 << self.exponent_bits) - 1) << self.mantissa_bits) | (mantissa_mask - 1)
        }
    }

    /// `Float(value, rd)` for a float32 `value`: the bits of the nearest representable value in the given direction
    pub fn from_f32(self, value: f32, rd: RoundingDirection) -> u32 {
        let sign: i32 = if value.is_sign_negative() { -1 } else { 1 };
        let inf_value = if !self.no_infinity { self.inf(sign) } else { self.nan() };

        if value.is_infinite() {
            return inf_value;
        }
        if value.is_nan() {
            return self.nan();
        }
        if value == 0.0 {
            return self.zero(sign);
        }

        let e_min = 1 - self.exponent_bias;
        let e_max = ((1i32 << self.exponent_bits) - if !self.no_infinity { 2 } else { 1 }) - self.exponent_bias;

        let bits = value.to_bits();
        let s = ((bits >> 31) & 1) << self.sign_shift();
        let exponent_field = ((bits >> 23) & 0xff) as i32;
        let mut e = if exponent_field == 0 {
            1 - 127
        } else {
            exponent_field - 127
        };
        let mut m = u64::from(if exponent_field == 0 {
            bits & 0x7f_ffff
        } else {
            (bits & 0x7f_ffff) | (1 << 23)
        });

        while m & (1u64 << OTHER_MANTISSA_BITS) == 0 {
            m <<= 1;
            e -= 1;
        }

        let round = |m: u64, bit_diff: u32| -> u64 {
            let last_bits = m & ((1u64 << bit_diff) - 1);
            let half = (1u64 << (bit_diff - 1)) - 1;
            let bias = (m >> bit_diff) & 1;
            match rd {
                RoundingDirection::ToEven => (m + half + bias) >> bit_diff,
                RoundingDirection::Downward => (m >> bit_diff) + u64::from(last_bits != 0 && sign < 0),
                RoundingDirection::Upward => (m >> bit_diff) + u64::from(last_bits != 0 && sign > 0),
            }
        };

        if e < e_min {
            if (e_min - e - 1) as u32 <= self.mantissa_bits {
                let bit_diff = (OTHER_MANTISSA_BITS - self.mantissa_bits) + (e_min - e) as u32;
                return s | round(m, bit_diff) as u32;
            }
            return self.zero(sign);
        }

        m &= !(1u64 << OTHER_MANTISSA_BITS);

        m = round(m, OTHER_MANTISSA_BITS - self.mantissa_bits);
        if m & (1u64 << self.mantissa_bits) != 0 {
            m = 0;
            e += 1;
        }

        if e > e_max {
            return if (sign < 0 && rd == RoundingDirection::Upward) || (sign > 0 && rd == RoundingDirection::Downward) {
                self.largest_normal(sign)
            } else {
                inf_value
            };
        }

        s | (((e + self.exponent_bias) as u32) << self.mantissa_bits) | m as u32
    }

    /// `asFloat()`
    pub fn to_f32(self, bits: u32) -> f32 {
        let sign = if (bits >> self.sign_shift()) & 1 != 0 {
            -1.0f64
        } else {
            1.0
        };
        let exponent = (bits >> self.mantissa_bits) & ((1 << self.exponent_bits) - 1);
        let mantissa = bits & ((1 << self.mantissa_bits) - 1);
        let all_ones = (1u32 << self.exponent_bits) - 1;

        let is_nan = if !self.no_infinity {
            exponent == all_ones && mantissa != 0
        } else {
            bits & ((1 << self.sign_shift()) - 1) == (1 << self.sign_shift()) - 1
        };
        if is_nan {
            return f32::NAN;
        }
        if !self.no_infinity && exponent == all_ones && mantissa == 0 {
            return (sign * f64::INFINITY) as f32;
        }
        let scale = |e: i32| 2f64.powi(e);
        let magnitude = if exponent == 0 {
            f64::from(mantissa) * scale(1 - self.exponent_bias - self.mantissa_bits as i32)
        } else {
            (1.0 + f64::from(mantissa) / f64::from(1u32 << self.mantissa_bits))
                * scale(exponent as i32 - self.exponent_bias)
        };
        (sign * magnitude) as f32
    }

    pub fn round_value(self, value: f64, rd: RoundingDirection) -> f64 {
        f64::from(self.to_f32(self.from_f32(value as f32, rd)))
    }
}

/// `calcB16Threshold`: the tolerance around a bfloat16 reference, none for denormals, infinities and NaNs
pub fn calc_b16_threshold(orig_ref: f32) -> Option<f32> {
    let bits = BFLOAT16.from_f32(orig_ref, RoundingDirection::ToEven);
    let exponent = (bits >> 7) & 0xff;
    let mantissa = bits & 0x7f;
    let is_denorm = exponent == 0 && mantissa != 0;
    let is_inf = exponent == 0xff && mantissa == 0;
    let is_nan = exponent == 0xff && mantissa != 0;
    if is_denorm || is_inf || is_nan {
        return None;
    }
    if exponent == 0 && mantissa == 0 {
        return Some(2.351e-38);
    }
    let trunc = BFLOAT16.to_f32(bits & !3);
    let sat = BFLOAT16.to_f32(bits | 3);
    Some((trunc - orig_ref).abs().max((sat - orig_ref).abs()))
}

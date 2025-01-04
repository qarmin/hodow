// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/openglcts/modules/common/glcMisc.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2016 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. Only the small-float conversions (`floatToHalfFloat` and friends) are here; they are the book's own, not `tcu::Float`, and differ from it in how they round (they truncate), which is why the packed-pixel tests cannot use the framework's.

const HALF_FLOAT_MIN_BIASED_EXP_AS_SINGLE_FP_EXP: u32 = 0x3800_0000;
const HALF_FLOAT_MAX_BIASED_EXP_AS_SINGLE_FP_EXP: u32 = 0x4780_0000;
const FLOAT_MAX_BIASED_EXP: u32 = 0xFF << 23;
const HALF_FLOAT_MAX_BIASED_EXP: u32 = 0x1F << 10;

const FLOAT11_MIN_BIASED_EXP_AS_SINGLE_FP_EXP: u32 = 0x3800_0000;
const FLOAT11_MAX_BIASED_EXP_AS_SINGLE_FP_EXP: u32 = 0x4780_0000;
const FLOAT11_MAX_BIASED_EXP: u32 = 0x1F << 6;

const FLOAT10_MIN_BIASED_EXP_AS_SINGLE_FP_EXP: u32 = 0x3800_0000;
const FLOAT10_MAX_BIASED_EXP_AS_SINGLE_FP_EXP: u32 = 0x4780_0000;
const FLOAT10_MAX_BIASED_EXP: u32 = 0x1F << 5;

/// `floatToHalfFloat`
pub fn float_to_half_float(f: f32) -> u16 {
    let x = f.to_bits();
    let sign = u32::from((x >> 31) as u16);
    let mut mantissa = x & ((1 << 23) - 1);
    let mut exp = x & FLOAT_MAX_BIASED_EXP;

    let hf: u16 = if exp >= HALF_FLOAT_MAX_BIASED_EXP_AS_SINGLE_FP_EXP {
        // check if the original single precision float number is a NaN
        if mantissa != 0 && exp == FLOAT_MAX_BIASED_EXP {
            // we have a single precision NaN
            mantissa = (1 << 23) - 1;
        } else {
            // 16-bit half-float representation stores number as Inf
            mantissa = 0;
        }
        ((sign as u16) << 15) | (HALF_FLOAT_MAX_BIASED_EXP as u16) | ((mantissa >> 13) as u16)
    } else if exp <= HALF_FLOAT_MIN_BIASED_EXP_AS_SINGLE_FP_EXP {
        // check if exponent is <= -15: store a denorm half-float value or zero
        exp = (HALF_FLOAT_MIN_BIASED_EXP_AS_SINGLE_FP_EXP - exp) >> 23;
        mantissa |= 1 << 23;

        if exp < 18 {
            mantissa >>= 14 + exp;
        } else {
            mantissa = 0;
        }

        ((sign as u16) << 15) | (mantissa as u16)
    } else {
        ((sign as u16) << 15)
            | (((exp - HALF_FLOAT_MIN_BIASED_EXP_AS_SINGLE_FP_EXP) >> 13) as u16)
            | ((mantissa >> 13) as u16)
    };

    hf
}

/// `floatToUnisgnedF11`
pub fn float_to_unsigned_f11(f: f32) -> u32 {
    let x = f.to_bits();
    let sign = u32::from((x >> 31) as u16);
    let mut mantissa = x & ((1 << 23) - 1);
    let mut exp = x & FLOAT_MAX_BIASED_EXP;

    // minus f32 value
    if sign > 0 {
        // f32 NaN -> f11 NaN, others round to 0.0
        return if mantissa != 0 && exp == FLOAT_MAX_BIASED_EXP {
            FLOAT11_MAX_BIASED_EXP | 0x0000_003F
        } else {
            0
        };
    }

    // only check positive value below
    if exp >= FLOAT11_MAX_BIASED_EXP_AS_SINGLE_FP_EXP {
        if mantissa != 0 && exp == FLOAT_MAX_BIASED_EXP {
            mantissa = (1 << 23) - 1;
        } else {
            // 11-bit float representation stores number as Inf
            mantissa = 0;
        }
        FLOAT11_MAX_BIASED_EXP | (mantissa >> 17)
    } else if exp <= FLOAT11_MIN_BIASED_EXP_AS_SINGLE_FP_EXP {
        // store a denorm 11-bit float value or zero
        exp = (FLOAT11_MIN_BIASED_EXP_AS_SINGLE_FP_EXP - exp) >> 23;
        mantissa |= 1 << 23;
        if 18 + exp >= u32::BITS {
            mantissa = 0;
        } else {
            mantissa >>= 18 + exp;
        }
        mantissa
    } else {
        ((exp - FLOAT11_MIN_BIASED_EXP_AS_SINGLE_FP_EXP) >> 17) | (mantissa >> 17)
    }
}

/// `floatToUnisgnedF10`
pub fn float_to_unsigned_f10(f: f32) -> u32 {
    let x = f.to_bits();
    let sign = u32::from((x >> 31) as u16);
    let mut mantissa = x & ((1 << 23) - 1);
    let mut exp = x & FLOAT_MAX_BIASED_EXP;

    // minus f32 value
    if sign > 0 {
        return if mantissa != 0 && exp == FLOAT_MAX_BIASED_EXP {
            FLOAT10_MAX_BIASED_EXP | 0x0000_001F
        } else {
            0
        };
    }

    // only check positive value below
    if exp >= FLOAT10_MAX_BIASED_EXP_AS_SINGLE_FP_EXP {
        if mantissa != 0 && exp == FLOAT_MAX_BIASED_EXP {
            mantissa = (1 << 23) - 1;
        } else {
            // 10-bit float representation stores number as Inf
            mantissa = 0;
        }
        FLOAT10_MAX_BIASED_EXP | (mantissa >> 18)
    } else if exp <= FLOAT10_MIN_BIASED_EXP_AS_SINGLE_FP_EXP {
        // store a denorm 10-bit float value or zero
        exp = (FLOAT10_MIN_BIASED_EXP_AS_SINGLE_FP_EXP - exp) >> 23;
        mantissa |= 1 << 23;
        if 19 + exp >= u32::BITS {
            mantissa = 0;
        } else {
            mantissa >>= 19 + exp;
        }
        mantissa
    } else {
        ((exp - FLOAT10_MIN_BIASED_EXP_AS_SINGLE_FP_EXP) >> 18) | (mantissa >> 18)
    }
}

/// `halfFloatToFloat`
pub fn half_float_to_float(hf: u16) -> f32 {
    let sign = u32::from(hf >> 15);
    let mut mantissa = u32::from(hf & ((1 << 10) - 1));
    let mut exp = u32::from(hf) & HALF_FLOAT_MAX_BIASED_EXP;

    if exp == HALF_FLOAT_MAX_BIASED_EXP {
        // we have a half-float NaN or Inf
        exp = FLOAT_MAX_BIASED_EXP;
        if mantissa != 0 {
            mantissa = (1 << 23) - 1; // set all bits to indicate a NaN
        }
    } else if exp == 0 {
        // convert half-float zero/denorm to single precision value
        if mantissa != 0 {
            mantissa <<= 1;
            exp = HALF_FLOAT_MIN_BIASED_EXP_AS_SINGLE_FP_EXP;
            // check for leading 1 in denorm mantissa
            while (mantissa & (1 << 10)) == 0 {
                // for every leading 0, decrement single precision exponent by 1 and shift half-float mantissa value to the left
                mantissa <<= 1;
                exp = exp.wrapping_sub(1 << 23);
            }
            // clamp the mantissa to 10-bits
            mantissa &= (1 << 10) - 1;
            // shift left to generate single-precision mantissa of 23-bits
            mantissa <<= 13;
        }
    } else {
        // shift left to generate single-precision mantissa of 23-bits
        mantissa <<= 13;
        // generate single precision biased exponent value
        exp = (exp << 13) + HALF_FLOAT_MIN_BIASED_EXP_AS_SINGLE_FP_EXP;
    }
    f32::from_bits((sign << 31) | exp | mantissa)
}

/// `unsignedF11ToFloat`
pub fn unsigned_f11_to_float(f11: u32) -> f32 {
    let mut mantissa = f11 & ((1 << 6) - 1);
    let mut exp = f11 & FLOAT11_MAX_BIASED_EXP;

    if exp == FLOAT11_MAX_BIASED_EXP {
        // we have a f11 NaN or Inf
        exp = FLOAT_MAX_BIASED_EXP;
        if mantissa != 0 {
            mantissa = (1 << 23) - 1; // set all bits to indicate a NaN
        }
    } else if exp == 0 {
        // convert f11 zero/denorm to single precision value
        if mantissa != 0 {
            mantissa <<= 1;
            exp = FLOAT11_MIN_BIASED_EXP_AS_SINGLE_FP_EXP;
            // check for leading 1 in denorm mantissa
            while (mantissa & (1 << 10)) == 0 {
                mantissa <<= 1;
                exp = exp.wrapping_sub(1 << 23);
            }
            // clamp the mantissa to 6-bits
            mantissa &= (1 << 6) - 1;
            // shift left to generate single-precision mantissa of 23-bits
            mantissa <<= 17;
        }
    } else {
        // shift left to generate single-precision mantissa of 23-bits
        mantissa <<= 17;
        // generate single precision biased exponent value
        exp = (exp << 17) + FLOAT11_MIN_BIASED_EXP_AS_SINGLE_FP_EXP;
    }
    f32::from_bits(exp | mantissa)
}

/// `unsignedF10ToFloat`
pub fn unsigned_f10_to_float(f10: u32) -> f32 {
    let mut mantissa = f10 & ((1 << 5) - 1);
    let mut exp = f10 & FLOAT10_MAX_BIASED_EXP;

    if exp == FLOAT10_MAX_BIASED_EXP {
        // we have a f10 NaN or Inf
        exp = FLOAT_MAX_BIASED_EXP;
        if mantissa != 0 {
            mantissa = (1 << 23) - 1; // set all bits to indicate a NaN
        }
    } else if exp == 0 {
        // convert f10 zero/denorm to single precision value
        if mantissa != 0 {
            mantissa <<= 1;
            exp = FLOAT10_MIN_BIASED_EXP_AS_SINGLE_FP_EXP;
            // check for leading 1 in denorm mantissa
            while (mantissa & (1 << 10)) == 0 {
                mantissa <<= 1;
                exp = exp.wrapping_sub(1 << 23);
            }
            // clamp the mantissa to 5-bits
            mantissa &= (1 << 5) - 1;
            // shift left to generate single-precision mantissa of 23-bits
            mantissa <<= 18;
        }
    } else {
        // shift left to generate single-precision mantissa of 23-bits
        mantissa <<= 18;
        // generate single precision biased exponent value
        exp = (exp << 18) + FLOAT10_MIN_BIASED_EXP_AS_SINGLE_FP_EXP;
    }
    f32::from_bits(exp | mantissa)
}

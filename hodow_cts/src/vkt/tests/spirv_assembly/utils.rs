// SPDX-License-Identifier: Apache-2.0
//
// Derived from VK-GL-CTS:
//   external/vulkancts/modules/vulkan/spirv_assembly/vktSpvAsmUtils.cpp
// Upstream revision: see hodow_cts/upstream/COMMIT
//
// Copyright (c) 2015 The Khronos Group Inc.
// Licensed under the Apache License, Version 2.0 (see LICENSE at the repo root).
//
// Modifications: rewritten in Rust for hodow_cts. The data generators for the integer and float element types, returning native-endian
// bytes per element so one function serves every width. `getFloat*s` is only ported with `includeSpecialFloat16Values` true, its default.

use crate::tcu::random::Random;

/// One element of generated data, as the bytes the buffer holds.
pub type Element = Vec<u8>;

fn from<T, const N: usize>(values: impl IntoIterator<Item = T>, to_bytes: impl Fn(T) -> [u8; N]) -> Vec<Element> {
    values.into_iter().map(|value| to_bytes(value).to_vec()).collect()
}

/// `getInt64s`
pub fn get_int64s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let mut data: Vec<i64> = vec![
        0x0000000000000000,
        0x0000000000000001,
        0x000000000000002a,
        0x000000007fffffff,
        0x0000000080000000,
        0x00000000ffffffff,
        0x0000000100000000,
        0x7fffffffffffffff,
        0x8000000000000000u64 as i64,
        0x8000000000000001u64 as i64,
        0xffffffff00000000u64 as i64,
        0xffffffff00000001u64 as i64,
        0xffffffff80000000u64 as i64,
        0xffffffff80000001u64 as i64,
        0xffffffffffffffd6u64 as i64,
        -1,
    ];
    while data.len() < count {
        data.push(rnd.get_uint64() as i64);
    }
    from(data, i64::to_ne_bytes)
}

/// `getInt32s`
pub fn get_int32s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let mut data: Vec<i32> = vec![
        0x00000000,
        0x00000001,
        0x0000002a,
        0x00007fff,
        0x00008000,
        0x0000ffff,
        0x00010000,
        0x7fffffff,
        0x80000000u32 as i32,
        0x80000001u32 as i32,
        0xffff0000u32 as i32,
        0xffff0001u32 as i32,
        0xffff8000u32 as i32,
        0xffff8001u32 as i32,
        0xffffffd6u32 as i32,
        -1,
    ];
    while data.len() < count {
        data.push(rnd.get_uint32() as i32);
    }
    from(data, i32::to_ne_bytes)
}

/// `getInt16s`
pub fn get_int16s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let mut data: Vec<i16> = vec![
        0x0000,
        0x0001,
        0x002a,
        0x7fff,
        0x8000u16 as i16,
        0x8001u16 as i16,
        0xffd6u16 as i16,
        -1,
    ];
    while data.len() < count {
        data.push(rnd.get_uint16() as i16);
    }
    from(data, i16::to_ne_bytes)
}

/// `getInt8s`
pub fn get_int8s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let mut data: Vec<i8> = vec![0x00, 0x01, 0x2a, 0x7f, 0x80u8 as i8, 0x81u8 as i8, 0xd6u8 as i8, -1];
    while data.len() < count {
        data.push(rnd.get_uint8() as i8);
    }
    from(data, i8::to_ne_bytes)
}

/// `getUint64s`
pub fn get_uint64s(rnd: &mut Random, count: usize) -> Vec<Element> {
    from(
        (0..count).map(|_| rnd.get_uint64()).collect::<Vec<_>>(),
        u64::to_ne_bytes,
    )
}

/// `getUint32s`
pub fn get_uint32s(rnd: &mut Random, count: usize) -> Vec<Element> {
    from(
        (0..count).map(|_| rnd.get_uint32()).collect::<Vec<_>>(),
        u32::to_ne_bytes,
    )
}

/// `getUint16s`
pub fn get_uint16s(rnd: &mut Random, count: usize) -> Vec<Element> {
    from(
        (0..count).map(|_| rnd.get_uint16()).collect::<Vec<_>>(),
        u16::to_ne_bytes,
    )
}

/// `getUint8s`
pub fn get_uint8s(rnd: &mut Random, count: usize) -> Vec<Element> {
    from((0..count).map(|_| rnd.get_uint8()).collect::<Vec<_>>(), u8::to_ne_bytes)
}

/// `getFloat64s` with the special float16 values included.
pub fn get_float64s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let snan = f64::from_bits(0x7ff4_0000_0000_0000);
    let mut data: Vec<f64> = vec![
        f64::INFINITY,
        f64::NEG_INFINITY,
        snan,
        -snan,
        f64::NAN,
        -f64::NAN,
        f64::from_bits(0x3B0357C299A88EA8),
        f64::from_bits(0xBB0357C299A88EA8),
        2.0f64.powi(100),
        -(2.0f64.powi(100)),
        0.0,
        -0.0,
        f64::from_bits(0x0008_0000_0000_0000),
        -f64::from_bits(0x0008_0000_0000_0000),
        2.0f64.powi(-100),
        -(2.0f64.powi(-100)),
        2.0f64.powi(-14),
        -(2.0f64.powi(-14)),
        f64::from_bits(0x3FD2000000000000),
        f64::from_bits(0xBFD2000000000000),
        f64::from_bits(0x3F100C0000000000),
        f64::from_bits(0xBF100C0000000000),
        0.28125,
        -0.28125,
    ];
    while data.len() < count {
        data.push(rnd.get_double());
    }
    from(data, f64::to_ne_bytes)
}

/// `getFloat32s` with the special float16 values included.
pub fn get_float32s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let snan = f32::from_bits(0x7fa0_0000);
    let mut data: Vec<f32> = vec![
        f32::INFINITY,
        f32::NEG_INFINITY,
        snan,
        -snan,
        f32::NAN,
        -f32::NAN,
        2.0f32.powi(-24),
        -(2.0f32.powi(-24)),
        2.0f32.powi(100),
        -(2.0f32.powi(100)),
        0.0,
        -0.0,
        f32::from_bits(0x0040_0000),
        -f32::from_bits(0x0040_0000),
        2.0f32.powi(-100),
        -(2.0f32.powi(-100)),
        2.0f32.powi(-14),
        -(2.0f32.powi(-14)),
        f32::from_bits(0x3880ff00),
        f32::from_bits(0xb880ff00),
        f32::from_bits(0x38803000),
        f32::from_bits(0xb8803000),
        0.28125,
        -0.28125,
    ];
    while data.len() < count {
        data.push(rnd.get_float());
    }
    from(data, f32::to_ne_bytes)
}

/// `getFloat16s` with the special values included, as raw half precision bit patterns.
pub fn get_float16s(rnd: &mut Random, count: usize) -> Vec<Element> {
    let mut data: Vec<u16> = vec![
        0x7c00, 0xfc00, 0x7c0f, 0xfc0f, 0x7cf0, 0xfcf0, 0x03f0, 0x83f0, 0x0000, 0x8000, 0x0401, 0x8401, 0x14cb, 0x94cb,
    ];
    while data.len() < count {
        data.push(rnd.get_uint16());
    }
    from(data, u16::to_ne_bytes)
}

/// `deFloat16To32`: the binary16 with the given bits as a binary32.
pub fn float16_to_float32(bits: u16) -> f32 {
    let sign = if bits & 0x8000 != 0 { -1.0f64 } else { 1.0 };
    let exponent = i32::from((bits >> 10) & 0x1f);
    let mantissa = f64::from(bits & 0x3ff);
    let value = match exponent {
        0 => sign * mantissa * 2.0f64.powi(-24),
        31 if mantissa == 0.0 => sign * f64::INFINITY,
        31 => return f32::NAN,
        _ => sign * (1.0 + mantissa / 1024.0) * 2.0f64.powi(exponent - 15),
    };
    value as f32
}

/// `roundToNearestEven` of deFloat16.c: `value >> bits` rounded to the nearest, a tie going to the even one.
fn round_to_nearest_even(value: u32, bits: u32) -> u32 {
    let quotient = value >> bits;
    let remainder = value & ((1u32 << bits) - 1);
    let half = 1u32 << (bits - 1);
    if remainder > half || (remainder == half && quotient & 1 == 1) {
        quotient + 1
    } else {
        quotient
    }
}

/// `deFloat32To16Round` of deFloat16.c with the rounding mode `DE_ROUNDINGMODE_TO_ZERO` (`toward_zero`) or `DE_ROUNDINGMODE_TO_NEAREST_EVEN`.
pub fn float32_to_float16_round(value: f32, toward_zero: bool) -> u16 {
    let bits = value.to_bits();
    let sign = (bits >> 16) & 0x8000;
    let exp32 = (bits >> 23) & 0xff;
    let exp16 = exp32 as i32 - 127 + 15;
    let mut mantissa = bits & 0x007f_ffff;

    if exp32 == 0 {
        return sign as u16;
    }
    if exp32 == 0xff {
        if mantissa == 0 {
            return (sign | 0x7c00) as u16;
        }
        mantissa >>= 13;
        return (sign | 0x7c00 | mantissa | u32::from(mantissa == 0)) as u16;
    }
    if exp16 < -10 {
        return sign as u16;
    }
    if exp16 <= 0 {
        mantissa |= 0x0080_0000;
        let shift = (14 - exp16) as u32;
        mantissa = if toward_zero {
            mantissa >> shift
        } else {
            round_to_nearest_even(mantissa, shift)
        };
        return (sign | mantissa) as u16;
    }
    if exp16 <= 30 {
        if toward_zero {
            return (sign | ((exp16 as u32) << 10) | (mantissa >> 13)) as u16;
        }
        mantissa = round_to_nearest_even(mantissa, 13);
        let exponent = ((exp16 as u32) << 10) + (mantissa & (1 << 10));
        mantissa &= (1u32 << 10) - 1;
        return (sign | exponent | mantissa) as u16;
    }
    if toward_zero {
        (sign | 0x7bff) as u16
    } else {
        (sign | 0x7c00) as u16
    }
}

/// `deFloat32To16` rounding to nearest even.
pub fn float32_to_float16(value: f32) -> u16 {
    float32_to_float16_round(value, false)
}

/// `roundToNearestEven64` of deFloat16.c.
fn round_to_nearest_even64(value: u64, bits: u32) -> u64 {
    let quotient = value >> bits;
    let remainder = value & ((1u64 << bits) - 1);
    let half = 1u64 << (bits - 1);
    if remainder > half || (remainder == half && quotient & 1 == 1) {
        quotient + 1
    } else {
        quotient
    }
}

/// `deFloat64To16Round` of deFloat16.c with the rounding mode `DE_ROUNDINGMODE_TO_ZERO` (`toward_zero`) or `DE_ROUNDINGMODE_TO_NEAREST_EVEN`.
pub fn float64_to_float16_round(value: f64, toward_zero: bool) -> u16 {
    let bits = value.to_bits();
    let sign = ((bits >> 48) & 0x8000) as u32;
    let exp64 = ((bits >> 52) & 0x7ff) as i32;
    let exp16 = exp64 - 1023 + 15;
    let mut mantissa = bits & 0x000f_ffff_ffff_ffff;

    if exp64 == 0 {
        return sign as u16;
    }
    if exp64 == 0x7ff {
        if mantissa == 0 {
            return (sign | 0x7c00) as u16;
        }
        mantissa >>= 42;
        return (sign | 0x7c00 | mantissa as u32 | u32::from(mantissa == 0)) as u16;
    }
    if exp16 < -10 {
        return sign as u16;
    }
    if exp16 <= 0 {
        mantissa |= 0x0010_0000_0000_0000;
        let shift = (43 - exp16) as u32;
        mantissa = if toward_zero {
            mantissa >> shift
        } else {
            round_to_nearest_even64(mantissa, shift)
        };
        return (sign | mantissa as u32) as u16;
    }
    if exp16 <= 30 {
        mantissa = if toward_zero {
            mantissa >> 42
        } else {
            round_to_nearest_even64(mantissa, 42)
        };
        let exponent = ((exp16 as u32) << 10) + (mantissa as u32 & (1 << 10));
        let mantissa = mantissa as u32 & ((1u32 << 10) - 1);
        return (sign | exponent | mantissa) as u16;
    }
    if toward_zero {
        (sign | 0x7bff) as u16
    } else {
        (sign | 0x7c00) as u16
    }
}

#![allow(non_snake_case)]
use std::arch::x86_64::*;

use crate::cpu::common;

#[inline]
pub fn create__m128_from(vals: [f32; 4]) -> __m128 {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m128() -> __m128 {
    let arr = common::get_random_float32_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m128d_from(vals: [f64; 2]) -> __m128d {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m128d() -> __m128d {
    let arr = common::get_random_float64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m128i_from(vals: [i64; 2]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128i_from_i32_array(vals: [i32; 4]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128i_from_i16_array(vals: [i16; 8]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128i_from_i8_array(vals: [i8; 16]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128i_from_u32_array(vals: [u32; 4]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128i_from_u16_array(vals: [u16; 8]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128i_from_i64_array(vals: [i64; 2]) -> __m128i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m128i() -> __m128i {
    let arr = common::get_random_i64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m128_from_f32_array(vals: [f32; 4]) -> __m128 {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128d_from_f64_array(vals: [f64; 2]) -> __m128d {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128bh_from(vals: [u16; 8]) -> __m128bh {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m128bh_from_f32_array(vals: [f32; 8]) -> __m128bh {
    let bits: [u16; 8] = std::array::from_fn(|i| (vals[i].to_bits() >> 16) as u16);
    unsafe { std::mem::transmute(bits) }
}

#[inline]
pub fn create_random__m128bh() -> __m128bh {
    let arr = common::get_random_float32_array::<8>();
    create__m128bh_from_f32_array(arr)
}

#[inline]
pub fn create__m256_from(vals: [f32; 8]) -> __m256 {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m256() -> __m256 {
    let arr = common::get_random_float32_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m256d_from(vals: [f64; 4]) -> __m256d {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m256d() -> __m256d {
    let arr = common::get_random_float64_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m256i_from(vals: [i64; 4]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256i_from_i32_array(vals: [i32; 8]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256i_from_i16_array(vals: [i16; 16]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256i_from_i8_array(vals: [i8; 32]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256i_from_u32_array(vals: [u32; 8]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256i_from_u16_array(vals: [u16; 16]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256i_from_u8_array(vals: [u8; 32]) -> __m256i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m256i() -> __m256i {
    let arr = common::get_random_i64_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m256bh_from(vals: [u16; 16]) -> __m256bh {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m256bh_from_f32_array(vals: [f32; 16]) -> __m256bh {
    let bits: [u16; 16] = std::array::from_fn(|i| (vals[i].to_bits() >> 16) as u16);
    unsafe { std::mem::transmute(bits) }
}

#[inline]
pub fn create_random__m256bh() -> __m256bh {
    let arr = common::get_random_float32_array::<16>();
    create__m256bh_from_f32_array(arr)
}

#[inline]
pub fn create__m512_from(vals: [f32; 16]) -> __m512 {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m512() -> __m512 {
    let arr = common::get_random_float32_array::<16>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m512d_from(vals: [f64; 8]) -> __m512d {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m512d() -> __m512d {
    let arr = common::get_random_float64_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m512i_from(vals: [i64; 8]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512i_from_i32_array(vals: [i32; 16]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512i_from_i16_array(vals: [i16; 32]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512i_from_i8_array(vals: [i8; 64]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512i_from_u32_array(vals: [u32; 16]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512i_from_u16_array(vals: [u16; 32]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512i_from_u8_array(vals: [u8; 64]) -> __m512i {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random__m512i() -> __m512i {
    let arr = common::get_random_i64_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m512bh_from(vals: [u16; 32]) -> __m512bh {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create__m512bh_from_f32_array(vals: [f32; 32]) -> __m512bh {
    let bits: [u16; 32] = std::array::from_fn(|i| (vals[i].to_bits() >> 16) as u16);
    unsafe { std::mem::transmute(bits) }
}

#[inline]
pub fn create_random__m512bh() -> __m512bh {
    let arr = common::get_random_float32_array::<32>();
    create__m512bh_from_f32_array(arr)
}

#[inline]
pub fn create__mmask8_from(val: u8) -> __mmask8 {
    val
}

#[inline]
pub fn create_random__mmask8() -> __mmask8 {
    rand::random::<u8>()
}

#[inline]
pub fn create__mmask16_from(val: u16) -> __mmask16 {
    val
}

#[inline]
pub fn create_random__mmask16() -> __mmask16 {
    rand::random::<u16>()
}

#[inline]
pub fn create__mmask32_from(val: u32) -> __mmask32 {
    val
}

#[inline]
pub fn create_random__mmask32() -> __mmask32 {
    rand::random::<u32>()
}

#[inline]
pub fn create__mmask64_from(val: u64) -> __mmask64 {
    val
}

#[inline]
pub fn create_random__mmask64() -> __mmask64 {
    rand::random::<u64>()
}

// Unpacking functions - convert SIMD types back to arrays

#[inline]
pub fn unpack__m128_to_f32_array(val: __m128) -> [f32; 4] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128d_to_f64_array(val: __m128d) -> [f64; 2] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_i8_array(val: __m128i) -> [i8; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_i16_array(val: __m128i) -> [i16; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_i32_array(val: __m128i) -> [i32; 4] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_i64_array(val: __m128i) -> [i64; 2] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_u8_array(val: __m128i) -> [u8; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_u16_array(val: __m128i) -> [u16; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_u32_array(val: __m128i) -> [u32; 4] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m128i_to_u64_array(val: __m128i) -> [u64; 2] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256_to_f32_array(val: __m256) -> [f32; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256d_to_f64_array(val: __m256d) -> [f64; 4] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_i8_array(val: __m256i) -> [i8; 32] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_i16_array(val: __m256i) -> [i16; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_i32_array(val: __m256i) -> [i32; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_i64_array(val: __m256i) -> [i64; 4] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_u8_array(val: __m256i) -> [u8; 32] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_u16_array(val: __m256i) -> [u16; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_u32_array(val: __m256i) -> [u32; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m256i_to_u64_array(val: __m256i) -> [u64; 4] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512_to_f32_array(val: __m512) -> [f32; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512d_to_f64_array(val: __m512d) -> [f64; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_i8_array(val: __m512i) -> [i8; 64] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_i16_array(val: __m512i) -> [i16; 32] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_i32_array(val: __m512i) -> [i32; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_i64_array(val: __m512i) -> [i64; 8] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_u8_array(val: __m512i) -> [u8; 64] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_u16_array(val: __m512i) -> [u16; 32] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_u32_array(val: __m512i) -> [u32; 16] {
    unsafe { std::mem::transmute(val) }
}

#[inline]
pub fn unpack__m512i_to_u64_array(val: __m512i) -> [u64; 8] {
    unsafe { std::mem::transmute(val) }
}
// Unstable - use, when will be stabilized
// #[inline]
// pub fn create_random_bf16() -> bf16 {
//     create_bf16_from(common::get_random_float())
// }
// #[inline]
// pub fn create__m128h_from(val: f32) -> __m128h {
//     let f16_val = f16::from_f32(val);
//     __m128h([f16_val; 8])
// }
//
// #[inline]
// pub fn create_random__m128h() -> __m128h {
//     let arr = std::array::from_fn(|_| f16::from_f32(common::get_random_float()));
//     __m128h(arr)
// }
// #[inline]
// pub fn create__m256h_from(val: f32) -> __m256h {
//     let f16_val = f16::from_f32(val);
//     __m256h([f16_val; 16])
// }
//
// #[inline]
// pub fn create_random__m256h() -> __m256h {
//     let arr = std::array::from_fn(|_| f16::from_f32(common::get_random_float()));
//     __m256h(arr)
// }
// #[inline]
// pub fn create__m512h_from(val: f32) -> __m512h {
//     let f16_val = f16::from_f32(val);
//     __m512h([f16_val; 32])
// }
//
// #[inline]
// pub fn create_random__m512h() -> __m512h {
//     let arr = std::array::from_fn(|_| f16::from_f32(common::get_random_float()));
//     __m512h(arr)
// }
//
// #[inline]
// pub fn create_bf16_from(val: f32) -> bf16 {
//     let bits = (val.to_bits() >> 16) as u16;
//     bf16(bits)
// }

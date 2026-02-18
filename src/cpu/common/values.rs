#![allow(non_snake_case)]
use std::arch::x86_64::*;
use crate::cpu::common;

#[inline]
pub fn create__m128_from(val: f32) -> __m128 {
    unsafe { std::mem::transmute([val, val, val, val]) }
}

#[inline]
pub fn create_random__m128() -> __m128 {
    let arr = common::get_random_float32_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m128d_from(val: f64) -> __m128d {
    unsafe { std::mem::transmute([val, val]) }
}

#[inline]
pub fn create_random__m128d() -> __m128d {
    let arr = common::get_random_float64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m128i_from(val: i64) -> __m128i {
    unsafe { std::mem::transmute([val, val]) }
}

#[inline]
pub fn create_random__m128i() -> __m128i {
    let arr = common::get_random_i64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m128bh_from(val: f32) -> __m128bh {
    let bf16_bits = (val.to_bits() >> 16) as u16;
    unsafe { std::mem::transmute([bf16_bits; 8]) }
}

#[inline]
pub fn create__m128bh_from_array(vals: [f32; 4]) -> __m128bh {
    let mut bits = [0u16; 8];
    for i in 0..4 {
        bits[i] = (vals[i].to_bits() >> 16) as u16;
    }
    unsafe { std::mem::transmute(bits) }
}

#[inline]
pub fn create_random__m128bh() -> __m128bh {
    let arr = common::get_random_float32_array::<4>();
    create__m128bh_from_array(arr)
}


#[inline]
pub fn create__m256_from(val: f32) -> __m256 {
    unsafe { std::mem::transmute([val; 8]) }
}

#[inline]
pub fn create_random__m256() -> __m256 {
    let arr = common::get_random_float32_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m256d_from(val: f64) -> __m256d {
    unsafe { std::mem::transmute([val; 4]) }
}

#[inline]
pub fn create_random__m256d() -> __m256d {
    let arr = common::get_random_float64_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m256i_from(val: i64) -> __m256i {
    unsafe { std::mem::transmute([val; 4]) }
}

#[inline]
pub fn create_random__m256i() -> __m256i {
    let arr = common::get_random_i64_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m256bh_from(val: f32) -> __m256bh {
    let bf16_bits = (val.to_bits() >> 16) as u16;
    unsafe { std::mem::transmute([bf16_bits; 16]) }
}

#[inline]
pub fn create_random__m256bh() -> __m256bh {
    let arr = common::get_random_float32_array::<16>();
    let bits: [u16; 16] = std::array::from_fn(|i| (arr[i].to_bits() >> 16) as u16);
    unsafe { std::mem::transmute(bits) }
}


#[inline]
pub fn create__m512_from(val: f32) -> __m512 {
    unsafe { std::mem::transmute([val; 16]) }
}

#[inline]
pub fn create_random__m512() -> __m512 {
    let arr = common::get_random_float32_array::<16>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m512d_from(val: f64) -> __m512d {
    unsafe { std::mem::transmute([val; 8]) }
}

#[inline]
pub fn create_random__m512d() -> __m512d {
    let arr = common::get_random_float64_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m512i_from(val: i64) -> __m512i {
    unsafe { std::mem::transmute([val; 8]) }
}

#[inline]
pub fn create_random__m512i() -> __m512i {
    let arr = common::get_random_i64_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn create__m512bh_from(val: f32) -> __m512bh {
    let bf16_bits = (val.to_bits() >> 16) as u16;
    unsafe { std::mem::transmute([bf16_bits; 32]) }
}

#[inline]
pub fn create_random__m512bh() -> __m512bh {
    let arr = common::get_random_float32_array::<32>();
    let bits: [u16; 32] = std::array::from_fn(|i| (arr[i].to_bits() >> 16) as u16);
    unsafe { std::mem::transmute(bits) }
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
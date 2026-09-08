#![allow(non_snake_case)]
#![allow(non_camel_case_types)]

#[cfg(target_arch = "arm")]
use std::arch::arm::*;
#[cfg(target_arch = "aarch64")]
use std::arch::aarch64::*;

use crate::cpu::common;

#[inline]
pub fn create_int8x8_t_from(vals: [i8; 8]) -> int8x8_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int8x8_t() -> int8x8_t {
    let arr = common::get_random_i8_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int8x8_t_to_i8_array(v: int8x8_t) -> [i8; 8] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int8x16_t_from(vals: [i8; 16]) -> int8x16_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int8x16_t() -> int8x16_t {
    let arr = common::get_random_i8_array::<16>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int8x16_t_to_i8_array(v: int8x16_t) -> [i8; 16] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int16x4_t_from(vals: [i16; 4]) -> int16x4_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int16x4_t() -> int16x4_t {
    let arr = common::get_random_i16_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int16x4_t_to_i16_array(v: int16x4_t) -> [i16; 4] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int16x8_t_from(vals: [i16; 8]) -> int16x8_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int16x8_t() -> int16x8_t {
    let arr = common::get_random_i16_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int16x8_t_to_i16_array(v: int16x8_t) -> [i16; 8] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int32x2_t_from(vals: [i32; 2]) -> int32x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int32x2_t() -> int32x2_t {
    let arr = common::get_random_i32_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int32x2_t_to_i32_array(v: int32x2_t) -> [i32; 2] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int32x4_t_from(vals: [i32; 4]) -> int32x4_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int32x4_t() -> int32x4_t {
    let arr = common::get_random_i32_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int32x4_t_to_i32_array(v: int32x4_t) -> [i32; 4] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int64x1_t_from(vals: [i64; 1]) -> int64x1_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int64x1_t() -> int64x1_t {
    let arr = common::get_random_i64_array::<1>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int64x1_t_to_i64_array(v: int64x1_t) -> [i64; 1] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_int64x2_t_from(vals: [i64; 2]) -> int64x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_int64x2_t() -> int64x2_t {
    let arr = common::get_random_i64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_int64x2_t_to_i64_array(v: int64x2_t) -> [i64; 2] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint8x8_t_from(vals: [u8; 8]) -> uint8x8_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint8x8_t() -> uint8x8_t {
    let arr = common::get_random_u8_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint8x8_t_to_u8_array(v: uint8x8_t) -> [u8; 8] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint8x16_t_from(vals: [u8; 16]) -> uint8x16_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint8x16_t() -> uint8x16_t {
    let arr = common::get_random_u8_array::<16>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint8x16_t_to_u8_array(v: uint8x16_t) -> [u8; 16] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint16x4_t_from(vals: [u16; 4]) -> uint16x4_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint16x4_t() -> uint16x4_t {
    let arr = common::get_random_u16_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint16x4_t_to_u16_array(v: uint16x4_t) -> [u16; 4] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint16x8_t_from(vals: [u16; 8]) -> uint16x8_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint16x8_t() -> uint16x8_t {
    let arr = common::get_random_u16_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint16x8_t_to_u16_array(v: uint16x8_t) -> [u16; 8] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint32x2_t_from(vals: [u32; 2]) -> uint32x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint32x2_t() -> uint32x2_t {
    let arr = common::get_random_u32_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint32x2_t_to_u32_array(v: uint32x2_t) -> [u32; 2] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint32x4_t_from(vals: [u32; 4]) -> uint32x4_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint32x4_t() -> uint32x4_t {
    let arr = common::get_random_u32_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint32x4_t_to_u32_array(v: uint32x4_t) -> [u32; 4] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint64x1_t_from(vals: [u64; 1]) -> uint64x1_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint64x1_t() -> uint64x1_t {
    let arr = common::get_random_u64_array::<1>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint64x1_t_to_u64_array(v: uint64x1_t) -> [u64; 1] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_uint64x2_t_from(vals: [u64; 2]) -> uint64x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_uint64x2_t() -> uint64x2_t {
    let arr = common::get_random_u64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_uint64x2_t_to_u64_array(v: uint64x2_t) -> [u64; 2] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_float32x2_t_from(vals: [f32; 2]) -> float32x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_float32x2_t() -> float32x2_t {
    let arr = common::get_random_float32_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_float32x2_t_to_f32_array(v: float32x2_t) -> [f32; 2] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_float32x4_t_from(vals: [f32; 4]) -> float32x4_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_float32x4_t() -> float32x4_t {
    let arr = common::get_random_float32_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_float32x4_t_to_f32_array(v: float32x4_t) -> [f32; 4] {
    unsafe { std::mem::transmute(v) }
}

// float64x1_t/float64x2_t are aarch64-only (defined in aarch64/neon/mod.rs, not
// arm_shared/neon/mod.rs) - arm32 NEON has no double-precision float vector support at all.
#[cfg(target_arch = "aarch64")]
#[inline]
pub fn create_float64x1_t_from(vals: [f64; 1]) -> float64x1_t {
    unsafe { std::mem::transmute(vals) }
}

#[cfg(target_arch = "aarch64")]
#[inline]
pub fn create_random_float64x1_t() -> float64x1_t {
    let arr = common::get_random_float64_array::<1>();
    unsafe { std::mem::transmute(arr) }
}

#[cfg(target_arch = "aarch64")]
#[inline]
pub fn unpack_float64x1_t_to_f64_array(v: float64x1_t) -> [f64; 1] {
    unsafe { std::mem::transmute(v) }
}

#[cfg(target_arch = "aarch64")]
#[inline]
pub fn create_float64x2_t_from(vals: [f64; 2]) -> float64x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[cfg(target_arch = "aarch64")]
#[inline]
pub fn create_random_float64x2_t() -> float64x2_t {
    let arr = common::get_random_float64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[cfg(target_arch = "aarch64")]
#[inline]
pub fn unpack_float64x2_t_to_f64_array(v: float64x2_t) -> [f64; 2] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_poly8x8_t_from(vals: [u8; 8]) -> poly8x8_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_poly8x8_t() -> poly8x8_t {
    let arr = common::get_random_u8_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_poly8x8_t_to_u8_array(v: poly8x8_t) -> [u8; 8] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_poly8x16_t_from(vals: [u8; 16]) -> poly8x16_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_poly8x16_t() -> poly8x16_t {
    let arr = common::get_random_u8_array::<16>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_poly8x16_t_to_u8_array(v: poly8x16_t) -> [u8; 16] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_poly16x4_t_from(vals: [u16; 4]) -> poly16x4_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_poly16x4_t() -> poly16x4_t {
    let arr = common::get_random_u16_array::<4>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_poly16x4_t_to_u16_array(v: poly16x4_t) -> [u16; 4] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_poly16x8_t_from(vals: [u16; 8]) -> poly16x8_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_poly16x8_t() -> poly16x8_t {
    let arr = common::get_random_u16_array::<8>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_poly16x8_t_to_u16_array(v: poly16x8_t) -> [u16; 8] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_poly64x1_t_from(vals: [u64; 1]) -> poly64x1_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_poly64x1_t() -> poly64x1_t {
    let arr = common::get_random_u64_array::<1>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_poly64x1_t_to_u64_array(v: poly64x1_t) -> [u64; 1] {
    unsafe { std::mem::transmute(v) }
}

#[inline]
pub fn create_poly64x2_t_from(vals: [u64; 2]) -> poly64x2_t {
    unsafe { std::mem::transmute(vals) }
}

#[inline]
pub fn create_random_poly64x2_t() -> poly64x2_t {
    let arr = common::get_random_u64_array::<2>();
    unsafe { std::mem::transmute(arr) }
}

#[inline]
pub fn unpack_poly64x2_t_to_u64_array(v: poly64x2_t) -> [u64; 2] {
    unsafe { std::mem::transmute(v) }
}


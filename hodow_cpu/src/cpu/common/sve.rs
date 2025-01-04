#![allow(non_snake_case)]
#![allow(non_camel_case_types)]

use std::arch::aarch64::*;

#[target_feature(enable = "sve")]
pub fn create_svbool_t() -> svbool_t {
    svptrue_b8()
}

#[target_feature(enable = "sve")]
pub fn create_svint8_t_from(val: i8) -> svint8_t {
    svdup_n_s8(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svint8_t() -> svint8_t {
    svdup_n_s8(rand::random::<i8>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svint8_t_to_i8_array(v: svint8_t) -> [i8; 1] {
    [svlastb_s8(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svuint8_t_from(val: u8) -> svuint8_t {
    svdup_n_u8(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svuint8_t() -> svuint8_t {
    svdup_n_u8(rand::random::<u8>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svuint8_t_to_u8_array(v: svuint8_t) -> [u8; 1] {
    [svlastb_u8(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svint16_t_from(val: i16) -> svint16_t {
    svdup_n_s16(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svint16_t() -> svint16_t {
    svdup_n_s16(rand::random::<i16>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svint16_t_to_i16_array(v: svint16_t) -> [i16; 1] {
    [svlastb_s16(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svuint16_t_from(val: u16) -> svuint16_t {
    svdup_n_u16(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svuint16_t() -> svuint16_t {
    svdup_n_u16(rand::random::<u16>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svuint16_t_to_u16_array(v: svuint16_t) -> [u16; 1] {
    [svlastb_u16(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svint32_t_from(val: i32) -> svint32_t {
    svdup_n_s32(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svint32_t() -> svint32_t {
    svdup_n_s32(rand::random::<i32>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svint32_t_to_i32_array(v: svint32_t) -> [i32; 1] {
    [svlastb_s32(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svuint32_t_from(val: u32) -> svuint32_t {
    svdup_n_u32(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svuint32_t() -> svuint32_t {
    svdup_n_u32(rand::random::<u32>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svuint32_t_to_u32_array(v: svuint32_t) -> [u32; 1] {
    [svlastb_u32(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svint64_t_from(val: i64) -> svint64_t {
    svdup_n_s64(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svint64_t() -> svint64_t {
    svdup_n_s64(rand::random::<i64>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svint64_t_to_i64_array(v: svint64_t) -> [i64; 1] {
    [svlastb_s64(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svuint64_t_from(val: u64) -> svuint64_t {
    svdup_n_u64(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svuint64_t() -> svuint64_t {
    svdup_n_u64(rand::random::<u64>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svuint64_t_to_u64_array(v: svuint64_t) -> [u64; 1] {
    [svlastb_u64(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svfloat32_t_from(val: f32) -> svfloat32_t {
    svdup_n_f32(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svfloat32_t() -> svfloat32_t {
    svdup_n_f32(rand::random::<f32>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svfloat32_t_to_f32_array(v: svfloat32_t) -> [f32; 1] {
    [svlastb_f32(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn create_svfloat64_t_from(val: f64) -> svfloat64_t {
    svdup_n_f64(val)
}

#[target_feature(enable = "sve")]
pub fn create_random_svfloat64_t() -> svfloat64_t {
    svdup_n_f64(rand::random::<f64>())
}

#[target_feature(enable = "sve")]
pub fn unpack_svfloat64_t_to_f64_array(v: svfloat64_t) -> [f64; 1] {
    [svlastb_f64(svptrue_b8(), v)]
}

#[target_feature(enable = "sve")]
pub fn unpack_svbool_t_to_i32_array(v: svbool_t) -> [i32; 1] {
    [svptest_any(svptrue_b8(), v) as i32]
}

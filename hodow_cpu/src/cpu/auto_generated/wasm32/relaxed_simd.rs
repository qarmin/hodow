mod f32x4;
mod f64x2;
mod i16x8;
mod i32x4;
mod i64x2;
mod i8x16;
mod u32x4;

use crate::cpu::auto_generated::wasm32::relaxed_simd::f32x4::*;
use crate::cpu::auto_generated::wasm32::relaxed_simd::f64x2::*;
use crate::cpu::auto_generated::wasm32::relaxed_simd::i16x8::*;
use crate::cpu::auto_generated::wasm32::relaxed_simd::i32x4::*;
use crate::cpu::auto_generated::wasm32::relaxed_simd::i64x2::*;
use crate::cpu::auto_generated::wasm32::relaxed_simd::i8x16::*;
use crate::cpu::auto_generated::wasm32::relaxed_simd::u32x4::*;

use crate::cpu::{ExtensionTest, TestFunction};

#[allow(non_camel_case_types)]
pub struct RELAXED_SIMD;

impl ExtensionTest for RELAXED_SIMD {
    fn get_name() -> &'static str {
        "wasm32::RELAXED_SIMD"
    }

    fn get_tests() -> &'static [(TestFunction, &'static str)] {
        &[
            (test_wasm32_relaxed_simd_i8x16_relaxed_swizzle, "test_wasm32_relaxed_simd_i8x16_relaxed_swizzle"),
            (test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f32x4, "test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f32x4"),
            (test_wasm32_relaxed_simd_u32x4_relaxed_trunc_f32x4, "test_wasm32_relaxed_simd_u32x4_relaxed_trunc_f32x4"),
            (test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f64x2_zero, "test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f64x2_zero"),
            (test_wasm32_relaxed_simd_u32x4_relaxed_trunc_f64x2_zero, "test_wasm32_relaxed_simd_u32x4_relaxed_trunc_f64x2_zero"),
            (test_wasm32_relaxed_simd_f32x4_relaxed_madd, "test_wasm32_relaxed_simd_f32x4_relaxed_madd"),
            (test_wasm32_relaxed_simd_f32x4_relaxed_nmadd, "test_wasm32_relaxed_simd_f32x4_relaxed_nmadd"),
            (test_wasm32_relaxed_simd_f64x2_relaxed_madd, "test_wasm32_relaxed_simd_f64x2_relaxed_madd"),
            (test_wasm32_relaxed_simd_f64x2_relaxed_nmadd, "test_wasm32_relaxed_simd_f64x2_relaxed_nmadd"),
            (test_wasm32_relaxed_simd_i8x16_relaxed_laneselect, "test_wasm32_relaxed_simd_i8x16_relaxed_laneselect"),
            (test_wasm32_relaxed_simd_i16x8_relaxed_laneselect, "test_wasm32_relaxed_simd_i16x8_relaxed_laneselect"),
            (test_wasm32_relaxed_simd_i32x4_relaxed_laneselect, "test_wasm32_relaxed_simd_i32x4_relaxed_laneselect"),
            (test_wasm32_relaxed_simd_i64x2_relaxed_laneselect, "test_wasm32_relaxed_simd_i64x2_relaxed_laneselect"),
            (test_wasm32_relaxed_simd_f32x4_relaxed_min, "test_wasm32_relaxed_simd_f32x4_relaxed_min"),
            (test_wasm32_relaxed_simd_f32x4_relaxed_max, "test_wasm32_relaxed_simd_f32x4_relaxed_max"),
            (test_wasm32_relaxed_simd_f64x2_relaxed_min, "test_wasm32_relaxed_simd_f64x2_relaxed_min"),
            (test_wasm32_relaxed_simd_f64x2_relaxed_max, "test_wasm32_relaxed_simd_f64x2_relaxed_max"),
            (test_wasm32_relaxed_simd_i16x8_relaxed_q15mulr, "test_wasm32_relaxed_simd_i16x8_relaxed_q15mulr"),
            (test_wasm32_relaxed_simd_i16x8_relaxed_dot_i8x16_i7x16, "test_wasm32_relaxed_simd_i16x8_relaxed_dot_i8x16_i7x16"),
            (test_wasm32_relaxed_simd_i32x4_relaxed_dot_i8x16_i7x16_add, "test_wasm32_relaxed_simd_i32x4_relaxed_dot_i8x16_i7x16_add"),
        ]
    }
}

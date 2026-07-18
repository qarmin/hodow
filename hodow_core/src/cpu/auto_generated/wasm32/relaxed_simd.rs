mod part1;

use crate::cpu::auto_generated::wasm32::relaxed_simd::part1::*;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct RELAXED_SIMD;

impl ExtensionTest for RELAXED_SIMD {
    fn get_name() -> &'static str {
        "wasm32::RELAXED_SIMD"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_i8x16_relaxed_swizzle, "test_i8x16_relaxed_swizzle"),
            (&test_i32x4_relaxed_trunc_f32x4, "test_i32x4_relaxed_trunc_f32x4"),
            (&test_u32x4_relaxed_trunc_f32x4, "test_u32x4_relaxed_trunc_f32x4"),
            (&test_i32x4_relaxed_trunc_f64x2_zero, "test_i32x4_relaxed_trunc_f64x2_zero"),
            (&test_u32x4_relaxed_trunc_f64x2_zero, "test_u32x4_relaxed_trunc_f64x2_zero"),
            (&test_f32x4_relaxed_madd, "test_f32x4_relaxed_madd"),
            (&test_f32x4_relaxed_nmadd, "test_f32x4_relaxed_nmadd"),
            (&test_f64x2_relaxed_madd, "test_f64x2_relaxed_madd"),
            (&test_f64x2_relaxed_nmadd, "test_f64x2_relaxed_nmadd"),
            (&test_i8x16_relaxed_laneselect, "test_i8x16_relaxed_laneselect"),
            (&test_i16x8_relaxed_laneselect, "test_i16x8_relaxed_laneselect"),
            (&test_i32x4_relaxed_laneselect, "test_i32x4_relaxed_laneselect"),
            (&test_i64x2_relaxed_laneselect, "test_i64x2_relaxed_laneselect"),
            (&test_f32x4_relaxed_min, "test_f32x4_relaxed_min"),
            (&test_f32x4_relaxed_max, "test_f32x4_relaxed_max"),
            (&test_f64x2_relaxed_min, "test_f64x2_relaxed_min"),
            (&test_f64x2_relaxed_max, "test_f64x2_relaxed_max"),
            (&test_i16x8_relaxed_q15mulr, "test_i16x8_relaxed_q15mulr"),
            (&test_i16x8_relaxed_dot_i8x16_i7x16, "test_i16x8_relaxed_dot_i8x16_i7x16"),
            (&test_i32x4_relaxed_dot_i8x16_i7x16_add, "test_i32x4_relaxed_dot_i8x16_i7x16_add"),
        ]
    }
}

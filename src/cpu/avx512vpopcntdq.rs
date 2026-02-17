use std::arch::x86_64::*;

use crate::cpu::common::{get_random_i32_array, get_random_i64_array};
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512VPOPCNTDQ;

impl ExtensionTest for AVX512VPOPCNTDQ {
    fn get_name() -> &'static str {
        "AVX512VPOPCNTDQ"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_popcnt_epi32, "test_mm_popcnt_epi32"),
            (&test_mm_maskz_popcnt_epi32, "test_mm_maskz_popcnt_epi32"),
            (&test_mm_mask_popcnt_epi32, "test_mm_mask_popcnt_epi32"),
            (&test_mm_popcnt_epi64, "test_mm_popcnt_epi64"),
            (&test_mm_maskz_popcnt_epi64, "test_mm_maskz_popcnt_epi64"),
            (&test_mm_mask_popcnt_epi64, "test_mm_mask_popcnt_epi64"),
        ]
    }
}

// Implementations
fn test_mm_popcnt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0_i32, 1, 3, 4294967295_i32);
        let r = _mm_popcnt_epi32(a);
        let _out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
    }
    if crate::get_fuzzing() {
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_popcnt_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_popcnt_epi32() -> Result<(), String> {
    test_mm_popcnt_epi32()
}
fn test_mm_mask_popcnt_epi32() -> Result<(), String> {
    test_mm_popcnt_epi32()
}
fn test_mm_popcnt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0, -1);
        let r = _mm_popcnt_epi64(a);
        let _out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
    }
    if crate::get_fuzzing() {
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _mm_popcnt_epi64(_mm_set1_epi64x(get_random_i64_array::<2>()[0]));
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_popcnt_epi64() -> Result<(), String> {
    test_mm_popcnt_epi64()
}
fn test_mm_mask_popcnt_epi64() -> Result<(), String> {
    test_mm_popcnt_epi64()
}

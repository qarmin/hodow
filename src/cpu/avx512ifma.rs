#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::cpu::common::check_array_equality;
use crate::get_fuzzing;

pub struct AVX512IFMA;

impl ExtensionTest for AVX512IFMA {
    fn get_name() -> &'static str {
        "AVX-512 IFMA"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            // (&test_mm_madd52hi_avx_epu64, "test_mm_madd52hi_avx_epu64"), // crashes, why? I don't know
            (&test_mm_madd52hi_epu64, "test_mm_madd52hi_epu64"),
            (&test_mm_mask_madd52hi_epu64, "test_mm_mask_madd52hi_epu64"),
            (&test_mm_maskz_madd52hi_epu64, "test_mm_maskz_madd52hi_epu64"),
            // (&test_mm_madd52lo_avx_epu64, "test_mm_madd52lo_avx_epu64"), // crashes, why? I don't know
            (&test_mm_madd52lo_epu64, "test_mm_madd52lo_epu64"),
            (&test_mm_mask_madd52lo_epu64, "test_mm_mask_madd52lo_epu64"),
            (&test_mm_maskz_madd52lo_epu64, "test_mm_maskz_madd52lo_epu64"),
        ]
    }
}

fn test_mm_madd52hi_avx_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52hi_avx_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);

        check_array_equality(&result, &[1000u64, 1000u64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_madd52hi_avx_epu64(a, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_madd52lo_avx_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52lo_avx_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        check_array_equality(&result, &[2000u64, 2000u64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_madd52lo_avx_epu64(a, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_madd52hi_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52hi_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        check_array_equality(&result, &[1000u64, 1000u64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_madd52hi_epu64(a, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_madd52hi_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let _result = _mm_mask_madd52hi_epu64(a, 0x3, b, c);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_mask_madd52hi_epu64(a, 0x3, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_madd52hi_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let _result = _mm_maskz_madd52hi_epu64(0x3, a, b, c);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_maskz_madd52hi_epu64(0x3, a, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_madd52lo_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52lo_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        check_array_equality(&result, &[201000, 201000])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_madd52lo_epu64(a, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_madd52lo_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let _result = _mm_mask_madd52lo_epu64(a, 0x3, b, c);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_mask_madd52lo_epu64(a, 0x3, b, c);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_madd52lo_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let _result = _mm_maskz_madd52lo_epu64(0x3, a, b, c);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set1_epi64x(rand::random());
                let b = _mm_set1_epi64x(rand::random());
                let c = _mm_set1_epi64x(rand::random());
                let _ = _mm_maskz_madd52lo_epu64(0x3, a, b, c);
            }
        }
    }

    Ok(())
}

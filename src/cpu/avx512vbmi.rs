#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::ExtensionTest;

pub struct AVX512VBMI;

impl ExtensionTest for AVX512VBMI {
    fn get_name() -> &'static str {
        "AVX-512 VBMI"
    }
    
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_permutex2var_epi8, "test_mm_permutex2var_epi8"),
            (&test_mm_mask_permutex2var_epi8, "test_mm_mask_permutex2var_epi8"),
            (&test_mm_maskz_permutex2var_epi8, "test_mm_maskz_permutex2var_epi8"),
            (&test_mm_mask2_permutex2var_epi8, "test_mm_mask2_permutex2var_epi8"),
            (&test_mm_permutexvar_epi8, "test_mm_permutexvar_epi8"),
            (&test_mm_mask_permutexvar_epi8, "test_mm_mask_permutexvar_epi8"),
            (&test_mm_maskz_permutexvar_epi8, "test_mm_maskz_permutexvar_epi8"),
            (&test_mm_multishift_epi64_epi8, "test_mm_multishift_epi64_epi8"),
            (&test_mm_mask_multishift_epi64_epi8, "test_mm_mask_multishift_epi64_epi8"),
            (&test_mm_maskz_multishift_epi64_epi8, "test_mm_maskz_multishift_epi64_epi8"),
        ]
    }
}

fn test_mm_permutex2var_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let _result = _mm_permutex2var_epi8(a, idx, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_mask_permutex2var_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let _result = _mm_mask_permutex2var_epi8(a, 0xFFFF, idx, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_permutex2var_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let _result = _mm_maskz_permutex2var_epi8(0xFFFF, a, idx, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_mask2_permutex2var_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let _result = _mm_mask2_permutex2var_epi8(a, idx, 0xFFFF, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_permutexvar_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let a = _mm_set1_epi8(42);
        let _result = _mm_permutexvar_epi8(idx, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_mask_permutexvar_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let src = _mm_set1_epi8(0);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let a = _mm_set1_epi8(42);
        let _result = _mm_mask_permutexvar_epi8(src, 0xFFFF, idx, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_permutexvar_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let a = _mm_set1_epi8(42);
        let _result = _mm_maskz_permutexvar_epi8(0xFFFF, idx, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_multishift_epi64_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(2);
        let b = _mm_set1_epi64x(0x0102030405060708u64 as i64);
        let _result = _mm_multishift_epi64_epi8(a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_mask_multishift_epi64_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let src = _mm_set1_epi8(0);
        let a = _mm_set1_epi8(2);
        let b = _mm_set1_epi64x(0x0102030405060708u64 as i64);
        let _result = _mm_mask_multishift_epi64_epi8(src, 0xFFFF, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_multishift_epi64_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512vbmi,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(2);
        let b = _mm_set1_epi64x(0x0102030405060708u64 as i64);
        let _result = _mm_maskz_multishift_epi64_epi8(0xFFFF, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512vbmi,avx512vl"))]
    Ok(())
}

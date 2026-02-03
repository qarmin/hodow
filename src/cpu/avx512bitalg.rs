#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::ExtensionTest;

pub struct AVX512BITALG;

impl ExtensionTest for AVX512BITALG {
    fn get_name() -> &'static str {
        "AVX-512 BITALG"
    }
    
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_popcnt_epi16, "test_mm_popcnt_epi16"),
            (&test_mm_maskz_popcnt_epi16, "test_mm_maskz_popcnt_epi16"),
            (&test_mm_mask_popcnt_epi16, "test_mm_mask_popcnt_epi16"),
            (&test_mm_popcnt_epi8, "test_mm_popcnt_epi8"),
            (&test_mm_maskz_popcnt_epi8, "test_mm_maskz_popcnt_epi8"),
            (&test_mm_mask_popcnt_epi8, "test_mm_mask_popcnt_epi8"),
            (&test_mm_bitshuffle_epi64_mask, "test_mm_bitshuffle_epi64_mask"),
            (&test_mm_mask_bitshuffle_epi64_mask, "test_mm_mask_bitshuffle_epi64_mask"),
        ]
    }
}

fn test_mm_popcnt_epi16() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let a = _mm_set1_epi16(0b1111_0000_1010_0101u16 as i16);
        let result = _mm_popcnt_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Count of 1 bits = 8
        if result[0] != 8 {
            return Err(format!("Expected 8, got {}", result[0]));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_popcnt_epi16() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let a = _mm_set1_epi16(0b1111_1111i16);
        let result = _mm_maskz_popcnt_epi16(0b11110000, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Lower 4 elements zeroed by mask
        if result[0] != 0 || result[4] != 8 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_mask_popcnt_epi16() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let src = _mm_set1_epi16(100);
        let a = _mm_set1_epi16(0b1111_1111i16);
        let result = _mm_mask_popcnt_epi16(src, 0b11110000, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // Lower 4 elements from src
        if result[0] != 100 || result[4] != 8 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_popcnt_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(0b1111_0000u8 as i8);
        let result = _mm_popcnt_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Count of 1 bits = 4
        if result[0] != 4 {
            return Err(format!("Expected 4, got {}", result[0]));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_popcnt_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(0b1111_1111u8 as i8);
        let result = _mm_maskz_popcnt_epi8(0xFF00, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Lower 8 elements zeroed
        if result[0] != 0 || result[8] != 8 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_mask_popcnt_epi8() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let src = _mm_set1_epi8(100);
        let a = _mm_set1_epi8(0b1111_1111u8 as i8);
        let result = _mm_mask_popcnt_epi8(src, 0xFF00, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // Lower 8 from src
        if result[0] != 100 || result[8] != 8 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_bitshuffle_epi64_mask() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(0b1010_1010u8 as i8);
        let b = _mm_set1_epi8(0);
        let _result = _mm_bitshuffle_epi64_mask(a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

fn test_mm_mask_bitshuffle_epi64_mask() -> Result<(), String> {
    #[cfg(target_feature = "avx512bitalg,avx512vl")]
    unsafe {
        let a = _mm_set1_epi8(0b1010_1010u8 as i8);
        let b = _mm_set1_epi8(0);
        let _result = _mm_mask_bitshuffle_epi64_mask(0xFF, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bitalg,avx512vl"))]
    Ok(())
}

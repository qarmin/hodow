#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::common::check_array_equality;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct AVX512BITALG;

impl ExtensionTest for AVX512BITALG {
    fn get_name() -> &'static str {
        "AVX-512 BITALG"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
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
    unsafe {
        let a = _mm_set1_epi16(0b1111_0000_1010_0101u16 as i16);
        let result = _mm_popcnt_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [8; 8];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_maskz_popcnt_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(0b1111_1111i16);
        let result = _mm_maskz_popcnt_epi16(0b11110000, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [0, 0, 0, 0, 8, 8, 8, 8];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_mask_popcnt_epi16() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi16(100);
        let a = _mm_set1_epi16(0b1111_1111i16);
        let result = _mm_mask_popcnt_epi16(src, 0b11110000, a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        let expected = [100, 100, 100, 100, 8, 8, 8, 8];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_popcnt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0b1111_0000u8 as i8);
        let result = _mm_popcnt_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [4; 16];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_maskz_popcnt_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0b1111_1111u8 as i8);
        let result = _mm_maskz_popcnt_epi8(0xFF00, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_mask_popcnt_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi8(100);
        let a = _mm_set1_epi8(0b1111_1111u8 as i8);
        let result = _mm_mask_popcnt_epi8(src, 0xFF00, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        let expected = [100, 100, 100, 100, 100, 100, 100, 100, 8, 8, 8, 8, 8, 8, 8, 8];
        check_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_bitshuffle_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0b1010_1010u8 as i8);
        let b = _mm_set1_epi8(0);
        let _result = _mm_bitshuffle_epi64_mask(a, b);

        Ok(())
    }
}

fn test_mm_mask_bitshuffle_epi64_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0b1010_1010u8 as i8);
        let b = _mm_set1_epi8(0);
        let _result = _mm_mask_bitshuffle_epi64_mask(0xFF, a, b);

        Ok(())
    }
}

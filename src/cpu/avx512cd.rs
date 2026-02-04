#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::{ExtensionTest, check_int_array_equality, check_int_equality};

pub struct AVX512CD;

impl ExtensionTest for AVX512CD {
    fn get_name() -> &'static str {
        "AVX-512 CD"
    }

    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_broadcastmw_epi32, "test_mm_broadcastmw_epi32"),
            (&test_mm_broadcastmb_epi64, "test_mm_broadcastmb_epi64"),
            (&test_mm_conflict_epi32, "test_mm_conflict_epi32"),
            (&test_mm_mask_conflict_epi32, "test_mm_mask_conflict_epi32"),
            (&test_mm_maskz_conflict_epi32, "test_mm_maskz_conflict_epi32"),
            (&test_mm_conflict_epi64, "test_mm_conflict_epi64"),
            (&test_mm_mask_conflict_epi64, "test_mm_mask_conflict_epi64"),
            (&test_mm_maskz_conflict_epi64, "test_mm_maskz_conflict_epi64"),
            (&test_mm_lzcnt_epi32, "test_mm_lzcnt_epi32"),
            (&test_mm_mask_lzcnt_epi32, "test_mm_mask_lzcnt_epi32"),
            (&test_mm_maskz_lzcnt_epi32, "test_mm_maskz_lzcnt_epi32"),
            (&test_mm_lzcnt_epi64, "test_mm_lzcnt_epi64"),
            (&test_mm_mask_lzcnt_epi64, "test_mm_mask_lzcnt_epi64"),
            (&test_mm_maskz_lzcnt_epi64, "test_mm_maskz_lzcnt_epi64"),
        ]
    }
}

fn test_mm_broadcastmw_epi32() -> Result<(), String> {
    unsafe {
        let k = 0b10101010u16;
        let result = _mm_broadcastmw_epi32(k);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_equality(result[0], 0b10101010)?;
        Ok(())
    }
}

fn test_mm_broadcastmb_epi64() -> Result<(), String> {
    unsafe {
        let k: u16 = 0xFF;
        let result = _mm_broadcastmb_epi64(k.try_into().unwrap());
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        let expected = [0xFF, 0xFF];
        check_int_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_conflict_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 1, 3);
        let _result = _mm_conflict_epi32(a);
        Ok(())
    }
}

fn test_mm_mask_conflict_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi32(0);
        let a = _mm_set_epi32(1, 2, 1, 3);
        let _result = _mm_mask_conflict_epi32(src, 0xF, a);
        Ok(())
    }
}

fn test_mm_maskz_conflict_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 1, 3);
        let _result = _mm_maskz_conflict_epi32(0xF, a);
        Ok(())
    }
}

fn test_mm_conflict_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let _result = _mm_conflict_epi64(a);
        Ok(())
    }
}

fn test_mm_mask_conflict_epi64() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi64x(0);
        let a = _mm_set_epi64x(1, 2);
        let _result = _mm_mask_conflict_epi64(src, 0x3, a);
        Ok(())
    }
}

fn test_mm_maskz_conflict_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let _result = _mm_maskz_conflict_epi64(0x3, a);
        Ok(())
    }
}

fn test_mm_lzcnt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(0x0000_00FF);
        let result = _mm_lzcnt_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_equality(result[0], 24)?;
        Ok(())
    }
}

fn test_mm_mask_lzcnt_epi32() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi32(100);
        let a = _mm_set1_epi32(0x0000_00FF);
        let result = _mm_mask_lzcnt_epi32(src, 0b1100, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_equality(result[0], 100)?;
        check_int_equality(result[2], 24)?;
        Ok(())
    }
}

fn test_mm_maskz_lzcnt_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(0x0000_00FF);
        let result = _mm_maskz_lzcnt_epi32(0b1100, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        if result[0] != 0 || result[2] != 24 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
}

fn test_mm_lzcnt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(0x0000_0000_0000_00FF);
        let result = _mm_lzcnt_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result[0] != 56 {
            return Err(format!("Expected 56 leading zeros, got {}", result[0]));
        }
        Ok(())
    }
}

fn test_mm_mask_lzcnt_epi64() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi64x(100);
        let a = _mm_set1_epi64x(0x0000_0000_0000_00FF);
        let result = _mm_mask_lzcnt_epi64(src, 0b10, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result[0] != 100 || result[1] != 56 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
}

fn test_mm_maskz_lzcnt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(0x0000_0000_0000_00FF);
        let result = _mm_maskz_lzcnt_epi64(0b10, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        if result[0] != 0 || result[1] != 56 {
            return Err(format!("Mask not applied correctly: {:?}", result));
        }
        Ok(())
    }
}

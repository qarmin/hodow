#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::check_array_equality;
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct SSSE3;

impl ExtensionTest for SSSE3 {
    fn get_name() -> &'static str {
        "SSSE3"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_shuffle_epi8, "test_mm_shuffle_epi8"),
            (&test_mm_abs_epi8, "test_mm_abs_epi8"),
            (&test_mm_abs_epi16, "test_mm_abs_epi16"),
            (&test_mm_abs_epi32, "test_mm_abs_epi32"),
            (&test_mm_sign_epi8, "test_mm_sign_epi8"),
            (&test_mm_sign_epi16, "test_mm_sign_epi16"),
            (&test_mm_sign_epi32, "test_mm_sign_epi32"),
            (&test_mm_hadd_epi16, "test_mm_hadd_epi16"),
            (&test_mm_hadd_epi32, "test_mm_hadd_epi32"),
            (&test_mm_hsub_epi16, "test_mm_hsub_epi16"),
            (&test_mm_hsub_epi32, "test_mm_hsub_epi32"),
            (&test_mm_maddubs_epi16, "test_mm_maddubs_epi16"),
            (&test_mm_alignr_epi8, "test_mm_alignr_epi8"),
        ]
    }
}

fn test_mm_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = _mm_shuffle_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let b = _mm_set_epi8(
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                    rand::random(),
                );
                let _result = _mm_shuffle_epi8(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_abs_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(-1, -2, 3, -4, 5, -6, 7, -8, 9, -10, 11, -12, 13, -14, 15, -16);
        let result = _mm_abs_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_abs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(-1, -2, 3, -4, 5, -6, 7, -8);
        let result = _mm_abs_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_abs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-1, -2, 3, -4);
        let result = _mm_abs_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_sign_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(-1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1);
        let result = _mm_sign_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[16, -15, 14, -13, 12, -11, 10, -9, 8, -7, 6, -5, 4, -3, 2, -1])?;
    }

    Ok(())
}

fn test_mm_sign_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(-1, 1, -1, 1, -1, 1, -1, 1);
        let result = _mm_sign_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[8, -7, 6, -5, 4, -3, 2, -1])?;
    }

    Ok(())
}

fn test_mm_sign_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(-1, 1, -1, 1);
        let result = _mm_sign_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[4, -3, 2, -1])?;
    }

    Ok(())
}

fn test_mm_hadd_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm_hadd_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[15, 11, 7, 3, 31, 27, 23, 19])?;
    }

    Ok(())
}

fn test_mm_hadd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_hadd_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[7, 3, 15, 11])?;
    }

    Ok(())
}

fn test_mm_hsub_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm_hsub_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }

    Ok(())
}

fn test_mm_hsub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_hsub_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);

        check_array_equality(&result, &[1, 1, 1, 1])?;
    }

    Ok(())
}

fn test_mm_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
        let result = _mm_maddubs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);

        check_array_equality(&result, &[31, 27, 23, 19, 15, 11, 7, 3])?;
    }

    Ok(())
}

fn test_mm_alignr_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_alignr_epi8::<2>(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1])?;
    }

    Ok(())
}

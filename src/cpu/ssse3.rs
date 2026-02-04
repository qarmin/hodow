#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use log::info;

use crate::cpu::{ExtensionTest, get_iterations, check_int_array_equality};
use crate::{get_four_random_floats, get_fuzzing};

pub struct SSSE3;

impl ExtensionTest for SSSE3 {
    fn get_name() -> &'static str {
        "SSSE3"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
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
        // shuffle takes indices from b and selects from a
        // b = [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0]
        // result should select a[15], a[14], ... a[0]
        check_int_array_equality(&result, &[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi8(rand::random(), rand::random(), rand::random(), rand::random(),
                                    rand::random(), rand::random(), rand::random(), rand::random(),
                                    rand::random(), rand::random(), rand::random(), rand::random(),
                                    rand::random(), rand::random(), rand::random(), rand::random());
                let b = _mm_set_epi8(rand::random(), rand::random(), rand::random(), rand::random(),
                                    rand::random(), rand::random(), rand::random(), rand::random(),
                                    rand::random(), rand::random(), rand::random(), rand::random(),
                                    rand::random(), rand::random(), rand::random(), rand::random());
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
        check_int_array_equality(&result, &[16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_abs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(-1, -2, 3, -4, 5, -6, 7, -8);
        let result = _mm_abs_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_int_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_abs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-1, -2, 3, -4);
        let result = _mm_abs_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm_sign_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(-1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1);
        let result = _mm_sign_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_int_array_equality(&result, &[16, -15, 14, -13, 12, -11, 10, -9, 8, -7, 6, -5, 4, -3, 2, -1])?;
    }

    Ok(())
}

fn test_mm_sign_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(-1, 1, -1, 1, -1, 1, -1, 1);
        let result = _mm_sign_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_int_array_equality(&result, &[8, -7, 6, -5, 4, -3, 2, -1])?;
    }

    Ok(())
}

fn test_mm_sign_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(-1, 1, -1, 1);
        let result = _mm_sign_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[4, -3, 2, -1])?;
    }

    Ok(())
}

fn test_mm_hadd_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm_hadd_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // hadd: [a0+a1, a2+a3, a4+a5, a6+a7, b0+b1, b2+b3, b4+b5, b6+b7]
        // a = [8,7,6,5,4,3,2,1], b = [16,15,14,13,12,11,10,9]
        // result = [8+7, 6+5, 4+3, 2+1, 16+15, 14+13, 12+11, 10+9] = [15, 11, 7, 3, 31, 27, 23, 19]
        check_int_array_equality(&result, &[15, 11, 7, 3, 31, 27, 23, 19])?;
    }

    Ok(())
}

fn test_mm_hadd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_hadd_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // hadd: [a0+a1, a2+a3, b0+b1, b2+b3]
        // a = [4,3,2,1], b = [8,7,6,5]
        // result = [4+3, 2+1, 8+7, 6+5] = [7, 3, 15, 11]
        check_int_array_equality(&result, &[7, 3, 15, 11])?;
    }

    Ok(())
}

fn test_mm_hsub_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set_epi16(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm_hsub_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // hsub: [a0-a1, a2-a3, a4-a5, a6-a7, b0-b1, b2-b3, b4-b5, b6-b7]
        // a = [8,7,6,5,4,3,2,1], b = [16,15,14,13,12,11,10,9]
        // result = [8-7, 6-5, 4-3, 2-1, 16-15, 14-13, 12-11, 10-9] = [1, 1, 1, 1, 1, 1, 1, 1]
        check_int_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }

    Ok(())
}

fn test_mm_hsub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_hsub_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        // hsub: [a0-a1, a2-a3, b0-b1, b2-b3]
        // a = [4,3,2,1], b = [8,7,6,5]
        // result = [4-3, 2-1, 8-7, 6-5] = [1, 1, 1, 1]
        check_int_array_equality(&result, &[1, 1, 1, 1])?;
    }

    Ok(())
}

fn test_mm_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
        let result = _mm_maddubs_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        // maddubs multiplies pairs and adds them to 16-bit result
        // a = [16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1]
        // result = [16*1+15*1, 14*1+13*1, 12*1+11*1, 10*1+9*1, 8*1+7*1, 6*1+5*1, 4*1+3*1, 2*1+1*1]
        // = [31, 27, 23, 19, 15, 11, 7, 3]
        check_int_array_equality(&result, &[31, 27, 23, 19, 15, 11, 7, 3])?;
    }

    Ok(())
}

fn test_mm_alignr_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_alignr_epi8::<2>(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        // alignr concatenates {b, a} and shifts right by 2 bytes
        // _mm_set_epi8 stores values in reverse order (from high to low byte)
        // In memory: a = [0,1,2,...,15], b = [16,17,18,...,31]
        // concatenated: {b,a} = [16,17,...,31,0,1,...,15]
        // shift right by 2 bytes: [18,19,20,...,31,0,1]
        check_int_array_equality(&result, &[18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 0, 1])?;
    }

    Ok(())
}

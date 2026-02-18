use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, get_random_i64_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512VBMI;

impl ExtensionTest for AVX512VBMI {
    fn get_name() -> &'static str {
        "AVX-512 VBMI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
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
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(7, 6, 5, 4, 3, 2, 1, 0, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_permutex2var_epi8(a, idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[1; 16])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i32_array::<16>();
                let a = _mm_set1_epi8(vals[0] as i8);
                let idx = _mm_set_epi8(
                    vals[15] as i8,
                    vals[14] as i8,
                    vals[13] as i8,
                    vals[12] as i8,
                    vals[11] as i8,
                    vals[10] as i8,
                    vals[9] as i8,
                    vals[8] as i8,
                    vals[7] as i8,
                    vals[6] as i8,
                    vals[5] as i8,
                    vals[4] as i8,
                    vals[3] as i8,
                    vals[2] as i8,
                    vals[1] as i8,
                    vals[0] as i8,
                );
                let _ = _mm_permutex2var_epi8(a, idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let result = _mm_mask_permutex2var_epi8(a, 6555, idx, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let idx_vals = get_random_i32_array::<16>();
                let b_vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let idx = _mm_set_epi8(
                    idx_vals[15] as i8,
                    idx_vals[14] as i8,
                    idx_vals[13] as i8,
                    idx_vals[12] as i8,
                    idx_vals[11] as i8,
                    idx_vals[10] as i8,
                    idx_vals[9] as i8,
                    idx_vals[8] as i8,
                    idx_vals[7] as i8,
                    idx_vals[6] as i8,
                    idx_vals[5] as i8,
                    idx_vals[4] as i8,
                    idx_vals[3] as i8,
                    idx_vals[2] as i8,
                    idx_vals[1] as i8,
                    idx_vals[0] as i8,
                );
                let b = _mm_set1_epi8(b_vals[0] as i8);
                let _ = _mm_mask_permutex2var_epi8(a, 6555, idx, b);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let result = _mm_maskz_permutex2var_epi8(65280, a, idx, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let idx_vals = get_random_i32_array::<16>();
                let b_vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let idx = _mm_set_epi8(
                    idx_vals[15] as i8,
                    idx_vals[14] as i8,
                    idx_vals[13] as i8,
                    idx_vals[12] as i8,
                    idx_vals[11] as i8,
                    idx_vals[10] as i8,
                    idx_vals[9] as i8,
                    idx_vals[8] as i8,
                    idx_vals[7] as i8,
                    idx_vals[6] as i8,
                    idx_vals[5] as i8,
                    idx_vals[4] as i8,
                    idx_vals[3] as i8,
                    idx_vals[2] as i8,
                    idx_vals[1] as i8,
                    idx_vals[0] as i8,
                );
                let b = _mm_set1_epi8(b_vals[0] as i8);
                let _ = _mm_maskz_permutex2var_epi8(65280, a, idx, b);
            }
        }
    }

    Ok(())
}

fn test_mm_mask2_permutex2var_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let idx = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set1_epi8(2);
        let result = _mm_mask2_permutex2var_epi8(a, idx, 6555, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[1, 1, 2, 1, 1, 5, 6, 1, 1, 9, 10, 1, 1, 13, 14, 15])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let idx_vals = get_random_i32_array::<16>();
                let b_vals = get_random_i32_array::<1>();
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let idx = _mm_set_epi8(
                    idx_vals[15] as i8,
                    idx_vals[14] as i8,
                    idx_vals[13] as i8,
                    idx_vals[12] as i8,
                    idx_vals[11] as i8,
                    idx_vals[10] as i8,
                    idx_vals[9] as i8,
                    idx_vals[8] as i8,
                    idx_vals[7] as i8,
                    idx_vals[6] as i8,
                    idx_vals[5] as i8,
                    idx_vals[4] as i8,
                    idx_vals[3] as i8,
                    idx_vals[2] as i8,
                    idx_vals[1] as i8,
                    idx_vals[0] as i8,
                );
                let b = _mm_set1_epi8(b_vals[0] as i8);
                let _ = _mm_mask2_permutex2var_epi8(a, idx, 6555, b);
            }
        }
    }

    Ok(())
}

fn test_mm_permutexvar_epi8() -> Result<(), String> {
    unsafe {
        let idx = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_permutexvar_epi8(idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let idx_vals = get_random_i32_array::<16>();
                let a_vals = get_random_i32_array::<16>();
                let idx = _mm_set_epi8(
                    idx_vals[15] as i8,
                    idx_vals[14] as i8,
                    idx_vals[13] as i8,
                    idx_vals[12] as i8,
                    idx_vals[11] as i8,
                    idx_vals[10] as i8,
                    idx_vals[9] as i8,
                    idx_vals[8] as i8,
                    idx_vals[7] as i8,
                    idx_vals[6] as i8,
                    idx_vals[5] as i8,
                    idx_vals[4] as i8,
                    idx_vals[3] as i8,
                    idx_vals[2] as i8,
                    idx_vals[1] as i8,
                    idx_vals[0] as i8,
                );
                let a = _mm_set_epi8(
                    a_vals[15] as i8,
                    a_vals[14] as i8,
                    a_vals[13] as i8,
                    a_vals[12] as i8,
                    a_vals[11] as i8,
                    a_vals[10] as i8,
                    a_vals[9] as i8,
                    a_vals[8] as i8,
                    a_vals[7] as i8,
                    a_vals[6] as i8,
                    a_vals[5] as i8,
                    a_vals[4] as i8,
                    a_vals[3] as i8,
                    a_vals[2] as i8,
                    a_vals[1] as i8,
                    a_vals[0] as i8,
                );
                let _ = _mm_permutexvar_epi8(idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_permutexvar_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi8(99);
        let idx = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_mask_permutexvar_epi8(src, 65280, idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[99, 99, 99, 99, 99, 99, 99, 99, 7, 6, 5, 4, 3, 2, 1, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_vals = get_random_i32_array::<1>();
                let a_vals = get_random_i32_array::<1>();
                let b_vals = get_random_i64_array::<2>();
                let src = _mm_set1_epi8(src_vals[0] as i8);
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let _b = _mm_set_epi64x(b_vals[0] as i64, b_vals[1] as i64);
                let _ = _mm_mask_permutexvar_epi8(src, 65280, idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_permutexvar_epi8() -> Result<(), String> {
    unsafe {
        let idx = _mm_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_maskz_permutexvar_epi8(65280, idx, a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);

        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 7, 6, 5, 4, 3, 2, 1, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let idx_vals = get_random_i32_array::<16>();
                let a_vals = get_random_i32_array::<16>();
                let idx = _mm_set_epi8(
                    idx_vals[15] as i8,
                    idx_vals[14] as i8,
                    idx_vals[13] as i8,
                    idx_vals[12] as i8,
                    idx_vals[11] as i8,
                    idx_vals[10] as i8,
                    idx_vals[9] as i8,
                    idx_vals[8] as i8,
                    idx_vals[7] as i8,
                    idx_vals[6] as i8,
                    idx_vals[5] as i8,
                    idx_vals[4] as i8,
                    idx_vals[3] as i8,
                    idx_vals[2] as i8,
                    idx_vals[1] as i8,
                    idx_vals[0] as i8,
                );
                let a = _mm_set_epi8(
                    a_vals[15] as i8,
                    a_vals[14] as i8,
                    a_vals[13] as i8,
                    a_vals[12] as i8,
                    a_vals[11] as i8,
                    a_vals[10] as i8,
                    a_vals[9] as i8,
                    a_vals[8] as i8,
                    a_vals[7] as i8,
                    a_vals[6] as i8,
                    a_vals[5] as i8,
                    a_vals[4] as i8,
                    a_vals[3] as i8,
                    a_vals[2] as i8,
                    a_vals[1] as i8,
                    a_vals[0] as i8,
                );
                let _ = _mm_maskz_permutexvar_epi8(65280, idx, a);
            }
        }
    }

    Ok(())
}

fn test_mm_multishift_epi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0);
        let b = _mm_set_epi64x(72623859790382856, 651345242494996240);
        let result = _mm_multishift_epi64_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[16, 16, 16, 16, 16, 16, 16, 16, 8, 8, 8, 8, 8, 8, 8, 8])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let b_vals = get_random_i64_array::<2>();
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let b = _mm_set_epi64x(b_vals[0] as i64, b_vals[1] as i64);
                let _ = _mm_multishift_epi64_epi8(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_mask_multishift_epi64_epi8() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi8(99);
        let a = _mm_set1_epi8(0);
        let b = _mm_set_epi64x(72623859790382856, 651345242494996240);
        let result = _mm_mask_multishift_epi64_epi8(src, 65280, a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[99, 99, 99, 99, 99, 99, 99, 99, 8, 8, 8, 8, 8, 8, 8, 8])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_vals = get_random_i32_array::<1>();
                let a_vals = get_random_i32_array::<1>();
                let b_vals = get_random_i64_array::<2>();
                let src = _mm_set1_epi8(src_vals[0] as i8);
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let b = _mm_set_epi64x(b_vals[0] as i64, b_vals[1] as i64);
                let _ = _mm_mask_multishift_epi64_epi8(src, 65280, a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_maskz_multishift_epi64_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0);
        let b = _mm_set_epi64x(72623859790382856, 651345242494996240);
        let result = _mm_maskz_multishift_epi64_epi8(65280, a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);

        check_array_equality(&result, &[0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let b_vals = get_random_i64_array::<2>();
                let a = _mm_set1_epi8(a_vals[0] as i8);
                let b = _mm_set_epi64x(b_vals[0] as i64, b_vals[1] as i64);
                let _ = _mm_maskz_multishift_epi64_epi8(65280, a, b);
            }
        }
    }

    Ok(())
}

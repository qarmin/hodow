use std::arch::x86_64::{__m256i, _mm256_abs_epi32, _mm256_add_epi32, _mm256_and_si256, _mm256_hadd_epi32, _mm256_max_epi32, _mm256_min_epi32, _mm256_mullo_epi32, _mm256_or_si256, _mm256_set_epi32, _mm256_set_epi8, _mm256_shuffle_epi8, _mm256_slli_epi32, _mm256_srli_epi32, _mm256_sub_epi32, _mm256_xor_si256};
use log::info;
use crate::cpu::common::check_array_equality;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm256_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_add_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = crate::cpu::avx2::get_eight_random_i32();
                let arr2 = crate::cpu::avx2::get_eight_random_i32();
                let _result = _mm256_add_epi32(
                    _mm256_set_epi32(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_epi32(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(10, 20, 30, 40, 50, 60, 70, 80);
        let b = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_sub_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[72, 63, 54, 45, 36, 27, 18, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = crate::cpu::avx2::get_eight_random_i32();
                let arr2 = crate::cpu::avx2::get_eight_random_i32();
                let _result = _mm256_sub_epi32(
                    _mm256_set_epi32(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_epi32(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_mullo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(2, 2, 2, 2, 2, 2, 2, 2);
        let result = _mm256_mullo_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[16, 14, 12, 10, 8, 6, 4, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr1 = crate::cpu::avx2::get_eight_random_i32();
                let arr2 = crate::cpu::avx2::get_eight_random_i32();
                let _result = _mm256_mullo_epi32(
                    _mm256_set_epi32(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_epi32(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm256_and_si256() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
        );
        let b = _mm256_set_epi32(
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
        );
        let result = _mm256_and_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        check_array_equality(&result, &[0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000])?;
    }

    Ok(())
}

pub(super) fn test_mm256_or_si256() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
        );
        let b = _mm256_set_epi32(
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
            0x00FF00FFu32 as i32,
        );
        let result = _mm256_or_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        check_array_equality(&result, &[0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF])?;
    }

    Ok(())
}

pub(super) fn test_mm256_xor_si256() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
            0xFF00FF00u32 as i32,
        );
        let b = _mm256_set_epi32(
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
            0xFFFF0000u32 as i32,
        );
        let result = _mm256_xor_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        check_array_equality(&result, &[0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00])?;
    }

    Ok(())
}

pub(super) fn test_mm256_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_slli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[32, 28, 24, 20, 16, 12, 8, 4])?;
    }

    Ok(())
}

pub(super) fn test_mm256_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(8, 16, 24, 32, 40, 48, 56, 64);
        let result = _mm256_srli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[16, 14, 12, 10, 8, 6, 4, 2])?;
    }

    Ok(())
}

pub(super) fn test_mm256_abs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(-1, -2, 3, -4, 5, -6, 7, -8);
        let result = _mm256_abs_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

pub(super) fn test_mm256_max_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_max_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[8, 7, 6, 5, 5, 6, 7, 8])?;
    }

    Ok(())
}

pub(super) fn test_mm256_min_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_min_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[1, 2, 3, 4, 4, 3, 2, 1])?;
    }

    Ok(())
}

pub(super) fn test_mm256_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi8(
            31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
        );
        let b = _mm256_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = _mm256_shuffle_epi8(a, b);
        let result = std::mem::transmute::<__m256i, [i8; 32]>(result);
        check_array_equality(
            &result,
            &[
                15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16,
            ],
        )?;
    }

    Ok(())
}

pub(super) fn test_mm256_hadd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hadd_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_array_equality(&result, &[15, 11, 31, 27, 7, 3, 23, 19])?;
    }

    Ok(())
}
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use log::info;

use crate::cpu::{ExtensionTest, DEFAULT_TEST_ITERATIONS};
use crate::get_fuzzing;

pub struct AVX2;

impl ExtensionTest for AVX2 {
    fn get_name() -> &'static str {
        "AVX2"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm256_add_epi32, "test_mm256_add_epi32"),
            (&test_mm256_sub_epi32, "test_mm256_sub_epi32"),
            (&test_mm256_mullo_epi32, "test_mm256_mullo_epi32"),
            (&test_mm256_and_si256, "test_mm256_and_si256"),
            (&test_mm256_or_si256, "test_mm256_or_si256"),
            (&test_mm256_xor_si256, "test_mm256_xor_si256"),
            (&test_mm256_slli_epi32, "test_mm256_slli_epi32"),
            (&test_mm256_srli_epi32, "test_mm256_srli_epi32"),
            (&test_mm256_abs_epi32, "test_mm256_abs_epi32"),
            (&test_mm256_max_epi32, "test_mm256_max_epi32"),
            (&test_mm256_min_epi32, "test_mm256_min_epi32"),
            (&test_mm256_shuffle_epi8, "test_mm256_shuffle_epi8"),
            (&test_mm256_hadd_epi32, "test_mm256_hadd_epi32"),
            (&test_mm256_hsub_epi32, "test_mm256_hsub_epi32"),
            (&test_mm256_broadcastd_epi32, "test_mm256_broadcastd_epi32"),
            (&test_mm256_permutevar8x32_epi32, "test_mm256_permutevar8x32_epi32"),
        ]
    }
}

fn get_eight_random_i32() -> [i32; 8] {
    [
        rand::random(),
        rand::random(),
        rand::random(),
        rand::random(),
        rand::random(),
        rand::random(),
        rand::random(),
        rand::random(),
    ]
}

fn test_mm256_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_add_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [9, 9, 9, 9, 9, 9, 9, 9]);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_i32();
                let arr2 = get_eight_random_i32();
                let _result = _mm256_add_epi32(
                    _mm256_set_epi32(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_epi32(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(10, 20, 30, 40, 50, 60, 70, 80);
        let b = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_sub_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [72, 63, 54, 45, 36, 27, 18, 9]);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_i32();
                let arr2 = get_eight_random_i32();
                let _result = _mm256_sub_epi32(
                    _mm256_set_epi32(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_epi32(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_mullo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(2, 2, 2, 2, 2, 2, 2, 2);
        let result = _mm256_mullo_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [16, 14, 12, 10, 8, 6, 4, 2]);
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let arr1 = get_eight_random_i32();
                let arr2 = get_eight_random_i32();
                let _result = _mm256_mullo_epi32(
                    _mm256_set_epi32(arr1[7], arr1[6], arr1[5], arr1[4], arr1[3], arr1[2], arr1[1], arr1[0]),
                    _mm256_set_epi32(arr2[7], arr2[6], arr2[5], arr2[4], arr2[3], arr2[2], arr2[1], arr2[0]),
                );
            }
        }
    }

    Ok(())
}

fn test_mm256_and_si256() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32,
                                  0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32);
        let b = _mm256_set_epi32(0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32,
                                  0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32);
        let result = _mm256_and_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        assert_eq!(result, [0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000]);
    }

    Ok(())
}

fn test_mm256_or_si256() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32,
                                  0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32);
        let b = _mm256_set_epi32(0x00FF00FFu32 as i32, 0x00FF00FFu32 as i32, 0x00FF00FFu32 as i32, 0x00FF00FFu32 as i32,
                                  0x00FF00FFu32 as i32, 0x00FF00FFu32 as i32, 0x00FF00FFu32 as i32, 0x00FF00FFu32 as i32);
        let result = _mm256_or_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        assert_eq!(result, [0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF]);
    }

    Ok(())
}

fn test_mm256_xor_si256() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32,
                                  0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32, 0xFF00FF00u32 as i32);
        let b = _mm256_set_epi32(0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32,
                                  0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32, 0xFFFF0000u32 as i32);
        let result = _mm256_xor_si256(a, b);
        let result = std::mem::transmute::<__m256i, [u32; 8]>(result);
        assert_eq!(result, [0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00]);
    }

    Ok(())
}

fn test_mm256_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_slli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [32, 28, 24, 20, 16, 12, 8, 4]);
    }

    Ok(())
}

fn test_mm256_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(8, 16, 24, 32, 40, 48, 56, 64);
        let result = _mm256_srli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [16, 14, 12, 10, 8, 6, 4, 2]);
    }

    Ok(())
}

fn test_mm256_abs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(-1, -2, 3, -4, 5, -6, 7, -8);
        let result = _mm256_abs_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [8, 7, 6, 5, 4, 3, 2, 1]);
    }

    Ok(())
}

fn test_mm256_max_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_max_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [8, 7, 6, 5, 5, 6, 7, 8]);
    }

    Ok(())
}

fn test_mm256_min_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_min_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [1, 2, 3, 4, 4, 3, 2, 1]);
    }

    Ok(())
}

fn test_mm256_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi8(
            31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16,
            15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
        );
        let b = _mm256_set_epi8(
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
        );
        let result = _mm256_shuffle_epi8(a, b);
        let result = std::mem::transmute::<__m256i, [i8; 32]>(result);
        assert_eq!(result, [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
            16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
        ]);
    }

    Ok(())
}

fn test_mm256_hadd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hadd_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [31, 23, 19, 11, 7, 3, 27, 15]);
    }

    Ok(())
}

fn test_mm256_hsub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hsub_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [-1, -1, -1, -1, -1, -1, -1, -1]);
    }

    Ok(())
}

fn test_mm256_broadcastd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 0, 42);
        let result = _mm256_broadcastd_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [42, 42, 42, 42, 42, 42, 42, 42]);
    }

    Ok(())
}

fn test_mm256_permutevar8x32_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm256_set_epi32(0, 1, 2, 3, 4, 5, 6, 7);
        let result = _mm256_permutevar8x32_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        assert_eq!(result, [0, 1, 2, 3, 4, 5, 6, 7]);
    }

    Ok(())
}

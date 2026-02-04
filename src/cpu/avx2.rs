#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{check_f32_array_equality, check_f64_array_equality, check_int_array_equality, check_int_equality, get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX2;

impl ExtensionTest for AVX2 {
    fn get_name() -> &'static str {
        "AVX2"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
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
            (&test_mm_blend_epi32, "test_mm_blend_epi32"),
            (&test_mm_broadcastb_epi8, "test_mm_broadcastb_epi8"),
            (&test_mm_broadcastq_epi64, "test_mm_broadcastq_epi64"),
            (&test_mm_broadcastsd_pd, "test_mm_broadcastsd_pd"),
            (&test_mm_broadcastsi128_si256, "test_mm_broadcastsi128_si256"),
            (&test_mm_broadcastss_ps, "test_mm_broadcastss_ps"),
            (&test_mm_broadcastw_epi16, "test_mm_broadcastw_epi16"),
            (&test_mm_i32gather_epi32, "test_mm_i32gather_epi32"),
            (&test_mm_mask_i32gather_epi32, "test_mm_mask_i32gather_epi32"),
            (&test_mm_i32gather_ps, "test_mm_i32gather_ps"),
            (&test_mm_mask_i32gather_ps, "test_mm_mask_i32gather_ps"),
            (&test_mm_i32gather_epi64, "test_mm_i32gather_epi64"),
            (&test_mm_mask_i32gather_epi64, "test_mm_mask_i32gather_epi64"),
            (&test_mm_i32gather_pd, "test_mm_i32gather_pd"),
            (&test_mm_mask_i32gather_pd, "test_mm_mask_i32gather_pd"),
            (&test_mm_i64gather_epi32, "test_mm_i64gather_epi32"),
            (&test_mm_mask_i64gather_epi32, "test_mm_mask_i64gather_epi32"),
            (&test_mm_i64gather_ps, "test_mm_i64gather_ps"),
            (&test_mm_mask_i64gather_ps, "test_mm_mask_i64gather_ps"),
            (&test_mm_i64gather_epi64, "test_mm_i64gather_epi64"),
            (&test_mm_mask_i64gather_epi64, "test_mm_mask_i64gather_epi64"),
            (&test_mm_i64gather_pd, "test_mm_i64gather_pd"),
            (&test_mm_mask_i64gather_pd, "test_mm_mask_i64gather_pd"),
            (&test_mm_maskload_epi32, "test_mm_maskload_epi32"),
            (&test_mm_maskload_epi64, "test_mm_maskload_epi64"),
            (&test_mm_maskstore_epi32, "test_mm_maskstore_epi32"),
            (&test_mm_maskstore_epi64, "test_mm_maskstore_epi64"),
            (&test_mm_sllv_epi32, "test_mm_sllv_epi32"),
            (&test_mm_sllv_epi64, "test_mm_sllv_epi64"),
            (&test_mm_srav_epi32, "test_mm_srav_epi32"),
            (&test_mm_srlv_epi32, "test_mm_srlv_epi32"),
            (&test_mm_srlv_epi64, "test_mm_srlv_epi64"),
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
        check_int_array_equality(&result, &[9, 9, 9, 9, 9, 9, 9, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
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
        check_int_array_equality(&result, &[72, 63, 54, 45, 36, 27, 18, 9])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
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
        check_int_array_equality(&result, &[16, 14, 12, 10, 8, 6, 4, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
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
        check_int_array_equality(&result, &[0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000, 0xFF000000])?;
    }

    Ok(())
}

fn test_mm256_or_si256() -> Result<(), String> {
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
        check_int_array_equality(&result, &[0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF])?;
    }

    Ok(())
}

fn test_mm256_xor_si256() -> Result<(), String> {
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
        check_int_array_equality(&result, &[0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00])?;
    }

    Ok(())
}

fn test_mm256_slli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let result = _mm256_slli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[32, 28, 24, 20, 16, 12, 8, 4])?;
    }

    Ok(())
}

fn test_mm256_srli_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(8, 16, 24, 32, 40, 48, 56, 64);
        let result = _mm256_srli_epi32::<2>(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[16, 14, 12, 10, 8, 6, 4, 2])?;
    }

    Ok(())
}

fn test_mm256_abs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(-1, -2, 3, -4, 5, -6, 7, -8);
        let result = _mm256_abs_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[8, 7, 6, 5, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm256_max_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_max_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[8, 7, 6, 5, 5, 6, 7, 8])?;
    }

    Ok(())
}

fn test_mm256_min_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(8, 7, 6, 5, 4, 3, 2, 1);
        let result = _mm256_min_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[1, 2, 3, 4, 4, 3, 2, 1])?;
    }

    Ok(())
}

fn test_mm256_shuffle_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi8(
            31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0,
        );
        let b = _mm256_set_epi8(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15);
        let result = _mm256_shuffle_epi8(a, b);
        let result = std::mem::transmute::<__m256i, [i8; 32]>(result);
        check_int_array_equality(
            &result,
            &[
                15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16,
            ],
        )?;
    }

    Ok(())
}

fn test_mm256_hadd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hadd_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[15, 11, 31, 27, 7, 3, 23, 19])?;
    }

    Ok(())
}

fn test_mm256_hsub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm256_set_epi32(9, 10, 11, 12, 13, 14, 15, 16);
        let result = _mm256_hsub_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[1, 1, 1, 1, 1, 1, 1, 1])?;
    }

    Ok(())
}

fn test_mm256_broadcastd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 0, 42);
        let result = _mm256_broadcastd_epi32(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[42, 42, 42, 42, 42, 42, 42, 42])?;
    }

    Ok(())
}

fn test_mm256_permutevar8x32_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm256_set_epi32(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm256_set_epi32(0, 1, 2, 3, 4, 5, 6, 7);
        let result = _mm256_permutevar8x32_epi32(a, b);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[7, 6, 5, 4, 3, 2, 1, 0])?;
    }

    Ok(())
}

fn test_mm_blend_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(5, 6, 7, 8);
        let result = _mm_blend_epi32::<0b1010>(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[4, 7, 2, 5])?;
    }
    Ok(())
}

fn test_mm_broadcastb_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42);
        let result = _mm_broadcastb_epi8(a);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_int_array_equality(&result, &[42; 16])?;
    }
    Ok(())
}

fn test_mm_broadcastq_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0, 42);
        let result = _mm_broadcastq_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_int_array_equality(&result, &[42, 42])?;
    }
    Ok(())
}

fn test_mm_broadcastsd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 42.5);
        let result = _mm_broadcastsd_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_f64_array_equality(&result, &[42.5, 42.5])?;
    }
    Ok(())
}

fn test_mm_broadcastsi128_si256() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_broadcastsi128_si256(a);
        let result = std::mem::transmute::<__m256i, [i32; 8]>(result);
        check_int_array_equality(&result, &[1, 2, 3, 4, 1, 2, 3, 4])?;
    }
    Ok(())
}

fn test_mm_broadcastss_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(0.0, 0.0, 0.0, 42.5);
        let result = _mm_broadcastss_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[42.5, 42.5, 42.5, 42.5])?;
    }
    Ok(())
}

fn test_mm_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0, 0, 0, 0, 0, 0, 0, 42);
        let result = _mm_broadcastw_epi16(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_int_array_equality(&result, &[42; 8])?;
    }
    Ok(())
}

fn test_mm_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let result = _mm_i32gather_epi32::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[70, 50, 30, 10])?;
    }
    Ok(())
}

fn test_mm_mask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi32(99);
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let result = _mm_mask_i32gather_epi32::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[99, 50, 99, 10])?;
    }
    Ok(())
}

fn test_mm_i32gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let result = _mm_i32gather_ps::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[7.0, 0.0, 0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm_mask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_ps(99.0);
        let indices = _mm_set_epi32(0, 2, 4, 6);
        let mask = _mm_set_ps(-1.0, 0.0, -1.0, 0.0);
        let result = _mm_mask_i32gather_ps::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);

        check_f32_array_equality(&result, &[7.0, 99.0, 5.0, 99.0])?;
        Ok(())
    }
}

fn test_mm_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let result = _mm_i32gather_epi64::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        // Previously checked only first element. Now check entire array.
        let expected: [i64; 2] = [40, 0];
        check_int_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_mask_i32gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi64x(99);
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let mask = _mm_set_epi64x(-1, 0);
        let result = _mm_mask_i32gather_epi64::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        // Previously checked only first element. Now check entire array.
        let expected: [i64; 2] = [99, 0];
        check_int_array_equality(&result, &expected)?;
        Ok(())
    }
}

fn test_mm_i32gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let result = _mm_i32gather_pd::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_f64_array_equality(&result, &[4.0, 2.0])?;
        Ok(())
    }
}

fn test_mm_mask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_pd(99.0);
        let indices = _mm_set_epi32(0, 0, 1, 3);
        let mask = _mm_set_pd(-1.0, 0.0);
        let result = _mm_mask_i32gather_pd::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_f64_array_equality(&result, &[4.0, 99.0])?;
        Ok(())
    }
}

fn test_mm_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi64x(0, 2);
        let result = _mm_i64gather_epi32::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[30, 0])?;
    }
    Ok(())
}

fn test_mm_mask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi32(99);
        let indices = _mm_set_epi64x(0, 2);
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let result = _mm_mask_i64gather_epi32::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[99, 0])?;
    }
    Ok(())
}

fn test_mm_i64gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi64x(0, 2);
        let result = _mm_i64gather_ps::<4>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;
    }
    Ok(())
}

fn test_mm_mask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let arr: [f32; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_ps(99.0);
        let indices = _mm_set_epi64x(0, 2);
        let mask = _mm_set_ps(-1.0, 0.0, -1.0, 0.0);
        let result = _mm_mask_i64gather_ps::<4>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_f32_array_equality(&result, &[7.0, 99.0, 3.0, 99.0])?;
        Ok(())
    }
}

fn test_mm_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let indices = _mm_set_epi64x(0, 3);
        let result = _mm_i64gather_epi64::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_int_array_equality(&result, &[40, 0])?;
        Ok(())
    }
}

fn test_mm_mask_i64gather_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 8] = [10, 20, 30, 40, 50, 60, 70, 80];
        let src = _mm_set1_epi64x(99);
        let indices = _mm_set_epi64x(0, 3);
        let mask = _mm_set_epi64x(-1, 0);
        let result = _mm_mask_i64gather_epi64::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_int_array_equality(&result, &[99, 0])?;
        Ok(())
    }
}

fn test_mm_i64gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let indices = _mm_set_epi64x(0, 3);
        let result = _mm_i64gather_pd::<8>(arr.as_ptr(), indices);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_f64_array_equality(&result, &[4.0, 0.0])?;
        Ok(())
    }
}

fn test_mm_mask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let arr: [f64; 8] = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0];
        let src = _mm_set1_pd(99.0);
        let indices = _mm_set_epi64x(0, 3);
        let mask = _mm_set_pd(-1.0, 0.0);
        let result = _mm_mask_i64gather_pd::<8>(src, arr.as_ptr(), indices, mask);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_f64_array_equality(&result, &[4.0, 99.0])?;
        Ok(())
    }
}

fn test_mm_maskload_epi32() -> Result<(), String> {
    unsafe {
        let arr: [i32; 4] = [10, 20, 30, 40];
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let result = _mm_maskload_epi32(arr.as_ptr(), mask);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        let expected = [0, 20, 0, 40];
        check_int_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_maskload_epi64() -> Result<(), String> {
    unsafe {
        let arr: [i64; 2] = [10, 20];
        let mask = _mm_set_epi64x(-1, 0);
        let result = _mm_maskload_epi64(arr.as_ptr(), mask);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        let expected = [0, 20];
        check_int_array_equality(&result, &expected)?;
    }
    Ok(())
}

fn test_mm_maskstore_epi32() -> Result<(), String> {
    unsafe {
        let mut arr: [i32; 4] = [0; 4];
        let mask = _mm_set_epi32(-1, 0, -1, 0);
        let a = _mm_set_epi32(40, 30, 20, 10);
        _mm_maskstore_epi32(arr.as_mut_ptr(), mask, a);
        let expected = [0, 20, 0, 40];
        check_int_array_equality(&arr, &expected)?;
    }
    Ok(())
}

fn test_mm_maskstore_epi64() -> Result<(), String> {
    unsafe {
        let mut arr: [i64; 2] = [0; 2];
        let mask = _mm_set_epi64x(-1, 0);
        let a = _mm_set_epi64x(20, 10);
        _mm_maskstore_epi64(arr.as_mut_ptr(), mask, a);
        let expected = [0, 20];
        check_int_array_equality(&arr, &expected)?;
    }
    Ok(())
}

fn test_mm_sllv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let count = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_sllv_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[1, 2, 4, 8])?;
    }
    Ok(())
}

fn test_mm_sllv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(2, 0);
        let result = _mm_sllv_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_int_array_equality(&result, &[1, 4])?;
    }
    Ok(())
}

fn test_mm_srav_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-8, -4, -2, -1);
        let count = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_srav_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[-1, -1, -1, -1])?;
    }
    Ok(())
}

fn test_mm_srlv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(8);
        let count = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_srlv_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_int_array_equality(&result, &[8, 4, 2, 1])?;
    }
    Ok(())
}

fn test_mm_srlv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(8);
        let count = _mm_set_epi64x(2, 0);
        let result = _mm_srlv_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_int_array_equality(&result, &[8, 2])?;
    }
    Ok(())
}

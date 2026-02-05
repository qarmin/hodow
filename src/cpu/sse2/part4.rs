use std::arch::x86_64::{
    __m128d, __m128i, _mm_add_sd, _mm_and_pd, _mm_andnot_pd, _mm_andnot_si128, _mm_bslli_si128, _mm_bsrli_si128, _mm_cvtepi32_pd, _mm_cvtepi32_ps, _mm_cvtpd_epi32, _mm_cvtpd_ps,
    _mm_cvtps_epi32, _mm_cvtsd_f64, _mm_cvttpd_epi32, _mm_cvttps_epi32, _mm_div_pd, _mm_div_sd, _mm_extract_epi16, _mm_insert_epi16, _mm_max_pd, _mm_max_sd, _mm_min_pd,
    _mm_min_sd, _mm_movemask_epi8, _mm_mul_sd, _mm_or_pd, _mm_packus_epi16, _mm_set1_epi16, _mm_set1_epi32, _mm_set1_epi64x, _mm_set_epi16, _mm_set_epi32, _mm_set_epi64x,
    _mm_set_epi8, _mm_set_pd, _mm_set_sd, _mm_shuffle_epi32, _mm_shufflehi_epi16, _mm_shufflelo_epi16, _mm_sll_epi16, _mm_sll_epi32, _mm_sll_epi64, _mm_sqrt_pd, _mm_sqrt_sd,
    _mm_sub_sd, _mm_unpackhi_epi16, _mm_unpackhi_epi32, _mm_unpackhi_epi64, _mm_unpackhi_epi8, _mm_unpacklo_epi16, _mm_unpacklo_epi32, _mm_unpacklo_epi64, _mm_unpacklo_epi8,
    _mm_xor_pd,
};

use log::info;

use crate::cpu::common::{
    check_array_equality, check_float_array_equality_with_error, check_int_equality, get_random_float, get_random_float32_array, get_random_float64_array, get_random_i32_array,
};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_packus_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(300, 200, 100, 50, 10, 5, 2, 1);
        let b = _mm_set_epi16(255, 254, 253, 252, -1, -2, -3, -4);
        let result = _mm_packus_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[1, 2, 5, 10, 50, 100, 200, 255, 0, 0, 0, 0, 252, 253, 254, 255])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<8>();
                let b_vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    a_vals[7] as i16,
                    a_vals[6] as i16,
                    a_vals[5] as i16,
                    a_vals[4] as i16,
                    a_vals[3] as i16,
                    a_vals[2] as i16,
                    a_vals[1] as i16,
                    a_vals[0] as i16,
                );
                let b = _mm_set_epi16(
                    b_vals[7] as i16,
                    b_vals[6] as i16,
                    b_vals[5] as i16,
                    b_vals[4] as i16,
                    b_vals[3] as i16,
                    b_vals[2] as i16,
                    b_vals[1] as i16,
                    b_vals[0] as i16,
                );
                let _ = _mm_packus_epi16(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpackhi_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpackhi_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[8, 24, 9, 25, 10, 26, 11, 27, 12, 28, 13, 29, 14, 30, 15, 31])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<16>();
                let b_vals = get_random_i32_array::<16>();
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
                let b = _mm_set_epi8(
                    b_vals[15] as i8,
                    b_vals[14] as i8,
                    b_vals[13] as i8,
                    b_vals[12] as i8,
                    b_vals[11] as i8,
                    b_vals[10] as i8,
                    b_vals[9] as i8,
                    b_vals[8] as i8,
                    b_vals[7] as i8,
                    b_vals[6] as i8,
                    b_vals[5] as i8,
                    b_vals[4] as i8,
                    b_vals[3] as i8,
                    b_vals[2] as i8,
                    b_vals[1] as i8,
                    b_vals[0] as i8,
                );
                let _ = _mm_unpackhi_epi8(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpackhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpackhi_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[4, 12, 5, 13, 6, 14, 7, 15])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<8>();
                let b_vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    a_vals[7] as i16,
                    a_vals[6] as i16,
                    a_vals[5] as i16,
                    a_vals[4] as i16,
                    a_vals[3] as i16,
                    a_vals[2] as i16,
                    a_vals[1] as i16,
                    a_vals[0] as i16,
                );
                let b = _mm_set_epi16(
                    b_vals[7] as i16,
                    b_vals[6] as i16,
                    b_vals[5] as i16,
                    b_vals[4] as i16,
                    b_vals[3] as i16,
                    b_vals[2] as i16,
                    b_vals[1] as i16,
                    b_vals[0] as i16,
                );
                let _ = _mm_unpackhi_epi16(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpackhi_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpackhi_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[2, 6, 3, 7])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<4>();
                let b_vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_epi32(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_unpackhi_epi32(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpackhi_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpackhi_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[1, 3])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<2>();
                let b_vals = get_random_i32_array::<2>();
                let a = _mm_set_epi64x(a_vals[1] as i64, a_vals[0] as i64);
                let b = _mm_set_epi64x(b_vals[1] as i64, b_vals[0] as i64);
                let _ = _mm_unpackhi_epi64(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi8(31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16);
        let result = _mm_unpacklo_epi8(a, b);
        let result = std::mem::transmute::<__m128i, [i8; 16]>(result);
        check_array_equality(&result, &[0, 16, 1, 17, 2, 18, 3, 19, 4, 20, 5, 21, 6, 22, 7, 23])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<16>();
                let b_vals = get_random_i32_array::<16>();
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
                let b = _mm_set_epi8(
                    b_vals[15] as i8,
                    b_vals[14] as i8,
                    b_vals[13] as i8,
                    b_vals[12] as i8,
                    b_vals[11] as i8,
                    b_vals[10] as i8,
                    b_vals[9] as i8,
                    b_vals[8] as i8,
                    b_vals[7] as i8,
                    b_vals[6] as i8,
                    b_vals[5] as i8,
                    b_vals[4] as i8,
                    b_vals[3] as i8,
                    b_vals[2] as i8,
                    b_vals[1] as i8,
                    b_vals[0] as i8,
                );
                let _ = _mm_unpacklo_epi8(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpacklo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let b = _mm_set_epi16(15, 14, 13, 12, 11, 10, 9, 8);
        let result = _mm_unpacklo_epi16(a, b);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 8, 1, 9, 2, 10, 3, 11])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<8>();
                let b_vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    a_vals[7] as i16,
                    a_vals[6] as i16,
                    a_vals[5] as i16,
                    a_vals[4] as i16,
                    a_vals[3] as i16,
                    a_vals[2] as i16,
                    a_vals[1] as i16,
                    a_vals[0] as i16,
                );
                let b = _mm_set_epi16(
                    b_vals[7] as i16,
                    b_vals[6] as i16,
                    b_vals[5] as i16,
                    b_vals[4] as i16,
                    b_vals[3] as i16,
                    b_vals[2] as i16,
                    b_vals[1] as i16,
                    b_vals[0] as i16,
                );
                let _ = _mm_unpacklo_epi16(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpacklo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set_epi32(7, 6, 5, 4);
        let result = _mm_unpacklo_epi32(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 4, 1, 5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<4>();
                let b_vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_epi32(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_unpacklo_epi32(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_unpacklo_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 0);
        let b = _mm_set_epi64x(3, 2);
        let result = _mm_unpacklo_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[0, 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<2>();
                let b_vals = get_random_i32_array::<2>();
                let a = _mm_set_epi64x(a_vals[1] as i64, a_vals[0] as i64);
                let b = _mm_set_epi64x(b_vals[1] as i64, b_vals[0] as i64);
                let _ = _mm_unpacklo_epi64(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_shuffle_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_shuffle_epi32::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[3, 2, 1, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_shuffle_epi32::<0b00011011>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_shufflehi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflehi_epi16::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 1, 2, 3, 7, 6, 5, 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    vals[7] as i16,
                    vals[6] as i16,
                    vals[5] as i16,
                    vals[4] as i16,
                    vals[3] as i16,
                    vals[2] as i16,
                    vals[1] as i16,
                    vals[0] as i16,
                );
                let _ = _mm_shufflehi_epi16::<0b00011011>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_shufflelo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_shufflelo_epi16::<0b00011011>(a);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[3, 2, 1, 0, 4, 5, 6, 7])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    vals[7] as i16,
                    vals[6] as i16,
                    vals[5] as i16,
                    vals[4] as i16,
                    vals[3] as i16,
                    vals[2] as i16,
                    vals[1] as i16,
                    vals[0] as i16,
                );
                let _ = _mm_shufflelo_epi16::<0b00011011>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_extract_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_extract_epi16::<3>(a);
        check_int_equality(result, 3)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    vals[7] as i16,
                    vals[6] as i16,
                    vals[5] as i16,
                    vals[4] as i16,
                    vals[3] as i16,
                    vals[2] as i16,
                    vals[1] as i16,
                    vals[0] as i16,
                );
                let _ = _mm_extract_epi16::<3>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_insert_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7, 6, 5, 4, 3, 2, 1, 0);
        let result = _mm_insert_epi16::<3>(a, 99);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[0, 1, 2, 99, 4, 5, 6, 7])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<8>();
                let a = _mm_set_epi16(
                    vals[7] as i16,
                    vals[6] as i16,
                    vals[5] as i16,
                    vals[4] as i16,
                    vals[3] as i16,
                    vals[2] as i16,
                    vals[1] as i16,
                    vals[0] as i16,
                );
                let _ = _mm_insert_epi16::<3>(a, vals[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_movemask_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0);
        let result = _mm_movemask_epi8(a);
        check_int_equality(result, 43690)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<16>();
                let a = _mm_set_epi8(
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
                let _ = _mm_movemask_epi8(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi32_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 0, 20, 10);
        let result = _mm_cvtepi32_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality_with_error(&result, &[10.0, 20.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_cvtepi32_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtepi32_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_cvtepi32_ps(a);
        let result = std::mem::transmute::<std::arch::x86_64::__m128, [f32; 4]>(result);
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_cvtepi32_ps(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7, 10.3);
        let result = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 21, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_cvtpd_epi32(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let ps = _mm_cvtpd_ps(a);
                let _ = _mm_cvtps_epi32(ps);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvttpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.9, 10.9);
        let result = _mm_cvttpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 20, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_cvttpd_epi32(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvttps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvttps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let ps = _mm_cvtpd_ps(a);
                let _ = _mm_cvttps_epi32(ps);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_add_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_add_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[15.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_add_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_div_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(20.0);
        let b = _mm_set_sd(4.0);
        let result = _mm_div_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_div_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.0, 10.0);
        let b = _mm_set_pd(4.0, 2.0);
        let result = _mm_div_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_div_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_max_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_max_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[10.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_max_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_max_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_max_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[7.0, 10.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let b_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let b = _mm_set_pd(b_vals[1], b_vals[0]);
                let _ = _mm_max_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_min_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_min_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_min_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_min_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(10.0, 5.0);
        let b = _mm_set_pd(8.0, 7.0);
        let result = _mm_min_pd(a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_float64_array::<2>();
                let b_vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(a_vals[1], a_vals[0]);
                let b = _mm_set_pd(b_vals[1], b_vals[0]);
                let _ = _mm_min_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mul_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result = _mm_mul_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[50.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_mul_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sqrt_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(25.0);
        let b = _mm_set_sd(0.0);
        let result = _mm_sqrt_sd(b, a);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[5.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_sqrt_sd(b, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sqrt_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(16.0, 25.0);
        let result = _mm_sqrt_pd(a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_array_equality(&result, &[5.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_sqrt_pd(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sub_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(3.0);
        let result = _mm_sub_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(result);
        check_float_array_equality_with_error(&[result_f64], &[7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_sub_sd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_and_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_and_pd(a, b);
        let res_bits = std::mem::transmute::<__m128d, [u64; 2]>(result);
        let a_bits = std::mem::transmute::<__m128d, [u64; 2]>(a);
        let b_bits = std::mem::transmute::<__m128d, [u64; 2]>(b);
        let expected = [a_bits[0] & b_bits[0], a_bits[1] & b_bits[1]];
        check_array_equality(&res_bits, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_and_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_andnot_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_andnot_pd(a, b);
        let res_bits = std::mem::transmute::<__m128d, [u64; 2]>(result);
        let a_bits = std::mem::transmute::<__m128d, [u64; 2]>(a);
        let b_bits = std::mem::transmute::<__m128d, [u64; 2]>(b);
        let expected = [(!a_bits[0]) & b_bits[0], (!a_bits[1]) & b_bits[1]];
        check_array_equality(&res_bits, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_andnot_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_or_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_or_pd(a, b);
        let res_bits = std::mem::transmute::<__m128d, [u64; 2]>(result);
        let a_bits = std::mem::transmute::<__m128d, [u64; 2]>(a);
        let b_bits = std::mem::transmute::<__m128d, [u64; 2]>(b);
        let expected = [a_bits[0] | b_bits[0], a_bits[1] | b_bits[1]];
        check_array_equality(&res_bits, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_or_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_xor_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 2.0);
        let b = _mm_set_pd(3.0, 4.0);
        let result = _mm_xor_pd(a, b);
        let res_bits = std::mem::transmute::<__m128d, [u64; 2]>(result);
        let a_bits = std::mem::transmute::<__m128d, [u64; 2]>(a);
        let b_bits = std::mem::transmute::<__m128d, [u64; 2]>(b);
        let expected = [a_bits[0] ^ b_bits[0], a_bits[1] ^ b_bits[1]];
        check_array_equality(&res_bits, &expected)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_pd(vals[1], vals[0]);
                let b = _mm_set_pd(vals[1] + 1.0, vals[0] + 1.0);
                let _ = _mm_xor_pd(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_andnot_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0xFF, 0xFF, 0x00, 0x00);
        let b = _mm_set_epi32(0xFF, 0x00, 0xFF, 0x00);
        let result = _mm_andnot_si128(a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[0, 255, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a_vals = get_random_i32_array::<4>();
                let b_vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(a_vals[3], a_vals[2], a_vals[1], a_vals[0]);
                let b = _mm_set_epi32(b_vals[3], b_vals[2], b_vals[1], b_vals[0]);
                let _ = _mm_andnot_si128(a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_bslli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_bslli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[0, 0, 0, 0, 13, 14, 15, 16, 9, 10, 11, 12, 5, 6, 7, 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_bslli_si128::<4>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_bsrli_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result = _mm_bsrli_si128::<4>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[9, 10, 11, 12, 5, 6, 7, 8, 1, 2, 3, 4, 0, 0, 0, 0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_i32_array::<4>();
                let a = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_bsrli_si128::<4>(a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sll_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(1);
        let count = _mm_set_epi64x(0, 2);
        let result = _mm_sll_epi16(a, count);
        let result = std::mem::transmute::<__m128i, [i16; 8]>(result);
        check_array_equality(&result, &[4; 8])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let a = _mm_set1_epi16(v[0] as i16);
                let count = _mm_set_epi64x(0, (v[0] as i64 & 0x3F) as i64);
                let _ = _mm_sll_epi16(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sll_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let count = _mm_set_epi64x(0, 3);
        let result = _mm_sll_epi32(a, count);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[8; 4])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let a = _mm_set1_epi32(v[0]);
                let count = _mm_set_epi64x(0, (v[0] as i64 & 0x3F) as i64);
                let _ = _mm_sll_epi32(a, count);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_sll_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(0, 4);
        let result = _mm_sll_epi64(a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[16; 2])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_i32_array::<1>();
                let a = _mm_set1_epi64x(v[0] as i64);
                let count = _mm_set_epi64x(0, (v[0] as i64 & 0x3F) as i64);
                let _ = _mm_sll_epi64(a, count);
            }
        }
    }

    Ok(())
}

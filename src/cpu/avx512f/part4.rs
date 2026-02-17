#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_equality, check_int_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_abs_epi64() -> Result<(), String> {
    unsafe {
        let a: __m128i = _mm_set_epi64x(-2i64, -1i64);
        let result_v = _mm_abs_epi64(a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[1i64, 2i64])?;

        if get_fuzzing() {
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = _mm_abs_epi64(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_abs_epi64() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi64x(-2i64, -1i64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_abs_epi64(src, k, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = _mm_mask_abs_epi64(src, k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_abs_epi64() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_epi64x(-3i64, -2i64);
        let result_v = _mm_maskz_abs_epi64(k, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[2i64, 3i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = _mm_maskz_abs_epi64(k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_epi32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(4, 3, 2, 1);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_mov_epi32(src, k, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_mask_mov_epi32(src, k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi32() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_epi32(4, 3, 2, 1);
        let result_v = _mm_maskz_mov_epi32(k, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_maskz_mov_epi32(k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_epi64() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi64x(2i64, 1i64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_mov_epi64(src, k, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = _mm_mask_mov_epi64(src, k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi64() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_epi64x(2i64, 1i64);
        let result_v = _mm_maskz_mov_epi64(k, a);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[1i64, 2i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = _mm_maskz_mov_epi64(k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_mov_ps(src, k, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_equality(result[0], 1.0, 0.0001)?;
        check_float_equality(result[1], 2.0, 0.0001)?;
        check_float_equality(result[2], 3.0, 0.0001)?;
        check_float_equality(result[3], 4.0, 0.0001)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r[3], r[2], r[1], r[0]);
                let _ = _mm_mask_mov_ps(src, k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_ps() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let result_v = _mm_maskz_mov_ps(k, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_equality(result[0], 1.0, 0.0001)?;
        check_float_equality(result[1], 2.0, 0.0001)?;
        check_float_equality(result[2], 3.0, 0.0001)?;
        check_float_equality(result[3], 4.0, 0.0001)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r[3], r[2], r[1], r[0]);
                let _ = _mm_maskz_mov_ps(k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(2.0, 1.0);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_mov_pd(src, k, a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_equality(result[0] as f32, 1.0, 0.0001)?;
        check_float_equality(result[1] as f32, 2.0, 0.0001)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r[1], r[0]);
                let _ = _mm_mask_mov_pd(src, k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_pd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a = _mm_set_pd(2.0, 1.0);
        let result_v = _mm_maskz_mov_pd(k, a);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_equality(result[0] as f32, 1.0, 0.0001)?;
        check_float_equality(result[1] as f32, 2.0, 0.0001)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r[1], r[0]);
                let _ = _mm_maskz_mov_pd(k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_epi32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(40, 30, 20, 10);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_add_epi32(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[11, 22, 33, 44])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_add_epi32(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(40, 30, 20, 10);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_maskz_add_epi32(k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[11, 22, 33, 44])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_add_epi32(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_epi64() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi64x(2i64, 1i64);
        let b = _mm_set_epi64x(20i64, 10i64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_mask_add_epi64(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[11i64, 22i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i64_array::<2>();
                let r2 = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r1[1], r1[0]);
                let b_r = _mm_set_epi64x(r2[1], r2[0]);
                let _ = _mm_mask_add_epi64(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2i64, 1i64);
        let b = _mm_set_epi64x(20i64, 10i64);
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let result_v = _mm_maskz_add_epi64(k, a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[11i64, 22i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i64_array::<2>();
                let r2 = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r1[1], r1[0]);
                let b_r = _mm_set_epi64x(r2[1], r2[0]);
                let _ = _mm_maskz_add_epi64(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

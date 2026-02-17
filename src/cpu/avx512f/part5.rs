use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_add_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(40.0, 30.0, 20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_add_ps(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_add_ps(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(40.0, 30.0, 20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_add_ps(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_add_ps(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_add_pd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_mask_add_pd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_add_pd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_maskz_add_pd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sub_epi32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(40, 30, 20, 10);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_sub_epi32(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[-9, -18, -27, -36])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_sub_epi32(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(40, 30, 20, 10);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_sub_epi32(k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[-9, -18, -27, -36])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_sub_epi32(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sub_epi64() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(20, 10);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_sub_epi64(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[-9, -18])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i64_array::<2>();
                let r2 = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r1[1], r1[0]);
                let b_r = _mm_set_epi64x(r2[1], r2[0]);
                let _ = _mm_mask_sub_epi64(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set_epi64x(20, 10);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_sub_epi64(k, a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[-9, -18])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i64_array::<2>();
                let r2 = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r1[1], r1[0]);
                let b_r = _mm_set_epi64x(r2[1], r2[0]);
                let _ = _mm_maskz_sub_epi64(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sub_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(40.0, 30.0, 20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_sub_ps(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-9.0, -18.0, -27.0, -36.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_sub_ps(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(40.0, 30.0, 20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_sub_ps(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-9.0, -18.0, -27.0, -36.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_sub_ps(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sub_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_sub_pd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[-9.0, -18.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_mask_sub_pd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(20.0, 10.0);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_sub_pd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[-9.0, -18.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_maskz_sub_pd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_epi32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(4, 3, 2, 1);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_mul_epi32(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 4, 9, 16])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_mul_epi32(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(4, 3, 2, 1);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_maskz_mul_epi32(k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 4, 9, 16])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_mul_epi32(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mullo_epi32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(4, 3, 2, 1);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_mullo_epi32(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 4, 9, 16])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_mullo_epi32(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_mullo_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(4, 3, 2, 1);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_mullo_epi32(k, a, b);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 4, 9, 16])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_i32_array::<4>();
                let r2 = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_epi32(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_mullo_epi32(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_epu32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(0, 100, 0, 200);
        let b = _mm_set_epi32(0, 5, 0, 3);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_mul_epu32(src, k, a, b);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result_v);
        check_array_equality(&result, &[600, 500])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i32_array::<4>();
                let _ = _mm_mask_mul_epu32(src, k, _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]), _mm_set_epi32(vals[0], vals[1], vals[2], vals[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(0, 100, 0, 200);
        let b = _mm_set_epi32(0, 5, 0, 3);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_mul_epu32(k, a, b);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result_v);
        check_array_equality(&result, &[600, 500])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i32_array::<4>();
                let _ = _mm_maskz_mul_epu32(k, _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]), _mm_set_epi32(vals[0], vals[1], vals[2], vals[3]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_mul_ps(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[16.0, 9.0, 4.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_mul_ps(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_mul_ps(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[16.0, 9.0, 4.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_mul_ps(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(2.0, 1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_mul_pd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[4.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_mask_mul_pd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(2.0, 1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_mul_pd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[4.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_maskz_mul_pd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(4.0, 6.0, 2.0, 1.0);
        let b = _mm_set_ps(2.0, 3.0, 1.0, 1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_div_ps(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[2.0, 2.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_mask_div_ps(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 6.0, 2.0, 1.0);
        let b = _mm_set_ps(2.0, 3.0, 1.0, 1.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_div_ps(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[2.0, 2.0, 2.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let _ = _mm_maskz_div_ps(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(4.0, 6.0);
        let b = _mm_set_pd(2.0, 3.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_div_pd(src, k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_mask_div_pd(src, k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(4.0, 6.0);
        let b = _mm_set_pd(2.0, 3.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_div_pd(k, a, b);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[2.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let _ = _mm_maskz_div_pd(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 5, -2, 100);
        let b = _mm_set_epi32(7, 6, 0, 50);
        let k: __mmask8 = 255u8 as __mmask8;
        let src: __m128i = _mm_setzero_si128();
        let r = _mm_mask_max_epi32(src, k, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[10, 6, 0, 100])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_i32_array::<4>();
                let v2 = get_random_i32_array::<4>();
                let _ = _mm_mask_max_epi32(_mm_setzero_si128(), k, _mm_set_epi32(v1[3], v1[2], v1[1], v1[0]), _mm_set_epi32(v2[3], v2[2], v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 5, -2, 100);
        let b = _mm_set_epi32(7, 6, 0, 50);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_maskz_max_epi32(k, a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[10, 6, 0, 100])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_i32_array::<4>();
                let v2 = get_random_i32_array::<4>();
                let _ = _mm_maskz_max_epi32(k, _mm_set_epi32(v1[3], v1[2], v1[1], v1[0]), _mm_set_epi32(v2[3], v2[2], v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_max_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 1);
        let b = _mm_set_epi64x(2, 4);
        let r = _mm_max_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<2>();
                let _ = _mm_max_epi64(_mm_set_epi64x(vals[1], vals[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 1);
        let b = _mm_set_epi64x(2, 4);
        let r = _mm_max_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<2>();
                let _ = _mm_max_epi64(_mm_set_epi64x(vals[1], vals[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

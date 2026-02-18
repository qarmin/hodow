use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_max_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 3.0, 4.0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_float32_array::<4>();
                let v2 = get_random_float32_array::<4>();
                let _ = _mm_max_ps(_mm_set_ps(v1[3], v1[2], v1[1], v1[0]), _mm_set_ps(v2[3], v2[2], v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 4.0, 2.0, 3.0);
        let b = _mm_set_ps(2.0, 3.0, 4.0, 1.0);
        let r = _mm_max_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 4.0, 4.0, 3.0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_float32_array::<4>();
                let v2 = get_random_float32_array::<4>();
                let _ = _mm_max_ps(_mm_set_ps(v1[3], v1[2], v1[1], v1[0]), _mm_set_ps(v2[3], v2[2], v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0, 5.0);
        let b = _mm_set_pd(4.0, 2.0);
        let r = _mm_max_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 5.0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_float64_array::<2>();
                let v2 = get_random_float64_array::<2>();
                let _ = _mm_max_pd(_mm_set_pd(v1[1], v1[0]), _mm_set_pd(v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(7.0, 1.0);
        let b = _mm_set_pd(2.0, 9.0);
        let r = _mm_max_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[7.0, 9.0])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_float64_array::<2>();
                let v2 = get_random_float64_array::<2>();
                let _ = _mm_max_pd(_mm_set_pd(v1[1], v1[0]), _mm_set_pd(v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 70000, 30000, 5);
        let b = _mm_set_epi32(2, 60000, 50000, 4);
        let r = _mm_max_epu32(a, b);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[2, 70000, 50000, 5])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals1 = get_random_i32_array::<4>();
                let vals2 = get_random_i32_array::<4>();
                let _ = _mm_max_epu32(_mm_set_epi32(vals1[3], vals1[2], vals1[1], vals1[0]), _mm_set_epi32(vals2[3], vals2[2], vals2[1], vals2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(100, 200, 300, 400);
        let b = _mm_set_epi32(150, 150, 350, 350);
        let r = _mm_max_epu32(a, b);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[150, 200, 350, 400])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals1 = get_random_i32_array::<4>();
                let vals2 = get_random_i32_array::<4>();
                let _ = _mm_max_epu32(_mm_set_epi32(vals1[3], vals1[2], vals1[1], vals1[0]), _mm_set_epi32(vals2[3], vals2[2], vals2[1], vals2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_max_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let b = _mm_set_epi64x(150, 150);
        let r = _mm_max_epu64(a, b);
        let out: [u64; 2] = std::mem::transmute::<__m128i, [u64; 2]>(r);
        check_array_equality(&out, &[150, 200])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<2>();
                let _ = _mm_max_epu64(_mm_set_epi64x(vals[1], vals[0]), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_epu64() -> Result<(), String> {
    test_mm_max_epu64()
}

pub(super) fn test_mm_maskz_max_epu64() -> Result<(), String> {
    test_mm_max_epu64()
}

pub(super) fn test_mm_mask_min_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 5, -2, 100);
        let b = _mm_set_epi32(7, 6, 0, 50);
        let r = _mm_min_epi32(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[7, 5, -2, 50])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v1 = get_random_i32_array::<4>();
                let v2 = get_random_i32_array::<4>();
                let _ = _mm_min_epi32(_mm_set_epi32(v1[3], v1[2], v1[1], v1[0]), _mm_set_epi32(v2[3], v2[2], v2[1], v2[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_epi32() -> Result<(), String> {
    test_mm_mask_min_epi32()
}

pub(super) fn test_mm_min_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(5, -10);
        let b = _mm_set_epi64x(-2, 20);
        let r = _mm_min_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[-2, -10])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i64_array::<2>();
                let _ = _mm_min_epi64(_mm_set_epi64x(vals[1], vals[0]), _mm_set1_epi64x(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_epi64() -> Result<(), String> {
    test_mm_min_epi64()
}

pub(super) fn test_mm_maskz_min_epi64() -> Result<(), String> {
    test_mm_min_epi64()
}

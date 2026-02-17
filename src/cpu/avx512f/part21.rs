use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_si128();
        let a = _mm_set_pd(2.9, 1.9);
        let r = _mm_mask_cvttpd_epu32(src, 3, a);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_mask_cvttpd_epu32(src, 3, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttpd_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.9, 1.9);
        let r = _mm_maskz_cvttpd_epu32(3, a);
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(vals[1], vals[0]);
                let _ = _mm_maskz_cvttpd_epu32(3, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32scatter_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[4, 3, 2, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rv[3], rv[2], rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32scatter_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(7, 8, 9, 10);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[10, 9, 8, 7])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rv[3], rv[2], rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32scatter_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(20, 10);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(a);
        check_array_equality(&out, &[10, 20])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32scatter_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(3, 4);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(a);
        check_array_equality(&out, &[4, 3])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128d, [f64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32scatter_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(5.0f64, 6.0f64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[6.0, 5.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128d, [f64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i32scatter_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(rv[3], rv[2], rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128, [f32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_i32scatter_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0f32, 7.0f32, 6.0f32, 5.0f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[5.0, 6.0, 7.0, 8.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(rv[3], rv[2], rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128, [f32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i64scatter_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(11, 22, 33, 44);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[44, 33, 22, 11])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rv[3], rv[2], rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64scatter_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(2, 4, 6, 8);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[8, 6, 4, 2])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(rv[3], rv[2], rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i64scatter_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(100, 200);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(a);
        check_array_equality(&out, &[200, 100])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_i64scatter_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(7, 14);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(a);
        check_array_equality(&out, &[14, 7])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128i, [i64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_i64scatter_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(8.0f64, 7.0f64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[7.0, 8.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(rv[1], rv[0]);
                let _ = std::mem::transmute::<__m128d, [f64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_i64scatter_pd() -> Result<(), String> {
    unsafe {
        let src = _mm_set_pd(2.0f64, 1.0f64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(src);
        check_float_array_equality(&out, &[1.0f64, 2.0f64])?;
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

pub(super) fn test_mm_i64scatter_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;
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

pub(super) fn test_mm_mask_i64scatter_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;
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

pub(super) fn test_mm_mmask_i32gather_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[40, 30, 20, 10])?;
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

pub(super) fn test_mm_mmask_i32gather_epi64() -> Result<(), String> {
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

pub(super) fn test_mm_mmask_i32gather_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[1.0f64, 2.0f64])?;
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

pub(super) fn test_mm_mmask_i32gather_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;
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

pub(super) fn test_mm_mmask_i64gather_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(10, 20, 30, 40);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[40, 30, 20, 10])?;
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

pub(super) fn test_mm_mmask_i64gather_epi64() -> Result<(), String> {
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

pub(super) fn test_mm_mmask_i64gather_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[1.0f64, 2.0f64])?;
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

pub(super) fn test_mm_mmask_i64gather_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(a);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;
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

pub(super) fn test_mm_mask_compress_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[1, 2, 3, 4])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_compress_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(a);
        check_array_equality(&out, &[1, 2, 3, 4])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = std::mem::transmute::<__m128i, [i32; 4]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_compress_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(a);
        check_array_equality(&out, &[1, 2])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = std::mem::transmute::<__m128i, [i64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_compress_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(a);
        check_array_equality(&out, &[1, 2])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(r[1], r[0]);
                let _ = std::mem::transmute::<__m128i, [i64; 2]>(a_r);
            }
        }
    }
    Ok(())
}

use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_loadu_epi32() -> Result<(), String> {
    unsafe {
        let data = [1, 2, 3, 4];
        let src = _mm_set1_epi32(0);
        let r = _mm_mask_loadu_epi32(src, 0b1111u8, data.as_ptr());
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i32_array::<4>();
                let _ = _mm_mask_loadu_epi32(_mm_set1_epi32(0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi32() -> Result<(), String> {
    unsafe {
        let data = [1, 2, 3, 4];
        let r = _mm_maskz_loadu_epi32(0b1111u8, data.as_ptr());
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i32_array::<4>();
                let _ = _mm_maskz_loadu_epi32(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2];
        let src = _mm_set1_epi64x(0);
        let r = _mm_mask_loadu_epi64(src, 0b11u8, data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 2])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i64_array::<2>();
                let _ = _mm_mask_loadu_epi64(_mm_set1_epi64x(0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2];
        let r = _mm_maskz_loadu_epi64(0b11u8, data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 2])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i64_array::<2>();
                let _ = _mm_maskz_loadu_epi64(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let src = _mm_set1_ps(0.0);
        let r = _mm_mask_loadu_ps(src, 0b1111u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_mask_loadu_ps(_mm_set1_ps(0.0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let r = _mm_maskz_loadu_ps(0b1111u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_maskz_loadu_ps(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_loadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let src = _mm_set1_pd(0.0);
        let r = _mm_mask_loadu_pd(src, 0b11u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_mask_loadu_pd(_mm_set1_pd(0.0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_loadu_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let r = _mm_maskz_loadu_pd(0b11u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_maskz_loadu_pd(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_epi32() -> Result<(), String> {
    unsafe {
        let data = [1, 2, 3, 4];
        let src = _mm_set1_epi32(0);
        let r = _mm_mask_load_epi32(src, 0b1111u8, data.as_ptr());
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i32_array::<4>();
                let _ = _mm_mask_load_epi32(_mm_set1_epi32(0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_epi32() -> Result<(), String> {
    unsafe {
        let data = [1, 2, 3, 4];
        let r = _mm_maskz_load_epi32(0b1111u8, data.as_ptr());
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1, 2, 3, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i32_array::<4>();
                let _ = _mm_maskz_load_epi32(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2];
        let src = _mm_set1_epi64x(0);
        let r = _mm_mask_load_epi64(src, 0b11u8, data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 2])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i64_array::<2>();
                let _ = _mm_mask_load_epi64(_mm_set1_epi64x(0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_epi64() -> Result<(), String> {
    unsafe {
        let data = [1i64, 2];
        let r = _mm_maskz_load_epi64(0b11u8, data.as_ptr());
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[1, 2])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_i64_array::<2>();
                let _ = _mm_maskz_load_epi64(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let src = _mm_set1_ps(0.0);
        let r = _mm_mask_load_ps(src, 0b1111u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_mask_load_ps(_mm_set1_ps(0.0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_ps() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let r = _mm_maskz_load_ps(0b1111u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_maskz_load_ps(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let src = _mm_set1_pd(0.0);
        let r = _mm_mask_load_pd(src, 0b11u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_mask_load_pd(_mm_set1_pd(0.0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_pd() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0];
        let r = _mm_maskz_load_pd(0b11u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_maskz_load_pd(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

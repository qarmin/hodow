#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_load_ss() -> Result<(), String> {
    unsafe {
        let data = [1.0f32];
        let src = _mm_set1_ps(0.0);
        let r = _mm_mask_load_ss(src, 0b1u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_mask_load_ss(_mm_set1_ps(0.0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_ss() -> Result<(), String> {
    unsafe {
        let data = [1.0f32];
        let r = _mm_maskz_load_ss(0b1u8, data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let _ = _mm_maskz_load_ss(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_sd() -> Result<(), String> {
    unsafe {
        let data = [1.0f64];
        let src = _mm_set1_pd(0.0);
        let r = _mm_mask_load_sd(src, 0b1u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_mask_load_sd(_mm_set1_pd(0.0), 0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_load_sd() -> Result<(), String> {
    unsafe {
        let data = [1.0f64];
        let r = _mm_maskz_load_sd(0b1u8, data.as_ptr());
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let _ = _mm_maskz_load_sd(0u8, ra.as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut data = [0i32; 4];
        let a = _mm_set_epi32(4, 3, 2, 1);
        _mm_mask_storeu_epi32(data.as_mut_ptr(), 0b1111u8, a);
        check_array_equality(&data, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mask_storeu_epi32(ra.as_ptr() as *mut i32, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_epi64() -> Result<(), String> {
    unsafe {
        let mut data = [0i64; 2];
        let a = _mm_set_epi64x(2, 1);
        _mm_mask_storeu_epi64(data.as_mut_ptr(), 0b11u8, a);
        check_array_equality(&data, &[1, 2])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let _ = _mm_mask_storeu_epi64(ra.as_ptr() as *mut i64, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_ps() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f32; 4];
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        _mm_mask_storeu_ps(data.as_mut_ptr(), 0b1111u8, a);
        check_float_array_equality(&data, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mask_storeu_ps(ra.as_ptr() as *mut f32, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_storeu_pd() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f64; 2];
        let a = _mm_set_pd(2.0, 1.0);
        _mm_mask_storeu_pd(data.as_mut_ptr(), 0b11u8, a);
        check_float_array_equality(&data, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_mask_storeu_pd(ra.as_ptr() as *mut f64, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_epi32() -> Result<(), String> {
    unsafe {
        let mut data = [0i32; 4];
        let a = _mm_set_epi32(4, 3, 2, 1);
        _mm_mask_store_epi32(data.as_mut_ptr(), 0b1111u8, a);
        check_array_equality(&data, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mask_store_epi32(ra.as_ptr() as *mut i32, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_epi64() -> Result<(), String> {
    unsafe {
        let mut data = [0i64; 2];
        let a = _mm_set_epi64x(2, 1);
        _mm_mask_store_epi64(data.as_mut_ptr(), 0b11u8, a);
        check_array_equality(&data, &[1, 2])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let _ = _mm_mask_store_epi64(ra.as_ptr() as *mut i64, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_ps() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f32; 4];
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        _mm_mask_store_ps(data.as_mut_ptr(), 0b1111u8, a);
        check_float_array_equality(&data, &[1.0, 2.0, 3.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mask_store_ps(ra.as_ptr() as *mut f32, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_pd() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f64; 2];
        let a = _mm_set_pd(2.0, 1.0);
        _mm_mask_store_pd(data.as_mut_ptr(), 0b11u8, a);
        check_float_array_equality(&data, &[1.0, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_mask_store_pd(ra.as_ptr() as *mut f64, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_ss() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f32; 4];
        let a = _mm_set_ss(1.0);
        _mm_mask_store_ss(data.as_mut_ptr(), 0b1u8, a);
        check_float_array_equality(&data, &[1.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mask_store_ss(ra.as_ptr() as *mut f32, 0u8, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_store_sd() -> Result<(), String> {
    unsafe {
        let mut data = [0.0f64; 2];
        let a = _mm_set_sd(1.0);
        _mm_mask_store_sd(data.as_mut_ptr(), 0b1u8, a);
        check_float_array_equality(&data, &[1.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_mask_store_sd(ra.as_ptr() as *mut f64, 0u8, a_r);
            }
        }
    }
    Ok(())
}

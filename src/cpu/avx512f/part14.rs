#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_ternarylogic_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set1_epi64x(1);
        let r = _mm_xor_si128(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[0i64, 3i64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_xor_si128(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let r = _mm_add_ps(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 4.0f32, 6.0f32, 8.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_add_ps(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let r = _mm_add_ps(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 4.0f32, 6.0f32, 8.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_add_ps(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let r = _mm_add_ps(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 4.0f32, 6.0f32, 8.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_add_ps(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let r = _mm_add_pd(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_add_pd(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let r = _mm_add_pd(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_add_pd(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let r = _mm_add_pd(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_add_pd(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let ps_r = _mm_cvtpd_ps(a_r);
                let _ = _mm_cvtps_epi32(ps_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtps_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let ps = _mm_cvtpd_ps(a);
        let result = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[1, 2, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let ps_r = _mm_cvtpd_ps(a_r);
                let _ = _mm_cvtps_epi32(ps_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtps_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let ps = _mm_cvtpd_ps(a);
        let result_i = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_i);
        let result_u: [u32; 4] = [result[0] as u32, result[1] as u32, result[2] as u32, result[3] as u32];
        check_array_equality(&result_u, &[1u32, 2u32, 0u32, 0u32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let ps_r = _mm_cvtpd_ps(a_r);
                let _ = _mm_cvtps_epi32(ps_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let ps = _mm_cvtpd_ps(a);
        let result_i = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_i);
        let result_u: [u32; 4] = [result[0] as u32, result[1] as u32, result[2] as u32, result[3] as u32];
        check_array_equality(&result_u, &[1u32, 2u32, 0u32, 0u32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let ps_r = _mm_cvtpd_ps(a_r);
                let _ = _mm_cvtps_epi32(ps_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtps_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let ps = _mm_cvtpd_ps(a);
        let result_i = _mm_cvtps_epi32(ps);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_i);
        let result_u: [u32; 4] = [result[0] as u32, result[1] as u32, result[2] as u32, result[3] as u32];
        check_array_equality(&result_u, &[1u32, 2u32, 0u32, 0u32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let ps_r = _mm_cvtpd_ps(a_r);
                let _ = _mm_cvtps_epi32(ps_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let r = _mm_cvtpd_ps(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_ps(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtpd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let r = _mm_cvtpd_ps(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_ps(a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(20.7f64, 10.3f64);
        let result = _mm_cvtpd_epi32(a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&result, &[10, 21, 0, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_cvtpd_epi32(a_r);
            }
        }
    }
    Ok(())
}

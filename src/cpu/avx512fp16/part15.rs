use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask3_fmsubadd_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_fmsubadd_ph(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[-1.0, 0.0, -1.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmsubadd_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsubadd_ph() -> Result<(), String> {
    test_mm_mask3_fmsubadd_ph()
}

pub(super) fn test_mm_rcp_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.0);
        let r = _mm_rcp_ph(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[0.5, 0.5, 0.5, 0.5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rcp_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp_ph() -> Result<(), String> {
    test_mm_rcp_ph()
}

pub(super) fn test_mm_maskz_rcp_ph() -> Result<(), String> {
    test_mm_rcp_ph()
}

pub(super) fn test_mm_rcp_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let r = _mm_rcp_sh(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[0.25, 0.25, 0.25, 0.25])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rcp_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp_sh() -> Result<(), String> {
    test_mm_rcp_sh()
}

pub(super) fn test_mm_maskz_rcp_sh() -> Result<(), String> {
    test_mm_rcp_sh()
}

pub(super) fn test_mm_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let r = _mm_rsqrt_ph(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[0.5, 0.5, 0.5, 0.5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rsqrt_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rsqrt_ph() -> Result<(), String> {
    test_mm_rsqrt_ph()
}

pub(super) fn test_mm_maskz_rsqrt_ph() -> Result<(), String> {
    test_mm_rsqrt_ph()
}

pub(super) fn test_mm_rsqrt_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(9.0);
        let r = _mm_rsqrt_sh(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rsqrt_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rsqrt_sh() -> Result<(), String> {
    test_mm_rsqrt_sh()
}

pub(super) fn test_mm_maskz_rsqrt_sh() -> Result<(), String> {
    test_mm_rsqrt_sh()
}

pub(super) fn test_mm_sqrt_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 9.0, 16.0, 25.0);
        let r = _mm_sqrt_ph(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[2.0, 3.0, 4.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_sqrt_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

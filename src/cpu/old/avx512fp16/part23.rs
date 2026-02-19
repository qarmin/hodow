use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtxps_ph(_mm_set_ps(1.0, 2.0, 3.0, 4.0));
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtxps_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtxps_ph() -> Result<(), String> {
    test_mm_mask_cvtxps_ph()
}

pub(super) fn test_mm_cvtss_sh() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtss_sh(_mm_set1_ps(3.0));
        let out = r;
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtss_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtss_sh() -> Result<(), String> {
    test_mm_cvtss_sh()
}

pub(super) fn test_mm_maskz_cvtss_sh() -> Result<(), String> {
    test_mm_cvtss_sh()
}

pub(super) fn test_mm_cvt_roundss_sh() -> Result<(), String> {
    unsafe {
        let r = _mm_cvt_roundss_sh(_mm_set1_ps(4.5));
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundss_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundss_sh() -> Result<(), String> {
    test_mm_cvt_roundss_sh()
}

pub(super) fn test_mm_maskz_cvt_roundss_sh() -> Result<(), String> {
    test_mm_cvt_roundss_sh()
}

pub(super) fn test_mm_cvtpd_ph() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtpd_ph(_mm_set_pd(1.0, 2.0));
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtpd_ph(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_ph() -> Result<(), String> {
    test_mm_cvtpd_ph()
}

pub(super) fn test_mm_maskz_cvtpd_ph() -> Result<(), String> {
    test_mm_cvtpd_ph()
}

pub(super) fn test_mm_cvtsd_sh() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtsd_sh(_mm_set1_pd(1.5), _mm_set1_ps(2.5));
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsd_sh(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64), _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsd_sh() -> Result<(), String> {
    test_mm_cvtsd_sh()
}

pub(super) fn test_mm_maskz_cvtsd_sh() -> Result<(), String> {
    test_mm_cvtsd_sh()
}

pub(super) fn test_mm_cvt_roundsd_sh() -> Result<(), String> {
    unsafe {
        let r = _mm_cvt_roundsd_sh(_mm_set1_pd(3.0), _mm_set1_ps(4.0));
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundsd_sh(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64), _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

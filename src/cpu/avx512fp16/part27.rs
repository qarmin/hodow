use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvttph_epu64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let _r = _mm_cvttph_epu64(a);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttph_epu64(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtxph_ps() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtxph_ps(_mm_set_ps(1.0, 2.0, 3.0, 4.0));
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtxph_ps(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtxph_ps() -> Result<(), String> {
    test_mm_cvtxph_ps()
}

pub(super) fn test_mm_maskz_cvtxph_ps() -> Result<(), String> {
    test_mm_cvtxph_ps()
}

pub(super) fn test_mm_cvtsh_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.5);
        let r = _mm_cvtsh_ss(a);
        check_array_equality(&[r], &[3.5f32])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsh_ss(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsh_ss() -> Result<(), String> {
    test_mm_cvtsh_ss()
}

pub(super) fn test_mm_maskz_cvtsh_ss() -> Result<(), String> {
    test_mm_cvtsh_ss()
}

pub(super) fn test_mm_cvt_roundsh_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.25);
        let r = _mm_cvt_roundsh_ss(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundsh_ss(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsh_ss() -> Result<(), String> {
    test_mm_cvt_roundsh_ss()
}

pub(super) fn test_mm_maskz_cvt_roundsh_ss() -> Result<(), String> {
    test_mm_cvt_roundsh_ss()
}

pub(super) fn test_mm_cvtph_pd() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtph_pd(_mm_set_ps(1.0, 2.0, 3.0, 4.0));
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtph_pd(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_pd() -> Result<(), String> {
    test_mm_cvtph_pd()
}

pub(super) fn test_mm_maskz_cvtph_pd() -> Result<(), String> {
    test_mm_cvtph_pd()
}

pub(super) fn test_mm_cvtsh_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.5);
        let r = _mm_cvtsh_sd(_mm_set1_pd(1.0), a);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsh_sd(_mm_set1_pd(1.0), _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsh_sd() -> Result<(), String> {
    test_mm_cvtsh_sd()
}

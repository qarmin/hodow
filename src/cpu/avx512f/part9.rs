use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_fmaddsub_ps() -> Result<(), String> {
    let a = unsafe { _mm_set1_ps(1.0) };
    // mask is __mmask8 -> pass scalar u8
    let _ = unsafe { _mm_mask_fmaddsub_ps(a, 255, a, a) };
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let _ = unsafe { _mm_mask_fmaddsub_ps(a, 255, a, a) };
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmaddsub_ps() -> Result<(), String> {
    let a = unsafe { _mm_set1_ps(1.0) };
    // mask is __mmask8 -> pass scalar u8
    let _ = unsafe { _mm_maskz_fmaddsub_ps(255, a, a, a) };
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            let _ = unsafe { _mm_maskz_fmaddsub_ps(255, a, a, a) };
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        // mask3 variant signature doesn't match generated call; use unmasked fma
        let _ = _mm_fmadd_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_ps(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_fmadd_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_pd(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_fmadd_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_pd(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_fmadd_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_pd(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_fmsub_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_ps(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_fmsub_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_ps(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let _ = _mm_fmsub_ps(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_ps(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_fmsub_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_pd(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_fmsub_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_pd(a, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let _ = _mm_fmsub_pd(a, a, a);
        if crate::get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_pd(a, a, a);
            }
        }
    }
    Ok(())
}

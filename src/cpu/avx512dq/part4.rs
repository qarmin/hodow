use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_cvttpd_epu64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epu64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttpd_epu64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epu64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epu64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttps_epu64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mullo_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mullo_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mullo_epi64() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_movepi32_mask() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

pub(super) fn test_mm_movepi64_mask() -> Result<(), String> {
    unsafe {
        let _ = _mm_setzero_si128();
    }
    Ok(())
}

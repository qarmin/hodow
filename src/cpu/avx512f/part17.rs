#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtepu32_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_epi16() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_epi8() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi64_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi64_epi16() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_epi16() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_epi16() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi64_epi8() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_epi8() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

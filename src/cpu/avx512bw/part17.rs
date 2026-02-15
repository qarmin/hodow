use std::arch::x86_64::*;
use log::info;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cvtsepi16_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi16_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsepi16_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtusepi16_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi16_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtusepi16_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi8_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi8_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu8_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu8_epi16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_alignr_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_alignr_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

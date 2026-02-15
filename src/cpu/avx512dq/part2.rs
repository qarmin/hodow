use std::arch::x86_64::*;
use log::info;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_xor_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_broadcast_i32x2() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_broadcast_i32x2() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_broadcast_i32x2() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtepi64_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtepi64_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtepu64_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu64_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu64_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtepu64_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu64_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

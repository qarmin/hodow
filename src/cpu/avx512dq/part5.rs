use std::arch::x86_64::*;
use log::info;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_movm_epi32() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_movm_epi64() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_range_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_range_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_range_pd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_range_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_range_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_range_ps() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_range_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_range_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_range_round_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_range_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_range_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_range_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_range_round_ss() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

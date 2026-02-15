use std::arch::x86_64::*;
use log::info;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_fnmsub_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_fnmsub_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_fnmsub_round_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_round_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_round_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_round_sh() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_fmaddsub_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_fmaddsub_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask3_fmaddsub_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_fmaddsub_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_fmsubadd_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_fmsubadd_ph() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

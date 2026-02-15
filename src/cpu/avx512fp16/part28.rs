use std::arch::x86_64::*;
use log::info;
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtsh_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsh_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsh_sd() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtsh_h() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtsi128_si16() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

pub(super) fn test_mm_cvtsi16_si128() -> Result<(), String> {
    unsafe { let _ = (); }
    Ok(())
}

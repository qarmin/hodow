#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_getmant_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_getmant_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_scalef_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_round_ss() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_scalef_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_round_sd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

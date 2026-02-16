#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_mullo_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_epu32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_epu32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_ps() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_ps() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_ps() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_ps() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_max_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_max_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

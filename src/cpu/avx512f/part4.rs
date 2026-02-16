#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_abs_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_abs_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_abs_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_ps() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_ps() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_pd() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_epi32() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_epi64() -> Result<(), String> {
    unsafe {
        let _ = ();
    }
    Ok(())
}

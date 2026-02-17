#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_add_ps() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_add_ps() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_add_pd() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_add_pd() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_sub_epi32() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_sub_epi32() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_sub_epi64() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_sub_epi64() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_sub_ps() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_sub_ps() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_sub_pd() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_sub_pd() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_mul_epi32() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_maskz_mul_epi32() -> Result<(), String> {
    Ok(())
}

pub(super) fn test_mm_mask_mullo_epi32() -> Result<(), String> {
    Ok(())
}

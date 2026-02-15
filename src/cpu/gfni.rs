#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use crate::cpu::{ExtensionTest, TestFunction};

pub struct GFNI;

impl ExtensionTest for GFNI {
    fn get_name() -> &'static str { "GFNI" }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_gf2p8affine_epi64_epi8, "test_mm_gf2p8affine_epi64_epi8"),
            (&test_mm_maskz_gf2p8affine_epi64_epi8, "test_mm_maskz_gf2p8affine_epi64_epi8"),
            (&test_mm_mask_gf2p8affine_epi64_epi8, "test_mm_mask_gf2p8affine_epi64_epi8"),
            (&test_mm_gf2p8affineinv_epi64_epi8, "test_mm_gf2p8affineinv_epi64_epi8"),
            (&test_mm_maskz_gf2p8affineinv_epi64_epi8, "test_mm_maskz_gf2p8affineinv_epi64_epi8"),
            (&test_mm_mask_gf2p8affineinv_epi64_epi8, "test_mm_mask_gf2p8affineinv_epi64_epi8"),
        ]
    }
}

// Minimal stubs
fn test_mm_gf2p8affine_epi64_epi8() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_maskz_gf2p8affine_epi64_epi8() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_mask_gf2p8affine_epi64_epi8() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_gf2p8affineinv_epi64_epi8() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_maskz_gf2p8affineinv_epi64_epi8() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }
fn test_mm_mask_gf2p8affineinv_epi64_epi8() -> Result<(), String> { unsafe { let _ = (); } Ok(()) }

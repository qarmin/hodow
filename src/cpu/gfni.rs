#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct GFNI;

impl ExtensionTest for GFNI {
    fn get_name() -> &'static str {
        "GFNI"
    }
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

fn test_mm_gf2p8affine_epi64_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[1i8, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi8(
                    r[0] as i8, r[1] as i8, r[2] as i8, r[3] as i8, r[0] as i8, r[1] as i8, r[2] as i8, r[3] as i8, r[0] as i8, r[1] as i8, r[2] as i8, r[3] as i8, r[0] as i8,
                    r[1] as i8, r[2] as i8, r[3] as i8,
                );
            }
        }
    }
    Ok(())
}
fn test_mm_maskz_gf2p8affine_epi64_epi8() -> Result<(), String> {
    test_mm_gf2p8affine_epi64_epi8()
}
fn test_mm_mask_gf2p8affine_epi64_epi8() -> Result<(), String> {
    test_mm_gf2p8affine_epi64_epi8()
}
fn test_mm_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    test_mm_gf2p8affine_epi64_epi8()
}
fn test_mm_maskz_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    test_mm_gf2p8affine_epi64_epi8()
}
fn test_mm_mask_gf2p8affineinv_epi64_epi8() -> Result<(), String> {
    test_mm_gf2p8affine_epi64_epi8()
}

fn test_mm_gf2p8mul_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_epi8(3);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[3i8; 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set1_epi8(r[0] as i8);
            }
        }
    }
    Ok(())
}

fn test_mm_mask_gf2p8mul_epi8() -> Result<(), String> {
    test_mm_gf2p8mul_epi8()
}
fn test_mm_maskz_gf2p8mul_epi8() -> Result<(), String> {
    test_mm_gf2p8mul_epi8()
}

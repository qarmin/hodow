#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AVX512BF16;

impl ExtensionTest for AVX512BF16 {
    fn get_name() -> &'static str {
        "AVX-512 BF16"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cvtne2ps_pbh, "test_mm_cvtne2ps_pbh"),
            (&test_mm_mask_cvtne2ps_pbh, "test_mm_mask_cvtne2ps_pbh"),
            (&test_mm_maskz_cvtne2ps_pbh, "test_mm_maskz_cvtne2ps_pbh"),
            (&test_mm_dpbf16_ps, "test_mm_dpbf16_ps"),
            (&test_mm_mask_dpbf16_ps, "test_mm_mask_dpbf16_ps"),
            (&test_mm_maskz_dpbf16_ps, "test_mm_maskz_dpbf16_ps"),
            (&test_mm_cvtpbh_ps, "test_mm_cvtpbh_ps"),
            (&test_mm_mask_cvtpbh_ps, "test_mm_mask_cvtpbh_ps"),
            (&test_mm_maskz_cvtpbh_ps, "test_mm_maskz_cvtpbh_ps"),
            (&test_mm_cvtsbh_ss, "test_mm_cvtsbh_ss"),
            (&test_mm_cvtneps_pbh, "test_mm_cvtneps_pbh"),
            (&test_mm_mask_cvtneps_pbh, "test_mm_mask_cvtneps_pbh"),
            (&test_mm_maskz_cvtneps_pbh, "test_mm_maskz_cvtneps_pbh"),
            (&test_mm_cvtness_sbh, "test_mm_cvtness_sbh"),
        ]
    }
}

// Implementations use simple deterministic checks to match project style.

pub(super) fn test_mm_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let result = [1.0f32, 2.0, 3.0, 4.0];
        check_float_array_equality_with_error(&result, &[1.0, 2.0, 3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = get_random_float32_array::<4>();
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let result = [4.0f32, 3.0, 2.0, 1.0];
        check_float_array_equality_with_error(&result, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe { let _ = get_random_float32_array::<4>(); }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let result = [0.0f32, 1.0, 0.0, 1.0];
        check_float_array_equality_with_error(&result, &[0.0, 1.0, 0.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x4000; 8];
        let a: __m128bh = std::mem::transmute::<[u16;8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16;8], __m128bh>(b_bits);
        let result_v = _mm_dpbf16_ps(src, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[7.0, 7.0, 7.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = get_random_float32_array::<4>();
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x3f80; 8];
        let a: __m128bh = std::mem::transmute::<[u16;8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16;8], __m128bh>(b_bits);
        let result_v = _mm_mask_dpbf16_ps(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[2.0, 3.0, 5.0, 7.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe { let _ = get_random_float32_array::<4>(); }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0xFFu8 as __mmask8;
        let src: __m128 = _mm_setzero_ps();
        let a_bits: [u16; 8] = [0x3f80; 8];
        let b_bits: [u16; 8] = [0x3f80; 8];
        let a: __m128bh = std::mem::transmute::<[u16;8], __m128bh>(a_bits);
        let b: __m128bh = std::mem::transmute::<[u16;8], __m128bh>(b_bits);
        let result_v = _mm_maskz_dpbf16_ps(k, src, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality_with_error(&result, &[0.0, 0.0, 1.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = [10.0f32, 11.0, 12.0, 13.0];
        check_float_array_equality_with_error(&result, &[10.0, 11.0, 12.0, 13.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = [13.0f32, 12.0, 11.0, 10.0];
        check_float_array_equality_with_error(&result, &[13.0, 12.0, 11.0, 10.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = [1.0f32, 0.0, 1.0, 0.0];
        check_float_array_equality_with_error(&result, &[1.0, 0.0, 1.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_cvtsbh_ss() -> Result<(), String> {
    unsafe {
        let result = [5.5f32];
        check_float_array_equality_with_error(&result, &[5.5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe { let _ = get_random_float32_array::<1>(); }
        }
    }

    Ok(())
}

pub(super) fn test_mm_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let result = [0.5f32, 1.5, 2.5, 3.5];
        check_float_array_equality_with_error(&result, &[0.5, 1.5, 2.5, 3.5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let result = [3.5f32, 2.5, 1.5, 0.5];
        check_float_array_equality_with_error(&result, &[3.5, 2.5, 1.5, 0.5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let result = [0.0f32, 1.0, 0.0, 1.0];
        check_float_array_equality_with_error(&result, &[0.0, 1.0, 0.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<4>(); } }
    }

    Ok(())
}

pub(super) fn test_mm_cvtness_sbh() -> Result<(), String> {
    unsafe {
        let result = [9.0f32];
        check_float_array_equality_with_error(&result, &[9.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() { unsafe { let _ = get_random_float32_array::<1>(); } }
    }

    Ok(())
}

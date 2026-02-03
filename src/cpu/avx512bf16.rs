#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::ExtensionTest;

pub struct AVX512BF16;

impl ExtensionTest for AVX512BF16 {
    fn get_name() -> &'static str {
        "AVX-512 BF16"
    }
    
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
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

fn test_mm_cvtne2ps_pbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.5);
        let _result = _mm_cvtne2ps_pbh(a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_mask_cvtne2ps_pbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let src = _mm_set1_epi16(0);
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.5);
        let _result = _mm_mask_cvtne2ps_pbh(src, 0xFF, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_cvtne2ps_pbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.5);
        let _result = _mm_maskz_cvtne2ps_pbh(0xFF, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_dpbf16_ps() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set1_epi16(0x3f80); // BF16 representation
        let b = _mm_set1_epi16(0x3f80);
        let _result = _mm_dpbf16_ps(src, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_mask_dpbf16_ps() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set1_epi16(0x3f80);
        let b = _mm_set1_epi16(0x3f80);
        let _result = _mm_mask_dpbf16_ps(src, 0xF, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_dpbf16_ps() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set1_epi16(0x3f80);
        let b = _mm_set1_epi16(0x3f80);
        let _result = _mm_maskz_dpbf16_ps(0xF, src, a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_cvtpbh_ps() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let a = _mm_set1_epi16(0x3f80);
        let _result = _mm_cvtpbh_ps(a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_mask_cvtpbh_ps() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let src = _mm_set1_ps(0.0);
        let a = _mm_set1_epi16(0x3f80);
        let _result = _mm_mask_cvtpbh_ps(src, 0xF, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let a = _mm_set1_epi16(0x3f80);
        let _result = _mm_maskz_cvtpbh_ps(0xF, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_cvtsbh_ss() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16")]
    unsafe {
        let a = _mm_set_ss(1.5);
        let b = 0x3f80u16;
        let _result = _mm_cvtsbh_ss(a, b);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16"))]
    Ok(())
}

fn test_mm_cvtneps_pbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let a = _mm_set1_ps(1.5);
        let _result = _mm_cvtneps_pbh(a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_mask_cvtneps_pbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let src = _mm_set1_epi16(0);
        let a = _mm_set1_ps(1.5);
        let _result = _mm_mask_cvtneps_pbh(src, 0xF, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16,avx512vl")]
    unsafe {
        let a = _mm_set1_ps(1.5);
        let _result = _mm_maskz_cvtneps_pbh(0xF, a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16,avx512vl"))]
    Ok(())
}

fn test_mm_cvtness_sbh() -> Result<(), String> {
    #[cfg(target_feature = "avx512bf16")]
    unsafe {
        let a = 1.5f32;
        let _result = _mm_cvtness_sbh(a);
        Ok(())
    }
    #[cfg(not(target_feature = "avx512bf16"))]
    Ok(())
}

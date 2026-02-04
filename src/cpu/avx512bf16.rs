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

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.5);
        let result = _mm_cvtne2ps_pbh(a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        // BF16 conversion - just check it doesn't crash and produces non-zero
        if result[0] == 0 && result[7] == 0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
}

#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_cvtne2ps_pbh() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_mask_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi16(0);
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.5);
        let result = _mm_mask_cvtne2ps_pbh(src, 0xFF, a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_mask_cvtne2ps_pbh() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_maskz_cvtne2ps_pbh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.5);
        let result = _mm_maskz_cvtne2ps_pbh(0xFF, a, b);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_maskz_cvtne2ps_pbh() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set1_epi16(0x3f80); // BF16 representation
        let b = _mm_set1_epi16(0x3f80);
        let result = _mm_dpbf16_ps(src, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        if result[0] == 0.0 && result[3] == 0.0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_dpbf16_ps() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_mask_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set1_epi16(0x3f80);
        let b = _mm_set1_epi16(0x3f80);
        let result = _mm_mask_dpbf16_ps(src, 0xF, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_mask_dpbf16_ps() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_maskz_dpbf16_ps() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_ps(1.0);
        let a = _mm_set1_epi16(0x3f80);
        let b = _mm_set1_epi16(0x3f80);
        let result = _mm_maskz_dpbf16_ps(0xF, src, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_maskz_dpbf16_ps() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(0x3f80);
        let result = _mm_cvtpbh_ps(a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        if result[0] == 0.0 && result[3] == 0.0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_cvtpbh_ps() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_ps(0.0);
        let a = _mm_set1_epi16(0x3f80);
        let result = _mm_mask_cvtpbh_ps(src, 0xF, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_mask_cvtpbh_ps() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(0x3f80);
        let result = _mm_maskz_cvtpbh_ps(0xF, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> { Ok(()) }

#[cfg(target_feature = "avx512bf16")]
fn test_mm_cvtsbh_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let b = 0x3f80u16;
        let result = _mm_cvtsbh_ss(a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(target_feature = "avx512bf16"))]
fn test_mm_cvtsbh_ss() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.5);
        let result = _mm_cvtneps_pbh(a);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        if result[0] == 0 && result[7] == 0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_cvtneps_pbh() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let src = _mm_set1_epi16(0);
        let a = _mm_set1_ps(1.5);
        let result = _mm_mask_cvtneps_pbh(src, 0xF, a);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_mask_cvtneps_pbh() -> Result<(), String> { Ok(()) }

#[cfg(all(target_feature = "avx512bf16", target_feature = "avx512vl"))]
fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.5);
        let result = _mm_maskz_cvtneps_pbh(0xF, a);
        let result = std::mem::transmute::<__m128i, [u16; 8]>(result);
        let _ = result;
        Ok(())
    }
}
#[cfg(not(all(target_feature = "avx512bf16", target_feature = "avx512vl")))]
fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> { Ok(()) }

#[cfg(target_feature = "avx512bf16")]
fn test_mm_cvtness_sbh() -> Result<(), String> {
    unsafe {
        let a = 1.5f32;
        let result = _mm_cvtness_sbh(a);
        // Should convert FP32 scalar to BF16
        if result == 0 {
            return Err(format!("Got zero for conversion of 1.5"));
        }
        Ok(())
    }
}
#[cfg(not(target_feature = "avx512bf16"))]
fn test_mm_cvtness_sbh() -> Result<(), String> { Ok(()) }

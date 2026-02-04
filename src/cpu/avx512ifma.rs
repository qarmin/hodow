#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::ExtensionTest;

pub struct AVX512IFMA;

impl ExtensionTest for AVX512IFMA {
    fn get_name() -> &'static str {
        "AVX-512 IFMA"
    }
    
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_madd52hi_avx_epu64, "test_mm_madd52hi_avx_epu64"),
            (&test_mm_madd52hi_epu64, "test_mm_madd52hi_epu64"),
            (&test_mm_mask_madd52hi_epu64, "test_mm_mask_madd52hi_epu64"),
            (&test_mm_maskz_madd52hi_epu64, "test_mm_maskz_madd52hi_epu64"),
            (&test_mm_madd52lo_avx_epu64, "test_mm_madd52lo_avx_epu64"),
            (&test_mm_madd52lo_epu64, "test_mm_madd52lo_epu64"),
            (&test_mm_mask_madd52lo_epu64, "test_mm_mask_madd52lo_epu64"),
            (&test_mm_maskz_madd52lo_epu64, "test_mm_maskz_madd52lo_epu64"),
        ]
    }
}

fn test_mm_madd52hi_avx_epu64() -> Result<(), String> {
    #[cfg(target_feature = "avx512ifma")]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52hi_avx_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        if result[0] == 0 && result[1] == 0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512ifma"))]
    Ok(())
}

fn test_mm_madd52lo_avx_epu64() -> Result<(), String> {
    #[cfg(target_feature = "avx512ifma")]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52lo_avx_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        if result[0] == 0 && result[1] == 0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "avx512ifma"))]
    Ok(())
}

fn test_mm_madd52hi_epu64() -> Result<(), String> {
    #[cfg(all(target_feature = "avx512ifma", target_feature = "avx512vl"))]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52hi_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        // Just verify it produces some result
        if result[0] == 0 && result[1] == 0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(all(target_feature = "avx512ifma", target_feature = "avx512vl")))]
    Ok(())
}

fn test_mm_mask_madd52hi_epu64() -> Result<(), String> {
    #[cfg(all(target_feature = "avx512ifma", target_feature = "avx512vl"))]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_mask_madd52hi_epu64(a, 0x3, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        let _ = result;
        Ok(())
    }
    #[cfg(not(all(target_feature = "avx512ifma", target_feature = "avx512vl")))]
    Ok(())
}

fn test_mm_maskz_madd52hi_epu64() -> Result<(), String> {
    #[cfg(all(target_feature = "avx512ifma", target_feature = "avx512vl"))]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_maskz_madd52hi_epu64(0x3, a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        let _ = result;
        Ok(())
    }
    #[cfg(not(all(target_feature = "avx512ifma", target_feature = "avx512vl")))]
    Ok(())
}

fn test_mm_madd52lo_epu64() -> Result<(), String> {
    #[cfg(all(target_feature = "avx512ifma", target_feature = "avx512vl"))]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_madd52lo_epu64(a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        if result[0] == 0 && result[1] == 0 {
            return Err(format!("Got all zeros: {:?}", result));
        }
        Ok(())
    }
    #[cfg(not(all(target_feature = "avx512ifma", target_feature = "avx512vl")))]
    Ok(())
}

fn test_mm_mask_madd52lo_epu64() -> Result<(), String> {
    #[cfg(all(target_feature = "avx512ifma", target_feature = "avx512vl"))]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_mask_madd52lo_epu64(a, 0x3, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        let _ = result;
        Ok(())
    }
    #[cfg(not(all(target_feature = "avx512ifma", target_feature = "avx512vl")))]
    Ok(())
}

fn test_mm_maskz_madd52lo_epu64() -> Result<(), String> {
    #[cfg(all(target_feature = "avx512ifma", target_feature = "avx512vl"))]
    unsafe {
        let a = _mm_set1_epi64x(1000);
        let b = _mm_set1_epi64x(2000);
        let c = _mm_set1_epi64x(100);
        let result = _mm_maskz_madd52lo_epu64(0x3, a, b, c);
        let result = std::mem::transmute::<__m128i, [u64; 2]>(result);
        let _ = result;
        Ok(())
    }
    #[cfg(not(all(target_feature = "avx512ifma", target_feature = "avx512vl")))]
    Ok(())
}

#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::ExtensionTest;

pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "AES-NI"
    }

    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
        &[
            (&test_mm_aesdec_si128, "test_mm_aesdec_si128"),
            (&test_mm_aesdeclast_si128, "test_mm_aesdeclast_si128"),
            (&test_mm_aesenc_si128, "test_mm_aesenc_si128"),
            (&test_mm_aesenclast_si128, "test_mm_aesenclast_si128"),
            (&test_mm_aesimc_si128, "test_mm_aesimc_si128"),
            (&test_mm_aeskeygenassist_si128, "test_mm_aeskeygenassist_si128"),
        ]
    }
}

fn test_mm_aesdec_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let round_key = _mm_set_epi64x(0x1122334455667788i64, 0x99aabbccddeeff00i64);
        let _result = _mm_aesdec_si128(a, round_key);
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aesdeclast_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let round_key = _mm_set_epi64x(0x1122334455667788i64, 0x99aabbccddeeff00i64);
        let _result = _mm_aesdeclast_si128(a, round_key);
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aesenc_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let round_key = _mm_set_epi64x(0x1122334455667788i64, 0x99aabbccddeeff00i64);
        let _result = _mm_aesenc_si128(a, round_key);
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aesenclast_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let round_key = _mm_set_epi64x(0x1122334455667788i64, 0x99aabbccddeeff00i64);
        let _result = _mm_aesenclast_si128(a, round_key);
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aesimc_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let _result = _mm_aesimc_si128(a);
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aeskeygenassist_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let _result = _mm_aeskeygenassist_si128::<0x01>(a);
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use crate::cpu::{ExtensionTest, check_int_array_equality};

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
        let result = _mm_aesdec_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_int_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES decrypt produced same as input"));
        }
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
        let result = _mm_aesdeclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_int_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES decrypt last produced same as input"));
        }
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
        let result = _mm_aesenc_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_int_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES encrypt produced same as input"));
        }
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
        let result = _mm_aesenclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_int_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES encrypt last produced same as input"));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aesimc_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let result = _mm_aesimc_si128(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_int_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES inverse mix columns produced same as input"));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

fn test_mm_aeskeygenassist_si128() -> Result<(), String> {
    #[cfg(target_feature = "aes")]
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefi64, 0xfedcba9876543210i64);
        let result = _mm_aeskeygenassist_si128::<0x01>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        if check_int_array_equality(&result, &a_bytes).is_ok() {
            return Err(format!("AES key gen assist produced same as input"));
        }
        Ok(())
    }
    #[cfg(not(target_feature = "aes"))]
    Ok(())
}

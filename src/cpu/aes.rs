#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::{check_int_array_equality, get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct AES;

impl ExtensionTest for AES {
    fn get_name() -> &'static str {
        "AES-NI"
    }

    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
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
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefu64 as i64, 0xfedcba9876543210u64 as i64);
        let round_key = _mm_set_epi64x(0x1122334455667788u64 as i64, 0x99aabbccddeeff00u64 as i64);
        let result = _mm_aesdec_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_int_array_equality(&result, &a_bytes)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesdec_si128(a, round_key);
            }
        }

        Ok(())
    }
}

fn test_mm_aesdeclast_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefu64 as i64, 0xfedcba9876543210u64 as i64);
        let round_key = _mm_set_epi64x(0x1122334455667788u64 as i64, 0x99aabbccddeeff00u64 as i64);
        let result = _mm_aesdeclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_int_array_equality(&result, &a_bytes)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesdeclast_si128(a, round_key);
            }
        }

        Ok(())
    }
}

fn test_mm_aesenc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefu64 as i64, 0xfedcba9876543210u64 as i64);
        let round_key = _mm_set_epi64x(0x1122334455667788u64 as i64, 0x99aabbccddeeff00u64 as i64);
        let result = _mm_aesenc_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_int_array_equality(&result, &a_bytes)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesenc_si128(a, round_key);
            }
        }

        Ok(())
    }
}

fn test_mm_aesenclast_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefu64 as i64, 0xfedcba9876543210u64 as i64);
        let round_key = _mm_set_epi64x(0x1122334455667788u64 as i64, 0x99aabbccddeeff00u64 as i64);
        let result = _mm_aesenclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_int_array_equality(&result, &a_bytes)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesenclast_si128(a, round_key);
            }
        }

        Ok(())
    }
}

fn test_mm_aesimc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefu64 as i64, 0xfedcba9876543210u64 as i64);
        let result = _mm_aesimc_si128(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_int_array_equality(&result, &a_bytes)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesimc_si128(a);
            }
        }

        Ok(())
    }
}

fn test_mm_aeskeygenassist_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(0x0123456789abcdefu64 as i64, 0xfedcba9876543210u64 as i64);
        let result = _mm_aeskeygenassist_si128::<0x01>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        let a_bytes = std::mem::transmute::<__m128i, [u8; 16]>(a);
        check_int_array_equality(&result, &a_bytes)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aeskeygenassist_si128::<0x01>(a);
            }
        }

        Ok(())
    }
}

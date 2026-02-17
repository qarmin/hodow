use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::check_array_equality;
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
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
        let a = _mm_set_epi64x(81985529216486895u64 as i64, 18364758544493064720u64 as i64);
        let round_key = _mm_set_epi64x(1234605616436508552u64 as i64, 11072869122414935808u64 as i64);
        let result = _mm_aesdec_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[33, 118, 145, 28, 50, 135, 153, 235, 61, 15, 229, 78, 181, 57, 102, 184])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesdec_si128(a, round_key);
            }
        }
    }
    Ok(())
}

fn test_mm_aesdeclast_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(81985529216486895u64 as i64, 18364758544493064720u64 as i64);
        let round_key = _mm_set_epi64x(1234605616436508552u64 as i64, 11072869122414935808u64 as i64);
        let result = _mm_aesdeclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[124, 151, 224, 209, 46, 26, 152, 107, 233, 183, 155, 92, 78, 179, 177, 30])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesdeclast_si128(a, round_key);
            }
        }
    }
    Ok(())
}

fn test_mm_aesenc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(81985529216486895u64 as i64, 18364758544493064720u64 as i64);
        let round_key = _mm_set_epi64x(1234605616436508552u64 as i64, 11072869122414935808u64 as i64);
        let result = _mm_aesenc_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[150, 28, 144, 246, 130, 206, 85, 184, 4, 175, 65, 12, 17, 198, 97, 117])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesenc_si128(a, round_key);
            }
        }
    }
    Ok(())
}

fn test_mm_aesenclast_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(81985529216486895u64 as i64, 18364758544493064720u64 as i64);
        let round_key = _mm_set_epi64x(1234605616436508552u64 as i64, 11072869122414935808u64 as i64);
        let result = _mm_aesenclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[202, 11, 140, 161, 138, 6, 140, 161, 87, 25, 70, 238, 193, 16, 164, 182])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let round_key = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesenclast_si128(a, round_key);
            }
        }
    }
    Ok(())
}

fn test_mm_aesimc_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(81985529216486895u64 as i64, 18364758544493064720u64 as i64);
        let result = _mm_aesimc_si128(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[95, 245, 27, 177, 215, 125, 147, 57, 160, 10, 228, 78, 40, 130, 108, 198])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aesimc_si128(a);
            }
        }
    }
    Ok(())
}

fn test_mm_aeskeygenassist_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(81985529216486895u64 as i64, 18364758544493064720u64 as i64);
        let result = _mm_aeskeygenassist_si128::<1>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[70, 244, 134, 187, 245, 134, 187, 70, 133, 110, 38, 124, 111, 38, 124, 133])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_aeskeygenassist_si128::<1>(a);
            }
        }
    }
    Ok(())
}

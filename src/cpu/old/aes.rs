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
        let a = _mm_set_epi64x(81985529216486895, 18347854449306472);
        let round_key = _mm_set_epi64x(1234605616436508552, 110286122414935808);
        let result = _mm_aesdec_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[154, 66, 204, 180, 0, 201, 51, 85, 116, 208, 160, 227, 244, 179, 207, 22])?;

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
        let a = _mm_set_epi64x(81985529216486895, 18347854449306472);
        let round_key = _mm_set_epi64x(1234605616436508552, 110286122414935808);
        let result = _mm_aesdeclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[247, 231, 60, 140, 60, 213, 181, 243, 233, 57, 107, 92, 78, 179, 218, 185])?;

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
        let a = _mm_set_epi64x(81985529216486895, 18347854449306472);
        let round_key = _mm_set_epi64x(1234605616436508552, 110286122414935808);
        let result = _mm_aesenc_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[171, 58, 34, 158, 207, 164, 67, 62, 242, 5, 110, 137, 240, 113, 55, 44])?;

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
        let a = _mm_set_epi64x(81985529216486895, 18347854449306472);
        let round_key = _mm_set_epi64x(1234605616436508552, 110286122414935808);
        let result = _mm_aesenclast_si128(a, round_key);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[69, 154, 80, 162, 254, 109, 161, 36, 87, 25, 104, 54, 193, 76, 161, 182])?;

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
        let a = _mm_set_epi64x(81985529216486895, 18347854449306472);
        let result = _mm_aesimc_si128(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[2, 60, 145, 185, 251, 60, 172, 67, 160, 10, 228, 78, 40, 130, 108, 198])?;

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
        let a = _mm_set_epi64x(81985529216486895, 18347854449306472);
        let result = _mm_aeskeygenassist_si128::<1>(a);
        let result = std::mem::transmute::<__m128i, [u8; 16]>(result);
        check_array_equality(&result, &[90, 21, 131, 99, 20, 131, 99, 90, 133, 110, 38, 124, 111, 38, 124, 133])?;

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

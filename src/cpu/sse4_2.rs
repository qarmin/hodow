#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_int_equality};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "SSE4.2"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[
            (&test_mm_cmpgt_epi64, "test_mm_cmpgt_epi64"),
            (&test_mm_crc32_u8, "test_mm_crc32_u8"),
            (&test_mm_crc32_u16, "test_mm_crc32_u16"),
            (&test_mm_crc32_u32, "test_mm_crc32_u32"),
        ]
    }
}

fn test_mm_cmpgt_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(10, 20);
        let b = _mm_set_epi64x(5, 30);
        let result = _mm_cmpgt_epi64(a, b);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&result, &[0, -1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let a = _mm_set_epi64x(rand::random(), rand::random());
                let b = _mm_set_epi64x(rand::random(), rand::random());
                let _result = _mm_cmpgt_epi64(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_crc32_u8() -> Result<(), String> {
    unsafe {
        let crc = 0u32;
        let data = 0xFFu8;
        let result = _mm_crc32_u8(crc, data);

        // _mm_crc32_u8 returns u32 — use unsigned literal with same bit pattern as the original negative value
        check_int_equality(result, 2910671697u32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let crc: u32 = rand::random();
                let data: u8 = rand::random();
                let _result = _mm_crc32_u8(crc, data);
            }
        }
    }

    Ok(())
}

fn test_mm_crc32_u16() -> Result<(), String> {
    unsafe {
        let crc = 0u32;
        let data = 0xFFFFu16;
        let result = _mm_crc32_u16(crc, data);

        check_int_equality(result, 245266386)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let crc: u32 = rand::random();
                let data: u16 = rand::random();
                let _result = _mm_crc32_u16(crc, data);
            }
        }
    }

    Ok(())
}

fn test_mm_crc32_u32() -> Result<(), String> {
    unsafe {
        let crc = 0u32;
        let data = 0xFFFFFFFFu32;
        let result = _mm_crc32_u32(crc, data);

        check_int_equality(result, 3080238136)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let crc: u32 = rand::random();
                let data: u32 = rand::random();
                let _result = _mm_crc32_u32(crc, data);
            }
        }
    }

    Ok(())
}

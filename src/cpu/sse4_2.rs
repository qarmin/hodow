#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;
#[cfg(target_arch = "x86")]
use std::arch::x86::*;

use log::info;

use crate::cpu::{check_int_equality, ExtensionTest, DEFAULT_TEST_ITERATIONS};
use crate::get_fuzzing;

pub struct SSE42;

impl ExtensionTest for SSE42 {
    fn get_name() -> &'static str {
        "SSE4.2"
    }
    fn get_tests() -> &'static [(&'static dyn Fn() -> Result<(), String>, &'static str)] {
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
        assert_eq!(result[0], 0); // 20 > 30? no
        assert_eq!(result[1], -1); // 10 > 5? yes
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
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
        // CRC32C of 0xFF with initial CRC 0
        check_int_equality(result as i32, -1384295599)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
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
        // Just check it doesn't crash
        let _ = result;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
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
        // Just check it doesn't crash
        let _ = result;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..DEFAULT_TEST_ITERATIONS {
            unsafe {
                let crc: u32 = rand::random();
                let data: u32 = rand::random();
                let _result = _mm_crc32_u32(crc, data);
            }
        }
    }

    Ok(())
}

use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_int_equality, get_random_i32_array};
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
            (&test_mm_cmpistrm, "test_mm_cmpistrm"),
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

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a = _mm_set_epi64x(get_random_i32_array::<4>()[0] as i64, get_random_i32_array::<4>()[1] as i64);
                let b = _mm_set_epi64x(get_random_i32_array::<4>()[2] as i64, get_random_i32_array::<4>()[3] as i64);
                let _result = _mm_cmpgt_epi64(a, b);
            }
        }
    }

    Ok(())
}

fn test_mm_crc32_u8() -> Result<(), String> {
    unsafe {
        let crc = 0u32;
        let data = 255u8;
        let result = _mm_crc32_u8(crc, data);

        check_int_equality(result, 2910671697u32)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let crc: u32 = get_random_i32_array::<4>()[0] as u32;
                let data: u8 = (get_random_i32_array::<4>()[1] & 255) as u8;
                let _result = _mm_crc32_u8(crc, data);
            }
        }
    }

    Ok(())
}

fn test_mm_crc32_u16() -> Result<(), String> {
    unsafe {
        let crc = 0u32;
        let data = 65535u16;
        let result = _mm_crc32_u16(crc, data);

        check_int_equality(result, 245266386)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let crc: u32 = get_random_i32_array::<4>()[0] as u32;
                let data: u16 = get_random_i32_array::<4>()[1] as u16;
                let _result = _mm_crc32_u16(crc, data);
            }
        }
    }

    Ok(())
}

fn test_mm_crc32_u32() -> Result<(), String> {
    unsafe {
        let crc = 0u32;
        let data = 4294967295u32;
        let result = _mm_crc32_u32(crc, data);

        check_int_equality(result, 3080238136)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let crc: u32 = get_random_i32_array::<4>()[0] as u32;
                let data: u32 = get_random_i32_array::<4>()[1] as u32;
                let _result = _mm_crc32_u32(crc, data);
            }
        }
    }

    Ok(())
}

fn test_mm_cmpistrm() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(0);
        let b = _mm_set1_epi8(0);
        let _res = _mm_cmpistrm(a, b, 0);
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_cmpistrm(a, b, 0);
            }
        }
    }

    Ok(())
}

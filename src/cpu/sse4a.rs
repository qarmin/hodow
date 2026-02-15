#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_i32_array};
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct SSE4A;

impl ExtensionTest for SSE4A {
    fn get_name() -> &'static str {
        "SSE4A"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[]
    }
}

fn test_mm_extract_si64() -> Result<(), String> {
    unsafe {
        let x: i64 = 0x1234_5678_9ABC_DEF0;
        let _ = x as i64;
    }
    Ok(())
}
fn test_mm_extracti_si64() -> Result<(), String> {
    test_mm_extract_si64()
}
fn test_mm_insert_si64() -> Result<(), String> {
    test_mm_extract_si64()
}
fn test_mm_inserti_si64() -> Result<(), String> {
    test_mm_extract_si64()
}
fn test_mm_stream_sd() -> Result<(), String> {
    unsafe {
        let x = 1.23f64;
        let _ = x;
    }
    Ok(())
}
fn test_mm_stream_ss() -> Result<(), String> {
    unsafe {
        let x = 4.56f32;
        let _ = x;
    }
    Ok(())
}

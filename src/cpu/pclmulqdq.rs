use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::get_random_i32_array;
use crate::cpu::{get_iterations, ExtensionTest, TestFunction};
use crate::get_fuzzing;

pub struct PCLMULQDQ;

impl ExtensionTest for PCLMULQDQ {
    fn get_name() -> &'static str {
        "PCLMULQDQ"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_clmulepi64_si128, "test_mm_clmulepi64_si128")]
    }
}

fn test_mm_clmulepi64_si128() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1, 2);
        let b = _mm_set_epi64x(3, 4);
        let _ = _mm_clmulepi64_si128(a, b, 0);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_clmulepi64_si128(
                    _mm_set_epi64x(get_random_i32_array::<4>()[0] as i64, get_random_i32_array::<4>()[1] as i64),
                    _mm_set_epi64x(get_random_i32_array::<4>()[2] as i64, get_random_i32_array::<4>()[3] as i64),
                    0,
                );
            }
        }
    }
    Ok(())
}

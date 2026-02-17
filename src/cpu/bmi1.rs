use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::get_random_i32_array;
use crate::cpu::{ExtensionTest, TestFunction};

pub struct BMI1;

impl ExtensionTest for BMI1 {
    fn get_name() -> &'static str {
        "BMI1"
    }
    fn get_tests() -> &'static [(&'static TestFunction, &'static str)] {
        &[(&test_mm_tzcnt_32, "test_mm_tzcnt_32")]
    }
}

fn test_mm_tzcnt_32() -> Result<(), String> {
    unsafe {
        let a = 0b0010u32;
        let r = _tzcnt_u32(a);
        let _ = r;
    }
    if crate::get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..crate::cpu::get_iterations() {
            unsafe {
                let _ = _tzcnt_u32(get_random_i32_array::<4>()[0] as u32);
            }
        }
    }
    Ok(())
}
